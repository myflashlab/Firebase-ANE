package 
{
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	
	import com.luaye.console.C;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import com.myflashlab.air.extensions.firebase.core.*;
	import com.myflashlab.air.extensions.firebase.fcm.*;
	import com.myflashlab.air.extensions.dependency.OverrideAir;
	
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 5/28/2016 10:36 AM
	 */
	public class MainFcm extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainFcm():void 
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			C.startOnStage(this, "`");
			C.commandLine = false;
			C.commandLineAllowed = false;
			C.x = 20;
			C.width = 250;
			C.height = 150;
			C.strongRef = true;
			C.visible = true;
			C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
			
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.embedFonts = false;
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase FCM V"+Firebase.VERSION+"</font>";
			_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			this.addChild(_txt);
			
			_body = new Sprite();
			this.addChild(_body);
			
			_list = new List();
			_list.holder = _body;
			_list.itemsHolder = new Sprite();
			_list.orientation = Orientation.VERTICAL;
			_list.hDirection = Direction.LEFT_TO_RIGHT;
			_list.vDirection = Direction.TOP_TO_BOTTOM;
			_list.space = BTN_SPACE;
			
			init();
			onResize();
		}
		
		private function onInvoke(e:InvokeEvent):void
		{
			var payload:Object = FCM.parsePayloadFromArguments(e.arguments);
			
			if (payload) // If available, it means that the Invoke listener contains FCM data
			{
				C.log("---------------------------------");
				for (var name:String in payload)
				{
					C.log(name + " = " + payload[name]);
				}
				C.log("---------------------------------");
			}
		}
		
		private function handleActivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
            {
				e.preventDefault();
				NativeApplication.nativeApplication.exit();
            }
		}
		
		private function onResize(e:*=null):void
		{
			if (_txt)
			{
				_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				
				C.x = 0;
				C.y = _txt.y + _txt.height + 0;
				C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
			}
			
			if (_list)
			{
				_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
				_list.row = _numRows;
				_list.itemArrange();
			}
			
			if (_body)
			{
				_body.y = stage.stageHeight - _body.height;
			}
		}
		
		private function init():void
		{
			// Remove OverrideAir debugger in production builds
			OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void
			{
				trace($ane+" ("+$class+") "+$msg);
			});
			
			var isConfigFound:Boolean = Firebase.init();
			
			if (isConfigFound)
			{
				var config:FirebaseConfig = Firebase.getConfig();
				C.log("default_web_client_id = " + 			config.default_web_client_id);
				C.log("firebase_database_url = " + 			config.firebase_database_url);
				C.log("gcm_defaultSenderId = " + 			config.gcm_defaultSenderId);
				C.log("google_api_key = " + 				config.google_api_key);
				C.log("google_app_id = " + 					config.google_app_id);
				C.log("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
				C.log("google_storage_bucket = " + 			config.google_storage_bucket);
				C.log("project_id = " + 					config.project_id);
				
				// FCM needs Google Services so, before using FCM, we need to check that first.
				// https://firebase.google.com/docs/cloud-messaging/android/client#sample-play
				if (OverrideAir.os == OverrideAir.ANDROID) Firebase.checkGoogleAvailability(onCheckResult);
				else onCheckResult(Firebase.SUCCESS);
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function onCheckResult($result:int):void
		{
			switch($result)
			{
				case Firebase.SUCCESS:
					
					C.log("checkGoogleAvailability result = SUCCESS");
					
					// now you can use FCM
					initFCM();
					onResize();
					
				break;
				case Firebase.SERVICE_MISSING:
					
					C.log("checkGoogleAvailability result = SERVICE_MISSING");
					
				break;
				case Firebase.SERVICE_VERSION_UPDATE_REQUIRED:
					
					C.log("checkGoogleAvailability result = SERVICE_VERSION_UPDATE_REQUIRED");
					
				break;
				case Firebase.SERVICE_UPDATING:
					
					C.log("checkGoogleAvailability result = SERVICE_UPDATING");
					
				break;
				case Firebase.SERVICE_DISABLED:
					
					C.log("checkGoogleAvailability result = SERVICE_DISABLED");
					
				break;
				case Firebase.SERVICE_INVALID:
					
					C.log("checkGoogleAvailability result = SERVICE_INVALID");
					
				break;
			}
		}
		
		
		private function initFCM():void
		{
			FCM.init(); 
			FCM.listener.addEventListener(FcmEvents.TOKEN_REFRESH, onTokenRefresh);
			FCM.listener.addEventListener(FcmEvents.MESSAGE, onMessage);
			FCM.listener.addEventListener(FcmEvents.DELETED_MESSAGES, onDeletedMessages);
			
			var btn1:MySprite = createBtn("getToken");
			btn1.addEventListener(MouseEvent.CLICK, getToken);
			_list.add(btn1);
			
			function getToken(e:MouseEvent):void
			{
				FCM.getInstanceId(onTokenReceived);
			}
			
			function onTokenReceived($token:String, $error:String):void
			{
				if($error)
				{
					trace("onTokenReceived error: " + $error);
					C.log("onTokenReceived error: " + $error);
				}
				
				if($token)
				{
					trace("token: " + $token);
					C.log("token: " + $token);
				}
			}
			
			var btn2:MySprite = createBtn("subscribe to 'news'");
			btn2.addEventListener(MouseEvent.CLICK, subscribe);
			_list.add(btn2);
			
			function subscribe(e:MouseEvent):void
			{
				// optionally you can listen to FcmEvents.ON_SUBSCRIBE to know the result
				if(!FCM.listener.hasEventListener(FcmEvents.ON_SUBSCRIBE))
					FCM.listener.addEventListener(FcmEvents.ON_SUBSCRIBE, onSubscribeResult);
				
				// It will take 24 hours before you can see this topic on the Firebase console
				FCM.subscribeToTopic("news");
			}
			
			var btn3:MySprite = createBtn("unsubscribe from 'news'");
			btn3.addEventListener(MouseEvent.CLICK, unsubscribe);
			_list.add(btn3);
			
			function unsubscribe(e:MouseEvent):void
			{
				// optionally you can listen to FcmEvents.ON_UNSUBSCRIBE to know the result
				if(!FCM.listener.hasEventListener(FcmEvents.ON_UNSUBSCRIBE))
					FCM.listener.addEventListener(FcmEvents.ON_UNSUBSCRIBE, onUnsubscribeResult);
				
				FCM.unsubscribeFromTopic("news");
			}
		}
		
		private function onSubscribeResult(e:FcmEvents):void
		{
			trace("subscribe to topic " + e.topic + ": " + e.isSuccessful);
			C.log("subscribe to topic " + e.topic + ": " + e.isSuccessful);
		}
		
		private function onUnsubscribeResult(e:FcmEvents):void
		{
			trace("unsubscribe to topic " + e.topic + ": " + e.isSuccessful);
			C.log("unsubscribe to topic " + e.topic + ": " + e.isSuccessful);
		}
		
		private function onTokenRefresh(e:FcmEvents):void
		{
			trace("onTokenRefresh = " + e.token);
			C.log("onTokenRefresh = " + e.token);
		}
		
		private function onDeletedMessages(e:FcmEvents):void
		{
			C.log("FcmEvents.DELETED_MESSAGES happened!");
		}
		
		private function onMessage(e:FcmEvents):void
		{
			trace(e.msg);
			var payload:Object = FCM.parsePayloadFromString(e.msg);
			
			if (payload)
			{
				for (var name:String in payload)
				{
					C.log(name + " = " + payload[name]);
				}
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createBtn($str:String):MySprite
		{
			var sp:MySprite = new MySprite();
			sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
			sp.addEventListener(MouseEvent.CLICK,  onOut);
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
			sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
			sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
			
			function onOver(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xFFDB48;
				sp.drawBg();
			}
			
			function onOut(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xDFE4FF;
				sp.drawBg();
			}
			
			var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.mouseEnabled = false;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
			txt.defaultTextFormat = format;
			txt.text = $str;
			
			txt.y = sp.height - txt.height >> 1;
			sp.addChild(txt);
			
			return sp;
		}
	}
	
}