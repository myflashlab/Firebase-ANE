# Firebase AIR Native Extension
Firebase ANE gives you access to the [Google Firebase project](https://firebase.google.com/docs/) in your AIR projects supported on both Android and iOS with 100% identical ActionScript API. 

If you decide to use Firebase in your next AIR project, you should consider the following structure: Firebase AIR Native Extension is consist of a *Core* ANE plus some other individual ANEs which are all dependent on the *Core*. i.e, If you wish to use [Firebase Cloud Messaging (FCM)](https://www.myflashlabs.com/product/fcm-firebase-air-native-extension/), you need to embed the Core ANE first and then use the required ANE(s) for the FCM. This structure will make sure that you are not compiling unused native code in your project. In result, your app file size will be as small as possible and faster to debug/compile. [The Wiki pages](https://github.com/myflashlab/Firebase-ANE/wiki) will provide you detailed information about how you can embed each ANE based on the Firebase feature you wish to use in your app.

**Main Features:**
* [Analytics](https://firebase.google.com/docs/analytics/) Reimagine analytics for mobile 
* [Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/) Deliver and receive messages across platforms reliably 
* [Authentication](https://firebase.google.com/docs/auth/) Reduce friction with robust authentication 
* [Realtime Database](https://firebase.google.com/docs/database/) Store and sync app data in realtime 
* [Functions](https://firebase.google.com/docs/functions) Run backend code in response to events
* [Firestore](https://firebase.google.com/docs/firestore/) Store and sync app data at global scale
* [Storage](https://firebase.google.com/docs/storage/) Store files with ease 
* [Remote Config](https://firebase.google.com/docs/remote-config/) Customize your app on the fly 
* [Performance](https://firebase.google.com/docs/perf-mon) Gain insight into your app's performance issues. 
* [Crashlytics](https://firebase.google.com/docs/crashlytics/) Get clear, actionable insight into app issues 
* [Notifications](https://firebase.google.com/docs/notifications/) Engage with users at the right moment 
* [Dynamic Links](https://firebase.google.com/docs/dynamic-links/) Send users to the right place inside your app 
* [MLKit](https://firebase.google.com/docs/ml-kit/) Use machine learning in your apps to solve real-world problems

[find the latest **asdoc** for Firebase ANEs here.](http://myflashlab.github.io/asdoc/)  
[How to get started? **read here**](https://github.com/myflashlab/Firebase-ANE/wiki)

# Sample AS3 codes
* [Firebase Core](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/Main.as)
* [Firebase Realtime Database](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainDatabase.as)
* [Firebase Firestore](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainFirestore.as)
* [Firebase Remote Config](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainRemoteConfig.as)
* [Firebase Authentication](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainAuth.as)
* [Firebase Dynamic Links](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainDynamicLinks.as)
* [Firebase Storage](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainStorage.as)
* [Firebase Analytics](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainAnalytics.as)
* [Firebase Crashlytics](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainCrashlytics.as)
* [Firebase FCM](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainFcm.as)
* [Firebase Mlkit](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainMlkit.as)
* [Firebase Performance](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainPerformance.as)
* [Firebase Functions](https://github.com/myflashlab/Firebase-ANE/blob/master/AIR/src/MainFunctions.as)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.dependency.OverrideAir;
import com.myflashlab.air.extensions.firebase.core.*;

// Remove OverrideAir debugger in production builds
OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void
{
	trace($ane+" ("+$class+") "+$msg);
});

// initialize the Firebase as early as possible in your project
var isConfigFound:Boolean = Firebase.init();

// If you wish to see the Firebase SDK debugging logs in detail, use the following
Firebase.setLoggerLevel(FirebaseConfig.LOGGER_LEVEL_MAX);

/*
	Calling Firebase.init() is just good enough to initialize Firebase core in your Air 
	project. However for debugging reasons, you can check the config values like below:
	
	What config files you may ask? well, This is explained in details in the Wiki pages. 
	https://github.com/myflashlab/Firebase-ANE/wiki but to give you a quick idea, I 
	should say that before being able to start with Firebase, you need to create a 
	Firebase account (It's free) and introduce your app to your Firebase console. When 
	you do that, your Firebase console will give you a config file. it will be a .plist 
	for iOS "GoogleService-Info.plist" and a .json file "google-services.json" for the 
	Android side. The content of these two config files are similar to these: 
	https://github.com/myflashlab/Firebase-ANE/tree/master/AIR/bin
	
	You need to make sure that these two config files are being embedded in your project 
	by putting them in the bin folder of your project. (Next to the main .swf file of 
	your app)
*/

if (isConfigFound)
{
	var config:FirebaseConfig = Firebase.getConfig();
	trace("default_web_client_id = " + 			config.default_web_client_id);
	trace("firebase_database_url = " + 			config.firebase_database_url);
	trace("gcm_defaultSenderId = " + 			config.gcm_defaultSenderId);
	trace("google_api_key = " + 				config.google_api_key);
	trace("google_app_id = " + 					config.google_app_id);
	trace("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
	trace("google_storage_bucket = " + 			config.google_storage_bucket);
	trace("project_id = " + 					config.project_id);

	// You must init other Firebase children after a successful initialization of the Core ANE.
	// readyToUseFirebase();
}
else
{
	trace("Config file is not found!");
}

/*
	To know how to use other features of Firebase, read the Wiki:
	https://github.com/myflashlab/Firebase-ANE/wiki
*/
```

Firebase ANEs are dependent on some other ANEs and frameworks. Complete information about these dependencies are explained in wiki pages. However, to make sure you are not confused with all these settings, you are encouraged to use the [ANE-LAB Software](https://github.com/myflashlab/ANE-LAB/).

# Requirements 
1. Android API 19+
2. iOS SDK 10.0+
3. Air SDK 30+
4. Every Firebase ANE might need some dependency Frameworks/ANEs which is [explained in details here](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md).

# Commercial Version
* [firebaseCore.ane](https://www.myflashlabs.com/product/firebase-air-native-extension/)
* [firebaseDatabase.ane](https://www.myflashlabs.com/product/realtime-database-firebase-air-native-extension/)
* [firebaseFirestore.ane](https://www.myflashlabs.com/product/firestore-firebase-air-native-extension/)
* [firebaseRemoteConfig.ane](https://www.myflashlabs.com/product/remote-config-firebase-air-native-extension/)
* [firebaseAuth.ane](https://www.myflashlabs.com/product/authentication-firebase-air-native-extension/)
* [firebaseDynamicLinks.ane](https://www.myflashlabs.com/product/dynamic-links-firebase-air-native-extension)
* [firebaseStorage.ane](https://www.myflashlabs.com/product/storage-firebase-air-native-extension/)
* [firebaseAnalytics.ane](https://www.myflashlabs.com/product/analytics-firebase-air-native-extension/)
* [firebaseCrashlytics.ane](https://www.myflashlabs.com/product/crashlytics-firebase-air-native-extension)
* [firebaseMessaging.ane](https://www.myflashlabs.com/product/fcm-firebase-air-native-extension/)
* [firebaseMlkit.ane](https://www.myflashlabs.com/product/mlkit-firebase-air-native-extension/)
* [firebasePerformance.ane](https://www.myflashlabs.com/product/performance-firebase-air-native-extension/)
* [firebaseFunctions.ane](https://www.myflashlabs.com/product/functions-firebase-air-native-extension/)

![Firebase ANE](https://www.myflashlabs.com/wp-content/uploads/2017/12/product_adobe-air-ane-extension-firebase_all-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[How to support Firebase in my Air app?](https://github.com/myflashlab/Firebase-ANE/wiki/A.-Get-Started)  
[How to use Firebase Realtime database?](https://github.com/myflashlab/Firebase-ANE/wiki/B.-Realtime-Database#get-started-with-firebase-realtime-database-in-adobeair)  
[How to use Firebase Firestore?](https://github.com/myflashlab/Firebase-ANE/wiki/K.-Firestore#get-started-with-firestore-in-adobeair)  
[How to use Firebase Remote Config?](https://github.com/myflashlab/Firebase-ANE/wiki/C.-Remote-Config#get-started-with-firebase-remote-config-in-adobeair)  
[How to use Firebase Authentication?](https://github.com/myflashlab/Firebase-ANE/wiki/D.-Authentication#get-started-with-firebase-authentication-in-adobeair)  
[How to use Firebase Storage?](https://github.com/myflashlab/Firebase-ANE/wiki/E.-Storage#get-started-with-firebase-storage-in-adobeair)  
[How to use Crashlytics?](https://github.com/myflashlab/Firebase-ANE/wiki/L.-Crashlytics#get-started-with-firebase-crashlytics-in-adobeair)  
[How to use Firebase FCM?](https://github.com/myflashlab/Firebase-ANE/wiki/G.-FCM#get-started-with-firebase-fcm-in-adobeair)  
[How to use Firebase Analytics?](https://github.com/myflashlab/Firebase-ANE/wiki/H.-Analytics#get-started-with-firebase-analytics-in-adobeair)  
[How to use Firebase Dynamic Links?](https://github.com/myflashlab/Firebase-ANE/wiki/I.-Dynamic-Links#get-started-with-firebase-dynamic-links-in-adobeair)  
[How to use Firebase MLKit?](https://github.com/myflashlab/Firebase-ANE/wiki/M.-MLKit#get-started-with-firebase-mlkit-in-adobeair)  
[How to use Firebase Performance?](https://github.com/myflashlab/Firebase-ANE/wiki/N.-Performance#get-started-with-firebase-performance-in-adobeair)  
[How to use Firebase Functions?](https://github.com/myflashlab/Firebase-ANE/wiki/O.-Functions#get-started-with-firebase-functions-in-adobeair)  

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).

--------------------------------------
**DISCRIMINATION:** Firebase SDKs are developed by Google and they own every copyright to the Firebase "native" projects. However, we have used their "compiled" native SDKs to develop the ActionScript API to be used in Adobe Air mobile projects. Moreover, as far as the documentations, we have copied and when needed has modified the Google documents so it will fit the needs of Adobe Air community. If you wish to see the original documentations in Android/iOS, [visit here](https://firebase.google.com/docs/). But if you are interested to do things in Adobe Air, then you are in the right place.