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
	import com.myflashlab.air.extensions.firebase.auth.*;
	import com.myflashlab.air.extensions.inspector.Inspector;
	import com.myflashlab.air.extensions.dependency.OverrideAir;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 7/13/2016 4:10 PM
	 */
	public class MainAuth extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainAuth():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Auth V"+Firebase.VERSION+"</font>";
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
			trace("------------------");
			trace("$ane = " + $ane);
			trace("$class = " + $class);
			trace("$msg = " + $msg);
			trace("------------------");
		}
		
		private function init():void
		{
			// remove this line in production build or pass null as the delegate
			OverrideAir.enableDebugger(myDebuggerDelegate);
			
			var isConfigFound:Boolean = Firebase.init();
			
			if (isConfigFound)
			{
				var config:FirebaseConfig = Firebase.getConfig();
				C.log("default_web_client_id = " + 				config.default_web_client_id);
				C.log("firebase_database_url = " + 				config.firebase_database_url);
				C.log("gcm_defaultSenderId = " + 				config.gcm_defaultSenderId);
				C.log("google_api_key = " + 					config.google_api_key);
				C.log("google_app_id = " + 						config.google_app_id);
				C.log("google_crash_reporting_api_key = " + 	config.google_crash_reporting_api_key);
				C.log("google_storage_bucket = " + 				config.google_storage_bucket);
				
				initFirebaseAuth();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function initFirebaseAuth():void
		{
			/*
			 	How to use the inspector ANE: https://github.com/myflashlab/ANE-Inspector-Tool
				You can use the same trick for all the other Child ANEs and other MyFlashLabs ANEs.
				All you have to do is to pass the Class name of the target ANE to the check method.
			*/
			/*if (!Inspector.check(Auth, true, true))
			{
				C.log("Inspector.lastError = " + Inspector.lastError);
				return;
			}*/
			
			Auth.init();
			
			Auth.listener.addEventListener(AuthEvents.AUTH_STATE_CHANGED, 				onAuthStateChanged);
			Auth.listener.addEventListener(AuthEvents.CREATE_NEW_USER_RESULT, 			onCreateNewUserResult);
			Auth.listener.addEventListener(AuthEvents.SIGN_IN_RESULT, 					onSignInResult);
			Auth.listener.addEventListener(AuthEvents.SEND_PASSWORD_RESET_EMAIL_RESULT, onPassResetResult);
			
			// -----------------------------------------------------------
			var btn1:MySprite = createBtn("is signed in?");
			btn1.addEventListener(MouseEvent.CLICK, isLoggin);
			_list.add(btn1);
			
			function isLoggin(e:MouseEvent):void
			{
				if (Auth.isLoggin)
				{
					C.log("user is logged in");
					getUserInfo();
				}
				else
				{
					C.log("user is NOT logged in");
				}
			}
			
			// -----------------------------------------------------------
			var btn2:MySprite = createBtn("register");
			btn2.addEventListener(MouseEvent.CLICK, register);
			_list.add(btn2);
			
			function register(e:MouseEvent):void
			{
				Auth.createUserWithEmailAndPassword("email@myflashlabs.com", "123456");
			}
			
			// -----------------------------------------------------------
			var btn3:MySprite = createBtn("signOut");
			btn3.addEventListener(MouseEvent.CLICK, signOut);
			_list.add(btn3);
			
			function signOut(e:MouseEvent):void
			{
				Auth.signOut();
			}
			
			// -----------------------------------------------------------
			var btn4:MySprite = createBtn("signIn");
			btn4.addEventListener(MouseEvent.CLICK, signIn);
			_list.add(btn4);
			
			function signIn(e:MouseEvent):void
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailAuthProvider("email@myflashlabs.com", "123456");
				
				// and finally feed in the Auth.signIn method with the parsed credential info from the authProvider instance.
				Auth.signIn(authProvider.getCredential());
			}
			
			// -----------------------------------------------------------
			var btn04:MySprite = createBtn("signIn anonymously");
			btn04.addEventListener(MouseEvent.CLICK, signInAnonymously);
			_list.add(btn04);
			
			function signInAnonymously(e:MouseEvent):void
			{
				Auth.signIn(null);
			}
			
			// -----------------------------------------------------------
			var btn5:MySprite = createBtn("send pass reset");
			btn5.addEventListener(MouseEvent.CLICK, sendPassReset);
			_list.add(btn5);
			
			function sendPassReset(e:MouseEvent):void
			{
				Auth.sendPasswordResetEmail("email@myflashlabs.com");
			}
			
			// -----------------------------------------------------------
			var btn6:MySprite = createBtn("reload user info");
			btn6.addEventListener(MouseEvent.CLICK, reloadUserInfo);
			_list.add(btn6);
			
			function reloadUserInfo(e:MouseEvent):void
			{
				if (FirebaseUser.isAvailable) FirebaseUser.reload();
				else C.log("FirebaseUser is not available");
			}
			
			// -----------------------------------------------------------
			var btn7:MySprite = createBtn("update display name");
			btn7.addEventListener(MouseEvent.CLICK, updateDisplayName);
			_list.add(btn7);
			
			function updateDisplayName(e:MouseEvent):void
			{
				if (FirebaseUser.isAvailable) FirebaseUser.updateProfile("Hadi");
				else C.log("FirebaseUser is not available");
			}
			
			// -----------------------------------------------------------
			var btn8:MySprite = createBtn("update email");
			btn8.addEventListener(MouseEvent.CLICK, updateEmail);
			_list.add(btn8);
			
			function updateEmail(e:MouseEvent):void
			{
				if (FirebaseUser.isAvailable) FirebaseUser.updateEmail("email@myflashlabs.com");
				else C.log("FirebaseUser is not available");
			}
			
			// -----------------------------------------------------------
			var btn9:MySprite = createBtn("get user token");
			btn9.addEventListener(MouseEvent.CLICK, getToken);
			_list.add(btn9);
			
			function getToken(e:MouseEvent):void
			{
				if (FirebaseUser.isAvailable) FirebaseUser.getToken(false);
				else C.log("FirebaseUser is not available");
			}
		}
		
		private function getUserInfo():void
		{
			C.log("displayName = " + 		FirebaseUser.displayName);
			C.log("email = " + 				FirebaseUser.email);
			C.log("photoUrl = " + 			FirebaseUser.photoUrl);
			C.log("providerId = " + 		FirebaseUser.providerId);
			C.log("userId = " + 			FirebaseUser.userId);
			C.log("isEmailVerified = " +	FirebaseUser.isEmailVerified);
			
			var userInfoOnProviders:UserInfo;
			for (var i:int = 0; i < FirebaseUser.providersData.length; i++) 
			{
				userInfoOnProviders = FirebaseUser.providersData[i];
				C.log("-------------")
				C.log("providerId = " + 		userInfoOnProviders.providerId);
				C.log("displayName = " + 		userInfoOnProviders.displayName);
				C.log("email = " + 				userInfoOnProviders.email);
				C.log("photoUrl = " + 			userInfoOnProviders.photoUrl);
				C.log("userId = " + 			userInfoOnProviders.userId);
				C.log("-------------")
			}
		}
		
		private function onCreateNewUserResult(e:AuthEvents):void
		{
			C.log("onCreateNewUserResult result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onSignInResult(e:AuthEvents):void
		{
			C.log("onSignInResult result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onPassResetResult(e:AuthEvents):void
		{
			C.log("onPassResetResult result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onAuthStateChanged(e:AuthEvents):void
		{
			// check if the user info is available or not
			if (FirebaseUser.isAvailable)
			{
				C.log("user is logged in");
				getUserInfo();
				
				// when you are logged in, it's a good time to add user listeners
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.RELOAD_USER_INFO, 		onReloadUserInfo);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.REAUTHENTICATE_RESULT, 	onReauthenticate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.GET_USER_TOKEN, 			onGetUserToken);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.UNLINK_RESULT, 			onUnlink);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.LINK_WITH_RESULT, 		onLink);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.PROFILE_UPDATE_RESULT, 	onProfileUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.PASSWORD_UPDATE_RESULT, 	onPassUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.EMAIL_UPDATE_RESULT, 		onEmailUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.DELETE_USER_RESULT, 		onDeleteUser);
			}
			else
			{
				C.log("user is NOT logged in");
				
				// When logged out, it's a good idea to remove the user listeners
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.RELOAD_USER_INFO, 			onReloadUserInfo);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.REAUTHENTICATE_RESULT, 	onReauthenticate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.GET_USER_TOKEN, 			onGetUserToken);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.UNLINK_RESULT, 			onUnlink);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.LINK_WITH_RESULT, 			onLink);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.PROFILE_UPDATE_RESULT, 	onProfileUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.PASSWORD_UPDATE_RESULT, 	onPassUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.EMAIL_UPDATE_RESULT, 		onEmailUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.DELETE_USER_RESULT, 		onDeleteUser);
			}
		}
		
		private function onReloadUserInfo(e:FirebaseUserEvents):void
		{
			C.log("onReloadUserInfo result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onReauthenticate(e:FirebaseUserEvents):void
		{
			C.log("onReauthenticate result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onGetUserToken(e:FirebaseUserEvents):void
		{
			C.log("onGetUserToken result=" + e.result, "     token=" + e.token);
		}
		
		private function onUnlink(e:FirebaseUserEvents):void
		{
			C.log("onUnlink result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onLink(e:FirebaseUserEvents):void
		{
			C.log("onLink result=" + e.result, "     msg=" + e.msg);
			
			// when receiving this result, you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again.
			if (e.result == Auth.RESULT_AUTH_RECENT_LOGIN_REQUIERD)
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailAuthProvider("email@myflashlabs.com", "123456");
				
				// and finally feed in the FirebaseUser.reauthenticate method with the parsed credential info from the authProvider instance.
				FirebaseUser.reauthenticate(authProvider.getCredential());
			}
		}
		
		private function onProfileUpdate(e:FirebaseUserEvents):void
		{
			C.log("onProfileUpdate result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onPassUpdate(e:FirebaseUserEvents):void
		{
			C.log("onPassUpdate result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onEmailUpdate(e:FirebaseUserEvents):void
		{
			C.log("onEmailUpdate result=" + e.result, "     msg=" + e.msg);
			
			// when receiving this result, you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again.
			if (e.result == Auth.RESULT_AUTH_RECENT_LOGIN_REQUIERD)
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailAuthProvider("email@myflashlabs.com", "123456");
				
				// and finally feed in the FirebaseUser.reauthenticate method with the parsed credential info from the authProvider instance.
				FirebaseUser.reauthenticate(authProvider.getCredential());
			}
		}
		
		private function onDeleteUser(e:FirebaseUserEvents):void
		{
			C.log("onDeleteUser result=" + e.result, "     msg=" + e.msg);
			
			// when receiving this result, you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again.
			if (e.result == Auth.RESULT_AUTH_RECENT_LOGIN_REQUIERD)
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailAuthProvider("email@myflashlabs.com", "123456");
				
				// and finally feed in the FirebaseUser.reauthenticate method with the parsed credential info from the authProvider instance.
				FirebaseUser.reauthenticate(authProvider.getCredential());
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