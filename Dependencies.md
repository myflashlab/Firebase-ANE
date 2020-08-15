Every release of Firebase ANEs will work with specific versions of Dependency ANEs and Frameworks. This document will tell you what dependencies and frameworks should be used in your project.

**IMPORTANT:**

1. Always try to use the latest releases because we won't be able to provide support for older versions.
1. Always try to use the latest AIR SDK. Doing this will automatically solve a lot of weird error messages.
1. Firebase ANEs will not run on simulators. make sure you are building on a real device.
1. When updating the .framework files, always delete the old ones and then copy the new ones. Never overwrite them.
1. Consider useing the [ANELAB](https://github.com/myflashlab/ANE-LAB/) software. It will automatically take care of ANEs installation and manifest setup.

Supported Firebase Features:

- [x] Analytics
- [x] Authentication
- [x] Crashlytics
- [x] DynamicLinks
- [x] FCM + **OneSignal**
- [x] Realtime Database
- [x] Firestore
- [x] Functions
- [ ] ~~MLKit~~
- [x] Performance
- [x] Remote Config
- [x] Storage
- [ ] In-App Messaging

# v10.x.x

Find the latest Android dependencies [here](https://github.com/myflashlab/common-dependencies-ANE). 
And download the iOS frameworks **v6.30.0 [from here](https://firebase.google.com/download/ios)**. 

**firebaseCore.ane**
Android | iOS
------------ | -------------
overrideAir.ane | overrideAir.ane
androidx_arch.ane | FirebaseAnalytics.framework
androidx_core.ane | FirebaseCore.framework
androidx_lifecycle.ane | FirebaseInstanceID.framework
firebase_analytics.ane | GoogleAppMeasurement.framework
firebase_common.ane | GoogleUtilities.framework
firebase_iid.ane | nanopb.framework
firebase_measurementConnector.ane | FIRAnalyticsConnector.framework
googlePlayServices_ads.ane | FirebaseCoreDiagnostics.framework
googlePlayServices_base.ane | GoogleDataTransport.framework
googlePlayServices_basement.ane | GoogleDataTransportCCTSupport.framework
googlePlayServices_measurementBase.ane | FirebaseInstallations.framework
googlePlayServices_stats.ane | PromisesObjC.framework
googlePlayServices_tasks.ane | .

**firebaseAnalytics.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'

**firebaseDynamicLinks.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_dynamicLinks.ane | FirebaseDynamicLinks.framework

**firebaseAuth.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
firebaseDynamicLinks.ane | firebaseDynamicLinks.ane
+other ANEs required by the 'Core' and 'DynamicLinks' | +other frameworks/ANEs required by the 'Core' and 'DynamicLinks'
firebase_auth.ane | FirebaseAuth.framework
gson.ane | GTMSessionFetcher.framework
googlePlayServices_flags.ane | .

**firebaseDatabase.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_database.ane | FirebaseDatabase.framework
firebase_databaseCollection.ane | leveldb-library.framework
firebase_auth.ane | .
googlePlayServices_flags.ane | .
gson.ane | .

**firebaseFunctions.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_addons_squareup.ane | FirebaseFunctions.framework
firebase_functions.ane | GTMSessionFetcher.framework
firebase_auth.ane | .
gson.ane | .

**firebaseFirestore.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_addons_squareup.ane | BoringSSL-GRPC.framework
firebase_auth.ane | FirebaseFirestore.framework
firebase_databaseCollection.ane | gRPC-C++.framework
firebase_firestore.ane | gRPC-Core.framework
gson.ane | leveldb-library.framework
firebase_addons_firestore.ane | Protobuf.framework
. | **Resources:** gRPCCertificates-Cpp.bundle

**firebaseRemoteConfig.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_config.ane | FirebaseRemoteConfig.framework
firebase_abt.ane | Protobuf.framework
. | FirebaseABTesting.framework

**firebasePerformance.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
firebaseRemoteConfig.ane | firebaseRemoteConfig.ane
+other ANEs required by the 'Core' and 'RemoteConfig' | +other frameworks/ANEs required by the 'Core' and 'RemoteConfig'
firebase_perf.ane | FirebasePerformance.framework
googlePlayServices_clearcut.ane | GTMSessionFetcher.framework
googlePlayServices_phenotype.ane | GoogleToolboxForMac.framework

**firebaseStorage.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_storage.ane | FirebaseStorage.framework
firebase_auth.ane | GTMSessionFetcher.framework
googlePlayServices_flags.ane | .
gson.ane | .

**firebaseCrashlytics.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
. | FirebaseCrashlytics.framework

**firebaseMessaging.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_messaging.ane | FirebaseMessaging.framework
firebase_datatransport.ane | Protobuf.framework
firebase_encoders_json.ane | .
firebase_addons_fcm.ane | .
(_OneSignal_) googlePlayServices_places.ane | .
(_OneSignal_) googlePlayServices_location.ane | .
(_OneSignal_) androidx_design.ane | .
(_OneSignal_) androidx_browser.ane | .

---

# V9.x.x

Find the latest Android dependencies [here](https://github.com/myflashlab/common-dependencies-ANE). And download the iOS frameworks **V6.18.0 [from here](https://dl.google.com/firebase/sdk/ios/6_18_0/Firebase-6.18.0.zip)**. And finally, if you want to use Crashlytics, you should download the frameworks **V3.14.0 [from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.14.0/com.crashlytics.ios-manual.zip)**.

**firebaseCore.ane**
Android | iOS
------------ | -------------
overrideAir.ane | overrideAir.ane
androidx_arch.ane | FirebaseAnalytics.framework
androidx_core.ane | FirebaseCore.framework
androidx_lifecycle.ane | FirebaseInstanceID.framework
firebase_analytics.ane | GoogleAppMeasurement.framework
firebase_common.ane | GoogleUtilities.framework
firebase_iid.ane | nanopb.framework
firebase_measurementConnector.ane | FIRAnalyticsConnector.framework
googlePlayServices_ads.ane | FirebaseCoreDiagnostics.framework
googlePlayServices_base.ane | GoogleDataTransport.framework
googlePlayServices_basement.ane | GoogleDataTransportCCTSupport.framework
googlePlayServices_measurementBase.ane | FirebaseInstallations.framework
googlePlayServices_stats.ane | PromisesObjC.framework
googlePlayServices_tasks.ane | .

**firebaseAnalytics.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'

**firebaseDynamicLinks.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_dynamicLinks.ane | FirebaseDynamicLinks.framework

**firebaseAuth.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
firebaseDynamicLinks.ane | firebaseDynamicLinks.ane
+other ANEs required by the 'Core' and 'DynamicLinks' | +other frameworks/ANEs required by the 'Core' and 'DynamicLinks'
firebase_auth.ane | FirebaseAuth.framework
gson.ane | GTMSessionFetcher.framework
googlePlayServices_flags.ane | .

**firebaseDatabase.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_database.ane | FirebaseDatabase.framework
firebase_databaseCollection.ane | leveldb-library.framework
firebase_auth.ane | .
googlePlayServices_flags.ane | .
gson.ane | .

**firebaseFunctions.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_addons_squareup.ane | FirebaseFunctions.framework
firebase_functions.ane | GTMSessionFetcher.framework
firebase_auth.ane | .
gson.ane | .

**firebaseFirestore.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_addons_squareup.ane | BoringSSL-GRPC.framework
firebase_auth.ane | FirebaseFirestore.framework
firebase_databaseCollection.ane | gRPC-C++.framework
firebase_firestore.ane | gRPC-Core.framework
gson.ane | leveldb-library.framework
firebase_addons_firestore.ane | Protobuf.framework
. | **Resources:** gRPCCertificates-Cpp.bundle

**firebaseRemoteConfig.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_config.ane | FirebaseRemoteConfig.framework
firebase_abt.ane | Protobuf.framework
. | FirebaseABTesting.framework

**firebasePerformance.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
firebaseRemoteConfig.ane | firebaseRemoteConfig.ane
+other ANEs required by the 'Core' and 'RemoteConfig' | +other frameworks/ANEs required by the 'Core' and 'RemoteConfig'
firebase_perf.ane | FirebasePerformance.framework
googlePlayServices_clearcut.ane | GTMSessionFetcher.framework
googlePlayServices_phenotype.ane | GoogleToolboxForMac.framework

**firebaseStorage.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_storage.ane | FirebaseStorage.framework
firebase_auth.ane | GTMSessionFetcher.framework
googlePlayServices_flags.ane | .
gson.ane | .

**firebaseCrashlytics.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
. | [Crashlytics.framework V3.14.0](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.14.0/com.crashlytics.ios-manual.zip)
. | [Fabric.framework V3.14.0](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.14.0/com.crashlytics.ios-manual.zip)

**firebaseMessaging.ane**
Android | iOS
------------ | -------------
firebaseCore.ane | firebaseCore.ane
+other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'
firebase_messaging.ane | FirebaseMessaging.framework
firebase_datatransport.ane | Protobuf.framework
firebase_encoders_json.ane | .
firebase_addons_fcm.ane | .
(_OneSignal_) googlePlayServices_places.ane | .
(_OneSignal_) googlePlayServices_location.ane | .
(_OneSignal_) androidx_design.ane | .
(_OneSignal_) androidx_browser.ane | .

---

# V8.x.x

Find the latest Android dependencies [here](https://github.com/myflashlab/common-dependencies-ANE). And download the iOS frameworks **V5.20.2 [from here](https://dl.google.com/firebase/sdk/ios/5_20_2/Firebase-5.20.2.zip)**. And finally, if you want to use Crashlytics, you should download the frameworks **V3.12.0 [from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.12.0/com.crashlytics.ios-manual.zip)**.

**firebaseCore.ane**

| Android                                        | iOS                               |
| ---------------------------------------------- | --------------------------------- |
| overrideAir.ane V6.1.1                         | overrideAir.ane V6.1.1            |
| androidSupport-arch.ane V1.1.1                 | FirebaseAnalytics.framework       |
| androidSupport-core.ane V27.1.1                | FirebaseCore.framework            |
| androidSupport-v4.ane V27.1.1                  | FirebaseInstanceID.framework      |
| firebase_analytics.ane V16.4.0                 | GoogleAppMeasurement.framework    |
| firebase_common.ane V16.1.0                    | GoogleUtilities.framework         |
| firebase_iid.ane V17.1.2                       | nanopb.framework                  |
| firebase_measurementConnector.ane V17.0.1      | FIRAnalyticsConnector.framework   |
| googlePlayServices_ads.ane V17.2.0             | FirebaseCoreDiagnostics.framework |
| googlePlayServices_base.ane V16.1.0            | .                                 |
| googlePlayServices_basement.ane V16.2.0        | .                                 |
| googlePlayServices_measurementBase.ane V16.4.0 | .                                 |
| googlePlayServices_stats.ane V16.0.1           | .                                 |
| googlePlayServices_tasks.ane V16.0.1           | .                                 |

**firebaseAnalytics.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |

**firebaseDynamicLinks.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_dynamicLinks.ane V6.1.8   | FirebaseDynamicLinks.framework                |

**firebaseAuth.ane**

| Android                                               | iOS                                                              |
| ----------------------------------------------------- | ---------------------------------------------------------------- |
| firebaseCore.ane V8.x.x                               | firebaseCore.ane V8.x.x                                          |
| firebaseDynamicLinks.ane V8.x.x                       | firebaseDynamicLinks.ane V8.x.x                                  |
| +other ANEs required by the 'Core' and 'DynamicLinks' | +other frameworks/ANEs required by the 'Core' and 'DynamicLinks' |
| firebase_auth.ane V16.2.1                             | FirebaseAuth.framework                                           |
| gson.ane V2.8.2                                       | GTMSessionFetcher.framework                                      |
| googlePlayServices_flags.ane V16.0.1                  | .                                                                |

**firebaseDatabase.ane**

| Android                                 | iOS                                           |
| --------------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x                 | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core'      | +other frameworks/ANEs required by the 'Core' |
| firebase_database.ane V16.1.0           | FirebaseDatabase.framework                    |
| firebase_databaseCollection.ane V16.0.1 | leveldb-library.framework                     |

**firebaseFunctions.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_addons.ane V2.0.0         | FirebaseFunctions.framework                   |
| firebase_functions.ane V16.3.0     | GTMSessionFetcher.framework                   |
| firebase_auth.ane V16.2.1          | .                                             |
| gson.ane V2.8.2                    | .                                             |

**firebaseFirestore.ane**

| Android                                 | iOS                                           |
| --------------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x                 | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core'      | +other frameworks/ANEs required by the 'Core' |
| firebase_addons.ane V2.0.0              | BoringSSL-GRPC.framework                      |
| firebase_auth.ane V16.2.1               | FirebaseFirestore.framework                   |
| firebase_databaseCollection.ane V16.0.1 | gRPC-C++.framework                            |
| firebase_firestore.ane V18.2.0          | gRPC-Core.framework                           |
| gson.ane V2.8.2                         | leveldb-library.framework                     |
| .                                       | Protobuf.framework                            |
| .                                       | **Resources:** gRPCCertificates.bundle        |

**firebaseRemoteConfig.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_config.ane V16.5.0        | FirebaseRemoteConfig.framework                |
| firebase_abt.ane V17.1.0           | Protobuf.framework                            |
| .                                  | FirebaseABTesting.framework                   |

**firebasePerformance.ane**

| Android                                               | iOS                                                              |
| ----------------------------------------------------- | ---------------------------------------------------------------- |
| firebaseCore.ane V8.x.x                               | firebaseCore.ane V8.x.x                                          |
| firebaseRemoteConfig.ane V8.x.x                       | firebaseRemoteConfig.ane V8.x.x                                  |
| +other ANEs required by the 'Core' and 'RemoteConfig' | +other frameworks/ANEs required by the 'Core' and 'RemoteConfig' |
| firebase_perf.ane V16.2.5                             | FirebaseABTesting.framework                                      |
| googlePlayServices_clearcut.ane V16.0.0               | FirebasePerformance.framework                                    |
| googlePlayServices_phenotype.ane V16.0.0              | FirebaseRemoteConfig.framework                                   |
| .                                                     | GoogleToolboxForMac.framework                                    |
| .                                                     | GTMSessionFetcher.framework                                      |
| .                                                     | Protobuf.framework                                               |

**firebaseStorage.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_storage.ane V16.1.0       | FirebaseStorage.framework                     |
| .                                  | GTMSessionFetcher.framework                   |

**firebaseCrashlytics.ane**

| Android                            | iOS                                                                                                                                                  |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                                                                                                                              |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'                                                                                                        |
| .                                  | [Crashlytics.framework V3.12.0](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.12.0/com.crashlytics.ios-manual.zip) |
| .                                  | [Fabric.framework V3.12.0](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.12.0/com.crashlytics.ios-manual.zip)      |

**firebaseMessaging.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V8.x.x            | firebaseCore.ane V8.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_messaging.ane V17.6.0     | FirebaseMessaging.framework                   |
| .                                  | Protobuf.framework                            |

**firebaseMlkit.ane**

| Android                                                                                                                                                              | iOS                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| firebaseCore.ane V8.x.x                                                                                                                                              | firebaseCore.ane V8.x.x                                                                                                   |
| +other ANEs required by the 'Core'                                                                                                                                   | +other frameworks/ANEs required by the 'Core'                                                                             |
| firebase_ml.ane V19.0.3                                                                                                                                              | FirebaseMLCommon.framework                                                                                                |
| tensorflow.ane V1.12.0                                                                                                                                               | FirebaseMLModelInterpreter.framework                                                                                      |
| googlePlayServices_auth.ane V16.0.1                                                                                                                                  | GTMSessionFetcher.framework                                                                                               |
| googlePlayServices_vision.ane V17.0.2                                                                                                                                | FirebaseMLVision.framework                                                                                                |
| googlePlayServices_clearcut.ane V16.0.0                                                                                                                              | FirebaseMLVisionBarcodeModel.framework                                                                                    |
| googlePlayServices_phenotype.ane V16.0.0                                                                                                                             | FirebaseMLVisionFaceModel.framework                                                                                       |
| googlePlayServices_flags.ane V16.0.1                                                                                                                                 | FirebaseMLVisionLabelModel.framework                                                                                      |
| **[Resources:](https://github.com/myflashlab/Firebase-ANE/blob/master/ml_res.zip?raw=true)** hobbes.tflite, langid_model.smfb.jpg, sensitive_model_020817.pb, models | FirebaseMLVisionTextModel.framework                                                                                       |
| .                                                                                                                                                                    | GoogleAPIClientForREST.framework                                                                                          |
| .                                                                                                                                                                    | GoogleMobileVision.framework                                                                                              |
| .                                                                                                                                                                    | tensorflow_lite.framework                                                                                                 |
| .                                                                                                                                                                    | FirebaseMLNaturalLanguage.framework                                                                                       |
| .                                                                                                                                                                    | FirebaseMLNLLanguageID.framework                                                                                          |
| .                                                                                                                                                                    | FirebaseABTesting.framework                                                                                               |
| .                                                                                                                                                                    | FirebaseMLNLSmartReply.framework                                                                                          |
| .                                                                                                                                                                    | FirebaseRemoteConfig.framework                                                                                            |
| .                                                                                                                                                                    | Protobuf.framework                                                                                                        |
| .                                                                                                                                                                    | GoogleToolboxForMac.framework                                                                                             |
| .                                                                                                                                                                    | BarcodeDetector.framework                                                                                                 |
| .                                                                                                                                                                    | FaceDetector.framework                                                                                                    |
| .                                                                                                                                                                    | LabelDetector.framework                                                                                                   |
| .                                                                                                                                                                    | TextDetector.framework                                                                                                    |
| .                                                                                                                                                                    | **Resources:** GoogleMVFaceDetectorResources.bundle, GoogleMVTextDetectorResources.bundle, PredictOnDeviceResource.bundle |

# V7.x.x

Find the latest Android dependencies [here](https://github.com/myflashlab/common-dependencies-ANE/tree/7c9c6c63779f051b62dc92a6f1d3557adc27e16e). And download the iOS frameworks V5.4.1 [from here](https://dl.google.com/firebase/sdk/ios/5_4_1/Firebase-5.4.1.zip). And finally, if you want to use Crashlytics, you should download the frameworks V3.10.7 [from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.7/com.crashlytics.ios-manual.zip).

**firebaseCore.ane**

| Android                                        | iOS                               |
| ---------------------------------------------- | --------------------------------- |
| overrideAir.ane V5.6.1                         | overrideAir.ane V5.6.1            |
| androidSupport-arch.ane V1.1.1                 | FirebaseAnalytics.framework       |
| androidSupport-core.ane V27.1.1                | FirebaseCore.framework            |
| androidSupport-v4.ane V27.1.1                  | FirebaseCoreDiagnostics.framework |
| firebase_analytics.ane V16.0.1                 | FirebaseNanoPB.framework          |
| firebase_analyticsImpl.ane V16.1.1             | FirebaseInstanceID.framework      |
| firebase_common.ane V16.0.0                    | GoogleToolboxForMac.framework     |
| firebase_iid.ane V16.2.0                       | nanopb.framework                  |
| firebase_measurementConnector.ane V16.0.0      | .                                 |
| firebase_measurementConnectorImpl.ane V16.0.1  | .                                 |
| googlePlayServices_ads.ane V15.0.1             | .                                 |
| googlePlayServices_base.ane V15.0.1            | .                                 |
| googlePlayServices_basement.ane V15.0.1        | .                                 |
| googlePlayServices_measurementBase.ane V16.0.0 | .                                 |
| googlePlayServices_stats.ane V15.0.1           | .                                 |
| googlePlayServices_tasks.ane V15.0.1           | .                                 |

**firebaseAnalytics.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x            | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |

**firebaseDynamicLinks.ane**

| Android                                  | iOS                                           |
| ---------------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x                  | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core'       | +other frameworks/ANEs required by the 'Core' |
| firebase_dynamicLinks.ane V16.0.1        | FirebaseDynamicLinks.framework                |
| googlePlayServices_appinvite.ane V16.0.1 | .                                             |

**firebaseInvites.ane**

| Android                                               | iOS                                                                                         |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| firebaseCore.ane V7.x.x                               | firebaseCore.ane V7.x.x                                                                     |
| firebaseDynamicLinks.ane V7.x.x                       | firebaseDynamicLinks.ane V7.x.x                                                             |
| +other ANEs required by the 'Core' and 'DynamicLinks' | +other frameworks/ANEs required by the 'Core' and 'DynamicLinks'                            |
| .                                                     | FirebaseInvites.framework                                                                   |
| .                                                     | GTMOAuth2.framework                                                                         |
| .                                                     | GTMSessionFetcher.framework                                                                 |
| .                                                     | GoogleAPIClientForREST.framework                                                            |
| .                                                     | GoogleSignIn.framework                                                                      |
| .                                                     | Protobuf.framework                                                                          |
| .                                                     | **Resources:** GINInviteResources.bundle, GoogleSignIn.bundle, GPPACLPickerResources.bundle |

**firebaseAuth.ane**

| Android                                                                                               | iOS                                                                                                              |
| ----------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| firebaseCore.ane V7.x.x                                                                               | firebaseCore.ane V7.x.x                                                                                          |
| firebaseInvites.ane V7.x.x                                                                            | firebaseInvites.ane V7.x.x                                                                                       |
| +other ANEs required by the 'Core' and 'Invites'. **NOTE: Invites is also dependent on DynamicLinks** | +other frameworks/ANEs required by the 'Core' and 'Invites'. **NOTE: Invites is also dependent on DynamicLinks** |
| firebase_auth.ane V16.0.2                                                                             | FirebaseAuth.framework                                                                                           |
| gson.ane V2.8.2                                                                                       | GTMSessionFetcher.framework                                                                                      |
| googlePlayServices_flags.ane V15.0.1                                                                  | .                                                                                                                |

**firebaseDatabase.ane**

| Android                                 | iOS                                           |
| --------------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x                 | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core'      | +other frameworks/ANEs required by the 'Core' |
| firebase_database.ane V16.0.1           | FirebaseDatabase.framework                    |
| firebase_databaseCollection.ane V15.0.1 | leveldb-library.framework                     |

**firebaseFirestore.ane**

| Android                                 | iOS                                           |
| --------------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x                 | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core'      | +other frameworks/ANEs required by the 'Core' |
| firebase_firestore.ane V17.0.4          | BoringSSL.framework                           |
| firebase_databaseCollection.ane V15.0.1 | FirebaseFirestore.framework                   |
| firebase-addons.ane V1.0.0              | Protobuf.framework                            |
| gson.ane V2.8.2                         | gRPC.framework                                |
| .                                       | gRPC-Core.framework                           |
| .                                       | gRPC-ProtoRPC.framework                       |
| .                                       | gRPC-RxLibrary.framework                      |
| .                                       | leveldb-library.framework                     |
| .                                       | **Resources:** gRPCCertificates.bundle        |

**firebaseRemoteConfig.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x            | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required for by 'Core' |
| firebase_config.ane V16.0.0        | FirebaseRemoteConfig.framework                |
| .                                  | Protobuf.framework                            |
| .                                  | FirebaseABTesting.framework                   |

**firebaseStorage.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x            | firebaseCore.ane V7.x.x                       |
| +other ANEs required for by 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_storage.ane V16.0.1       | FirebaseStorage.framework                     |
| .                                  | GTMSessionFetcher.framework                   |

**firebaseCrashlytics.ane**

| Android                            | iOS                                                                                                                                                  |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| firebaseCore.ane V7.x.x            | firebaseCore.ane V7.x.x                                                                                                                              |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core'                                                                                                        |
| .                                  | [Crashlytics.framework V3.10.7](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.7/com.crashlytics.ios-manual.zip) |
| .                                  | [Fabric.framework V3.10.7](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.7/com.crashlytics.ios-manual.zip)      |

**firebaseMessaging.ane**

| Android                            | iOS                                           |
| ---------------------------------- | --------------------------------------------- |
| firebaseCore.ane V7.x.x            | firebaseCore.ane V7.x.x                       |
| +other ANEs required by the 'Core' | +other frameworks/ANEs required by the 'Core' |
| firebase_messaging.ane V17.1.0     | FirebaseMessaging.framework                   |
| .                                  | Protobuf.framework                            |

**firebaseMlkit.ane**

| Android                                  | iOS                                                                                       |
| ---------------------------------------- | ----------------------------------------------------------------------------------------- |
| firebaseCore.ane V7.x.x                  | firebaseCore.ane V7.x.x                                                                   |
| +other ANEs required by the 'Core'       | +other frameworks/ANEs required by the 'Core'                                             |
| firebase-ml.ane V16.0.0                  | BarcodeDetector.framework                                                                 |
| tensorflow.ane V0.1.7                    | FaceDetector.framework                                                                    |
| googlePlayServices_vision.ane V15.0.2    | FirebaseMLCommon.framework                                                                |
| googlePlayServices_clearcut.ane V15.0.1  | FirebaseMLModelInterpreter.framework                                                      |
| googlePlayServices_phenotype.ane V15.0.1 | FirebaseMLVision.framework                                                                |
| googlePlayServices_flags.ane V15.0.1     | FirebaseMLVisionBarcodeModel.framework                                                    |
| .                                        | FirebaseMLVisionFaceModel.framework                                                       |
| .                                        | FirebaseMLVisionLabelModel.framework                                                      |
| .                                        | FirebaseMLVisionTextModel.framework                                                       |
| .                                        | GoogleAPIClientForREST.framework                                                          |
| .                                        | GoogleMobileVision.framework                                                              |
| .                                        | GTMSessionFetcher.framework                                                               |
| .                                        | LabelDetector.framework                                                                   |
| .                                        | Protobuf.framework                                                                        |
| .                                        | tensorflow_lite.framework                                                                 |
| .                                        | TextDetector.framework                                                                    |
| .                                        | **Resources:** GoogleMVFaceDetectorResources.bundle, GoogleMVTextDetectorResources.bundle |

# V6.x.x

Find the Android dependencies V12.0.1 on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/a9ac3e9fa2e9c002d99751246b1255e243fba1d5). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks V4.11.0 [from here](https://dl.google.com/firebase/sdk/ios/4_11_0/Firebase-4.11.0.zip). And finally, if you want to use Crashlytics, you should download the frameworks V3.10.1 [from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.1/com.crashlytics.ios-manual.zip).

**firebaseCore.ane**

| On the Android side                      | On the iOS side                   |
| ---------------------------------------- | --------------------------------- |
| androidSupport.ane V27.0.2               | overrideAir.ane V5.1.1            |
| overrideAir.ane V5.1.1                   | FirebaseAnalytics.framework       |
| firebase_common.ane V12.0.1              | FirebaseCore.framework            |
| firebase_iid.ane V12.0.1                 | FirebaseCoreDiagnostics.framework |
| googlePlayServices_base.ane V12.0.1      | FirebaseNanoPB.framework          |
| googlePlayServices_basement.ane V12.0.1  | FirebaseInstanceID.framework      |
| googlePlayServices_tasks.ane V12.0.1     | GoogleToolboxForMac.framework     |
| googlePlayServices_appinvite.ane V12.0.1 | nanopb.framework                  |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V6.x.x          | firebaseCore.ane V6.x.x                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_auth.ane V12.0.1        | FirebaseAuth.framework                      |
| .                                | GTMSessionFetcher.framework                 |

**firebaseDatabase.ane**

| On the Android side                     | On the iOS side                             |
| --------------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x                  | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core        | +other frameworks/ANEs required by the Core |
| firebase_database.ane V12.0.1           | FirebaseDatabase.framework                  |
| firebase_databaseConnection.ane V12.0.1 | leveldb-library.framework                   |

**firebaseFirestore.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x           | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_firestore.ane V12.0.1   | BoringSSL.framework                         |
| .                                | FirebaseFirestore.framework                 |
| .                                | Protobuf.framework                          |
| .                                | gRPC.framework                              |
| .                                | gRPC-Core.framework                         |
| .                                | gRPC-ProtoRPC.framework                     |
| .                                | gRPC-RxLibrary.framework                    |
| .                                | leveldb-library.framework                   |
| .                                | **Resources:** gRPCCertificates.bundle      |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x           | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core | +other frameworks/ANEs required for by Core |
| firebase_config.ane V12.0.1      | FirebaseRemoteConfig.framework              |
| .                                | Protobuf.framework                          |
| .                                | FirebaseABTesting.framework                 |

**firebaseStorage.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x             | firebaseCore.ane 6.x.x                      |
| +other ANEs required for by Core   | +other frameworks/ANEs required by the Core |
| firebase_storage.ane V12.0.1       | FirebaseStorage.framework                   |
| firebase_storageCommon.ane V12.0.1 | GTMSessionFetcher.framework                 |

**firebaseCrash.ane** \*Deprecated, use Crashlytics instead.

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x             | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_crash.ane V12.0.1         | FirebaseCrash.framework                     |
| firebase_analyticsImpl.ane V12.0.1 | Protobuf.framework                          |

**firebaseCrashlytics.ane**

| On the Android side                | On the iOS side                                                                                                                                      |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| firebaseCore.ane 6.x.x             | firebaseCore.ane 6.x.x                                                                                                                               |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core                                                                                                          |
| firebase_analyticsImpl.ane V12.0.1 | [Crashlytics.framework V3.10.1](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.1/com.crashlytics.ios-manual.zip) |
| .                                  | [Fabric.framework V3.10.1](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.1/com.crashlytics.ios-manual.zip)      |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x           | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_messaging.ane V12.0.1   | FirebaseMessaging.framework                 |
| .                                | Protobuf.framework                          |

**firebaseAnalytics.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x             | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_analyticsImpl.ane V12.0.1 |
| firebase-analytics.ane V12.0.1     |

**firebaseDynamicLinks.ane**

| On the Android side               | On the iOS side                             |
| --------------------------------- | ------------------------------------------- |
| firebaseCore.ane 6.x.x            | firebaseCore.ane 6.x.x                      |
| +other ANEs required by the Core  | +other frameworks/ANEs required by the Core |
| firebase_dynamicLinks.ane V12.0.1 | FirebaseDynamicLinks.framework              |

**firebaseInvites.ane**

| On the Android side                      | On the iOS side                                                                             |
| ---------------------------------------- | ------------------------------------------------------------------------------------------- |
| firebaseCore.ane 6.x.x                   | firebaseCore.ane 6.x.x                                                                      |
| +other ANEs required by the Core         | +other frameworks/ANEs required by the Core                                                 |
| firebaseDynamicLinks.ane V6.x.x          | firebaseDynamicLinks.ane V6.x.x                                                             |
| +other ANEs required by the DynamicLinks | +other frameworks/ANEs required by the DynamicLinks                                         |
| .                                        | FirebaseInvites.framework                                                                   |
| .                                        | GTMOAuth2.framework                                                                         |
| .                                        | GTMSessionFetcher.framework                                                                 |
| .                                        | GoogleAPIClientForREST.framework                                                            |
| .                                        | GoogleSignIn.framework                                                                      |
| .                                        | Protobuf.framework                                                                          |
| .                                        | **Resources:** GINInviteResources.bundle, GoogleSignIn.bundle, GPPACLPickerResources.bundle |

# V5.x.x

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/236eb77a96c17865de10f0eba0fed3db6e0909ed). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/4_0_3/Firebase-4.0.3.zip).

**firebaseCore.ane**

| On the Android side                      | On the iOS side                   |
| ---------------------------------------- | --------------------------------- |
| androidSupport.ane V25.3.1               | overrideAir.ane V4.1.0            |
| overrideAir.ane V4.1.0                   | FirebaseAnalytics.framework       |
| firebase_common.ane V11.0.2              | FirebaseCore.framework            |
| firebase_iid.ane V11.0.2                 | FirebaseCoreDiagnostics.framework |
| googlePlayServices_base.ane V11.0.2      | FirebaseNanoPB.framework          |
| googlePlayServices_basement.ane V11.0.2  | FirebaseInstanceID.framework      |
| googlePlayServices_tasks.ane V11.0.2     | GoogleToolboxForMac.framework     |
| googlePlayServices_appinvite.ane V11.0.2 |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1          | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_auth.ane V11.0.2        | FirebaseAuth.framework                      |
| .                                | GTMSessionFetcher.framework                 |

**firebaseDatabase.ane**

| On the Android side                     | On the iOS side                             |
| --------------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1                 | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core        | +other frameworks/ANEs required by the Core |
| firebase_database.ane V11.0.2           | FirebaseDatabase.framework                  |
| firebase_databaseConnection.ane V11.0.2 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1          | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core | +other frameworks/ANEs required for by Core |
| firebase_config.ane V11.0.2      | FirebaseRemoteConfig.framework              |
| .                                | Protobuf.framework                          |

**firebaseStorage.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1            | firebaseCore.ane V5.1.1                     |
| +other ANEs required for by Core   | +other frameworks/ANEs required by the Core |
| firebase_storage.ane V11.0.2       | FirebaseStorage.framework                   |
| firebase_storageCommon.ane V11.0.2 | GTMSessionFetcher.framework                 |

**firebaseCrash.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1            | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_crash.ane V11.0.2         | FirebaseCrash.framework                     |
| firebase_analyticsImpl.ane V11.0.2 | Protobuf.framework                          |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1          | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_messaging.ane V11.0.2   | FirebaseMessaging.framework                 |
| .                                | Protobuf.framework                          |

**firebaseAnalytics.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1            | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_analyticsImpl.ane V11.0.2 |
| firebase-analytics.ane V11.0.2     |

**firebaseDynamicLinks.ane**

| On the Android side               | On the iOS side                             |
| --------------------------------- | ------------------------------------------- |
| firebaseCore.ane V5.1.1           | firebaseCore.ane V5.1.1                     |
| +other ANEs required by the Core  | +other frameworks/ANEs required by the Core |
| firebase_dynamicLinks.ane V11.0.2 | FirebaseDynamicLinks.framework              |

**firebaseInvites.ane**

| On the Android side                      | On the iOS side                                     |
| ---------------------------------------- | --------------------------------------------------- |
| firebaseCore.ane V5.1.1                  | firebaseCore.ane V5.1.1                             |
| +other ANEs required by the Core         | +other frameworks/ANEs required by the Core         |
| firebaseDynamicLinks.ane V5.1.0          | firebaseDynamicLinks.ane V5.1.0                     |
| +other ANEs required by the DynamicLinks | +other frameworks/ANEs required by the DynamicLinks |
| .                                        | FirebaseDynamicLinks.framework                      |
| .                                        | FirebaseInvites.framework                           |
| .                                        | GTMOAuth2.framework                                 |
| .                                        | GTMSessionFetcher.framework                         |
| .                                        | GoogleAPIClientForREST.framework                    |
| .                                        | GoogleSignIn.framework                              |
| .                                        | Protobuf.framework                                  |

# V4.x.x

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/072a311ad98ec34f9a4c8078b1d2cdd4229a4aaa). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_13_0/Firebase-3.13.0.zip).

**firebaseCore.ane**

| On the Android side                      | On the iOS side                       |
| ---------------------------------------- | ------------------------------------- |
| androidSupport.ane V24.2.1               | overrideAir.ane V4.0.0                |
| overrideAir.ane V4.0.0                   | FirebaseAnalytics.framework V3.13.0   |
| firebase_common.ane V10.2.0              | FirebaseCore.framework V3.13.0        |
| firebase_iid.ane V10.2.0                 | FirebaseInstanceID.framework V3.13.0  |
| googlePlayServices_base.ane V10.2.0      | GoogleToolboxForMac.framework V3.13.0 |
| googlePlayServices_basement.ane V10.2.0  |
| googlePlayServices_tasks.ane V10.2.0     |
| googlePlayServices_appinvite.ane V10.2.0 |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0          | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_auth.ane V10.2.0        | FirebaseAuth.framework V3.13.0              |
| .                                | GTMSessionFetcher.framework V3.13.0         |

**firebaseDatabase.ane**

| On the Android side                     | On the iOS side                             |
| --------------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0                 | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core        | +other frameworks/ANEs required by the Core |
| firebase_database.ane V10.2.0           | FirebaseDatabase.framework V3.13.0          |
| firebase_databaseConnection.ane V10.2.0 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0          | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core | +other frameworks/ANEs required for by Core |
| firebase_config.ane V10.2.0      | FirebaseRemoteConfig.framework V3.13.0      |
| .                                | Protobuf.framework V3.13.0                  |

**firebaseStorage.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0            | firebaseCore.ane V4.0.0                     |
| +other ANEs required for by Core   | +other frameworks/ANEs required by the Core |
| firebase_storage.ane V10.2.0       | FirebaseStorage.framework V3.13.0           |
| firebase_storageCommon.ane V10.2.0 | GTMSessionFetcher.framework V3.13.0         |

**firebaseCrash.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0            | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_crash.ane V10.2.0         | FirebaseCrash.framework V3.13.0             |
| firebase_analyticsImpl.ane V10.2.0 | Protobuf.framework V3.13.0                  |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0          | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| firebase_messaging.ane V10.2.0   | FirebaseMessaging.framework V3.13.0         |
| .                                | Protobuf.framework V3.13.0                  |

**firebaseAnalytics.ane**

| On the Android side                | On the iOS side                             |
| ---------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0            | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core   | +other frameworks/ANEs required by the Core |
| firebase_analyticsImpl.ane V10.2.0 |
| firebase-analytics.ane V10.2.0     |

**firebaseDynamicLinks.ane**

| On the Android side              | On the iOS side                             |
| -------------------------------- | ------------------------------------------- |
| firebaseCore.ane V4.0.0          | firebaseCore.ane V4.0.0                     |
| +other ANEs required by the Core | +other frameworks/ANEs required by the Core |
| .                                | FirebaseDynamicLinks.framework V3.13.0      |

**firebaseInvites.ane**

| On the Android side                      | On the iOS side                                     |
| ---------------------------------------- | --------------------------------------------------- |
| firebaseCore.ane V4.0.0                  | firebaseCore.ane V4.0.0                             |
| +other ANEs required by the Core         | +other frameworks/ANEs required by the Core         |
| firebaseDynamicLinks.ane V4.0.0          | firebaseDynamicLinks.ane V4.0.0                     |
| +other ANEs required by the DynamicLinks | +other frameworks/ANEs required by the DynamicLinks |
| .                                        | FirebaseDynamicLinks.framework V3.13.0              |
| .                                        | FirebaseInvites.framework V3.13.0                   |
| .                                        | GTMOAuth2.framework V3.13.0                         |
| .                                        | GTMSessionFetcher.framework V3.13.0                 |
| .                                        | GoogleAPIClientForREST.framework V3.13.0            |
| .                                        | GoogleSignIn.framework V3.13.0                      |
| .                                        | Protobuf.framework V3.13.0                          |

# V3.x.x

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/3df030020e09c17f31603a492171ed2dc3d5aa7d). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_10_0/Firebase-3.10.0.zip).

**firebaseCore.ane**

| On the Android side                      | On the iOS side                              |
| ---------------------------------------- | -------------------------------------------- |
| androidSupport.ane V24.2.1               | FirebaseAnalytics.framework V3.10.0          |
| overrideAir.ane V3.0.0                   | FirebaseCore.framework V3.10.0               |
| firebase_common.ane V10.0.0              | FirebaseInstanceID.framework V3.10.0         |
| firebase_iid.ane V10.0.0                 | GoogleInterchangeUtilities.framework V3.10.0 |
| googlePlayServices_base.ane V10.0.0      | GoogleSymbolUtilities.framework V3.10.0      |
| googlePlayServices_basement.ane V10.0.0  | GoogleToolboxForMac.framework V3.10.0        |
| googlePlayServices_tasks.ane V10.0.0     |
| googlePlayServices_appinvite.ane V10.0.0 |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0          | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_auth.ane V10.0.0        | FirebaseAuth.framework V3.10.0         |
| .                                | GTMSessionFetcher.framework V3.10.0    |

**firebaseDatabase.ane**

| On the Android side                     | On the iOS side                        |
| --------------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0                 | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core        | +other frameworks required by the Core |
| firebase_database.ane V10.0.0           | FirebaseDatabase.framework V3.10.0     |
| firebase_databaseConnection.ane V10.0.0 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0          | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_config.ane V10.0.0      | FirebaseRemoteConfig.framework V3.10.0 |

**firebaseStorage.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0            | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_storage.ane V10.0.0       | FirebaseStorage.framework V3.10.0      |
| firebase_storageCommon.ane V10.0.0 | GTMSessionFetcher.framework V3.10.0    |

**firebaseCrash.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0            | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_crash.ane V10.0.0         | FirebaseCrash.framework V3.10.0        |
| firebase_analyticsImpl.ane V10.0.0 |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0          | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_messaging.ane V10.0.0   | FirebaseMessaging.framework V3.10.0    |

**firebaseAnalytics.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0            | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_analyticsImpl.ane V10.0.0 |
| firebase-analytics.ane V10.0.0     |

**firebaseDynamicLinks.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V3.0.0          | firebaseCore.ane V3.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| .                                | FirebaseDynamicLinks.framework V3.10.0 |

# V2.x.x

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/3df030020e09c17f31603a492171ed2dc3d5aa7d). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_10_0/Firebase-3.10.0.zip).

**firebaseCore.ane**

| On the Android side                     | On the iOS side                              |
| --------------------------------------- | -------------------------------------------- |
| androidSupport.ane V24.2.1              | FirebaseAnalytics.framework V3.10.0          |
| overrideAir.ane V3.0.0                  | FirebaseCore.framework V3.10.0               |
| firebase_common.ane V10.0.0             | FirebaseInstanceID.framework V3.10.0         |
| firebase_iid.ane V10.0.0                | GoogleInterchangeUtilities.framework V3.10.0 |
| googlePlayServices_base.ane V10.0.0     | GoogleSymbolUtilities.framework V3.10.0      |
| googlePlayServices_basement.ane V10.0.0 | GoogleToolboxForMac.framework V3.10.0        |
| googlePlayServices_tasks.ane V10.0.0    |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0          | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_auth.ane V10.0.0        | FirebaseAuth.framework V3.10.0         |
| .                                | GTMSessionFetcher.framework V3.10.0    |

**firebaseDatabase.ane**

| On the Android side                     | On the iOS side                        |
| --------------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0                 | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core        | +other frameworks required by the Core |
| firebase_database.ane V10.0.0           | FirebaseDatabase.framework V3.10.0     |
| firebase_databaseConnection.ane V10.0.0 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0          | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_config.ane V10.0.0      | FirebaseRemoteConfig.framework V3.10.0 |

**firebaseStorage.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0            | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_storage.ane V10.0.0       | FirebaseStorage.framework V3.10.0      |
| firebase_storageCommon.ane V10.0.0 | GTMSessionFetcher.framework V3.10.0    |

**firebaseCrash.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0            | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_crash.ane V10.0.0         | FirebaseCrash.framework V3.10.0        |
| firebase_analyticsImpl.ane V10.0.0 |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0          | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_messaging.ane V10.0.0   | FirebaseMessaging.framework V3.10.0    |

**firebaseAnalytics.ane**

| On the Android side                | On the iOS side                        |
| ---------------------------------- | -------------------------------------- |
| firebaseCore.ane V2.0.0            | firebaseCore.ane V2.0.0                |
| +other ANEs required by the Core   | +other frameworks required by the Core |
| firebase_analyticsImpl.ane V10.0.0 |
| firebase-analytics.ane V10.0.0     |

# V1.2.0

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/11eb0c7370b0a38da923e6f1adb77ba23a826e2b). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_6_0/Firebase.zip).

**firebaseCore.ane**

| On the Android side                    | On the iOS side                             |
| -------------------------------------- | ------------------------------------------- |
| androidSupport.ane V23.4.0             | FirebaseAnalytics.framework V3.6.0          |
| firebase_common.ane V9.6.1             | FirebaseInstanceID.framework V3.6.0         |
| firebase_iid.ane V9.6.1                | GoogleInterchangeUtilities.framework V3.6.0 |
| googlePlayServices_base.ane V9.6.1     | GoogleSymbolUtilities.framework V3.6.0      |
| googlePlayServices_basement.ane V9.6.1 | GoogleUtilities.framework V3.6.0            |
| googlePlayServices_tasks.ane V9.6.1    |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                            |
| -------------------------------- | ------------------------------------------ |
| firebaseCore.ane V1.2.0          | firebaseCore.ane V1.2.0                    |
| +other ANEs required by the Core | +other frameworks required by the Core     |
| firebase_auth.ane V9.6.1         | FirebaseAuth.framework V3.6.0              |
| firebase_authCommon.ane V9.6.1   | GoogleNetworkingUtilities.framework V3.6.0 |
| firebase_authModule.ane V9.6.1   |

**firebaseDatabase.ane**

| On the Android side                    | On the iOS side                        |
| -------------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.2.0                | firebaseCore.ane V1.2.0                |
| +other ANEs required by the Core       | +other frameworks required by the Core |
| firebase_database.ane V9.6.1           | FirebaseDatabase.framework V3.6.0      |
| firebase_databaseConnection.ane V9.6.1 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.2.0          | firebaseCore.ane V1.2.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_config.ane V9.6.1       | FirebaseRemoteConfig.framework V3.6.0  |
| .                                | GoogleIPhoneUtilities.framework V3.6.0 |

**firebaseStorage.ane**

| On the Android side               | On the iOS side                            |
| --------------------------------- | ------------------------------------------ |
| firebaseCore.ane V1.2.0           | firebaseCore.ane V1.2.0                    |
| +other ANEs required by the Core  | +other frameworks required by the Core     |
| firebase_storage.ane V9.6.1       | FirebaseStorage.framework V3.6.0           |
| firebase_storageCommon.ane V9.6.1 | GoogleNetworkingUtilities.framework V3.6.0 |

**firebaseCrash.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.2.0          | firebaseCore.ane V1.2.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_crash.ane V9.6.1        | FirebaseCrash.framework V3.6.0         |

**firebaseMessaging.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.2.0          | firebaseCore.ane V1.2.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_messaging.ane V9.6.1    | FirebaseMessaging.framework V3.6.0     |
| .                                | GoogleIPhoneUtilities.framework V3.6.0 |

**firebaseAnalytics.ane**

| On the Android side               | On the iOS side                        |
| --------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.2.0           | firebaseCore.ane V1.2.0                |
| +other ANEs required by the Core  | +other frameworks required by the Core |
| firebase_analyticsImpl.ane V9.6.1 |
| firebase-analytics.ane V9.6.1     |

---

# V1.1.0

Find the Android dependencies on [this branch](https://github.com/myflashlab/common-dependencies-ANE/tree/d2e6ca60f511ca4baf219a67de57ebda90d56772). _The master branch may have newer versions of these files but if you are building for the specified version number, you will need this specific branch._ And download the iOS frameworks [from here](https://dl.google.com/firebase/sdk/ios/3_4_0/Firebase.zip).

**firebaseCore.ane**

| On the Android side                    | On the iOS side                             |
| -------------------------------------- | ------------------------------------------- |
| androidSupport.ane V23.4.0             | FirebaseAnalytics.framework V3.4.0          |
| firebase_common.ane V9.4.0             | FirebaseInstanceID.framework V3.4.0         |
| firebase_iid.ane V9.4.0                | GoogleInterchangeUtilities.framework V3.4.0 |
| googlePlayServices_base.ane V9.4.0     | GoogleSymbolUtilities.framework V3.4.0      |
| googlePlayServices_basement.ane V9.4.0 | GoogleUtilities.framework V3.4.0            |
| googlePlayServices_tasks.ane V9.4.0    |

**firebaseAuth.ane**

| On the Android side              | On the iOS side                            |
| -------------------------------- | ------------------------------------------ |
| firebaseCore.ane V1.1.0          | firebaseCore.ane V1.1.0                    |
| +other ANEs required by the Core | +other frameworks required by the Core     |
| firebase_auth.ane V9.4.0         | FirebaseAuth.framework V3.4.0              |
| firebase_authCommon.ane V9.4.0   | GoogleNetworkingUtilities.framework V3.4.0 |
| firebase_authModule.ane V9.4.0   | GoogleParsingUtilities.framework V3.4.0    |

**firebaseDatabase.ane**

| On the Android side                    | On the iOS side                        |
| -------------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.1.0                | firebaseCore.ane V1.1.0                |
| +other ANEs required by the Core       | +other frameworks required by the Core |
| firebase_database.ane V9.4.0           | FirebaseDatabase.framework V3.4.0      |
| firebase_databaseConnection.ane V9.4.0 |

**firebaseRemoteConfig.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.1.0          | firebaseCore.ane V1.1.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_config.ane V9.4.0       | FirebaseRemoteConfig.framework V3.4.0  |
| .                                | GoogleIPhoneUtilities.framework V3.4.0 |

**firebaseAnalytics.ane**

| On the Android side               | On the iOS side                        |
| --------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.1.0           | firebaseCore.ane V1.1.0                |
| +other ANEs required by the Core  | +other frameworks required by the Core |
| firebase_analyticsImpl.ane V9.4.0 |
| firebase-analytics.ane V9.4.0     |

**firebaseStorage.ane**

| On the Android side               | On the iOS side                            |
| --------------------------------- | ------------------------------------------ |
| firebaseCore.ane V1.1.0           | firebaseCore.ane V1.1.0                    |
| +other ANEs required by the Core  | +other frameworks required by the Core     |
| firebase_storage.ane V9.4.0       | FirebaseStorage.framework V3.4.0           |
| firebase_storageCommon.ane V9.4.0 | GoogleSignIn.framework V3.4.0              |
| .                                 | GoogleAppUtilities.framework V3.4.0        |
| .                                 | GoogleAuthUtilities.framework V3.4.0       |
| .                                 | GoogleNetworkingUtilities.framework V3.4.0 |
| .                                 | GoogleSymbolUtilities.framework V3.4.0     |
| .                                 | GoogleUtilities.framework V3.4.0           |

**firebaseCrash.ane**

| On the Android side              | On the iOS side                        |
| -------------------------------- | -------------------------------------- |
| firebaseCore.ane V1.1.0          | firebaseCore.ane V1.1.0                |
| +other ANEs required by the Core | +other frameworks required by the Core |
| firebase_crash.ane V9.4.0        | FirebaseCrash.framework V3.4.0         |
