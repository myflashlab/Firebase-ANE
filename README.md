# Firebase Air Native Extension V1.2.0 Android+iOS
Firebase ANE gives you access to the [Google Firebase project](https://firebase.google.com/docs/) in your AdobeAir projects supported on both Android and iOS with 100% identical ActionScript API. 

If you decide to use Firebase in your next AdobeAir project, you should consider the following structure: Firebase Air Native Extension is consist of a *Core* ANE plus some other individual ANEs which are all dependent on the *Core*. i.e, If you wish to use [Firebase Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/), you need to embed the Core ANE first and then use the required ANE(s) for the FCM. This structure will make sure that you are not compiling unused native code in your AdobeAir project. In result, your app file size will be as small as possible and faster to debug/compile. [The Wiki pages](https://github.com/myflashlab/Firebase-ANE/wiki) will provide you detailed information about how you can embed each ANE based on the Firebase feature you wish to use in your app.

**Main Features:**
* [Analytics](https://firebase.google.com/docs/analytics/) Reimagine analytics for mobile 
* [Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/) Deliver and receive messages across platforms reliably 
* [Authentication](https://firebase.google.com/docs/auth/) Reduce friction with robust authentication 
* [Realtime Database](https://firebase.google.com/docs/database/) Store and sync app data in realtime 
* [Storage](https://firebase.google.com/docs/storage/) Store files with ease 
* [Remote Config](https://firebase.google.com/docs/remote-config/) Customize your app on the fly 
* [Crash Reporting](https://firebase.google.com/docs/crash/) Keep your app stable 
* [Notifications](https://firebase.google.com/docs/notifications/) Engage with users at the right moment 
* [App Indexing](https://firebase.google.com/docs/app-indexing/) Drive organic search traffic to your app 
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
* Firebase Dynamic Links (Coming soon)
* Firebase Invites (Coming soon)
* [Firebase Storage](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainStorage.as)
* Firebase App Indexing (Coming soon)
* Firebase Analytics (Coming soon)
* [Firebase Crash Report](https://github.com/myflashlab/Firebase-ANE/blob/master/FD/src/MainCrash.as)
* Firebase FCM (Coming soon)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.firebase.core.Firebase;
import com.myflashlab.air.extensions.firebase.core.FirebaseConfig;

// initialize the Firebase as early as possible in your project
var isConfigFound:Boolean = Firebase.init();

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

Firebase ANEs on Android are dependent on some other ANEs. Complete information about these dependencies are explained in wiki pages. However, to make sure you are not confused in the process of adding the dependencies, you may use our [Inspector ANE](https://github.com/myflashlab/ANE-Inspector-Tool) while developing your app to be notified if you have correctly added all the required dependency ANEs or not.

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
1. Android API 15 or higher
2. iOS SDK 7.0 or higher
3. Air SDK 22 or higher
4. Every Firebase ANE might need some dependency Frameworks/ANEs which is [explained in details here](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md).

# Commercial Version
* [firebaseCore.ane](http://www.myflashlabs.com/product/firebase-air-native-extension/)
* [firebaseDatabase.ane](http://www.myflashlabs.com/product/realtime-database-firebase-air-native-extension/)
* [firebaseRemoteConfig.ane](http://www.myflashlabs.com/product/remote-config-firebase-air-native-extension/)
* [firebaseAuth.ane](http://www.myflashlabs.com/product/authentication-firebase-air-native-extension/)
* firebaseDynamicLinks.ane (coming soon)
* firebaseInvites.ane (coming soon)
* [firebaseStorage.ane](http://www.myflashlabs.com/product/storage-firebase-air-native-extension/)
* firebaseAppIndexing.ane (coming soon)
* firebaseAnalytics.ane (coming soon)
* [firebaseCrash.ane](http://www.myflashlabs.com/product/crash-firebase-air-native-extension/)
* firebaseMessaging.ane (coming soon)

![Firebase ANE](http://www.myflashlabs.com/wp-content/uploads/2016/07/product_adobe-air-ane-extension-firebase_all-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  
[How to support Firebase in my Air app?](https://github.com/myflashlab/Firebase-ANE/wiki/A.-Get-Started)  
[How to use Firebase Realtime database?](https://github.com/myflashlab/Firebase-ANE/wiki/B.-Realtime-Database#get-started-with-firebase-realtime-database-in-adobe-air)  
[How to use Firebase Remote Config?](https://github.com/myflashlab/Firebase-ANE/wiki/C.-Remote-Config#get-started-with-firebase-remote-config-in-adobe-air)  
[How to use Firebase Authentication?](https://github.com/myflashlab/Firebase-ANE/wiki/D.-Authentication#get-started-with-firebase-authentication-in-adobe-air)  
[How to use Firebase Storage?](https://github.com/myflashlab/Firebase-ANE/wiki/E.-Storage#get-started-with-firebase-storage-in-adobe-air)  
[How to use Firebase Crash?](https://github.com/myflashlab/Firebase-ANE/wiki/F.-Crash#get-started-with-firebase-crash-in-adobe-air)  

# Changelog
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