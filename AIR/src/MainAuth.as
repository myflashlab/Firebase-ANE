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
	import com.myflashlab.air.extensions.firebase.dynamicLinks.*;
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
		
		private var email:String = "email@gmail.com";
		
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
			trace($ane + "(" + $class + ")" + " " + $msg);
		}
		
		private function init():void
		{
			// remove this line in production build or pass null as the delegate
			OverrideAir.enableDebugger(myDebuggerDelegate);
			
			// pass "true" for the init method so the ANE can prepare itself for accepting dynamic links.
			var isConfigFound:Boolean = Firebase.init(true);
			
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
				C.log("project_id = " + 						config.project_id);
				
				initFirebaseAuth();
				initDynamicLinks();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function initFirebaseAuth():void
		{
			Auth.init();
			
			Auth.listener.addEventListener(AuthEvents.AUTH_STATE_CHANGED, 				onAuthStateChanged);
			Auth.listener.addEventListener(AuthEvents.ID_TOKEN_CHANGED, 				onIdTokenChanged);
			Auth.listener.addEventListener(AuthEvents.CREATE_NEW_USER_RESULT, 			onCreateNewUserResult);
			Auth.listener.addEventListener(AuthEvents.SIGN_IN_RESULT, 					onSignInResult);
			Auth.listener.addEventListener(AuthEvents.SEND_PASSWORD_RESET_EMAIL_RESULT, onPassResetResult);
			Auth.listener.addEventListener(AuthEvents.SEND_SIGNIN_LINK_RESULT, 			onSignInLinkResult);
			
			// -----------------------------------------------------------
			var btn01:MySprite = createBtn("isLoggin?");
			btn01.addEventListener(MouseEvent.CLICK, isLoggin);
			_list.add(btn01);
			
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
			var btn2:MySprite = createBtn("create User With Email & Pass");
			btn2.addEventListener(MouseEvent.CLICK, register);
			_list.add(btn2);
			
			function register(e:MouseEvent):void
			{
				if (Auth.isLoggin)
				{
					C.log("user is already signed in.")
				}
				else
				{
					Auth.createUserWithEmailAndPassword(email, "123456");
				}
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
				authProvider.setEmailPassAuthProvider(email, "123456");
				
				// and finally feed the Auth.signIn method with the parsed credential info from the authProvider instance.
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
				/*
				
					To use ActionCodeSettings, your app must have Firebase Dynamic Links enabled and ready:
					https://github.com/myflashlab/Firebase-ANE/wiki/I.1-Add-Dynamic-links
				
				// make sure you have whitelisted your domain in your firebase console/Authentication section, before trying this.
				var settings:ActionCodeSettings = new ActionCodeSettings("https://example.com/");
				settings.handleCodeInApp = true;*/
				
				Auth.sendPasswordResetEmail(email/*, settings*/);
			}
			
			// -----------------------------------------------------------
			
			var btn005:MySprite = createBtn("send signin link to email");
			btn005.addEventListener(MouseEvent.CLICK, sendSigninLink);
			_list.add(btn005);
			
			function sendSigninLink(e:MouseEvent):void
			{
				/*
				
					To use ActionCodeSettings, your app must have Firebase Dynamic Links enabled and ready:
					https://github.com/myflashlab/Firebase-ANE/wiki/I.1-Add-Dynamic-links
				
				*/
				
				// make sure you have whitelisted your domain in your firebase console/Authentication section, before trying this.
				var settings:ActionCodeSettings = new ActionCodeSettings("https://www.myflashlabs.com/");
				settings.handleCodeInApp = true; // The sign-in operation has to always be completed in the app.
				settings.iOSBundleID = NativeApplication.nativeApplication.applicationID;
				settings.androidPackageName = "air." + NativeApplication.nativeApplication.applicationID;
				settings.androidInstallIfNotAvailable = false;
				settings.androidMinVersion = "1";
				
				Auth.sendSignInLinkToEmail(email, settings);
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
			var btn06:MySprite = createBtn("send verify email");
			btn06.addEventListener(MouseEvent.CLICK, verifyEmail);
			_list.add(btn06);
			
			function verifyEmail(e:MouseEvent):void
			{
				if (FirebaseUser.isEmailVerified)
				{
					C.log("email is already verified.");
					return;
				}
				
				/*
				
					To use ActionCodeSettings, your app must have Firebase Dynamic Links enabled and ready:
					https://github.com/myflashlab/Firebase-ANE/wiki/I.1-Add-Dynamic-links
				
				// make sure you have whitelisted your domain in your firebase console/Authentication section, before trying this.
				var settings:ActionCodeSettings = new ActionCodeSettings("https://example.com/");
				settings.handleCodeInApp = true;
				*/
				
				FirebaseUser.sendEmailVerification(/*settings*/);
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
				if (FirebaseUser.isAvailable) FirebaseUser.updateEmail(email);
				else C.log("FirebaseUser is not available");
			}
			
			// -----------------------------------------------------------
			var btn9:MySprite = createBtn("get user token");
			btn9.addEventListener(MouseEvent.CLICK, getIdToken);
			_list.add(btn9);
			
			function getIdToken(e:MouseEvent):void
			{
				if (FirebaseUser.isAvailable) FirebaseUser.getIdToken(false);
				else C.log("FirebaseUser is not available");
			}
			
			// -----------------------------------------------------------
			var btn10:MySprite = createBtn("verifyPhoneNumber");
			btn10.addEventListener(MouseEvent.CLICK, verifyPhoneNumber);
			_list.add(btn10);
			
			function verifyPhoneNumber(e:MouseEvent):void
			{
				Auth.listener.addEventListener(AuthEvents.PHONE_VERIFICATION_RESULT, onPhoneVerificationResult);
				Auth.listener.addEventListener(AuthEvents.PHONE_CODE_SENT, onPhoneCodeSent);
				Auth.listener.addEventListener(AuthEvents.PHONE_AUTO_RETRIEVAL_TIME_OUT, onPhoneTimeout);
				
				// phone number format: +(country code)(mobile number with no initial zero)
				Auth.verifyPhoneNumber("+11222222222");
			}
			
			// -----------------------------------------------------------
			/*
			var btn11:MySprite = createBtn("signin with phone");
			btn11.addEventListener(MouseEvent.CLICK, signinWithPhone);
			_list.add(btn11);
			
			function signinWithPhone(e:MouseEvent):void
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setPhoneAuthProvider("verificationId-received-from-AuthEvents.PHONE_CODE_SENT", "SMS-code-found-in-the-sms");
				
				// and finally feed Auth.signIn method with the parsed credential info from the authProvider instance.
				Auth.signIn(authProvider.getCredential());
			}
			*/
			
			// -----------------------------------------------------------
			
			var btn12:MySprite = createBtn("fetch SignIn Methods");
			btn12.addEventListener(MouseEvent.CLICK, fetchSignInMethods);
			_list.add(btn12);
			
			function fetchSignInMethods(e:MouseEvent):void
			{
				Auth.fetchSignInMethodsForEmail(email, function ($methods:Array, $error:Error):void
				{
					if($error)
					{
						trace("fetchSignInMethods: " + $error.message);
					}
					else
					{
						trace("fetchSignInMethods: " + $methods);
					}
				});
			}
		}
		
		private function initDynamicLinks():void
		{
			// DynamicLinks class must be initialized right after Firebase.init(true); and as soon as possible.
			DynamicLinks.init();
			
			// You should immediately listen for possible DynamicLinksEvents.INVOKE event
			DynamicLinks.listener.addEventListener(DynamicLinksEvents.INVOKE, onDynamicLinksInvoke);
		}
		
		private function onDynamicLinksInvoke(e:DynamicLinksEvents):void
		{
			if(Auth.isSignInWithEmailLink(e.link))
			{
				// listen to SIGN_IN_RESULT like how you did for other signin methods
				Auth.listener.addEventListener(AuthEvents.SIGN_IN_RESULT, onSignInResult);
				
				Auth.signInWithEmailLink(email, e.link);
			}
		}
		
		private function onPhoneVerificationResult(e:AuthEvents):void
		{
			// You don't need to do anything when the verification is successful
			// On a successful verification, the ANE will try to sign-in the user automatically.
			C.log("PHONE_VERIFICATION_RESULT, smsCode = " + e.smsCode);
			C.log("PHONE_VERIFICATION_RESULT, msg = " + e.msg);
		}
		
		private function onPhoneCodeSent(e:AuthEvents):void
		{
			// On most Android devices, the ANE reads the sms automatically so you don't have to
			// pass the verificationId + the user input (the sms code) to the signIn method.
			// But on iOS, and sometimes on Android, you MUST save the verificationId and later
			// pass it to Auth.signIn(authProvider.getCredential());
			C.log("PHONE_CODE_SENT, verificationId = " + e.verificationId);
			trace("PHONE_CODE_SENT, verificationId = " + e.verificationId);
		}
		
		private function onPhoneTimeout(e:AuthEvents):void
		{
			C.log("PHONE_AUTO_RETRIEVAL_TIME_OUT, verificationId = " + e.verificationId);
		}
		
		private function getUserInfo():void
		{
			C.log("displayName = " + 		FirebaseUser.displayName);
			C.log("email = " + 				FirebaseUser.email);
			C.log("photoUrl = " + 			FirebaseUser.photoUrl);
			C.log("phoneNumber = " + 		FirebaseUser.phoneNumber);
			C.log("providerId = " + 		FirebaseUser.providerId);
			C.log("userId = " + 			FirebaseUser.userId);
			C.log("isEmailVerified = " +	FirebaseUser.isEmailVerified);
			if(FirebaseUser.metadata)
			{
				C.log("creatinTime = " + 	new Date(FirebaseUser.metadata.creationTime).toLocaleString());
				C.log("lastSignInTime = " + new Date(FirebaseUser.metadata.lastSignInTime).toLocaleString());
			}
			
			var userInfoOnProviders:UserInfo;
			for (var i:int = 0; i < FirebaseUser.providersData.length; i++) 
			{
				userInfoOnProviders = FirebaseUser.providersData[i];
				C.log("-------------")
				C.log("providerId = " + 		userInfoOnProviders.providerId);
				C.log("displayName = " + 		userInfoOnProviders.displayName);
				C.log("email = " + 				userInfoOnProviders.email);
				C.log("photoUrl = " + 			userInfoOnProviders.photoUrl);
				C.log("phoneNumber = " + 		userInfoOnProviders.phoneNumber);
				C.log("userId = " + 			userInfoOnProviders.userId);
				C.log("-------------")
			}
		}
		
		private function onCreateNewUserResult(e:AuthEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("new user created successfully");
				
				if(e.additionalUserInfo)
				{
					trace("-------------- additionalUserInfo ------------");
					trace("providerId: " + e.additionalUserInfo.providerId);
					trace("username: " + e.additionalUserInfo.username);
					trace("isNewUser: " + e.additionalUserInfo.isNewUser);
					trace("profile: " + JSON.stringify(e.additionalUserInfo.profile));
					trace("----------------------------------------------");
				}
				
				/*
					When a new user is created, it will automatically sign in. That means the
					AUTH_STATE_CHANGED event will be dispatched which you can use to read user's
					information.
				*/
			}
			else
			{
				trace("onCreateNewUserResult: " + e.msg);
			}
		}
		
		private function onSignInResult(e:AuthEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("signed in successfully");
				
				if(e.additionalUserInfo)
				{
					trace("-------------- additionalUserInfo ------------");
					trace("providerId: " + e.additionalUserInfo.providerId);
					trace("username: " + e.additionalUserInfo.username);
					trace("isNewUser: " + e.additionalUserInfo.isNewUser);
					trace("profile: " + JSON.stringify(e.additionalUserInfo.profile));
					trace("----------------------------------------------");
				}
				
				/*
					When sign in is successful, the AUTH_STATE_CHANGED event will be dispatched which
					you can use to read user's information.
				*/
			}
			else
			{
				trace("onSignInResult: " + e.msg);
			}
		}
		
		private function onSignInLinkResult(e:AuthEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onSignInLinkResult email sent");
			}
			else
			{
				trace("onSignInLinkResult: " + e.msg);
			}
		}
		
		private function onPassResetResult(e:AuthEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onPassResetResult successfully");
			}
			else
			{
				trace("onPassResetResult: " + e.msg);
			}
		}
		
		private function onIdTokenChanged(e:AuthEvents):void
		{
			trace("onIdTokenChanged, get id token from FirebaseUser.getIdToken(false)");
		}
		
		private function onAuthStateChanged(e:AuthEvents):void
		{
			// check if the user info is available or not
			if (FirebaseUser.isAvailable)
			{
				C.log("user is logged in");
				getUserInfo();
				
				// when you are logged in, it's a good time to add user listeners
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.RELOAD_USER_INFO, 				onReloadUserInfo);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.REAUTHENTICATE_RESULT, 			onReauthenticate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.GET_USER_TOKEN, 					onGetUserToken);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.UNLINK_RESULT, 					onUnlink);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.LINK_WITH_RESULT, 				onLink);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.PROFILE_UPDATE_RESULT, 			onProfileUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.PASSWORD_UPDATE_RESULT, 			onPassUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.EMAIL_UPDATE_RESULT, 				onEmailUpdate);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.DELETE_USER_RESULT, 				onDeleteUser);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.SEND_EMAIL_VERIFICATION_RESULT, 	onSendEmailVerification);
				FirebaseUser.listener.addEventListener(FirebaseUserEvents.PHONE_UPDATE_RESULT, 				onPhoneUpdate);
			}
			else
			{
				C.log("user is NOT logged in");
				
				// When logged out, it's a good idea to remove the user listeners
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.RELOAD_USER_INFO, 					onReloadUserInfo);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.REAUTHENTICATE_RESULT, 			onReauthenticate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.GET_USER_TOKEN, 					onGetUserToken);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.UNLINK_RESULT, 					onUnlink);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.LINK_WITH_RESULT, 					onLink);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.PROFILE_UPDATE_RESULT, 			onProfileUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.PASSWORD_UPDATE_RESULT, 			onPassUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.EMAIL_UPDATE_RESULT, 				onEmailUpdate);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.DELETE_USER_RESULT, 				onDeleteUser);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.SEND_EMAIL_VERIFICATION_RESULT, 	onSendEmailVerification);
				FirebaseUser.listener.removeEventListener(FirebaseUserEvents.PHONE_UPDATE_RESULT, 				onPhoneUpdate);
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
//			C.log("onGetUserToken result=" + e.result, "     token=" + e.token);
			
			if(e.result == Auth.RESULT_SUCCESS)
			{
				C.log("onGetUserToken result == Auth.RESULT_SUCCESS");
				C.log("e.tokenResult.token: " + e.tokenResult.token);
				C.log("e.tokenResult.claims: " + JSON.stringify(e.tokenResult.claims));
				C.log("e.tokenResult.authTimestamp: " + new Date(e.tokenResult.authTimestamp).toLocaleString());
				C.log("e.tokenResult.expirationTimestamp: " + new Date(e.tokenResult.expirationTimestamp).toLocaleString());
				C.log("e.tokenResult.issuedAtTimestamp: " + new Date(e.tokenResult.issuedAtTimestamp).toLocaleString());
				C.log("e.tokenResult.signInProvider: " + e.tokenResult.signInProvider);
			}
			else
			{
				C.log("onGetUserToken result != Auth.RESULT_SUCCESS");
			}
		}
		
		private function onUnlink(e:FirebaseUserEvents):void
		{
			C.log("onUnlink result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onLink(e:FirebaseUserEvents):void
		{
			C.log("onLink result=" + e.result, "     msg=" + e.msg);
			
			if(e.additionalUserInfo)
			{
				trace("-------------- additionalUserInfo ------------");
				trace("providerId: " + e.additionalUserInfo.providerId);
				trace("username: " + e.additionalUserInfo.username);
				trace("isNewUser: " + e.additionalUserInfo.isNewUser);
				trace("profile: " + JSON.stringify(e.additionalUserInfo.profile));
				trace("----------------------------------------------");
			}
		}
		
		private function onProfileUpdate(e:FirebaseUserEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onProfileUpdate successful")
			}
			else
			{
				trace("onProfileUpdate: " + e.msg);
			}
		}
		
		private function onPassUpdate(e:FirebaseUserEvents):void
		{
			C.log("onPassUpdate result=" + e.result, "     msg=" + e.msg);
		}
		
		private function onEmailUpdate(e:FirebaseUserEvents):void
		{
			// when this happens, you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again., you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again.
			if (e.result == Auth.RESULT_AUTH_RECENT_LOGIN_REQUIRED)
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailPassAuthProvider(email, "123456");
				
				// and finally feed FirebaseUser.reauthenticate with the parsed credential info from the authProvider instance.
				FirebaseUser.reauthenticate(authProvider.getCredential());
			}
			else if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onEmailUpdate successful");
			}
			else
			{
				trace("onEmailUpdate: " + e.msg);
			}
		}
		
		private function onDeleteUser(e:FirebaseUserEvents):void
		{
			// when this happens, you have to call FirebaseUser.reauthenticate to resolve it. and then try your operation again.
			if (e.result == Auth.RESULT_AUTH_RECENT_LOGIN_REQUIRED)
			{
				// create a new authProvider object first
				var authProvider:AuthProvider = new AuthProvider();
				
				// decide what kind of credential this authProvider instance will hold
				authProvider.setEmailPassAuthProvider(email, "123456");
				
				// and finally feed FirebaseUser.reauthenticate with the parsed credential info from the authProvider instance.
				FirebaseUser.reauthenticate(authProvider.getCredential());
			}
			else if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onDeleteUser successful");
			}
			else
			{
				trace("onDeleteUser: " + e.msg);
			}
		}
		
		private function onSendEmailVerification(e:FirebaseUserEvents):void
		{
			if(e.result == Auth.RESULT_SUCCESS)
			{
				trace("onSendEmailVerification successful");
			}
			else
			{
				trace("onSendEmailVerification: " + e.msg);
			}
		}
		
		private function onPhoneUpdate(e:FirebaseUserEvents):void
		{
			C.log("onPhoneUpdate result=" + e.result, "     msg=" + e.msg);
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