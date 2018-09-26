package 
{
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	
	import com.luaye.console.C;
import com.myflashlab.air.extensions.dependency.OverrideAir;

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
	import com.myflashlab.air.extensions.firebase.remoteConfig.*;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 5/28/2016 10:36 AM
	 */
	public class MainRemoteConfig extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainRemoteConfig():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase RemoteConfig V"+Firebase.VERSION+"</font>";
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
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
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
		
		private function myDebuggerDelegate($ane:String, $class:String, $msg:String):void
		{
			trace($ane + "(" + $class + ")" + " " + $msg);
		}
		
		private function init():void
		{
			// remove this line in production build or pass null as the delegate
			OverrideAir.enableDebugger(myDebuggerDelegate);
			
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
				
				initRemoteConfig();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		
		private function initRemoteConfig():void
		{
			// initialize RemoteConfig only once in your app
			RemoteConfig.init();
			
			// start listening to the fetch results
			RemoteConfig.listener.addEventListener(RemoteConfigEvents.FETCH_RESULT, onFetched);
			
			// when developing, set this to true so the developer mode will be on
			RemoteConfig.setConfigSettings(true);
			
			// create an object with the following format (key/value) and add all your default values to it.
			var myDefaults:Object = {};
			myDefaults["first_key"] = "my default value";
			
			// insert the default values to the ANE
			RemoteConfig.setDefaults(myDefaults);
			
			
			var btn1:MySprite = createBtn("fetch");
			btn1.addEventListener(MouseEvent.CLICK, fetch);
			_list.add(btn1);
			
			function fetch(e:MouseEvent):void
			{
				var cacheExpiration:Number = 3600; // 1 hour in seconds.
				
				C.log("isDeveloperModeEnabled = " + RemoteConfig.isDeveloperModeEnabled);
				
				if (RemoteConfig.isDeveloperModeEnabled)
				{
					// If in developer mode cacheExpiration is set to 0 so each fetch will retrieve values from the server.
					cacheExpiration = 0;
				}
				
				// when you call fetch, make sure you are listening to the RemoteConfigEvents.FETCH_RESULT event to know the fetch result
				RemoteConfig.fetch(cacheExpiration);
			}
			
			var btn2:MySprite = createBtn("get source");
			btn2.addEventListener(MouseEvent.CLICK, getSource);
			_list.add(btn2);
			
			function getSource(e:MouseEvent):void
			{
				// get the source for your values to know if they are local or from Firebase servers
				var source:int = RemoteConfig.getSource("first_key");
				
				switch (source) 
				{
					case RemoteConfig.VALUE_SOURCE_DEFAULT:
						C.log("source = VALUE_SOURCE_DEFAULT");
					break;
					case RemoteConfig.VALUE_SOURCE_REMOTE:
						C.log("source = VALUE_SOURCE_REMOTE");
					break;
					case RemoteConfig.VALUE_SOURCE_STATIC:
						C.log("source = VALUE_SOURCE_STATIC");
					break;
					default:
				}
			}
			
			var btn3:MySprite = createBtn("get value");
			btn3.addEventListener(MouseEvent.CLICK, getValue);
			_list.add(btn3);
			
			function getValue(e:MouseEvent):void
			{
				var value:String = RemoteConfig.getValue("first_key", RemoteConfig.AS_STRING) as String;
				
				C.log("value = " + value);
			}
		}
		
		private function onFetched(e:RemoteConfigEvents):void
		{
			if (e.result == 1)
			{
				C.log("onFetched was successfull, Now, let's call RemoteConfig.activateFetched() to activate the new data");
				
				// When you fetch the new information from server, you can activate them anytime you think is appropriate in your app
				RemoteConfig.activateFetched();
			}
			else
			{
				C.log("onFetched was NOT successfull");
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