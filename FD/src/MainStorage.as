package 
{
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.utils.setTimeout;
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
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	
	import com.myflashlab.air.extensions.firebase.core.Firebase;
	import com.myflashlab.air.extensions.firebase.core.FirebaseConfig;
	import com.myflashlab.air.extensions.firebase.storage.*;
	import com.myflashlab.air.extensions.inspector.Inspector;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 9/6/2016 11:08 AM
	 */
	public class MainStorage extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainStorage():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Storage V"+Firebase.VERSION+"</font>";
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
		
		
		private function init():void
		{
			var isConfigFound:Boolean = Firebase.init();
			
			if (Firebase.checkDependencies()) trace("All dependencies required by firebaseCore.ane are loaded successfully.");
			else trace("some dependencies are missing!");
			
			if (isConfigFound)
			{
				var config:FirebaseConfig = Firebase.getConfig();
				C.log("default_web_client_id = " + 			config.default_web_client_id);
				C.log("firebase_database_url = " + 			config.firebase_database_url);
				C.log("gcm_defaultSenderId = " + 			config.gcm_defaultSenderId);
				C.log("google_api_key = " + 				config.google_api_key);
				C.log("google_app_id = " + 					config.google_app_id);
				C.log("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
				C.log("google_storage_bucket = " + 			config.google_storage_bucket);
				
				initStorage();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		
		private function initStorage():void
		{
			/*
				How to use the inspector ANE: https://github.com/myflashlab/ANE-Inspector-Tool
				You can use the same trick for all the other Child ANEs and other MyFlashLabs ANEs.
				All you have to do is to pass the Class name of the target ANE to the check method.
			*/
			if (!Inspector.check(Storage, true, true))
			{
				trace("Inspector.lastError = " + Inspector.lastError);
				return;
			}
			
			// initialize the Storage first
			Storage.init();
			
			// You can create a root reference to the storage with either these two ways
			//var rootRef:StorageReference = Storage.getReference(null, "gs://your-storage.appspot.com");
			var rootRef:StorageReference = Storage.getReference();
			
			// If you have a file already uploaded to your storage at the location "folder/myflashlab2.png", you should
			// create a reference to it like below.
			var imgRef:StorageReference = rootRef.child("folder/myflashlab2.png");
			
			// Even if you wish to upload a new file to a location on Storage, you should first create a reference to it.
			var imgUploadRef:StorageReference = rootRef.child("folder/FlashDevelop.png");
			
			// Generally, to download or upload objects to the Storage, you need to create references to those locations.
			
			var fileUploadRef:StorageReference;
			var fileDownloadRef:StorageReference;
			
// ----------------------------------------------------------------------------------------------------------------------------------
			
			var btn0:MySprite = createBtn("getBytes");
			btn0.addEventListener(MouseEvent.CLICK, getBytes);
			_list.add(btn0);
			
			function getBytes(e:MouseEvent):void
			{
				imgRef.getBytes(1024*1024, onGetBytesSuccess, onGetBytesFailed);
			}
			
			function onGetBytesFailed(e:StorageEvents):void
			{
				C.log("onGetBytesFailed, errorCode = " + e.errorCode + " with message: " + e.msg);
			}
			
			function onGetBytesSuccess(e:StorageEvents):void
			{
				var loader:Loader = new Loader();
				loader.loadBytes(e.bytes);
				addChild(loader);
				
				setTimeout(removeImage, 5000);
				
				function removeImage():void
				{
					removeChild(loader);
					loader = null;
				}
				
				// you can read the metadata of any object on the Storage like this:
				imgRef.getMetadata(onMetadataSuccess, onMetadataFailed);
			}
			
			function onMetadataFailed(e:StorageEvents):void
			{
				C.log("onMetadataFailed, errorCode = " + e.errorCode + " with message: " + e.msg);
			}
			
			function onMetadataSuccess(e:StorageEvents):void
			{
				C.log("bucket = " + 				e.metadata.bucket);
				C.log("cacheControl = " + 			e.metadata.cacheControl);
				C.log("contentDisposition = " + 	e.metadata.contentDisposition);
				C.log("contentEncoding = " + 		e.metadata.contentEncoding);
				C.log("contentLanguage = " + 		e.metadata.contentLanguage);
				C.log("contentType = " + 			e.metadata.contentType);
				C.log("creationTimeMillis = " + 	e.metadata.creationTimeMillis);
				C.log("updatedTimeMillis = " + 		e.metadata.updatedTimeMillis);
				C.log("customMetadata = " + 		e.metadata.customMetadata);
				C.log("downloadUrl = " + 			e.metadata.downloadUrl);
				C.log("downloadUrls = " + 			e.metadata.downloadUrls);
				C.log("generation = " + 			e.metadata.generation);
				C.log("metadataGeneration = " + 	e.metadata.metadataGeneration);
				C.log("name = " + 					e.metadata.name);
				C.log("path = " + 					e.metadata.path);
				C.log("sizeBytes = " + 				e.metadata.sizeBytes);
				C.log("------------------------------------------------------");
			}
			
// ----------------------------------------------------------------------------------------------------------------------------------
			
			var btn1:MySprite = createBtn("putBytes");
			btn1.addEventListener(MouseEvent.CLICK, putBytes);
			_list.add(btn1);
			
			function putBytes(e:MouseEvent):void
			{
				var file:File = File.applicationDirectory.resolvePath("FlashDevelop.png");
				file.addEventListener(Event.COMPLETE, onFileLoaded);
				file.load();
			}
			
			function onFileLoaded(e:Event):void
			{
				var file:File = e.currentTarget as File;
				file.removeEventListener(Event.COMPLETE, onFileLoaded);
				
				var task:UploadTask = imgUploadRef.putBytes(file.data, new StorageMetadata([{key1:"value1"}, {key2:"value2"}], null, null, null, null, null));
				task.addEventListener(StorageEvents.TASK_FAILED, onUploadBytesFailed);
				task.addEventListener(StorageEvents.TASK_PROGRESS, onUploadBytesProgress);
				task.addEventListener(StorageEvents.TASK_SUCCESS, onUploadBytesSuccess);
			}
			
			function onUploadBytesFailed(e:StorageEvents):void
			{
				var task:UploadTask = e.currentTarget as UploadTask;
				task.removeEventListener(StorageEvents.TASK_FAILED, onUploadBytesFailed);
				task.removeEventListener(StorageEvents.TASK_PROGRESS, onUploadBytesProgress);
				task.removeEventListener(StorageEvents.TASK_SUCCESS, onUploadBytesSuccess);
				
				C.log("onUploadBytesFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onUploadBytesProgress(e:StorageEvents):void
			{
				var task:UploadTask = e.currentTarget as UploadTask;
				
				var percent:Number = task.bytesTransferred / task.bytesTotal * 100;
				
				C.log("onUploadBytesProgress = " + Math.floor(percent) + "%");
			}
			
			function onUploadBytesSuccess(e:StorageEvents):void
			{
				var task:UploadTask = e.currentTarget as UploadTask;
				task.removeEventListener(StorageEvents.TASK_FAILED, onUploadBytesFailed);
				task.removeEventListener(StorageEvents.TASK_PROGRESS, onUploadBytesProgress);
				task.removeEventListener(StorageEvents.TASK_SUCCESS, onUploadBytesSuccess);
				
				C.log("onUploadBytesSuccess. task.downloadUrl = " + 					task.downloadUrl);
				C.log("onUploadBytesSuccess. task.metadata.bucket = " + 				task.metadata.bucket);
				C.log("onUploadBytesSuccess. task.metadata.cacheControl = " + 			task.metadata.cacheControl);
				C.log("onUploadBytesSuccess. task.metadata.contentDisposition = " + 	task.metadata.contentDisposition);
				C.log("onUploadBytesSuccess. task.metadata.contentEncoding = " + 		task.metadata.contentEncoding);
				C.log("onUploadBytesSuccess. task.metadata.contentLanguage = " + 		task.metadata.contentLanguage);
				C.log("onUploadBytesSuccess. task.metadata.contentType = " + 			task.metadata.contentType);
				C.log("onUploadBytesSuccess. task.metadata.creationTimeMillis = " + 	task.metadata.creationTimeMillis);
				C.log("onUploadBytesSuccess. task.metadata.updatedTimeMillis = " + 		task.metadata.updatedTimeMillis);
				C.log("onUploadBytesSuccess. task.metadata.customMetadata = " + 		task.metadata.customMetadata);
				C.log("onUploadBytesSuccess. task.metadata.downloadUrl = " + 			task.metadata.downloadUrl);
				C.log("onUploadBytesSuccess. task.metadata.downloadUrls = " + 			task.metadata.downloadUrls);
				C.log("onUploadBytesSuccess. task.metadata.generation = " + 			task.metadata.generation);
				C.log("onUploadBytesSuccess. task.metadata.metadataGeneration = " + 	task.metadata.metadataGeneration);
				C.log("onUploadBytesSuccess. task.metadata.name = " + 					task.metadata.name);
				C.log("onUploadBytesSuccess. task.metadata.path = " + 					task.metadata.path);
				C.log("onUploadBytesSuccess. task.metadata.sizeBytes = " + 				task.metadata.sizeBytes);
				C.log("------------------------------------------------------");
			}
			
// ----------------------------------------------------------------------------------------------------------------------------------

			var btn2:MySprite = createBtn("delete reference");
			btn2.addEventListener(MouseEvent.CLICK, deleteReference);
			_list.add(btn2);
			
			function deleteReference(e:MouseEvent):void
			{
				imgUploadRef.remove(onDeleteSuccess, onDeleteFailed);
			}
			
			function onDeleteFailed(e:StorageEvents):void
			{
				C.log("onDeleteFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onDeleteSuccess(e:StorageEvents):void
			{
				C.log("onDeleteSuccess");
			}
		
// ----------------------------------------------------------------------------------------------------------------------------------

			var btn3:MySprite = createBtn("putFile");
			btn3.addEventListener(MouseEvent.CLICK, putFile);
			_list.add(btn3);
			
			var fileUploadTask:UploadTask;
			
			function putFile(e:MouseEvent):void
			{
				var file:File = File.applicationDirectory.resolvePath("myBigFile.zip");
				//var file:File = File.applicationDirectory.resolvePath("FlashDevelop.png");
				
				// to use the "putFile()" method, your file must be in File.documentsDirectory or File.applicationStorageDirectory
				//var copy:File = File.documentsDirectory.resolvePath(file.name);
				var copy:File = File.applicationStorageDirectory.resolvePath(file.name);
				
				if(!copy.exists) file.copyTo(copy);
				
				// create a reference to where you wish to upload your file
				fileUploadRef = rootRef.child("folder/" + copy.name);
				
				/*
					you can use the UploadUri session thing on Android only. at least for the moment. We hope Firebase will support this on the iOS too.
					https://github.com/firebase/quickstart-ios/issues/89
					
					On Android, you can call fileUploadRef.activeUploadTasks which will return an array of active upload tasks.
					Each object in the array is of type UploadTask and you can extract the uploadSessionUri string property from them.
					
					You can save this uploadSessionUri string object in a database or Local Encrypted Store so you can continue the upload process from
					where it was paused.
				*/
				if (getEncryptedLocalStore("uploadSessionTest2"))
				{
					fileUploadTask = fileUploadRef.putFile(copy, new StorageMetadata([{varriable:"val"}]), getEncryptedLocalStore("uploadSessionTest2"));
					trace("resume upload");
				}
				else
				{
					fileUploadTask = fileUploadRef.putFile(copy, new StorageMetadata([{varriable:"val"}]));
					trace("fresh upload");
				}
				
				// Begin monitoring the upload progress with these listeners
				fileUploadTask.addEventListener(StorageEvents.TASK_FAILED, onUploadFileFailed);
				fileUploadTask.addEventListener(StorageEvents.TASK_PAUSED, onUploadFilePaused);
				fileUploadTask.addEventListener(StorageEvents.TASK_PROGRESS, onUploadFileProgress);
				fileUploadTask.addEventListener(StorageEvents.TASK_SUCCESS, onUploadFileSuccess);
			}
			
			function onUploadFileFailed(e:StorageEvents):void
			{
				removeEncryptedLocalStore("uploadSessionTest2");
				
				// make sure you are removing the listeners or you will experience unexpected behavior.
				fileUploadTask.removeEventListener(StorageEvents.TASK_FAILED, onUploadFileFailed);
				fileUploadTask.removeEventListener(StorageEvents.TASK_PAUSED, onUploadFilePaused);
				fileUploadTask.removeEventListener(StorageEvents.TASK_PROGRESS, onUploadFileProgress);
				fileUploadTask.removeEventListener(StorageEvents.TASK_SUCCESS, onUploadFileSuccess);
				
				C.log("onUploadFileFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onUploadFilePaused(e:StorageEvents):void
			{
				C.log("onUploadFilePaused");
			}
			
			function onUploadFileProgress(e:StorageEvents):void
			{
				var percent:Number = fileUploadTask.bytesTransferred / fileUploadTask.bytesTotal * 100;
				
				C.log("onUploadFileProgress = " + Math.floor(percent) + "%");
			}
			
			function onUploadFileSuccess(e:StorageEvents):void
			{
				removeEncryptedLocalStore("uploadSessionTest2");
				
				// make sure you are removing the listeners or you will experience unexpected behavior.
				fileUploadTask.removeEventListener(StorageEvents.TASK_FAILED, onUploadFileFailed);
				fileUploadTask.removeEventListener(StorageEvents.TASK_PAUSED, onUploadFilePaused);
				fileUploadTask.removeEventListener(StorageEvents.TASK_PROGRESS, onUploadFileProgress);
				fileUploadTask.removeEventListener(StorageEvents.TASK_SUCCESS, onUploadFileSuccess);
				
				C.log("onUploadFileSuccess. fileUploadTask.downloadUrl = " + 					fileUploadTask.downloadUrl);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.bucket = " + 				fileUploadTask.metadata.bucket);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.cacheControl = " + 			fileUploadTask.metadata.cacheControl);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.contentDisposition = " + 	fileUploadTask.metadata.contentDisposition);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.contentEncoding = " + 		fileUploadTask.metadata.contentEncoding);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.contentLanguage = " + 		fileUploadTask.metadata.contentLanguage);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.contentType = " + 			fileUploadTask.metadata.contentType);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.creationTimeMillis = " + 	fileUploadTask.metadata.creationTimeMillis);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.updatedTimeMillis = " + 	fileUploadTask.metadata.updatedTimeMillis);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.customMetadata = " + 		fileUploadTask.metadata.customMetadata);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.downloadUrl = " + 			fileUploadTask.metadata.downloadUrl);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.downloadUrls = " + 			fileUploadTask.metadata.downloadUrls);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.generation = " + 			fileUploadTask.metadata.generation);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.metadataGeneration = " + 	fileUploadTask.metadata.metadataGeneration);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.name = " + 					fileUploadTask.metadata.name);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.path = " + 					fileUploadTask.metadata.path);
				C.log("onUploadFileSuccess. fileUploadTask.metadata.sizeBytes = " + 			fileUploadTask.metadata.sizeBytes);
				C.log("------------------------------------------------------");
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn4:MySprite = createBtn("pause upload");
			btn4.addEventListener(MouseEvent.CLICK, pauseUpload);
			_list.add(btn4);
			
			function pauseUpload(e:MouseEvent):void
			{
				fileUploadTask.pause();
				C.log("pauseUpload");
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn5:MySprite = createBtn("resume upload");
			btn5.addEventListener(MouseEvent.CLICK, resumeUpload);
			_list.add(btn5);
			
			function resumeUpload(e:MouseEvent):void
			{
				fileUploadTask.resume();
				C.log("resumeUpload");	
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn6:MySprite = createBtn("cancel upload");
			btn6.addEventListener(MouseEvent.CLICK, cancelUpload);
			_list.add(btn6);
			
			function cancelUpload(e:MouseEvent):void
			{
				fileUploadTask.cancel();
				C.log("cancelUpload");	
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn7:MySprite = createBtn("update metadata");
			btn7.addEventListener(MouseEvent.CLICK, updateMetadata);
			_list.add(btn7);
			
			function updateMetadata(e:MouseEvent):void
			{
				var metadata:StorageMetadata = new StorageMetadata([{var1:"Value1"}, {var2:"Value2"}, {var3:3}, {var4:4}]);
				imgRef.updateMetadata(metadata, onMetadataUpdateSuccess, onMetadataUpdateFailed);
			}
			
			function onMetadataUpdateFailed(e:StorageEvents):void
			{
				C.log("onMetadataUpdateFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onMetadataUpdateSuccess(e:StorageEvents):void
			{
				C.log("onMetadataUpdateSuccess");
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn8:MySprite = createBtn("getDownloadUrl");
			btn8.addEventListener(MouseEvent.CLICK, getDownloadUrl);
			_list.add(btn8);
			
			function getDownloadUrl(e:MouseEvent):void
			{
				imgRef.getDownloadUrl(onGetDownloadUrlSuccess, onGetDownloadUrlFailed);
			}
			
			function onGetDownloadUrlFailed(e:StorageEvents):void
			{
				C.log("onGetDownloadUrlFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onGetDownloadUrlSuccess(e:StorageEvents):void
			{
				C.log("onGetDownloadUrlSuccess url = " + e.url);
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn9:MySprite = createBtn("getFile");
			btn9.addEventListener(MouseEvent.CLICK, getFile);
			_list.add(btn9);
			
			var fileDownloadTask:FileDownloadTask;
			
			function getFile(e:MouseEvent):void
			{
				// deside where you want to save the downloaded file. Note that this location must be writable.
				var distination:File = File.documentsDirectory.resolvePath("myBigFile.zip");
				
				fileDownloadRef = rootRef.child("folder/myBigFile.zip");
				
				fileDownloadTask = fileDownloadRef.getFile(distination);
				
				// monitor the download progress with the following listeners
				fileDownloadTask.addEventListener(StorageEvents.TASK_FAILED, onDownloadFileFailed);
				fileDownloadTask.addEventListener(StorageEvents.TASK_PAUSED, onDownloadFilePaused);
				fileDownloadTask.addEventListener(StorageEvents.TASK_PROGRESS, onDownloadFileProgress);
				fileDownloadTask.addEventListener(StorageEvents.TASK_SUCCESS, onDownloadFileSuccess);
			}
			
			function onDownloadFileFailed(e:StorageEvents):void
			{
				// make sure you are removing the listeners or you will experience unexpected behavior.
				fileDownloadTask.removeEventListener(StorageEvents.TASK_FAILED, onDownloadFileFailed);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_PAUSED, onDownloadFilePaused);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_PROGRESS, onDownloadFileProgress);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_SUCCESS, onDownloadFileSuccess);
				
				C.log("onDownloadFileFailed with errorCode '" + e.errorCode + "' and msg: " + e.msg);
			}
			
			function onDownloadFilePaused(e:StorageEvents):void
			{
				C.log("onDownloadFilePaused");
			}
			
			function onDownloadFileProgress(e:StorageEvents):void
			{
				var percent:Number = fileDownloadTask.bytesTransferred / fileDownloadTask.bytesTotal * 100;
				
				C.log("onDownloadFileProgress = " + Math.floor(percent) + "%");
			}
			
			function onDownloadFileSuccess(e:StorageEvents):void
			{
				// make sure you are removing the listeners or you will experience unexpected behavior.
				fileDownloadTask.removeEventListener(StorageEvents.TASK_FAILED, onDownloadFileFailed);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_PAUSED, onDownloadFilePaused);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_PROGRESS, onDownloadFileProgress);
				fileDownloadTask.removeEventListener(StorageEvents.TASK_SUCCESS, onDownloadFileSuccess);
				
				C.log("onDownloadFileSuccess");
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn10:MySprite = createBtn("pause download");
			btn10.addEventListener(MouseEvent.CLICK, pauseDownload);
			_list.add(btn10);
			
			function pauseDownload(e:MouseEvent):void
			{
				fileDownloadTask.pause();
				C.log("pauseUpload");	
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn11:MySprite = createBtn("resume download");
			btn11.addEventListener(MouseEvent.CLICK, resumeDownload);
			_list.add(btn11);
			
			function resumeDownload(e:MouseEvent):void
			{
				fileDownloadTask.resume();
				C.log("resumeUpload");	
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn12:MySprite = createBtn("cancel download");
			btn12.addEventListener(MouseEvent.CLICK, cancelDownload);
			_list.add(btn12);
			
			function cancelDownload(e:MouseEvent):void
			{
				fileDownloadTask.cancel();
				C.log("cancelUpload");	
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn13:MySprite = createBtn("activeDownloadTasks");
			btn13.addEventListener(MouseEvent.CLICK, activeDownloadTasks);
			_list.add(btn13);
			
			function activeDownloadTasks(e:MouseEvent):void
			{
				if (fileDownloadRef)
				{
					// available on Android only
					trace(fileDownloadRef.activeDownloadTasks);
				}
			}

// ----------------------------------------------------------------------------------------------------------------------------------

			var btn14:MySprite = createBtn("activeUploadTasks");
			btn14.addEventListener(MouseEvent.CLICK, activeUploadTasks);
			_list.add(btn14);
			
			function activeUploadTasks(e:MouseEvent):void
			{
				if (fileUploadRef)
				{
					if (fileUploadRef.activeUploadTasks)
					{
						// available on Android only
						
						var task:UploadTask = fileUploadRef.activeUploadTasks[0];
						setEncryptedLocalStore("uploadSessionTest2", task.uploadSessionUri);
					}
				}
			}

// ----------------------------------------------------------------------------------------------------------------------------------
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		public function setEncryptedLocalStore($key:String, $value:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes($value);
			
			EncryptedLocalStore.setItem($key, bytes);
		}
		
		public function getEncryptedLocalStore($key:String):String
		{
			var value:ByteArray = EncryptedLocalStore.getItem($key);
			
			if (!value) return null;
			
			return value.readUTFBytes(value.length);
		}
		
		public function removeEncryptedLocalStore($key:String):void
		{
			EncryptedLocalStore.removeItem($key);
		}
		
		public function resetEncryptedLocalStore():void
		{
			EncryptedLocalStore.reset();
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