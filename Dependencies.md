Every release of Firebase ANEs will work with specific versions of Dependency ANEs and Frameworks. This document will tell you what dependencies and frameworks should be used in your project if you are building your project using different versions of Firebase ANEs.

**Note1**: Always try to use the latest releases because we won't be able to provide support on older versions.  
**Note2**: Always try to use the latest AdobeAir SDK. Doing this will automatically solve a lot of weird error messages.  
**Note3**: Firebase ANEs will not run on simulators. make sure you are building on a real device.  

# V2.0.0 #
Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/3df030020e09c17f31603a492171ed2dc3d5aa7d). *The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch.* And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_10_0/Firebase-3.10.0.zip).

**firebaseCore.ane**

On the Android side | On the iOS side
------------ | -------------
androidSupport.ane V24.2.1 | FirebaseAnalytics.framework V3.10.0
overrideAir.ane V3.0.0 | FirebaseCore.framework V3.10.0
firebase_common.ane V10.0.0 | FirebaseInstanceID.framework V3.10.0
firebase_iid.ane V10.0.0 | GoogleInterchangeUtilities.framework V3.10.0
googlePlayServices_base.ane V10.0.0 | GoogleSymbolUtilities.framework V3.10.0
googlePlayServices_basement.ane V10.0.0 | GoogleToolboxForMac.framework V3.10.0
googlePlayServices_tasks.ane V10.0.0 | 

**firebaseAuth.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_auth.ane V10.0.0 | FirebaseAuth.framework V3.10.0
 | GTMSessionFetcher.framework V3.10.0

**firebaseDatabase.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_database.ane V10.0.0 | FirebaseDatabase.framework V3.10.0
firebase_databaseConnection.ane V10.0.0 | 

**firebaseRemoteConfig.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_config.ane V10.0.0 | FirebaseRemoteConfig.framework V3.10.0

**firebaseStorage.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_storage.ane V10.0.0 | FirebaseStorage.framework V3.10.0
firebase_storageCommon.ane V10.0.0 | GTMSessionFetcher.framework V3.10.0

**firebaseCrash.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_crash.ane V10.0.0 | FirebaseCrash.framework V3.10.0
firebase_analyticsImpl.ane V10.0.0 | 

**firebaseMessaging.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_messaging.ane V10.0.0 | FirebaseMessaging.framework V3.10.0

**firebaseAnalytics.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V2.0.0 | firebaseCore.ane V2.0.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_analyticsImpl.ane V10.0.0 | 
firebase-analytics.ane V10.0.0 | 

# V1.2.0 #
Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/11eb0c7370b0a38da923e6f1adb77ba23a826e2b). *The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch.* And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_6_0/Firebase.zip).

**firebaseCore.ane**

On the Android side | On the iOS side
------------ | -------------
androidSupport.ane V23.4.0 | FirebaseAnalytics.framework V3.6.0
firebase_common.ane V9.6.1 | FirebaseInstanceID.framework V3.6.0
firebase_iid.ane V9.6.1 | GoogleInterchangeUtilities.framework V3.6.0
googlePlayServices_base.ane V9.6.1 | GoogleSymbolUtilities.framework V3.6.0
googlePlayServices_basement.ane V9.6.1 | GoogleUtilities.framework V3.6.0
googlePlayServices_tasks.ane V9.6.1 | 

**firebaseAuth.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_auth.ane V9.6.1 | FirebaseAuth.framework V3.6.0
firebase_authCommon.ane V9.6.1 | GoogleNetworkingUtilities.framework V3.6.0
firebase_authModule.ane V9.6.1 | 

**firebaseDatabase.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_database.ane V9.6.1 | FirebaseDatabase.framework V3.6.0
firebase_databaseConnection.ane V9.6.1 | 

**firebaseRemoteConfig.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_config.ane V9.6.1 | FirebaseRemoteConfig.framework V3.6.0
 | GoogleIPhoneUtilities.framework V3.6.0

**firebaseStorage.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_storage.ane V9.6.1 | FirebaseStorage.framework V3.6.0
firebase_storageCommon.ane V9.6.1 | GoogleNetworkingUtilities.framework V3.6.0

**firebaseCrash.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_crash.ane V9.6.1 | FirebaseCrash.framework V3.6.0

**firebaseMessaging.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_messaging.ane V9.6.1 | FirebaseMessaging.framework V3.6.0
 | GoogleIPhoneUtilities.framework V3.6.0
 
**firebaseAnalytics.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.2.0 | firebaseCore.ane V1.2.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_analyticsImpl.ane V9.6.1 | 
firebase-analytics.ane V9.6.1 | 

----------------------------------------------------------

# V1.1.0 #
Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/d2e6ca60f511ca4baf219a67de57ebda90d56772). *The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch.* And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_4_0/Firebase.zip).

**firebaseCore.ane**

On the Android side | On the iOS side
------------ | -------------
androidSupport.ane V23.4.0 | FirebaseAnalytics.framework V3.4.0
firebase_common.ane V9.4.0 | FirebaseInstanceID.framework V3.4.0
firebase_iid.ane V9.4.0 | GoogleInterchangeUtilities.framework V3.4.0
googlePlayServices_base.ane V9.4.0 | GoogleSymbolUtilities.framework V3.4.0
googlePlayServices_basement.ane V9.4.0 | GoogleUtilities.framework V3.4.0
googlePlayServices_tasks.ane V9.4.0 | 

**firebaseAuth.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_auth.ane V9.4.0 | FirebaseAuth.framework V3.4.0
firebase_authCommon.ane V9.4.0 | GoogleNetworkingUtilities.framework V3.4.0
firebase_authModule.ane V9.4.0 | GoogleParsingUtilities.framework V3.4.0

**firebaseDatabase.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_database.ane V9.4.0 | FirebaseDatabase.framework V3.4.0
firebase_databaseConnection.ane V9.4.0 | 

**firebaseRemoteConfig.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_config.ane V9.4.0 | FirebaseRemoteConfig.framework V3.4.0
 | GoogleIPhoneUtilities.framework V3.4.0

**firebaseAnalytics.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_analyticsImpl.ane V9.4.0 | 
firebase-analytics.ane V9.4.0 | 

**firebaseStorage.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_storage.ane V9.4.0 | FirebaseStorage.framework V3.4.0
firebase_storageCommon.ane V9.4.0 | GoogleSignIn.framework V3.4.0
 | GoogleAppUtilities.framework V3.4.0
 | GoogleAuthUtilities.framework V3.4.0
 | GoogleNetworkingUtilities.framework V3.4.0
 | GoogleSymbolUtilities.framework V3.4.0
 | GoogleUtilities.framework V3.4.0

**firebaseCrash.ane**

On the Android side | On the iOS side
------------ | -------------
firebaseCore.ane V1.1.0 | firebaseCore.ane V1.1.0
+ other ANEs required for the Core | + other frameworks required for the Core
firebase_crash.ane V9.4.0 | FirebaseCrash.framework V3.4.0