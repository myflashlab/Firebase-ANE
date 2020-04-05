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
import com.myflashlab.air.extensions.localNotifi.NotificationChannel;
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
		_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase FCM V" + FCM.VERSION + "</font>";
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
		
		if(payload) // If available, it means that the Invoke listener contains FCM data
		{
			C.log("---------------------------------");
			for(var name:String in payload)
			{
				C.log(name + " = " + payload[name]);
			}
			C.log("---------------------------------");

			trace("---------------------------------");
			for(var name:String in payload)
			{
				trace(name + " = " + payload[name]);
			}
			trace("---------------------------------");
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
	
	private function onResize(e:* = null):void
	{
		if(_txt)
		{
			_txt.y = 150 * (1 / DeviceInfo.dpiScaleMultiplier);
			_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			
			C.x = 0;
			C.y = _txt.y + _txt.height + 0;
			C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
		}
		
		if(_list)
		{
			_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
			_list.row = _numRows;
			_list.itemArrange();
		}
		
		if(_body)
		{
			_body.y = stage.stageHeight - _body.height;
		}
	}
	
	private function init():void
	{
		// Remove OverrideAir debugger in production builds
		OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void {
			trace($ane + " (" + $class + ") " + $msg);
		});
		
		var isConfigFound:Boolean = Firebase.init();
		
		if(isConfigFound)
		{
			var config:FirebaseConfig = Firebase.getConfig();
			C.log("default_web_client_id = " + config.default_web_client_id);
			C.log("firebase_database_url = " + config.firebase_database_url);
			C.log("gcm_defaultSenderId = " + config.gcm_defaultSenderId);
			C.log("google_api_key = " + config.google_api_key);
			C.log("google_app_id = " + config.google_app_id);
			C.log("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
			C.log("google_storage_bucket = " + config.google_storage_bucket);
			C.log("project_id = " + config.project_id);
			
			trace("default_web_client_id = " + config.default_web_client_id);
			trace("firebase_database_url = " + config.firebase_database_url);
			trace("gcm_defaultSenderId = " + config.gcm_defaultSenderId);
			trace("google_api_key = " + config.google_api_key);
			trace("google_app_id = " + config.google_app_id);
			trace("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
			trace("google_storage_bucket = " + config.google_storage_bucket);
			trace("project_id = " + config.project_id);

			// FCM needs Google Services so, before using FCM, we need to check that first.
			// https://firebase.google.com/docs/cloud-messaging/android/client#sample-play
			if(OverrideAir.os == OverrideAir.ANDROID) Firebase.checkGoogleAvailability(onCheckResult); else onCheckResult(Firebase.SUCCESS);
		} else
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
				initOneSignal();
				createAndroidNotificationChannel();
				onResize();
				
				break;
			case Firebase.SERVICE_MISSING:
				
				C.log("checkGoogleAvailability result = SERVICE_MISSING");
				trace("checkGoogleAvailability result = SERVICE_MISSING");

				break;
			case Firebase.SERVICE_VERSION_UPDATE_REQUIRED:
				
				C.log("checkGoogleAvailability result = SERVICE_VERSION_UPDATE_REQUIRED");
				trace("checkGoogleAvailability result = SERVICE_VERSION_UPDATE_REQUIRED");

				break;
			case Firebase.SERVICE_UPDATING:
				
				C.log("checkGoogleAvailability result = SERVICE_UPDATING");
				trace("checkGoogleAvailability result = SERVICE_UPDATING");

				break;
			case Firebase.SERVICE_DISABLED:
				
				C.log("checkGoogleAvailability result = SERVICE_DISABLED");
				trace("checkGoogleAvailability result = SERVICE_DISABLED");

				break;
			case Firebase.SERVICE_INVALID:
				
				C.log("checkGoogleAvailability result = SERVICE_INVALID");
				trace("checkGoogleAvailability result = SERVICE_INVALID");

				break;
		}
	}
	
	private static function createAndroidNotificationChannel():void
	{
		// channels are required on Android 8+ only
		if(OverrideAir.os == OverrideAir.ANDROID)
		{
			// create a new channel with a unique id
			var channel:NotificationChannel = new NotificationChannel("myChannelId", "channel name");
			
			/*
				you can add your own sound files into the "res/raw" using the resourceManager tool
				available in the ANELAB software: https://github.com/myflashlab/ANE-LAB/
			*/
			channel.rawSound = "myflashlab_toy"; // this is myflashlab_toy.mp3 file placed inside Android "res/raw"
			channel.showBadge = true;
			channel.importance = NotificationChannel.NOTIFICATION_IMPORTANCE_DEFAULT;
			channel.isLightsEnabled = true;
			channel.isVibrationEnabled = true;
			channel.lightColor = "#990000";
			channel.lockscreenVisibility = NotificationChannel.VISIBILITY_PUBLIC;
			channel.vibrationPattern = [10, 100, 100, 200, 100, 300, 100, 400, 100, 500, 100, 600, 100, 700, 100, 800];
			channel.description = "channel description";
			
			// finally register the channel.
			FCM.registerChannel(channel);
		}
	}
	
	private function initFCM():void
	{
		FCM.init(); // web API key: AIzaSyBvWdo5STJ4pPl3FG6MHlEsiguedNzdxhQ
		
		FCM.listener.addEventListener(FcmEvents.TOKEN_REFRESH, function(e:FcmEvents):void
		{
			trace("\tFCM: onTokenRefresh = " + e.token);
			C.log("\tFCM: onTokenRefresh = " + e.token);
		});
		
		FCM.listener.addEventListener(FcmEvents.MESSAGE, function(e:FcmEvents):void
		{
			trace(e.msg);
			var payload:Object = FCM.parsePayloadFromString(e.msg);
			
			if(payload)
			{
				for(var name:String in payload)
				{
					C.log("\tFCM: " + name + " = " + payload[name]);
					trace("\tFCM: " + name + " = " + payload[name]);
				}
			}
		});
		
		FCM.listener.addEventListener(FcmEvents.DELETED_MESSAGES, function onDeletedMessages(e:FcmEvents):void
		{
			C.log("\tFCM: DELETED_MESSAGES happened!");
		});
		
		var btn_fcm_1:MySprite = createBtn("getToken", 0xe6ffdf);
		_list.add(btn_fcm_1);
		btn_fcm_1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			FCM.getInstanceId(function($token:String, $error:String):void
			{
				if($error)
				{
					trace("\tFCM: onTokenReceived error: " + $error);
					C.log("\tFCM: onTokenReceived error: " + $error);
				}
				
				if($token)
				{
					trace("\tFCM: token: " + $token);
					C.log("\tFCM: token: " + $token);
				}
			});
		});
		
		var btn_fcm_2:MySprite = createBtn("subscribe to 'news'", 0xe6ffdf);
		_list.add(btn_fcm_2);
		btn_fcm_2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			// optionally you can listen to FcmEvents.ON_SUBSCRIBE to know the result
			if(!FCM.listener.hasEventListener(FcmEvents.ON_SUBSCRIBE))
			{
				FCM.listener.addEventListener(FcmEvents.ON_SUBSCRIBE, function(e:FcmEvents):void
				{
					trace("\tFCM: subscribe to topic " + e.topic + ": " + e.isSuccessful);
					C.log("\tFCM: subscribe to topic " + e.topic + ": " + e.isSuccessful);
				});
			}
			
			// It will take 24 hours before you can see this topic on the Firebase console
			FCM.subscribeToTopic("news");
		});
		
		var btn_fcm_3:MySprite = createBtn("unsubscribe from 'news'", 0xe6ffdf);
		_list.add(btn_fcm_3);
		btn_fcm_3.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			// optionally you can listen to FcmEvents.ON_UNSUBSCRIBE to know the result
			if(!FCM.listener.hasEventListener(FcmEvents.ON_UNSUBSCRIBE))
			{
				FCM.listener.addEventListener(FcmEvents.ON_UNSUBSCRIBE, function(e:FcmEvents):void
				{
					trace("\tFCM: unsubscribe to topic " + e.topic + ": " + e.isSuccessful);
					C.log("\tFCM: unsubscribe to topic " + e.topic + ": " + e.isSuccessful);
				});
			}
			
			FCM.unsubscribeFromTopic("news");
		});
	}
	
	private function initOneSignal():void
	{
		/*
			if you set to true, you must ask for user's consent and then pass the result to
			'consentGranted($granted:Boolean)' so the SDK can continue to work normally
		*/
		//OneSignal.requiresUserPrivacyConsent = true;
		
		OneSignal.setLogLevel(OneSignalLogLevel.VERBOSE, OneSignalLogLevel.NONE);
		
		var settings:OneSignalInitSettings = new OneSignalInitSettings();
		
		// iOS settings
		settings.autoPrompt = false;
		settings.inAppAlerts = true;
		settings.inAppLaunchURL = true;
		settings.promptBeforeOpeningPushURL = true;
		settings.providesAppNotificationSettings = true;
		
		// Android settings
		settings.autoPromptLocation = false;
		settings.disableGmsMissingPrompt = false;
		settings.unsubscribeWhenNotificationsAreDisabled = false;
		settings.filterOtherGCMReceivers = false;
		
		// Android + iOS settings
		settings.inFocusDisplayOption = OneSignalDisplayType.IN_APP_ALERT;
		
		OneSignal.init(settings);
		
		// you may change how notifications are shown when your app is in focus
		OneSignal.inFocusDisplayType = OneSignalDisplayType.IN_APP_ALERT;
		
		// On iOS, it is required to get the user's consent before collecting location.
		OneSignal.setlocationshared(true);
		
		// add listeners
		OneSignal.listener.addEventListener(OneSignalEvents.NOTIFICATION_RECEIVED, function(e:OneSignalEvents):void
		{
			trace("OneSignal onNotificationReceived: " + e.msg);
			C.log("OneSignal onNotificationReceived: " + e.msg);
		});
		
		OneSignal.listener.addEventListener(OneSignalEvents.NOTIFICATION_OPENED, function(e:OneSignalEvents):void
		{
			trace("OneSignal onNotificationOpened: " + e.msg);
			C.log("OneSignal onNotificationOpened: " + e.msg);
		});
		
		//----------------------------------------------------------------------
		var btn0:MySprite = createBtn("Ask for permission", 0xDFE4FF);
		btn0.addEventListener(MouseEvent.CLICK, askPermission);
		if(OverrideAir.os == OverrideAir.IOS) _list.add(btn0);
		
		function askPermission(e:MouseEvent):void
		{
			OneSignal.promptForPushNotifications(function ($accepted:Boolean):void
			{
				trace("promptForPushNotifications, result: " + $accepted);
				C.log("promptForPushNotifications, result: " + $accepted);
			});
		}
		
		//----------------------------------------------------------------------
		var btn1:MySprite = createBtn("getPermissionSubscriptionState", 0xDFE4FF);
		_list.add(btn1);
		btn1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			/*
				check permission state meaning in NotificationPermissionStatus
				NotificationPermissionStatus.NOT_DETERMINDED > 0
				NotificationPermissionStatus.DENIED > 1
				NotificationPermissionStatus.AUTHORIZED > 2
				NotificationPermissionStatus.PROVISIONAL > 3
			*/
			C.log(OneSignal.getPermissionSubscriptionState());
			trace(OneSignal.getPermissionSubscriptionState());
		});
		
		//----------------------------------------------------------------------
		var btn2:MySprite = createBtn("getTags", 0xDFE4FF);
		_list.add(btn2);
		btn2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			OneSignal.getTags(function($msg:String):void
			{
				trace($msg);
				C.log($msg);
			});
		});
		
		//----------------------------------------------------------------------
		var btn3:MySprite = createBtn("sendTag", 0xDFE4FF);
		_list.add(btn3);
		btn3.addEventListener(MouseEvent.CLICK, function sendTag(e:MouseEvent):void
		{
			OneSignal.sendTag("TagKey1", "TagValue1");
		});
		
		//----------------------------------------------------------------------
		var btn4:MySprite = createBtn("sendTags", 0xDFE4FF);
		_list.add(btn4);
		btn4.addEventListener(MouseEvent.CLICK, function sendTags(e:MouseEvent):void
		{
			var tags:Object = {};
			tags.TagKey2 = "TagValue2";
			tags.TagKey3 = "TagValue3";
			tags["TagKey4"] = "TagValue4";
			tags.time = new Date().toLocaleTimeString();
			
			OneSignal.sendTags(tags, function($msg:String):void
			{
				trace($msg);
				C.log($msg);
				
			}, function($error:String):void
			{
				trace($error);
				C.log($error);
			});
		});
		
		//----------------------------------------------------------------------
		var btn5:MySprite = createBtn("deleteTag", 0xDFE4FF);
		_list.add(btn5);
		btn5.addEventListener(MouseEvent.CLICK, function deleteTag(e:MouseEvent):void
		{
			OneSignal.deleteTag("TagKey4", function($msg:String):void
			{
				trace($msg);
				C.log($msg);
				
			}, function($error:String):void
			{
				trace($error);
				C.log($error);
			});
		});
		
		//----------------------------------------------------------------------
		var btn6:MySprite = createBtn("deleteTags", 0xDFE4FF);
		_list.add(btn6);
		btn6.addEventListener(MouseEvent.CLICK, function deleteTags(e:MouseEvent):void
		{
			OneSignal.deleteTags(["TagKey3", "TagKey4"], function($msg:String):void
			{
				trace($msg);
				C.log($msg);
				
			}, function ($error:String):void
			{
				trace($error);
				C.log($error);
			});
		});
		
		//----------------------------------------------------------------------
		var btn7:MySprite = createBtn("promptLocation", 0xDFE4FF);
		_list.add(btn7);
		btn7.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
		{
			OneSignal.promptLocation();
		});
	}
	
	// --------------------------------------------------------------------------------------------------------
	private function createBtn($str:String, $bgColor:uint = 0xDFE4FF):MySprite
	{
		var sp:MySprite = new MySprite();
		sp.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		sp.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		sp.addEventListener(MouseEvent.CLICK, onOut);
		sp.bgAlpha = 1;
		sp.bgColor = $bgColor;
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
			sp.bgColor = $bgColor;
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