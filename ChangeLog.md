# Firebase Air Native Extension

_Aug 15, 2020 - v10.2.1_

- Upgrade Firebase iOS SDK to v6.30.0.
- Migrate from Firebase Instance Id to Firebase Installations Service.
- Firebase Instance Id deprecated and will be removed in next version

_Jul 31, 2020 - v10.0.0_

- Upgrade dependencies for Android to the latest versions.
- Fixed some minor issues and refactor native codes.

_Jun 10, 2020 - v9.12.1_

- (**Crashlytics**) Fix an issue related to updating manifest on the ANELAB. If you are applying changes manually you have to remove this part from your manifest.

```xml
<provider
  android:name="com.crashlytics.android.CrashlyticsInitProvider"
  android:authorities="{PACKAGE_NAME}.crashlyticsinitprovider"
  android:exported="false"
  android:initOrder="99"/>
```

_Jun 09, 2020 - v9.12.0_

- (**Firestore**) Added an `addSnapshotsInSyncListener()` method to Firestore that notifies you when all your snapshot listeners are in sync with each other. You can remove listener using `removeSnapshotsInSyncListener()` method.
- (**Firestore**) Added a dependency on the `abseil` on iOS for ANELAB. If you're manually tracking dependencies, you need to add it to your SDK path.
- (**Firestore**) Removed Firestore's dependency on the `Protobuf` on iOS for ANELAB. If you're manually tracking dependencies, you may be able to remove it from your SDK path (note, however, that other Firebase components may still require it).
- (**Firestore**) Firestore no longer loads its TLS certificates from a bundle, which fixes crashes at startup when the bundle can't be loaded. This fixes a specific case where the bundle couldn't be loaded due to non-ASCII characters in the application name. If you're manually tracking dependencies, you can now remove `gRPCCertificates-Cpp.bundle` from your build.
- (**Analytics**) Firebase InstanceID SDK dependency replaced by Firebase Installations SDK for iOS.
- (**Auth**) Added support for Sign-in with Apple.
- (**Auth**) Fixed rawNonce in encoder credential.
- (**Crashlytics**) Removed the Fabric API Key. Now, Crashlytics uses the `GoogleService-Info.plist` and `google-services.json` files to associate your app with your project. If you linked your app from Fabric and want to upgrade to the new SDK, remove the Fabric API key from your run and upload-symbols scripts. We also recommend removing the Fabric section from your app's manifest (when you upgrade, Crashlytics uses the new configuration you set up in Firebase).

_Jun 08, 2020 - v9.11.1_

- (**Crashlytics**) Bug fixes and some improvements.

_Jun 07, 2020 - v9.11.0_

- (**Crashlytics**) Upgrade to the Firebase Crashlytics SDK.

_May 24, 2020 - v9.10.1_

- Fix a minor issue on FirebaseCore related to ANE-LAB.

_May 23, 2020 - v9.10.0_

- (**Firestore**) Added `whereIn()` and `whereArrayContainsAny()` query operators. `whereIn()` finds documents where a specified field’s value is IN a specified array. `whereArrayContainsAny()` finds documents where a specified field is an array and contains ANY element of a specified array.
- (**Firestore**) Added `limitToLast(long)`, which returns the last n documents as the result.
- (**Firestore**) Added a `Firestore.terminate()` method which terminates the instance, releasing any held resources. Once it completes, you can optionally call `clearPersistence()` to wipe persisted Cloud Firestore data from disk.
- (**RemoteConfig**) Added a method that fetches configs and activates them: `RemoteConfig.fetchAndActivate()`.
- (**RemoteConfig**) Network connection timeout for fetch requests is now customizable. To set the network timeout, use `setFetchTimeoutInSeconds(long)` on `RemoteConfigSettings`.
- (**RemoteConfig**) The default minimum fetch interval is now customizable. To set the default minimum fetch interval, use `setMinimumFetchIntervalInSeconds(long)` on `RemoteConfigSettings`.
- (**Performance**) Upgrade RemoteConfig dependency version.

_May 21, 2020 - v9.9.2_

- (**Functions**) Fix a minor issue related to the FirebaseCore.

_May 20, 2020 - v9.9.1_

- Fix a minor issue on FirebaseCore related to ANE-LAB.

_May 19, 2020 - v9.9.0_

- Upgraded to [Firebase SDK 6.18.0](https://dl.google.com/firebase/sdk/ios/6_18_0/Firebase-6.18.0.zip) for iOS. update all the older .framework and resources. based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)

_May 11, 2020 - v9.5.0_

- Upgraded to [Firebase SDK 6.9.0](https://dl.google.com/firebase/sdk/ios/6_9_0/Firebase-6.9.0.zip) for iOS. update all the older .framework and resources. based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)

_May 01, 2020 - v9.1.0_

- (**Performanc**) Removed the deprecated counter API. Use metrics API going forward.
- (**Analytics**) Adds the ability for an app to specify whether events logged by Google Analytics can be used to [personalize ads](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/analytics/AnalyticsParam.html#ALLOW_PERSONALIZED_ADS) for the user.
- (**Database**) Added support for the Firebase Realtime Database Emulator. To connect to the emulator, specify "http://:/?ns=" as your Database URL (via [DB.init(String)](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/db/DB.html#init()>)). Note that if you are running the Realtime Database Emulator on "localhost" and connecting from an app that is running inside an Android Emulator, the Realtime Database Emulator host will be "10.0.2.2" followed by its port.
- (**Storage**) Added [list()](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/storage/StorageMetadata.html#list()>) and [listAll()](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/storage/StorageMetadata.html#listAll()>), which allows developers to list the files and folders under the given StorageReference.
- (**Storage**) Added getCacheControl(), getContentDisposition(), getContentEncoding(), getContentLanguage(), and getContentType() to [StorageMetadata](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/storage/StorageMetadata.html) to provide access to the current state of the metadata.
- (**Auth**) Added integration support for authenticate using apple signin.

_Apr 04, 2020 - V9.0.1_

- Upgraded to Androidx libraries.
- Upgraded to Firebase SDK 17.2.1 for Android. update the dependencies based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)
- Upgraded to [Firebase SDK 6.5.0](https://dl.google.com/firebase/sdk/ios/6_5_0/Firebase-6.5.0.zip) for iOS. update all the older .framework and resources. based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)
- Replace the following dependencies:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.arch</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>
```

with these:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.androidx.arch</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidx.core</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidx.lifecycle</extensionID>
```

- Remove the following server tag:

```xml
<service
    android:name="com.google.firebase.iid.FirebaseInstanceIdService"
    android:exported="true">
    <intent-filter android:priority="-500">
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```

- Add the following provider:

```xml
<!-- Required by androidx_lifecycle.ane Change {PACKAGE_NAME} to your own app package name -->
<provider
    android:name="androidx.lifecycle.ProcessLifecycleOwnerInitializer"
    android:authorities="{PACKAGE_NAME}.lifecycle-process"
    android:exported="false"
    android:multiprocess="true"/>
```

- (**FCM**) the following new dependencies must be added:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.datatransport</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.firebase.encoders.json</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons.fcm</extensionID>
```

- (**FCM**) the following new service tags must be added under the android `<application>` tag:

```xml
<!-- Required by firebase_addons_fcm.ane -->
<service
    android:name="com.google.android.datatransport.runtime.backends.TransportBackendDiscovery"
    android:exported="false">
    <meta-data
        android:name="backend:com.google.android.datatransport.cct.CctBackendFactory"
        android:value="cct"/>
</service>
<service
    android:name="com.google.android.datatransport.runtime.scheduling.jobscheduling.JobInfoSchedulerService"
    android:exported="false"
    android:permission="android.permission.BIND_JOB_SERVICE"/>
<receiver
    android:name="com.google.android.datatransport.runtime.scheduling.jobscheduling.AlarmManagerSchedulerBroadcastReceiver"
    android:exported="false"/>
```

- (**FCM**) the following two `meta-data` must be added under the `` tag:

```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" android:exported="false">

    <!--
        Previous meta-data tags for Firebase core and other children...
        ...
    -->


    <!-- Required by firebase_messaging.ane -->
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.messaging.FirebaseMessagingRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar"/>

    <!-- Required by firebase_datatransport.ane -->
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.datatransport.TransportRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar"/>
</service>
```

- (**FCM**) implemented OneSignal functionalety into FCM.

  - OneSignal Android SDK [V3.13.0](https://github.com/OneSignal/OneSignal-Android-SDK/releases)
  - OneSignal iOS SDK [V2.10.0](https://github.com/OneSignal/OneSignal-iOS-SDK/releases)

- (**FCM**) For OneSignal library, the folloiwng dependencies must also be added:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.places</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.location</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidx.design</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.androidx.browser</extensionID>
```

- (**FCM**) OneSignal library requiers the following permissions added to the manifest also: Don't forget to replace **{PACKAGE_NAME}** to your app's package name before copy pasting.

```xml
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<permission android:name="{PACKAGE_NAME}.permission.C2D_MESSAGE" android:protectionLevel="signature"/>
<uses-permission android:name="{PACKAGE_NAME}.permission.C2D_MESSAGE"/>

<!-- Samsung -->
<uses-permission android:name="com.sec.android.provider.badge.permission.READ"/>
<uses-permission android:name="com.sec.android.provider.badge.permission.WRITE"/>
<!-- HTC -->
<uses-permission android:name="com.htc.launcher.permission.READ_SETTINGS"/>
<uses-permission android:name="com.htc.launcher.permission.UPDATE_SHORTCUT"/>
<!-- Sony -->
<uses-permission android:name="com.sonyericsson.home.permission.BROADCAST_BADGE"/>
<uses-permission android:name="com.sonymobile.home.permission.PROVIDER_INSERT_BADGE"/>
<!-- Apex -->
<uses-permission android:name="com.anddoes.launcher.permission.UPDATE_COUNT"/>
<!-- Solid -->
<uses-permission android:name="com.majeur.launcher.permission.UPDATE_BADGE"/>
<!-- Huawei -->
<uses-permission android:name="com.huawei.android.launcher.permission.CHANGE_BADGE"/>
<uses-permission android:name="com.huawei.android.launcher.permission.READ_SETTINGS"/>
<uses-permission android:name="com.huawei.android.launcher.permission.WRITE_SETTINGS"/>
<!-- ZUK -->
<uses-permission android:name="android.permission.READ_APP_BADGE"/>
<!-- OPPO -->
<uses-permission android:name="com.oppo.launcher.permission.READ_SETTINGS"/>
<uses-permission android:name="com.oppo.launcher.permission.WRITE_SETTINGS"/>
<!-- EvMe -->
<uses-permission android:name="me.everything.badger.permission.BADGE_COUNT_READ"/>
<uses-permission android:name="me.everything.badger.permission.BADGE_COUNT_WRITE"/>
```

- (**FCM**) And finally, for OneSignal library to work, you need to add the folloiwng to the `<application>` tag of your Android setup: Don't forget to replace the data inside **{xxxx}** to the correct data.

```xml
<!-- Required if using OneSignal -->
<meta-data android:name="onesignal_app_id" android:value="{ONESIGNAL_APP_ID}"/>
<meta-data android:name="onesignal_google_project_number" android:value="str:REMOTE"/>
<receiver
    android:name="com.onesignal.GcmBroadcastReceiver"
    android:permission="com.google.android.c2dm.permission.SEND">

    <intent-filter android:priority="999">
        <action android:name="com.google.android.c2dm.intent.RECEIVE"/>
        <category android:name="{PACKAGE_NAME}"/>
    </intent-filter>
</receiver>
<receiver android:name="com.onesignal.NotificationOpenedReceiver"/>
<service android:name="com.onesignal.GcmIntentService"/>
<service android:name="com.onesignal.GcmIntentJobService" android:permission="android.permission.BIND_JOB_SERVICE"/>
<service android:name="com.onesignal.RestoreJobService" android:permission="android.permission.BIND_JOB_SERVICE"/>
<service android:name="com.onesignal.RestoreKickoffJobService" android:permission="android.permission.BIND_JOB_SERVICE"/>
<service android:name="com.onesignal.SyncService" android:stopWithTask="true"/>
<service android:name="com.onesignal.SyncJobService" android:permission="android.permission.BIND_JOB_SERVICE"/>
<activity android:name="com.onesignal.PermissionsActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
<service android:name="com.onesignal.NotificationRestoreService"/>
<receiver android:name="com.onesignal.BootUpReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
    </intent-filter>
</receiver>
<receiver android:name="com.onesignal.UpgradeReceiver">
    <intent-filter>
       <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
    </intent-filter>
</receiver>
```

- (**FCM**) For OneSignal to work on the iOS side, you must add the following under: Don't forget to replace **{ONESIGNAL_APP_ID}**.

```xml
<key>onesignal_app_id</key>
<string>{ONESIGNAL_APP_ID}</string>
```

- (**Storage**) Beside the older dependencies, the following dependencies are needed to be added too:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.auth</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.flags</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
```

- (**DB**) Beside the older dependencies, the following dependencies are needed to be added too:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.auth</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.flags</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
```

- (**Functions**) Replace this dependnecy `<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons</extensionID>` with the following:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons.squareup</extensionID>
```

- (**Firestore**) Replace this dependnecy `<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons</extensionID>` with the following ones:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons.firestore</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.firebase.addons.squareup</extensionID>
```

- (**Auth**) Need to add REVERSED_CLIENT_ID from the GoogleService-Info.plist file to the manifest for iOS side under the `<InfoAdditions>` tag:

```xml
<!-- Add REVERSED_CLIENT_ID from the GoogleService-Info.plist file -->
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>google</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>{REVERSED_CLIENT_ID}</string>
		</array>
	</dict>
</array>
```

- (**MLKIT**) MLKIT development is temporarily discontinues.

_Aug 3, 2019 - V8.0.1_

- Added support for Android 64-bit
- Supports iOS 10+

_Jun 16, 2019 - V8.0.0_

- Updated to Firebase SDK 16.0.8 for Android. update the dependencies based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)
- Updated to [Firebase SDK 5.20.2](https://dl.google.com/firebase/sdk/ios/5_20_2/Firebase-5.20.2.zip) for iOS. update all the older .framework and resources. based on [this list](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md)
- Minimum iOS version to support the Firebase ANEs will be iOS 10.0+ from now on
- (Core) The current _/Users/{username}/Documents/AIR_32.116/lib/android/bin/dx.jar_ file in AIRSDK is too old! until Adobe updates that file, we may use the newer version copied from Android SDK build tools 28.0.3 _/Users/{username}/Library/Android/sdk/build-tools/28.0.3/lib/dx.jar_
- (Core) Because of [another bug in AIR SDK](https://tracker.adobe.com/#/view/AIR-4198557), you need to manually copy the file framework **lclang_rt** from **xcode 10.1** to your AIR SDK. This is explained in [this video](https://www.youtube.com/watch?v=m4bwZRCvs2c).
- (Core) Added `android:exported="false"` to the **ComponentDiscoveryService** service:

```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" android:exported="false">
```

- (Core) Removed the following tags:

```xml
<permission android:name="{package_name}.permission.C2D_MESSAGE" android:protectionLevel="signature"/>

<uses-permission android:name="{package_name}.permission.C2D_MESSAGE"/>
```

- (Core) Removed the `<category android:name="{package_name}"/>` tag from the following service:

```xml
<receiver
    android:name="com.google.firebase.iid.FirebaseInstanceIdReceiver"
    android:exported="true"
    android:permission="com.google.android.c2dm.permission.SEND">
    <intent-filter>
        <action android:name="com.google.android.c2dm.intent.RECEIVE"/>
    </intent-filter>
</receiver>
```

- (Core) Removed the dependency:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.firebase.measurement.connector.impl</extensionID>
```

- (Core) Removed deprecated setter `Firebase.getConfig().projectID`. it will be read automatically.
- (Core) You need to copy the **libclang_rt.ios.a** file from xcode 10 to your AIRSDK. [This video tutorial shows you how](https://www.youtube.com/watch?v=m4bwZRCvs2c).
- (Core) Removed the following frameworks from iOS requirements:

  - FirebaseNanoPB.framework
  - GoogleToolboxForMac.framework

- (Core) Added the following frameworks to iOS requirements:

  - FIRAnalyticsConnector.framework
  - GoogleAppMeasurement.framework
  - GoogleUtilities.framework

- (Core) Added global property `Firebase.dataCollectionDefaultEnabled`. default value is true.
- (Core) Added new method `Firebase.makeGooglePlayServicesAvailable`.

- (Core) Google deprecated the FirebaseInvites and we removed that ANE. Instead, all its features are now implemented into the DynamicLinks ANE. Because of this change, the property `Firebase.listener` is removed along with the following events:

```actionscript
FirebaseEvents.GOOGLE_API_CONNECTION_SUCCESS
FirebaseEvents.GOOGLE_API_CONNECTION_FAILURE
FirebaseEvents.GOOGLE_API_CONNECTION_CANCELED
```

- (Analytics) setter `minimumSessionDuration` is deprecated and won't do anything. From now on, sessions start as soon as app comes to foreground. more info [here](https://firebase.googleblog.com/2018/12/new-changes-sessions-user-engagement.html).
- (Analytics) Removed deprecated const **AnalyticsParam.SIGN_UP_METHOD**

- (Firestore) Added dependency firebase_auth.ane (_com.myflashlab.air.extensions.dependency.firebase.auth_)

- (Firestore) iOS depends on the following frameworks:

  - BoringSSL-GRPC.framework
  - FirebaseFirestore.framework
  - gRPC-C++.framework
  - gRPC-Core.framework
  - leveldb-library.framework
  - Protobuf.framework

- (Firestore) The constent **FieldValue.TIMESTAMP** is removed. instead used the method `FieldValue.TIMESTAMP();`
- (Firestore) The constent **FieldValue.DELETE** is removed. instead used the method `FieldValue.DELETE();`

- (Firestore) Added new FieldValue methods:

  - `FieldValue.INCREMENT(value:Number);`
  - `FieldValue.ARRAY_UNION(value:Vector.<String>);`
  - `FieldValue.ARRAY_REMOVE(value:Vector.<String>);`

- (Firestore) Added new property `cacheSizeBytes` to class **FirestoreSettings**.

- (RemoteConfig) Added new meta-data tags under `<service android:name="com.google.firebase.components.ComponentDiscoveryService" android:exported="false">` service:

```xml
<meta-data
    android:name="com.google.firebase.components:com.google.firebase.remoteconfig.RemoteConfigRegistrar"
    android:value="com.google.firebase.components.ComponentRegistrar"/>

<meta-data
    android:name="com.google.firebase.components:com.google.firebase.abt.component.AbtRegistrar"
    android:value="com.google.firebase.components.ComponentRegistrar"/>
```

- (RemoteConfig) Android now has a new dependency: `<extensionID>com.myflashlab.air.extensions.dependency.firebase.abt</extensionID>`
- (RemoteConfig) Deprecated the listener `RemoteConfig.listener.addEventListener(RemoteConfigEvents.FETCH_RESULT, onFetched);` and will be removed in future versions. instead, you must use the callback function from the `RemoteConfig.fetch` method to know when the fetch operation is completed:

```actionscript
RemoteConfig.fetch(cacheExpiration, function ($error:Error):void
{
	if($error)
	{
		trace($error.message);
	}
	else
	{
		trace("Fetch was successful, Now, let's call RemoteConfig.activateFetched() to activate the new data");

		// When you fetch the new information from server, you can activate them anytime you think is appropriate in your app
		RemoteConfig.activateFetched();
	}
});
```

- (DB) Added new meta-data tag under `<service android:name="com.google.firebase.components.ComponentDiscoveryService` service:

```xml
<meta-data
    android:name="com.google.firebase.components:com.google.firebase.database.DatabaseRegistrar"
    android:value="com.google.firebase.components.ComponentRegistrar"/>
```

- (Storage) Added new meta-data tag under `<service android:name="com.google.firebase.components.ComponentDiscoveryService` service:

```xml
<meta-data
    android:name="com.google.firebase.components:com.google.firebase.storage.StorageRegistrar"
    android:value="com.google.firebase.components.ComponentRegistrar"/>
```

- (FCM) Added `android:exported="false"` to `<service android:name="com.myflashlab.firebase.fcm.MyFirebaseMessagingService">`
- (FCM) Added new event `FcmEvents.DELETED_MESSAGES`.
- (DynamicLinks) Removed dependency `<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.appinvite</extensionID>`
- (DynamicLinks) Added new meta-data tag under `<service android:name="com.google.firebase.components.ComponentDiscoveryService` service:

```xml
<meta-data
    android:name="com.google.firebase.components:com.google.firebase.dynamiclinks.internal.FirebaseDynamicLinkRegistrar"
    android:value="com.google.firebase.components.ComponentRegistrar"/>
```

- (DynamicLinks) property `SocialMediaParams.su` is deprecated and not used anymore. instead you should use `SocialMediaParams.si`.
- (DynamicLinks) property `DynamicLinks.api` is no longer available. to build dynamiclinks, you must use the new methods:

```actionscript
var myLink:String = DynamicLinks.build(
						"myflashlabs.page.link", // You must have created this URL Prefix from your Firebase Console
						"https://www.myflashlabs.com/deeplinks",
						androidParams, // optional
						iosParams, // optional
						socialMediaParams, // optional
						analyticsParams, // optional
						otherPlatformParams, // optional
						navigationParams, // optional
						"MY_INVITATION_ID"); // optional

// then use the method to create the short link version of your dynamiclink
DynamicLinks.toMakeShort(myLink, function ($link:String, $raw:String):void
{
	trace("$raw = " + $raw);

	if($link)
	{
		trace("$link = " + $link);
	}
});
```

- (DynamicLinks) for your convenient, a new method is introduced: `DynamicLinks.share`.
- (Invites) Firebase invites is deprecated and removed by Google. From now on, you can create dynamiclinks with your own custom invitation id using `DynamicLinks.build` method. Then, in your app you must be listening to `DynamicLinksEvents.INVOKE` event and check if the invitationId is available or not.

```actionscript
DynamicLinks.listener.addEventListener(DynamicLinksEvents.INVOKE, onDynamicLinksInvoke);

private function onDynamicLinksInvoke(e:DynamicLinksEvents):void
{
	trace("e.link = " + e.link);
	trace("e.invitationId = " + e.invitationId);
}
```

- (Auth) Auth ANE is no longer dependent on Firebase Invites. (Invites is removed and its functionality is moved into DynamicLinks)
- (Auth) changed activity params for `com.google.firebase.auth.internal.FederatedSignInActivity` to:

```xml
<activity
    android:name="com.google.firebase.auth.internal.FederatedSignInActivity"
    android:excludeFromRecents="true"
    android:exported="true"
    android:launchMode="singleTask"
    android:permission="com.google.firebase.auth.api.gms.permission.LAUNCH_FEDERATED_SIGN_IN"
    android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
```

- (Auth) Added property `dynamicLinkDomain` to class `ActionCodeSettings`. that is used in out-of-band email action flows.

- (MLKIT) MLKIT is still in beta version (by Google) and when new versions are released, they might not be backword compatible. till the alpha version is released things can change drastically. Follow the new instruction and new usage sample code on our GitHub repository.
- (MLKIT) iOS depends on the following frameworks:

  - FirebaseMLCommon.framework
  - FirebaseMLModelInterpreter.framework
  - GTMSessionFetcher.framework
  - tensorflow_lite.framework
  - FirebaseMLNaturalLanguage.framework
  - FirebaseMLNLLanguageID.framework
  - FirebaseABTesting.framework
  - FirebaseMLNLSmartReply.framework
  - FirebaseRemoteConfig.framework
  - Protobuf.framework
  - FirebaseMLVision.framework
  - GoogleAPIClientForREST.framework
  - GoogleMobileVision.framework
  - GoogleToolboxForMac.framework
  - BarcodeDetector.framework
  - FirebaseMLVisionBarcodeModel.framework
  - FaceDetector.framework
  - FirebaseMLVisionFaceModel.framework
  - FirebaseMLVisionLabelModel.framework
  - LabelDetector.framework
  - FirebaseMLVisionTextModel.framework
  - TextDetector.framework

- (MLKIT) iOS depends on the following resources:

  - GoogleMVFaceDetectorResources.bundle
  - GoogleMVTextDetectorResources.bundle
  - PredictOnDeviceResource.bundle

- (Performance) Added Firebase Performance
- (Functions) Added Firebase Functions

_Nov 16, 2018 - V7.0.1_

- Works with OverrideAir ANE V5.6.1 or higher
- Works with ANELAB V1.1.26 or higher
- (Auth) new dependency is required:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
<extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.flags</extensionID>
```

- (Firestore) new dependency is required:

```xml
<extensionID>com.myflashlab.air.extensions.dependency.gson</extensionID>
```

_Sep 20, 2018 - V7.0.0_

- Updated Android dependencies. Google has recently decided to update GooglePlayService and Firebase dependencies separately. Because of this decision, we have also updated our dependency ANEs. checkout [this page](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md) to know the version of ANEs which should be added to your project to make this version of Firebase ANEs work correctly.
- Updated to Firebase SDK 5.4.1 for iOS. update all the older .framework and resources. https://dl.google.com/firebase/sdk/ios/5_4_1/Firebase-5.4.1.zip
- Updated Crashlytics iOS SDK to V3.10.7. You should copy the new .framework files to your AIR SDK. [Download from here](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.7/com.crashlytics.ios-manual.zip).
- Added support for Firebase MLKIT. This ANE is still in beta phase.
- (Core) Calling `Firebase.iid.getToken` would be valid only when passing `$authorizedEntity` and `$scope`.
- (Core) Instead of method `getToken`, use the new method`Firebase.iid.getInstanceId();`.
- (Core) Removed event `FirebaseEvents.IID_TOKEN_REFRESH`. You must use `FCM.listener.addEventListener(FcmEvents.TOKEN_REFRESH, onTokenRefresh);` from now on.
- (Core) Removed:

```xml
<service android:name="com.myflashlab.firebase.core.MyFirebaseInstanceIdService" android:exported="true">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```

- (Core) Added: `<uses-permission android:name="com.google.android.finsky.permission.BIND_GET_INSTALL_REFERRER_SERVICE"/>`
- (Core) Added:

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

- (FCM) Added Events: `FcmEvents.ON_SUBSCRIBE` and `FcmEvents.ON_UNSUBSCRIBE` to know when topic un/subscription is completed.
- (FCM) Removed `getToken` and added `getInstanceId` method:

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

- (FCM) Removed:

```xml
<service android:name="com.myflashlab.firebase.fcm.MyFirebaseInstanceIDService">
	<intent-filter>
		<action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
	</intent-filter>
</service>
```

- (Analytics) Added attribute _exported="true"_ to `com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver` and moreover, moved all manifest setup from analytics to FirebaseCore.
- (Analytics) Added new public method `resetAnalyticsData` to clear all Analytics data as well as reset App Instance ID.
- (Auth) Removed deprecated method `Firebaseuser.getToken`. Use `getIdToken` instead.
- (Auth) Added class `TokenResult`. is accessible from “FirebaseUserEvents.GET_USER_TOKEN” event. access token using `e.tokenResult`

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

- (Auth) Added new `meta-data` tag as follow. make sure you are adding this to the currently existing `<service>` tag.

```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" >
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.auth.FirebaseAuthRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar" />
</service>
```

- (Auth) There's a known bug in AIR SDK [explained here](https://tracker.adobe.com/#/view/AIR-4198557). If you are seeing this problem when compiling the iOS side of your app, [check out this video](https://www.youtube.com/watch?v=m4bwZRCvs2c) for the fix.
- (Auth) Features like `Auth.sendSignInLinkToEmail` need DynamicLink And Invites to be implemented in the project already.
- (Auth) FirebaseAuth has too many APIs based on Firebase Invites and Dynamic Links. So, we have made it dependent on FirebaseInvite when using the [ANELAB software](https://github.com/myflashlab/ANE-LAB). FirebaseInvite is also dependent on FirebaseDynamicLinks. It is strongly recommended to implement DynamicLinks and invites prior to implementing Auth to your app.
- (Firestore) Removed `QueryListenOptions` class and added [MetadataChanges](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/firestore/MetadataChanges.html) class to be used with `addSnapshotListener` method. You don't need to initialize the new class, simply pass `MetadataChanges.INCLUDE` or `MetadataChanges.EXCLUDE` as the last parameter of `addSnapshotListener` method.
- (Firestore) Query and collection `read` methods now optionally takes a MetadataChanges value. Notice that by default, metadata-only document changes are suppressed in the `read()` method, even when listening to a query with MetadataChanges.INCLUDE.
- (Firestore) Added the ability to control whether `read` method for documents and queries should fetch from server only, cache only, or attempt server and fall back to the cache. By default, both methods still attempt server and fall back to the cache. check the new class [Source](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/firestore/Source.html).
- (Firestore) Added a `Firestore.setServerTimestampBehavior` to control how DocumentSnapshots return unresolved server timestamps.
  - DocumentSnapshot.ServerTimestampBehavior_NONE
  - DocumentSnapshot.ServerTimestampBehavior_ESTIMATE
  - DocumentSnapshot.ServerTimestampBehavior_PREVIOUS
- (Firestore) Added new `meta-data` tag as follow. make sure you are adding this to the currently existing `<service>` tag.

```xml
<service android:name="com.google.firebase.components.ComponentDiscoveryService" >
    <meta-data
        android:name="com.google.firebase.components:com.google.firebase.firestore.FirestoreRegistrar"
        android:value="com.google.firebase.components.ComponentRegistrar" />
</service>
```

- (Firestore) mergeFields is now available on the iOS side also. Prior to this version, it was supported on the Android side only.
- (Storage) Removed `downloadUrl` and `downloadUrls` from StorageMetadata class and added `ref` property which returns a reference to the `StorageReference` object of the current StorageMetadata. You may use the `getDownloadUrl` method of this object instead of the removed ones.
- (Storage) Added support for `StorageEvents.TASK_COMPLETE` on instances of UploadTask and FileDownloadTask:

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

_May 20, 2018 - V6.5.0_

- Added support for Firebase Crashlytics V6.5.0
- Use iOS frameworks [V3.10.1 for Crashlytics](https://s3.amazonaws.com/kits-crashlytics-com/ios/com.twitter.crashlytics.ios/3.10.1/com.crashlytics.ios-manual.zip).

_Apr 22, 2018 - V6.5.0_

- Updated to Firebase SDK 12.0.1 for Android. update all the depenency ANEs.
- Updated to Firebase SDK 4.11.0 for iOS. update all the .framework and resources. https://dl.google.com/firebase/sdk/ios/4_11_0/Firebase-4.11.0.zip
- (Core) You need to regenerate the core ANE using the ane generator software V6.5.0 and you need to update all the other Firebase children that you are using in your project.
- (Core) multidex attribute added to the main android application tag in the manifest: `android:name="android.support.multidex.MultiDexApplication"`
- (Firestore) Removed the following framework dependencies:
  - FirebaseAuth
  - GTMSessionFetcher
- (Firestore) batch.commit now takes a param `$listenForCallback`. if set to false, FirestoreEvents.BATCH_SUCCESS or FirestoreEvents.BATCH_FAILURE won’t be dispatched.
- (Firestore) Added methods: disableNetwork/enableNetwork
- (Analytics) introduced new analytics events and params. Check asdoc for more details.
- (Analytics) Setting the ID to null removes the user ID.
- (Auth) new Activity tag should be added to the manifest as follow:

```xml
<activity
    android:name="com.google.firebase.auth.internal.FederatedSignInActivity"
    android:excludeFromRecents="true"
    android:exported="true"
    android:launchMode="singleInstance"
    android:permission="com.google.firebase.auth.api.gms.permission.LAUNCH_FEDERATED_SIGN_IN"
    android:theme="@android:style/Theme.Translucent.NoTitleBar" />
```

- (Auth) Added `AdditionalUserInfo` class, `e.additionalUserInfo` getter for events:
  - AuthEvents.CREATE_NEW_USER_RESULT
  - AuthEvents.SIGN_IN_RESULT
  - FirebaseUserEvents.LINK_WITH_RESULT
- (Auth) Added Email Link Authentication feature. `Auth.sendSignInLinkToEmail`, `Auth.isSignInWithEmailLink`.
- (Auth) Deprecated `fetchProvidersForEmail`. use new method `fetchSignInMethodsForEmail` instead.
- (Auth) Renamed `signInWithEmail` method to `signInWithEmailPass` and also added new method: `signInWithEmailLink`.
- (Auth) Deprecated `AuthProvider.EMAIL`. use new const `AuthProvider.EMAIL_PASS` instead and also added new const `AuthProvider.EMAIL_LINK`.
- (Auth) Deprecated `setEmailAuthProvider`. use new method `setEmailPassAuthProvider` instead and also added new method `setEmailLinkAuthProvider`.
- (Auth) ON ANDROID, Added the ability to use Google Play Games as a sign-in provider in your Firebase Project `setPlayGamesAuthProvider`.
- (FCM) Added `autoInitEnabled` property.
- (Storage) Added **md5Hash** property to StorageMetadata.

_Dec 15, 2017 - V6.0.0_

- Updated to Firebase SDK 11.6.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v6xx)
- Updated to Firebase SDK 4.6.0 for iOS. Make sure you are updating the [frameworks and resources](https://dl.google.com/firebase/sdk/ios/4_6_0/Firebase-4.6.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v6xx)
- (Core) You need to regenerate the core ANE using the ane generator software V6.0.0 and you need to update all the other Firebase children that you are using in your project.
- (Core) Remove the following receiver from your manifest: `<receiver android:name="com.google.firebase.iid.FirebaseInstanceIdInternalReceiver" android:exported="false"/>`
- (Core) The `projectID` property from the `FirebaseConfig` class is now deprecated and you no longer can set it manually. This property will be set automatically from now on and you can see its value with the following getter: `project_id`.
- (Analytics) Added new method `resetAnalyticsData()` which works on the Android side only.
- (Auth) Added `FirebaseUser.metadata`.
- (Auth) Added `ActionCodeSettings` to [sendPasswordResetEmail](<https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#sendPasswordResetEmail()>) and [sendEmailVerification](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#sendEmailVerification()>)
- (Dynamic-Links) You no longer have to set `Firebase.getConfig().projectID`. This will happen automatically from now on. However, you still need to set `Firebase.getConfig().webApiKey` manually.
- Firestore is now added and you can start using it. Start by reading the [wiki on how to initialize Firestore](https://github.com/myflashlab/Firebase-ANE/wiki/K.-Firestore).

_Sep 03, 2017 - V5.1.1_

- (Core) Fixed [issue 148](https://github.com/myflashlab/Firebase-ANE/issues/148). The core ANE must be regenerated with the new ane generator V5.1.1.

_Aug 21, 2017 - V5.1.0_

- (Core) the core ANE must be regenerated with the new ane generator V5.1.0.
- (Core) Added API for managing FirebaseInstanceId. You can now manualy delete and regenerate new iid ID and tokens.
- (Core) You need to add the following service to your manifest right after the `<provider ....` tag.

```xml
<service
    android:name="com.myflashlab.firebase.core.MyFirebaseInstanceIdService"
    android:exported="true">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```

_Jul 19, 2017 - V5.0.0_

- Updated to Firebase SDK 11.0.2 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v500)
- Updated to Firebase SDK 4.0.3 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/4_0_3/Firebase-4.0.3.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v500)
- From now on, sample files are in IntelliJ IDE.
- (Core) You need to regenerate the core ANE using the ane generator software V5.0.0 and you need to update all the other Firebase children that you are using in your project.
- (Core) Remove the following from your manifest: `<action android:name="com.google.android.c2dm.intent.REGISTRATION" />`
- (Analytics) The following service must be added to the manifest:

```xml
<service
	android:name="com.google.android.gms.measurement.AppMeasurementJobService"
	android:permission="android.permission.BIND_JOB_SERVICE"
	android:enabled="true"
	android:exported="false"/>
```

- (Auth) Corrected miss-spelling described at issue https://github.com/myflashlab/Firebase-ANE/issues/42
- (Auth) `Auth.RESULT_TOO_MANY_REQUESTS` introduced.
- (Auth) Listener `AuthEvents.ID_TOKEN_CHANGED` introduced. Listen to this even just like how you used to listen to `AuthEvents.AUTH_STATE_CHANGED`
- (Auth) Added support for Phone verification and sign in. `Auth.verifyPhoneNumber()`, Check Wiki to know how you can use this feature.
- (Auth) The new Phone verification feature on iOS will run only if you have setup push-notification on your app. To know how to do that, read the [setup information for FCM](https://github.com/myflashlab/Firebase-ANE/wiki/G.-FCM). If FCM is already added to your app, you're just good to go.
- (Crash) `Crash.crashCollectionEnabled` introduced
- (DynamicLinks) You need to add the follwoing dependency to your manifest: `<extensionID>com.myflashlab.air.extensions.dependency.firebase.dynamicLinks</extensionID>`

_Mar 07, 2017 - V4.0.0_

- Updated to Firebase SDK 10.2.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
- Updated to Firebase SDK 3.13.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_13_0/Firebase-3.13.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400)
- firebaseInvites.ane has been added to the collection and it is highly dependent on on DynamicLinks ANE. In simple terms, if you wish to use the Firebase Invites SDK, you need to first add Firebase DynamicLinks to your app.
- (Core) You need to regenerate the core ANE using the ane generator software V4.0.0 and you need to update all the other Firebase children that you are using in your project.
- (Core) [setLoggerLevel](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/core/Firebase.html#setLoggerLevel()>) has been introduced and [logLevel](http://myflashlab.github.io/asdoc/com/myflashlab/air//extensions/firebase/db/DB.html#logLevel) is now deprecated.
- (Core) Prior to this updated, other ANE dependencies were not required for iOS builds but from now on, you need to add `overrideAir.ane` even if you are building for iOS only. Just make sure you are reading [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v400) very carefully.
- (Auth) Added [signInWithEmail](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signInWithEmail()>)
- (Auth) Added [signInWithCustomToken](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signInWithCustomToken()>)
- (Auth) Added [confirmPasswordResetWithCode](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#confirmPasswordResetWithCode()>)
- (Auth) Added [checkActionCode](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#checkActionCode()>)
- (Auth) Added [verifyPasswordResetCode](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#verifyPasswordResetCode()>)
- (Auth) Added [applyActionCode](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#applyActionCode()>)
- (Auth) fixed [issue 84](https://github.com/myflashlab/Firebase-ANE/issues/84)
- (Analytics) Firebase team fixed [issue 34](https://github.com/firebase/quickstart-ios/issues/34) and we made sure it is also working on the ANE side.
- (Analytics) Added [getAppInstanceID](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/analytics/FirebaseAnalytics.html#getAppInstanceID()>)
- (DB) fixed [issue 65](https://github.com/myflashlab/Firebase-ANE/issues/65)
- (DB) fixed setValue and updateChilderen methods so they are now correctly removing values at targetted references if you are sending an empty String `""` at those references.
- (FCM) You can now use the [Resource Manager Software](http://www.myflashlabs.com/adobe-air-native-extension-resources-project/) to add custom icons for notifications on the Android side. _iOS shows app icon only. Firebase does not support this_
- (FCM) You can create custom [.caf files](https://www.google.com/search?q=%22.caf%22+files&ie=utf-8&oe=utf-8&client=firefox-b-ab) for iOS notifications to play custom sounds when a notification arrives.
- (FCM) known issue: custom sounds for Android must be placed in the res/raw folder using the [Resource Manager Software](http://www.myflashlabs.com/adobe-air-native-extension-resources-project/) but unfortunately this is not working because it seems like AIR is somehow compressing the files inside the raw folder. We will bring this issue to Adobe's attention so maybe they can fix this problem.
- Minor bug fixes on the ANE side.
- With upgrading to the latest Firebase SDK, a lot of native bugs are also fixed. You can learn about them by checking the official native Firebase [release notes](https://firebase.google.com/support/releases).

_Jan 14, 2017 - V3.0.0_

- Firebase Core ANE needs the `appinvite` dependency also from now on.
- You will need AIR SDK 24 or higher to compile Firebase ANEs. Older SDKs are just too old to support Firebase from mow on.
- firebaseDynamicLinks.ane has been added and works on both Android and iOS. To make sure it works correctly, you need to initialize dynamicLinks as soon as possible in your app, right after you initialized the Core Firebase ANE. `Firebase.init(true);`
- `FirebaseConfig` now has two getter/setter properties (`projectID` and `webApiKey`) which can be used for accessing dynamicLinks REST API.
- [Firebase.init](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/core/Firebase.html#init()>) accepts a boolean which is set to `false` by default. If set to `true`, the ANE will be prepared to use DynamicLinks.
- `FirebaseEvents` has been introduced which notifies you when GoogleApiClient is connected or disconnected. You may find these events helpful only on the Android side when working with DynamicLinks. These events will not be dispatched at all when you're running on iOS.
- If you are going to add DynamicLinks to your project, read the Wiki and make sure you are generating new provision files for iOS. Your old provisions will not work with DynamicLinks.

_Nov 27, 2016 - V2.0.0_

- Updated to Firebase SDK 10.0.0 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v200)
- Updated to Firebase SDK 3.10.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_10_0/Firebase-3.10.0.zip) based on [this information](https://github.com/myflashlab/Firebase-ANE/blob/master/Dependencies.md#v200)
- All Firebase ANEs are now optimized for AIR 24
- Minimum iOS version to support the Firebase ANEs will be iOS 8.0+ from now on
- (Auth) Added [sendEmailVerification](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#sendEmailVerification()>) method
- (Auth) Added [isEmailVerified](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/FirebaseUser.html#isEmailVerified) property
- (Auth) Added [fetchProvidersForEmail](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#fetchProvidersForEmail()>) method
- (Crash) You no longer need to add services to the manifest Android side.
- Minor bug fixes on the ANE side.
- With upgrading to the latest Firebase SDK, a lot of native bugs are also fixed. You can learn about them by checking the official native Firebase [release notes](https://firebase.google.com/support/releases).

_Oct 19, 2016_

- Added FCM

_Oct 05, 2016_

- Added Analytics

_Oct 04, 2016_

- Added FCM beta

_Sep 25, 2016 - V1.2.0_

- Updated to Firebase SDK 9.6.1 for Android. Make sure to update all your [dependency files](https://github.com/myflashlab/common-dependencies-ANE) also.
- Updated to Firebase SDK 3.6.0 for iOS. Make sure you are updating the [frameworks](https://dl.google.com/firebase/sdk/ios/3_6_0/Firebase.zip) too.
- (DB) Added Child and single events requested on [issue #15](https://github.com/myflashlab/Firebase-ANE/issues/15)
- (DB) Fixed Query EndAt method on iOS reported on [issue #16](https://github.com/myflashlab/Firebase-ANE/issues/16)
- (DB) Added `DBServerValue` class requested on [issue #10](https://github.com/myflashlab/Firebase-ANE/issues/10)
- (Auth) Added signInAnonymously. Simply pass `null` to the [signIn()](<http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/auth/Auth.html#signIn()>) method. [issue #8](https://github.com/myflashlab/Firebase-ANE/issues/8)
- The `checkDependencies` method is now deprecated in all Firebase ANEs. instead, you should use the [Inspector ANE](https://github.com/myflashlab/ANE-Inspector-Tool/) if you wish to check the availablity of dependencies.

_Sep 13, 2016_

- Added Crash

_Sep 06, 2016_

- Added Storage

_Aug 10, 2016 - V1.1.0_

- Updated to Firebase SDK 9.4.0 for Android. Make sure to update all your dependency files also.
- Updated to Firebase SDK 3.4.0 for iOS. Make sure you are updating the Frameworks also.
- minor bug fixes

_Jul 25, 2016_

- Added Remote config and Authentication

_Jul 21, 2016_

- Realtime database and the core are ready for beta testing

_Jul 05, 2016 - V1.0.0_

- beginning of the journey!
