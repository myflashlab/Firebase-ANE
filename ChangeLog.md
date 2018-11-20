Firebase Air Native Extension

*Nov 16, 2018 - V7.0.1*
* Works with OverrideAir ANE V5.6.1 or higher
* Works with ANELAB V1.1.26 or higher
* (Auth) new dependency is required: 
```xml
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.flags</extensionID>
```
* (Firestore) new dependency is required: 
```xml
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
```

*Sep 20, 2018 - V7.0.0*
* Updated Android dependencies. Google has recently decided to update GooglePlayService and Firebase dependencies separately. Because of this decision, we have also updated our dependency ANEs. checkout [this page](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md) to know the version of ANEs which should be added to your project to make this version of Firebase ANEs work correctly.
* Updated to Firebase SDK 5.4.1 for iOS. update all the older .framework and resources. https://dl.google.com/firebase/sdk/ios/5_4_1/Firebase-5.4.1.zip
* Updated Crashlytics iOS SDK to V3.10.7. You should copy the new .framework files to your AIR SDK. [Download from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.7/com.crashlytics.ios-manual.zip).
* Added support for Firebase MLKIT. This ANE is still in beta phase.
* (Core) Calling ```Firebase.iid.getToken``` would be valid only when passing ```$authorizedEntity``` and ```$scope```.
* (Core) Instead of method ```getToken```, use the new method```Firebase.iid.getInstanceId();```.
* (Core) Removed event ```FirebaseEvents.IID_TOKEN_REFRESH```. You must use ```FCM.listener.addEventListener(FcmEvents.TOKEN_REFRESH, onTokenRefresh);``` from now on.
* (Core) Removed:
```xml
<service android:name="com.myflashlab.firebase.core.MyFirebaseInstanceIdService" android:exported="true">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```
* (Core) Added: ```<uses-permission android:name="com.google.android.finsky.permission.BIND_GET_INSTALL_REFERRER_SERVICE"/>```
* (Core) Added:
```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService">

    <!-- Required by firebase_iid.ane -->
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.iid.Registrar"
        android:value="com.google.firebase.components.ComponentRegistrar"/>

    <!-- Required by firebase_measurementConnectorImpl.ane -->
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.analytics.connector.internal.AnalyticsConnectorRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar"/>

    <!--
        FirebaseAuth and Crashlytics has their own meta-data tag also. And if you are using them in your app, you must add them
        under this <service> tag. Follow the changelog list below and you'll learn more about this.
    -->

</service>
```
* (FCM) Added Events: ```FcmEvents.ON_SUBSCRIBE``` and ```FcmEvents.ON_UNSUBSCRIBE``` to know when topic un/subscription is completed.
* (FCM) Removed ```getToken``` and added ```getInstanceId``` method:
```actionscript
FCM.getInstanceId(onTokenReceived);
function onTokenReceived($token:String, $error:String):void
{
	if($error)
	{
		trace("onTokenReceived error: " + $error);
	}
				
	if($token)
    {
		trace("token: " + $token);
    }
}
```
* (FCM) Removed: 
```xml
<service android:name="com.myflashlab.firebase.fcm.MyFirebaseInstanceIDService">
	<intent-filter>
		<action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
	</intent-filter>
</service>
```
* (Analytics) Added attribute *exported="true"* to ```com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver``` and moreover, moved all manifest setup from analytics to FirebaseCore.
* (Analytics) Added new public method ```resetAnalyticsData``` to clear all Analytics data as well as reset App Instance ID.
* (Auth) Removed deprecated method ```Firebaseuser.getToken```. Use ```getIdToken``` instead.
* (Auth) Added class ```TokenResult```. is accessible from “FirebaseUserEvents.GET_USER_TOKEN” event. access token using ```e.tokenResult```
```actionscript
FirebaseUser.listener.addEventListener(FirebaseUserEvents.GET_USER_TOKEN, onGetUserToken);
private function onGetUserToken(e:FirebaseUserEvents):void
{			
	if(e.result == Auth.RESULT_SUCCESS)
	{
		trace("onGetUserToken result == Auth.RESULT_SUCCESS");
		trace("e.tokenResult.token: " + e.tokenResult.token);
		trace("e.tokenResult.claims: " + JSON.stringify(e.tokenResult.claims));
		trace("e.tokenResult.authTimestamp: " + new Date(e.tokenResult.authTimestamp).toLocaleString());
		trace("e.tokenResult.expirationTimestamp: " + new Date(e.tokenResult.expirationTimestamp).toLocaleString());
		trace("e.tokenResult.issuedAtTimestamp: " + new Date(e.tokenResult.issuedAtTimestamp).toLocaleString());
		trace("e.tokenResult.signInProvider: " + e.tokenResult.signInProvider);
	}
	else
	{
		trace("onGetUserToken result != Auth.RESULT_SUCCESS");
	}
}
```
* (Auth) Added new ```meta-data``` tag as follow. make sure you are adding this to the currently existing ```<service>``` tag.
```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" >
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.auth.FirebaseAuthRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar" />
</service>
```
* (Auth) There's a known bug in AIR SDK [explained here](https://tracker.adobe.com/#/view/AIR-4198557). If you are seeing this problem when compiling the iOS side of your app, [check out this video](https://www.youtube.com/watch?v=m4bwZRCvs2c) for the fix.
* (Auth) Features like ```Auth.sendSignInLinkToEmail``` need DynamicLink And Invites to be implemented in the project already.
* (Auth) FirebaseAuth has too many APIs based on Firebase Invites and Dynamic Links. So, we have made it dependent on FirebaseInvite when using the [ANELAB software](https://github.com/myflashlab/ANE-LAB). FirebaseInvite is also dependent on FirebaseDynamicLinks. It is strongly recommended to implement DynamicLinks and invites prior to implementing Auth to your app.
* (Firestore) Removed ```QueryListenOptions``` class and added [MetadataChanges](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/firestore/MetadataChanges.html) class to be used with ```addSnapshotListener``` method. You don't need to initialize the new class, simply pass ```MetadataChanges.INCLUDE``` or ```MetadataChanges.EXCLUDE``` as the last parameter of ```addSnapshotListener``` method.
* (Firestore) Query and collection ```read``` methods now optionally takes a MetadataChanges value. Notice that by default, metadata-only document changes are suppressed in the ```read()``` method, even when listening to a query with MetadataChanges.INCLUDE.
* (Firestore) Added the ability to control whether ```read``` method for documents and queries should fetch from server only, cache only, or attempt server and fall back to the cache. By default, both methods still attempt server and fall back to the cache. check the new class [Source](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/firestore/Source.html).
* (Firestore) Added a ```Firestore.setServerTimestampBehavior``` to control how DocumentSnapshots return unresolved server timestamps.
    * DocumentSnapshot.ServerTimestampBehavior_NONE
    * DocumentSnapshot.ServerTimestampBehavior_ESTIMATE
    * DocumentSnapshot.ServerTimestampBehavior_PREVIOUS
* (Firestore) Added new ```meta-data``` tag as follow. make sure you are adding this to the currently existing ```<service>``` tag.
```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" >
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.firestore.FirestoreRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar" />
</service>
```
* (Firestore) mergeFields is now available on the iOS side also. Prior to this version, it was supported on the Android side only.
* (Storage) Removed ```downloadUrl``` and ```downloadUrls``` from StorageMetadata class and added ```ref``` property which returns a reference to the ```StorageReference``` object of the current StorageMetadata. You may use the ```getDownloadUrl``` method of this object instead of the removed ones.
* (Storage) Added support for ```StorageEvents.TASK_COMPLETE``` on instances of UploadTask and FileDownloadTask:
```actionscript
fileDownloadTask.addEventListener(StorageEvents.TASK_COMPLETE, onDownloadFileComplete);
function onDownloadFileComplete(e:StorageEvents):void
{
    if(e.error)
	{
		trace("onDownloadFileComplete: " + e.error.message);
	}
	else
	{
		trace("onDownloadFileComplete");
	}
}
```

*May 20, 2018 - V6.5.0*
* Added support for Firebase Crashlytics V6.5.0
* Use iOS frameworks [V3.10.1 for Crashlytics](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.1/com.crashlytics.ios-manual.zip).

*Apr 22, 2018 - V6.5.0*
* Updated to Firebase SDK 12.0.1 for Android. update all the depenency ANEs.
* Updated to Firebase SDK 4.11.0 for iOS. update all the .framework and resources. https://dl.google.com/firebase/sdk/ios/4_11_0/Firebase-4.11.0.zip
* (Core) You need to regenerate the core ANE using the ane generator software V6.5.0 and you need to update all the other Firebase children that you are using in your project.
* (Core) multidex attribute added to the main android application tag in the manifest: ```android:name="android.support.multidex.MultiDexApplication"```
* (Firestore) Removed the following framework dependencies:
    * FirebaseAuth
    * GTMSessionFetcher
* (Firestore) batch.commit now takes a param ```$listenForCallback```. if set to false, FirestoreEvents.BATCH_SUCCESS or FirestoreEvents.BATCH_FAILURE won’t be dispatched.
* (Firestore) Added methods: disableNetwork/enableNetwork
* (Analytics) introduced new analytics events and params. Check asdoc for more details.
* (Analytics) Setting the ID to null removes the user ID.
* (Auth) new Activity tag should be added to the manifest as follow:
```xml
<activity
    android:name="com.google.firebase.auth.internal.FederatedSignInActivity"
    android:excludeFromRecents="true"
    android:exported="true"
    android:launchMode="singleInstance"
    android:permission="com.google.firebase.auth.api.gms.permission.LAUNCH_FEDERATED_SIGN_IN"
    android:theme="@android:style/Theme.Translucent.NoTitleBar" />
```
* (Auth) Added ```AdditionalUserInfo``` class, ```e.additionalUserInfo``` getter for events:
    * AuthEvents.CREATE_NEW_USER_RESULT
    * AuthEvents.SIGN_IN_RESULT
    * FirebaseUserEvents.LINK_WITH_RESULT
* (Auth) Added Email Link Authentication feature. ```Auth.sendSignInLinkToEmail```, ```Auth.isSignInWithEmailLink```.
* (Auth) Deprecated ```fetchProvidersForEmail```. use new method ```fetchSignInMethodsForEmail``` instead.
* (Auth) Renamed ```signInWithEmail``` method to ```signInWithEmailPass``` and also added new method: ```signInWithEmailLink```.
* (Auth) Deprecated ```AuthProvider.EMAIL```. use new const ```AuthProvider.EMAIL_PASS``` instead and also added new const ```AuthProvider.EMAIL_LINK```.
* (Auth) Deprecated ```setEmailAuthProvider```. use new method ```setEmailPassAuthProvider``` instead and also added new method ```setEmailLinkAuthProvider```.
* (Auth) ON ANDROID, Added the ability to use Google Play Games as a sign-in provider in your Firebase Project ```setPlayGamesAuthProvider```.
* (FCM) Added ```autoInitEnabled``` property.
* (Storage) Added **md5Hash** property to StorageMetadata.

*Dec 15, 2017 - V6.0.0*
* Updated to Firebase SDK 11.6.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v6xx)
* Updated to Firebase SDK 4.6.0 for iOS. Make sure you are updating the [frameworks and resources](https://dl.google.com/firebase/sdk/ios/4_6_0/Firebase-4.6.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v6xx)
* (Core) You need to regenerate the core ANE using the ane generator software V6.0.0 and you need to update all the other Firebase children that you are using in your project.
* (Core) Remove the following receiver from your manifest: ```<receiver android:name="com.google.firebase.iid.FirebaseInstanceIdInternalReceiver" android:exported="false"/>```
* (Core) The ```projectID``` property from the ```FirebaseConfig``` class is now deprecated and you no longer can set it manually. This property will be set automatically from now on and you can see its value with the following getter: ```project_id```.
* (Analytics) Added new method ```resetAnalyticsData()``` which works on the Android side only.
* (Auth) Added ```FirebaseUser.metadata```.
* (Auth) Added ```ActionCodeSettings``` to [sendPasswordResetEmail](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#sendPasswordResetEmail()) and [sendEmailVerification](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#sendEmailVerification())
* (Dynamic-Links) You no longer have to set ```Firebase.getConfig().projectID```. This will happen automatically from now on. However, you still need to set ```Firebase.getConfig().webApiKey``` manually.
* Firestore is now added and you can start using it. Start by reading the [wiki on how to initialize Firestore](https://github.com/myflashlab/Firebase-ANE/wiki/K.-Firestore).

*Sep 03, 2017 - V5.1.1*
* (Core) Fixed [issue 148](https://github.com/myflashlab/Firebase-ANE/issues/148). The core ANE must be regenerated with the new ane generator V5.1.1.

*Aug 21, 2017 - V5.1.0*
* (Core) the core ANE must be regenerated with the new ane generator V5.1.0.
* (Core) Added API for managing FirebaseInstanceId. You can now manualy delete and regenerate new iid ID and tokens.
* (Core) You need to add the following service to your manifest right after the ```<provider ....``` tag.
```xml
<service
    android:name="com.myflashlab.firebase.core.MyFirebaseInstanceIdService"
    android:exported="true">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```

*Jul 19, 2017 - V5.0.0*
* Updated to Firebase SDK 11.0.2 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v500)
* Updated to Firebase SDK 4.0.3 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/4_0_3/Firebase-4.0.3.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v500)
* From now on, sample files are in IntelliJ IDE.
* (Core) You need to regenerate the core ANE using the ane generator software V5.0.0 and you need to update all the other Firebase children that you are using in your project.
* (Core) Remove the following from your manifest: ```<action android:name="com.google.android.c2dm.intent.REGISTRATION" />```
* (Analytics) The following service must be added to the manifest:
```xml
<service
	android:name="com.google.android.gms.measurement.AppMeasurementJobService"
	android:permission="android.permission.BIND_JOB_SERVICE"
	android:enabled="true"
	android:exported="false"/>
```
* (Auth) Corrected miss-spelling described at issue https://github.com/myflashlab/Firebase-ANE/issues/42
* (Auth) ```Auth.RESULT_TOO_MANY_REQUESTS``` introduced.
* (Auth) Listener ```AuthEvents.ID_TOKEN_CHANGED``` introduced. Listen to this even just like how you used to listen to ```AuthEvents.AUTH_STATE_CHANGED```
* (Auth) Added support for Phone verification and sign in. ```Auth.verifyPhoneNumber()```, Check Wiki to know how you can use this feature.
* (Auth) The new Phone verification feature on iOS will run only if you have setup push-notification on your app. To know how to do that, read the [setup information for FCM](https://github.com/myflashlab/Firebase-ANE/wiki/G.-FCM). If FCM is already added to your app, you're just good to go.
* (Crash) ```Crash.crashCollectionEnabled``` introduced
* (DynamicLinks) You need to add the follwoing dependency to your manifest: ```<extensionID>com.myflashlab.air.extensions.dependency.firebase.dynamicLinks</extensionID>```

*Mar 07, 2017 - V4.0.0*
* Updated to Firebase SDK 10.2.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
* Updated to Firebase SDK 3.13.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_13_0/Firebase-3.13.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
* firebaseInvites.ane has been added to the collection and it is highly dependent on on DynamicLinks ANE. In simple terms, if you wish to use the Firebase Invites SDK, you need to first add Firebase DynamicLinks to your app.
* (Core) You need to regenerate the core ANE using the ane generator software V4.0.0 and you need to update all the other Firebase children that you are using in your project.
* (Core) [setLoggerLevel](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/core/Firebase.html#setLoggerLevel()) has been introduced and [logLevel](http://myflashlab.github.io/asdoc/com/myflashlab/air//extensions/firebase/db/DB.html#logLevel) is now deprecated.
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