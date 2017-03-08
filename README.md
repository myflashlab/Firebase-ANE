# Firebase Air Native Extension V4.0.0 Android+iOS
Firebase ANE gives you access to the [Google Firebase project](https://firebase.google.com/docs/) in your AdobeAir projects supported on both Android and iOS with 100% identical ActionScript API. 

If you decide to use Firebase in your next AdobeAir project, you should consider the following structure: Firebase Air Native Extension is consist of a *Core* ANE plus some other individual ANEs which are all dependent on the *Core*. i.e, If you wish to use [Firebase Cloud Messaging (FCM)](http://www.myflashlabs.com/product/fcm-firebase-air-native-extension/), you need to embed the Core ANE first and then use the required ANE(s) for the FCM. This structure will make sure that you are not compiling unused native code in your AdobeAir project. In result, your app file size will be as small as possible and faster to debug/compile. [The Wiki pages](https://github.com/myflashlab/Firebase-ANE/wiki) will provide you detailed information about how you can embed each ANE based on the Firebase feature you wish to use in your app.

**Main Features:**
* [Analytics](https://firebase.google.com/docs/analytics/) Reimagine analytics for mobile 
* [Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/) Deliver and receive messages across platforms reliably 
* [Authentication](https://firebase.google.com/docs/auth/) Reduce friction with robust authentication 
* [Realtime Database](https://firebase.google.com/docs/database/) Store and sync app data in realtime 
* [Storage](https://firebase.google.com/docs/storage/) Store files with ease 
* [Remote Config](https://firebase.google.com/docs/remote-config/) Customize your app on the fly 
* [Crash Reporting](https://firebase.google.com/docs/crash/) Keep your app stable 
* [Notifications](https://firebase.google.com/docs/notifications/) Engage with users at the right moment 
* [Dynamic Links](https://firebase.google.com/docs/dynamic-links/) Send users to the right place inside your app 
* [Invites](https://firebase.google.com/docs/invites/) Empower your users to share your app 
* [AdWords](https://firebase.google.com/docs/adwords/) Acquire users with the reach of Google 
* [Admob](https://firebase.google.com/docs/admob/) Monetize through engaging ads 

# asdoc
[find the latest asdoc for this ANE here.](http://myflashlab.github.io/asdoc/)  
[How to get started? **read here**](https://github.com/myflashlab/Firebase-ANE/wiki)

# Sample AS3 codes
* [Firebase Core](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/Main.as)
* [Firebase Realtime Database](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainDatabase.as)
* [Firebase Remote Config](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainRemoteConfig.as)
* [Firebase Authentication](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainAuth.as)
* [Firebase Dynamic Links](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainDynamicLinks.as)
* [Firebase Invites](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainInvites.as)
* [Firebase Storage](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainStorage.as)
* [Firebase Analytics](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainAnalytics.as)
* [Firebase Crash Report](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainCrash.as)
* [Firebase FCM](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainFcm.as)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.firebase.core.*;

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
	https://github.com/myflashlab/Firebase-ANE/tree/master/FD/bin
	
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

Firebase ANEs are dependent on some other ANEs. Complete information about these dependencies are explained in wiki pages. However, to make sure you are not confused in the process of adding the dependencies, you may use our [Inspector ANE](https://github.com/myflashlab/ANE-Inspector-Tool) while developing your app to be notified if you have correctly added all the required dependency ANEs or not.

```actionscript
import com.myflashlab.air.extensions.inspector.Inspector;

if (!Inspector.check(Firebase, true, true))
{
	// If you're here, it means that the Firebase Class cannot be initialized!
	trace("Inspector.lastError = " + Inspector.lastError);
}

// You can use the inspector ANE with other Firebase child ANEs and ALL of the other myflashlabs ANEs.
```

**NOTICE:** When you are compiling a release version of your app, it's a **very** good idea to set the third parameter of the [check()](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/inspector/Inspector.html#check()) method to ```false``` so your app is not doing unnecessary operations. The third parameter checks if all of the dependency ANEs are included or not and you would need this check only when developing your app. However, the second parameter checks if the current platform you are running your app on, can initialize the Firebase classes or not. For example, if you are running on a simulator, the ```check``` method will return ```false```.

# Requirements 
1. Android API 15+
2. iOS SDK 8.0+
3. Air SDK 24+
4. Every Firebase ANE might need some dependency Frameworks/ANEs which is [explained in details here](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md).

# Commercial Version
* [firebaseCore.ane](http://www.myflashlabs.com/product/firebase-air-native-extension/)
* [firebaseDatabase.ane](http://www.myflashlabs.com/product/realtime-database-firebase-air-native-extension/)
* [firebaseRemoteConfig.ane](http://www.myflashlabs.com/product/remote-config-firebase-air-native-extension/)
* [firebaseAuth.ane](http://www.myflashlabs.com/product/authentication-firebase-air-native-extension/)
* [firebaseDynamicLinks.ane](http://www.myflashlabs.com/product/dynamic-links-firebase-air-native-extension)
* [firebaseInvites.ane](http://www.myflashlabs.com/product/invites-firebase-air-native-extension)
* [firebaseStorage.ane](http://www.myflashlabs.com/product/storage-firebase-air-native-extension/)
* [firebaseAnalytics.ane](http://www.myflashlabs.com/product/analytics-firebase-air-native-extension/)
* [firebaseCrash.ane](http://www.myflashlabs.com/product/crash-firebase-air-native-extension/)
* [firebaseMessaging.ane](http://www.myflashlabs.com/product/fcm-firebase-air-native-extension/)

![Firebase ANE](http://www.myflashlabs.com/wp-content/uploads/2016/07/product_adobe-air-ane-extension-firebase_all-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[How to support Firebase in my Air app?](https://github.com/myflashlab/Firebase-ANE/wiki/A.-Get-Started)  
[How to use Firebase Realtime database?](https://github.com/myflashlab/Firebase-ANE/wiki/B.-Realtime-Database#get-started-with-firebase-realtime-database-in-adobe-air)  
[How to use Firebase Remote Config?](https://github.com/myflashlab/Firebase-ANE/wiki/C.-Remote-Config#get-started-with-firebase-remote-config-in-adobe-air)  
[How to use Firebase Authentication?](https://github.com/myflashlab/Firebase-ANE/wiki/D.-Authentication#get-started-with-firebase-authentication-in-adobe-air)  
[How to use Firebase Storage?](https://github.com/myflashlab/Firebase-ANE/wiki/E.-Storage#get-started-with-firebase-storage-in-adobe-air)  
[How to use Firebase Crash?](https://github.com/myflashlab/Firebase-ANE/wiki/F.-Crash#get-started-with-firebase-crash-in-adobe-air)  
[How to use Firebase FCM?](https://github.com/myflashlab/Firebase-ANE/wiki/G.-FCM#get-started-with-firebase-fcm-in-adobe-air)  
[How to use Firebase Analytics?](https://github.com/myflashlab/Firebase-ANE/wiki/H.-Analytics#get-started-with-firebase-analytics-in-adobe-air)  
[How to use Firebase Dynamic Links?](https://github.com/myflashlab/Firebase-ANE/wiki/I.-Dynamic-Links#get-started-with-firebase-dynamic-links-in-adobe-air)  
[How to use Firebase Invites?](https://github.com/myflashlab/Firebase-ANE/wiki/J.-Invites#get-started-with-firebase-invites-in-adobe-air)  

# Changelog
*Mar 07, 2017 - V4.0.0*
* Updated to Firebase SDK 10.2.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
* Updated to Firebase SDK 3.13.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_13_0/Firebase-3.13.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
* firebaseInvites.ane has been added to the collection and it is highly dependent on on DynamicLinks ANE. In simple terms, if you wish to use the Firebase Invites SDK, you need to first add Firebase DynamicLinks to your app.
* (Core) You need to regenerate the core ANE using the ane generator software V4.0.0 and you need to update all the other Firebase children that you are using in your project.
* (Core) [setLoggerLevel](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/core/Firebase.html#setLoggerLevel()) has been intrduced and [logLevel](http://myflashlab.github.io/asdoc/com/myflashlab/air//extensions/firebase/db/DB.html#logLevel) is now deprecated.
* (Core) Prior to this updated, other ANE dependencies were not required for iOS builds but from now on, you need to add ```overrideAir.ane``` even if you are building for iOS only. Just make sure you are reading [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400) very carefully.
* (Auth) Added [signInWithEmail](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signInWithEmail()) 
* (Auth) Added [signInWithCustomToken](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signInWithCustomToken()) 
* (Auth) Added [confirmPasswordResetWithCode](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#confirmPasswordResetWithCode()) 
* (Auth) Added [checkActionCode](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#checkActionCode()) 
* (Auth) Added [verifyPasswordResetCode](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#verifyPasswordResetCode()) 
* (Auth) Added [applyActionCode](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#applyActionCode()) 
* (Auth) fixed [issue 84](https://github.com/myflashlab/Firebase-ANE/issues/84)
* (Analytics) Firebase team fixed [issue 34](https://github.com/firebase/quickstart-ios/issues/34) and we made sure it is also working on the ANE side.
* (Analytics) Added [getAppInstanceID](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/analytics/FirebaseAnalytics.html#getAppInstanceID())
* (DB) fixed [issue 65](https://github.com/myflashlab/Firebase-ANE/issues/65)
* (DB) fixed setValue and updateChilderen methods so they are now correctly removing values at targetted references if you are sending an empty String ```""``` at those references.
* (FCM) You can now use the [Resource Manager Software](http://www.myflashlabs.com/adobe-air-native-extension-resources-project/) to add custom icons for notifications on the Android side. *iOS shows app icon only. Firebase does not support this*
* (FCM) You can create custom [.caf files](https://www.google.com/search?q=%22.caf%22+files&ie=utf-8&oe=utf-8&client=firefox-b-ab) for iOS notifications to play custom sounds when a notification arrives.
* (FCM) known issue: custom sounds for Android must be placed in the res/raw folder using the [Resource Manager Software](http://www.myflashlabs.com/adobe-air-native-extension-resources-project/) but unfortunately this is not working because it seems like AIR is somehow compressing the files inside the raw folder. We will bring this issue to Adobe's attention so maybe they can fix this problem.  
* Minor bug fixes on the ANE side.
* With upgrading to the latest Firebase SDK, a lot of native bugs are also fixed. You can learn about them by checking the official native Firebase [release notes](https://firebase.google.com/support/releases).

*Jan 14, 2017 - V3.0.0*
* Firebase Core ANE needs the ```appinvite``` dependency also from now on.
* You will need AIR SDK 24 or higher to compile Firebase ANEs. Older SDKs are just too old to support Firebase from mow on.
* firebaseDynamicLinks.ane has been added and works on both Android and iOS. To make sure it works correctly, you need to initialize dynamicLinks as soon as possible in your app, right after you initialized the Core Firebase ANE. ```Firebase.init(true);```
* ```FirebaseConfig``` now has two getter/setter properties (```projectID``` and ```webApiKey```) which can be used for accessing dynamicLinks REST API.
* [Firebase.init](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/core/Firebase.html#init()) accepts a boolean which is set to ```false``` by default. If set to ```true```, the ANE will be prepared to use DynamicLinks.
* ```FirebaseEvents``` has been introduced which notifies you when GoogleApiClient is connected or disconnected. You may find these events helpful only on the Android side when working with DynamicLinks. These events will not be dispatched at all when you're running on iOS.
* If you are going to add DynamicLinks to your project, read the Wiki and make sure you are generating new provision files for iOS. Your old provisions will not work with DynamicLinks.

*Nov 27, 2016 - V2.0.0*
* Updated to Firebase SDK 10.0.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v200)
* Updated to Firebase SDK 3.10.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_10_0/Firebase-3.10.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v200)
* All Firebase ANEs are now optimized for AIR 24
* Minimum iOS version to support the Firebase ANEs will be iOS 8.0+ from now on
* (Auth) Added [sendEmailVerification](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#sendEmailVerification()) method
* (Auth) Added [isEmailVerified](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#isEmailVerified) property
* (Auth) Added [fetchProvidersForEmail](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#fetchProvidersForEmail()) method
* (Crash) You no longer need to add services to the manifest Android side.
* Minor bug fixes on the ANE side.
* With upgrading to the latest Firebase SDK, a lot of native bugs are also fixed. You can learn about them by checking the official native Firebase [release notes](https://firebase.google.com/support/releases).

*Oct 19, 2016*
* Added FCM

*Oct 05, 2016*
* Added Analytics

*Oct 04, 2016*
* Added FCM beta

*Sep 25, 2016 - V1.2.0*
* Updated to Firebase SDK 9.6.1 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) also.
* Updated to Firebase SDK 3.6.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_6_0/Firebase.zip) too.
* (DB) Added Child and single events requested on [issue #15](https://github.com/myflashlab/Firebase-ANE/issues/15)
* (DB) Fixed Query EndAt method on iOS reported on [issue #16](https://github.com/myflashlab/Firebase-ANE/issues/16)
* (DB) Added ```DBServerValue``` class requested on [issue #10](https://github.com/myflashlab/Firebase-ANE/issues/10)
* (Auth) Added signInAnonymously. Simply pass ```null``` to the [signIn()](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signIn()) method. [issue #8](https://github.com/myflashlab/Firebase-ANE/issues/8)
* The ```checkDependencies``` method is now deprecated in all Firebase ANEs. instead, you should use the [Inspector ANE](https://github.com/myflashlab/ANE-Inspector-Tool/) if you wish to check the availablity of dependencies.

*Sep 13, 2016*
* Added Crash

*Sep 06, 2016*
* Added Storage

*Aug 10, 2016 - V1.1.0*
* Updated to Firebase SDK 9.4.0 for Android. Make sure to update all your dependency files also.
* Updated to Firebase SDK 3.4.0 for iOS. Make sure you are updating the Frameworks also.
* minor bug fixes

*Jul 25, 2016*
* Added Remote config and Authentication

*Jul 21, 2016*
* Realtime database and the core are ready for beta testing

*Jul 05, 2016 - V1.0.0*
* beginning of the journey!

--------------------------------------
**DISCRIMINATION:** Firebase SDKs are developed by Google and they own every copyright to the Firebase "native" projects. However, we have used their "compiled" native SDKs to develop the ActionScript API to be used in Adobe Air mobile projects. Moreover, as far as the documentations, we have copied and when needed has modified the Google documents so it will fit the needs of Adobe Air community. If you wish to see the original documentations in Android/iOS, [visit here](https://firebase.google.com/docs/). But if you are interested to do things in Adobe Air, then you are in the right place.