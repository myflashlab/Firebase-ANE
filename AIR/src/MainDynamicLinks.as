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
	
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 1/4/2017 4:04 PM
	 */
	public class MainDynamicLinks extends Sprite 
	{
		private var _deepLink:String;
		private var _deepLinkShort:String;
		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainDynamicLinks():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Dynamic Links V"+DynamicLinks.VERSION+"</font>";
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
				_txt.y = 150 * (1 / DeviceInfo.dpiScaleMultiplier);
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
			
			// pass "true" for the init method so the ANE can prepare itself for accepting dynamic links.
			var isConfigFound:Boolean = Firebase.init(true);
			
			if (isConfigFound)
			{
				// to be able to build "short" dynamicLinks, you need to set the Web API Key manually
				// copy this information from Firebase console: https://console.firebase.google.com/project/_/settings/general/
				Firebase.getConfig().webApiKey = "AIzaSyBvWdo5STJ4pPl3FG6MHlEsiguedNzdxhQ";
				
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
			
			// You should immediately listen for possible DynamicLinksEvents.INVOKE event
			DynamicLinks.listener.addEventListener(DynamicLinksEvents.INVOKE, onDynamicLinksInvoke);
			
			
			
			var btn1:MySprite = createBtn("build a deeplink");
			btn1.addEventListener(MouseEvent.CLICK, buildDeepLink);
			_list.add(btn1);
			
			function buildDeepLink(e:MouseEvent):void
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
				
				// add optional Analytics params: http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/dynamicLinks/AnalyticsParams.html
				var analyticsParams:AnalyticsParams = new AnalyticsParams();
				
				// add optional otherPlatform params: http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/dynamicLinks/OtherPlatformParams.html
				var otherPlatformParams:OtherPlatformParams = new OtherPlatformParams();
				
				// add optional navigation params: http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/dynamicLinks/NavigationParams.html
				var navigationParams:NavigationParams = new NavigationParams();
				
				// first create your URL Prefix from your Firebase Console: https://console.firebase.google.com/project/_/durablelinks/links/
				_deepLink = DynamicLinks.build(
						"myflashlabs.page.link",
						"https://www.myflashlabs.com/deeplinks",
						androidParams,
						iosParams,
						socialMediaParams,
						analyticsParams,
						otherPlatformParams,
						navigationParams,
						"MY_INVITATION_ID");
				
				trace(_deepLink);
				C.log(_deepLink);
			}
			
			var btn2:MySprite = createBtn("make it short!");
			btn2.addEventListener(MouseEvent.CLICK, makeItShort);
			_list.add(btn2);
			
			function makeItShort(e:MouseEvent):void
			{
				if(!_deepLink)
				{
					C.log("First create a deeplink!");
					trace("First create a deeplink!");
					return;
				}
				
				DynamicLinks.toMakeShort(_deepLink, function ($link:String, $raw:String):void
				{
					trace("$raw = " + $raw);
					
					if($link)
					{
						_deepLinkShort = $link;
						C.log("$link = " + _deepLinkShort);
						trace("$link = " + _deepLinkShort);
					}
				});
			}
			
			var btn3:MySprite = createBtn("share deeplink");
			btn3.addEventListener(MouseEvent.CLICK, shareDeeplink);
			_list.add(btn3);
			
			function shareDeeplink(e:MouseEvent):void
			{
				if(!_deepLinkShort)
				{
					C.log("First create a _deepLinkShort!");
					return;
				}
				
				DynamicLinks.share("Title", _deepLinkShort);
			}
			
			onResize();
		}
		
		private function onDynamicLinksInvoke(e:DynamicLinksEvents):void
		{
			C.log("e.link = " + e.link);
			C.log("e.invitationId = " + e.invitationId);
			
			trace("e.link = " + e.link);
			trace("e.invitationId = " + e.invitationId);
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