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

	import com.myflashlab.air.extensions.dependency.OverrideAir;
	import com.myflashlab.air.extensions.firebase.core.*;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 5/28/2016 10:36 AM
	 * 						 - 1/4/2017 7:39 PM
	 * 						 - 9/10/2018 3:15 PM
	 */
	public class Main extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function Main():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Core V"+Firebase.VERSION+"</font>";
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
			
			toTrace("framerate: " + stage.frameRate);
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
			
			var isConfigFound:Boolean = Firebase.init();
			Firebase.setLoggerLevel(FirebaseConfig.LOGGER_LEVEL_MAX);
			Firebase.dataCollectionDefaultEnabled = true;

			if (isConfigFound)
			{
				var config:FirebaseConfig = Firebase.getConfig();
				toTrace("default_web_client_id = " + 			config.default_web_client_id);
				toTrace("firebase_database_url = " + 			config.firebase_database_url);
				toTrace("gcm_defaultSenderId = " + 			config.gcm_defaultSenderId);
				toTrace("google_api_key = " + 				config.google_api_key);
				toTrace("google_app_id = " + 					config.google_app_id);
				toTrace("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
				toTrace("google_storage_bucket = " + 			config.google_storage_bucket);
				toTrace("project_id = " + 					config.project_id);
				
				// You must initialize any of the other Firebase children after a successful initialization
				// of the Core ANE.
				readyToUseFirebase();
			}
			else
			{
				toTrace("Config file is not found!");
			}
		}
		
		private function readyToUseFirebase():void
		{
			Firebase.installations.addEventListener(FirebaseEvents.FIS_FID, onInstallationsIdReceived)
			Firebase.installations.addEventListener(FirebaseEvents.FIS_TOKEN, onInstallationsTokenReceived)

			var btn10:MySprite = createBtn("get installations id");
			btn10.addEventListener(MouseEvent.CLICK, getInstallationsId);
			_list.add(btn10);

			function getInstallationsId(e:MouseEvent):void
			{
				// you must be listening to FirebaseEvents.FIS_FID
				Firebase.installations.getId();
			}

			var btn11:MySprite = createBtn("get installations token");
			btn11.addEventListener(MouseEvent.CLICK, getInstallationsToken);
			_list.add(btn11);

			function getInstallationsToken(e:MouseEvent):void
			{
				// you must be listening to FirebaseEvents.FIS_TOKEN
				Firebase.installations.getToken(false);
			}

			var btn12:MySprite = createBtn("delete installations");
			btn12.addEventListener(MouseEvent.CLICK, deleteInstallations);
			_list.add(btn12);

			function deleteInstallations(e:MouseEvent):void
			{
				Firebase.installations.remove();
			}

			var btn5:MySprite = createBtn("get frame rate");
			btn5.addEventListener(MouseEvent.CLICK, getFrameRate);
			_list.add(btn5);
			
			function getFrameRate(e:MouseEvent):void
			{
				toTrace("framerate: " + stage.frameRate);
			}
			
			onResize();
		}

		private function onInstallationsIdReceived(e:FirebaseEvents):void
		{
			toTrace("installations id = "+e.installationsId);
		}

		private function onInstallationsTokenReceived(e:FirebaseEvents):void
		{
			toTrace("installations token = "+e.installationsToken);
		}

		private function toTrace(...rest):void
		{
			C.log(rest);
			trace(rest);
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