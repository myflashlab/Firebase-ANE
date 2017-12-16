package 
{
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	
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
	
	import com.luaye.console.C;
	
	import com.myflashlab.air.extensions.dependency.OverrideAir;
	import com.myflashlab.air.extensions.firebase.core.*;
	import com.myflashlab.air.extensions.firebase.dynamicLinks.*;
	import com.myflashlab.air.extensions.firebase.invites.*;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 2/7/2017 7:17 PM
	 */
	public class MainInvites extends Sprite 
	{
		private var _deepLink:String;
		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainInvites():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Invites V"+Firebase.VERSION+"</font>";
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
			//C.log(e.arguments);
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
			
			// pass "true" for the init method so the ANE can prepare itself for accepting dynamic links / invites.
			var isConfigFound:Boolean = Firebase.init(true);
			
			if (isConfigFound)
			{
				// to be able to build dynamicLinks, you need to set the Web API Key manually
				// copy this information from Firebase console: https://console.firebase.google.com/project/_/settings/general/
				Firebase.getConfig().webApiKey = "AIzySaBvQto5SVR6pPl8FU6LHlFsrgnepNhzxhQ";
				
				var config:FirebaseConfig = Firebase.getConfig();
				C.log("webApiKey = " + 						config.webApiKey);
				C.log("default_web_client_id = " + 			config.default_web_client_id);
				C.log("firebase_database_url = " + 			config.firebase_database_url);
				C.log("gcm_defaultSenderId = " + 			config.gcm_defaultSenderId);
				C.log("google_api_key = " + 				config.google_api_key);
				C.log("google_app_id = " + 					config.google_app_id);
				C.log("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
				C.log("google_storage_bucket = " + 			config.google_storage_bucket);
				C.log("project_id = " + 					config.project_id);
				
				initDynamicLinks();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function initDynamicLinks():void
		{
			// DynamicLinks class must be initialized right after Firebase.init(true); and as soon as possible.
			DynamicLinks.init();
			
			// You should immedietly listen for possible DynamicLinksEvents.INVOKE event
			DynamicLinks.listener.addEventListener(DynamicLinksEvents.INVOKE, onDynamicLinksInvoke);
			
			buildDeepLink();
			
			// when sending an invitation, you should use the dynamiclinks ANE to generate a valid deeplink
			function buildDeepLink():void
			{
				var androidParams:AndroidParams = new AndroidParams();
				androidParams.apn = "air." + NativeApplication.nativeApplication.applicationID;
				androidParams.amv = 3;
				
				var iosParams:IosParams = new IosParams();
				iosParams.ibi = NativeApplication.nativeApplication.applicationID;
				iosParams.isi = "2293507574";
				
				var socialMediaParams:SocialMediaParams = new SocialMediaParams();
				socialMediaParams.st = "my Social Media title";
				socialMediaParams.sd = "my Social Media description";
				
				var analyticsParams:AnalyticsParams = new AnalyticsParams();
				
				DynamicLinks.api.build("r23kf", "http://www.myflashlabs.com/deeplinks", false, androidParams, iosParams, socialMediaParams, analyticsParams, onDeeplinkBuiltDone);
			}
		}
		
		private function onDeeplinkBuiltDone($deeplink:String, $raw:String):void
		{
			if ($raw)
			{
				//trace("$raw = " + $raw);
			}
			
			if($deeplink)
			{
				_deepLink = $deeplink;
				//C.log("_deepLink = " + _deepLink);
				//trace("_deepLink = " + _deepLink);
				
				var btn1:MySprite = createBtn("send invitation");
				btn1.addEventListener(MouseEvent.CLICK, sendInvitation);
				_list.add(btn1);
				
				onResize();
			}
			
			function sendInvitation(e:MouseEvent):void
			{
				// customize the invitation
				var invitationBuilder:InvitesBuilder = new InvitesBuilder();
				invitationBuilder.title = "my Title";
				invitationBuilder.msg = "My Message";
				invitationBuilder.callToAction = "Join the club!";
				invitationBuilder.url = _deepLink;
				invitationBuilder.img = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png";
				
				if (Firebase.os == Firebase.ANDROID)
				{
					invitationBuilder.otherPlatform = Invites.PROJECT_PLATFORM_IOS;
					invitationBuilder.otherPlatformClientId = "183683121391-5t7j6ara6qgbwjub3636im7h5q2lgceb.apps.googleusercontent.com";
				}
				else
				{
					invitationBuilder.otherPlatform = Invites.PROJECT_PLATFORM_ANDROID;
					invitationBuilder.otherPlatformClientId = "183683121391-h2hoth005fu6ata6n6pij4pba3297fe5.apps.googleusercontent.com";
				}
				
				/*
					NOTE: On iOS, invitation can be sent ONLY if the user is logged in with GoogleSignin ANE
				*/
				
				// send the invitation
				Invites.send(invitationBuilder, onFirebaseInviteResult);
			}
		}
		
		private function onDynamicLinksInvoke(e:DynamicLinksEvents):void
		{
			C.log("e.link = " + e.link);
			C.log("e.invitationId = " + e.invitationId);
		}
		
		private function onFirebaseInviteResult($invitationIds:Array):void
		{
			if ($invitationIds)
			{
				C.log($invitationIds);
			}
			else
			{
				C.log("invitation canceled or closed.");
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