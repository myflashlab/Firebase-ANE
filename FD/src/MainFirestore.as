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

	import com.myflashlab.air.extensions.dependency.OverrideAir;
	import com.myflashlab.air.extensions.firebase.core.*;
	import com.myflashlab.air.extensions.firebase.firestore.*;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 7/17/2016 12:15 PM
	 */
	public class MainFirestore extends Sprite
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainFirestore():void
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Firestore V"+Firebase.VERSION+"</font>";
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
			
			var isConfigFound:Boolean = Firebase.init();
			Firebase.setLoggerLevel(FirebaseConfig.LOGGER_LEVEL_MAX);
			
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
				C.log("project_id = " + 					config.project_id);
				
				initFirestore();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function initFirestore():void
		{
			Firestore.init();
			
			
			
			// You can add snapshot listeners to any document, collection or query to watch for their vlue changes.
			
			// read samples and more information here:
				// http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/firebase/firestore/package-detail.html
				// https://github.com/myflashlab/Firebase-ANE/wiki/K.7-Query-Get-Realtime-Updates
			
			var document:DocumentReference = Firestore.collection("data").document("one");
			document.addSnapshotListener(onSnapshotListenerSuccess, onSnapshotListenerFailure);
			
			function onSnapshotListenerSuccess(e:FirestoreEvents):void
			{
				if(e.documentSnapshot)
				{
					trace("onSnapshotListenerSuccess: "+JSON.stringify(e.documentSnapshot.data));
					var source:String = (e.documentSnapshot.metadata.hasPendingWrites)? "local" : "server";
					trace("source of changes: " + source);
				}
				else
				{
					trace("document '" + document.documentId + "' is not available yet");
				}
			}
			
			function onSnapshotListenerFailure(e:FirestoreEvents):void
			{
				trace("onSnapshotListenerFailure: "+e.msg);
			}
			
			
			
			var btn01:MySprite = createBtn("1) Add Data");
			btn01.addEventListener(MouseEvent.CLICK, addData);
			_list.add(btn01);
			
			function addData(e:MouseEvent):void
			{
				// Create a new user with a first and last name
				var user:Object = {
					first: "Ada",
					last: "Lovelace",
					born: 1815
				};
				
				// Add a new document with a generated ID
				var collection:CollectionReference = Firestore.collection("users");
				collection.addEventListener(FirestoreEvents.COLLECTION_ADD_SUCCESS, onCollectionAddSuccess);
				collection.addEventListener(FirestoreEvents.COLLECTION_ADD_FAILURE, onCollectionAddFailure);
				collection.add(user);
			}
			
			function onCollectionAddSuccess(e:FirestoreEvents):void
			{
				var c:CollectionReference = e.target as CollectionReference;
				c.removeEventListener(FirestoreEvents.COLLECTION_ADD_SUCCESS, onCollectionAddSuccess);
				c.removeEventListener(FirestoreEvents.COLLECTION_ADD_FAILURE, onCollectionAddFailure);
				
				trace("DocumentSnapshot added with ID: " + e.documentReference.documentId);
			}
			
			function onCollectionAddFailure(e:FirestoreEvents):void
			{
				var c:CollectionReference = e.target as CollectionReference;
				c.removeEventListener(FirestoreEvents.COLLECTION_ADD_SUCCESS, onCollectionAddSuccess);
				c.removeEventListener(FirestoreEvents.COLLECTION_ADD_FAILURE, onCollectionAddFailure);
				
				trace("Error adding document: " + e.msg);
			}
			
			// --------------------------------------------------------------------
			
			var btn02:MySprite = createBtn("2) Add another Data");
			btn02.addEventListener(MouseEvent.CLICK, addAnotherData);
			_list.add(btn02);
			
			function addAnotherData(e:MouseEvent):void
			{
				// Create a new user with a first, middle, and last name
				var user:Object = {
					first: "Alan",
					middle: "Mathison",
					last: "Turring",
					born: 1912
				};
				
				// Add a new document with a generated ID
				var collection:CollectionReference = Firestore.collection("users");
				collection.addEventListener(FirestoreEvents.COLLECTION_ADD_SUCCESS, onCollectionAddSuccess);
				collection.addEventListener(FirestoreEvents.COLLECTION_ADD_FAILURE, onCollectionAddFailure);
				collection.add(user);
			}
			
			// --------------------------------------------------------------------
			
			var btn03:MySprite = createBtn("3) Read Data");
			btn03.addEventListener(MouseEvent.CLICK, readData);
			_list.add(btn03);
			
			function readData(e:MouseEvent):void
			{
				var collection:CollectionReference = Firestore.collection("users");
				collection.addEventListener(FirestoreEvents.QUERY_GET_SUCCESS, onCollectionReadSuccess);
				collection.addEventListener(FirestoreEvents.QUERY_GET_FAILURE, onCollectionReadFailure);
				collection.read();
			}
			
			function onCollectionReadSuccess(e:FirestoreEvents):void
			{
				var c:CollectionReference = e.target as CollectionReference;
				c.removeEventListener(FirestoreEvents.QUERY_GET_SUCCESS, onCollectionReadSuccess);
				c.removeEventListener(FirestoreEvents.QUERY_GET_FAILURE, onCollectionReadFailure);
				
				for(var i:int=0; i < e.querySnapshot.documents.length; i++)
				{
					var doc:DocumentSnapshot = e.querySnapshot.documents[i];
					trace(doc.snapshotId + " => " + JSON.stringify(doc.data));
				}
			}
			
			function onCollectionReadFailure(e:FirestoreEvents):void
			{
				var c:CollectionReference = e.target as CollectionReference;
				c.removeEventListener(FirestoreEvents.QUERY_GET_SUCCESS, onCollectionReadSuccess);
				c.removeEventListener(FirestoreEvents.QUERY_GET_FAILURE, onCollectionReadFailure);
				
				trace("Error getting documents: " + e.msg);
			}
			
			// --------------------------------------------------------------------
			
			var btn04:MySprite = createBtn("4) Write Data again!");
			btn04.addEventListener(MouseEvent.CLICK, writeAgain);
			_list.add(btn04);
			
			function writeAgain(e:MouseEvent):void
			{
				var city:Object = {
					name: "Los Angeles",
					state: "CA",
					country: "USA",
					population: 500000
				};
				
				var document:DocumentReference = Firestore.collection("cities").document("LA");
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_SUCCESS, onDocWriteSuccess);
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_FAILURE, onDocWriteFailure);
				document.write(city);
			}
			
			function onDocWriteSuccess(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_SET_SUCCESS, onDocWriteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_SET_FAILURE, onDocWriteFailure);
				
				trace("Document successfully written!");
			}
			
			function onDocWriteFailure(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_SET_SUCCESS, onDocWriteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_SET_FAILURE, onDocWriteFailure);
				
				trace("Error writing document: " + e.msg);
			}
			
			// --------------------------------------------------------------------
			
			var btn05:MySprite = createBtn("5) merge Data");
			btn05.addEventListener(MouseEvent.CLICK, mergeData);
			_list.add(btn05);
			
			function mergeData(e:MouseEvent):void
			{
				var city:Object = {
					capital: true
				};
				
				var document:DocumentReference = Firestore.collection("cities").document("BJ");
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_SUCCESS, onDocWriteSuccess);
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_FAILURE, onDocWriteFailure);
				
				var setOptions:SetOptions = new SetOptions();
				setOptions.merge();
				
				document.write(city, setOptions);
			}
			
			// --------------------------------------------------------------------
			
			var btn06:MySprite = createBtn("6) Write Complex Data");
			btn06.addEventListener(MouseEvent.CLICK, writeComplexData);
			_list.add(btn06);
			
			function writeComplexData(e:MouseEvent):void
			{
				var docData:Object = {
					stringExample: "Hello world!",
					booleanExample: true,
					numberExample: 3.14159265,
					incrementNumber:1000,
					serverTime:FieldValue.TIMESTAMP,
					arrayExample:[
						"Hello world!",
						false,
						{key:"value"}
					],
					objectExample:{
						"key": "can host other objects or arrays..."
					}
				};
				
				var document:DocumentReference = Firestore.collection("data").document("one");
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_SUCCESS, onDocWriteSuccess);
				document.addEventListener(FirestoreEvents.DOCUMENT_SET_FAILURE, onDocWriteFailure);
				document.write(docData);
			}
			
			// -----------------------------------------------------------
			
			var btn07:MySprite = createBtn("7) Transaction");
			btn07.addEventListener(MouseEvent.CLICK, runTransaction);
			_list.add(btn07);
			
			var myDocument:DocumentReference = Firestore.collection("data").document("one");
			var myTransaction:Transaction;
			
			function runTransaction(e:MouseEvent):void
			{
				var trans:Transaction = Firestore.createTransaction();
				if(trans)
				{
					myTransaction = trans;
					
					myTransaction.addEventListener(FirestoreEvents.TRANSACTION_BEGIN, onTransactionBegin);
					myTransaction.addEventListener(FirestoreEvents.TRANSACTION_COMPLETE, onTransactionComplete);
					myTransaction.addEventListener(FirestoreEvents.TRANSACTION_FAILURE, onTransactionFailure);
					
					// to start working with the transaction, you must wait for the "TRANSACTION_BEGIN" event to happen
					myTransaction.execute();
				}
				else
				{
					/*
						Every transaction will be finished when you call either of these methods:
						myTransaction.abort();
						myTransaction.keep();
					 */
					trace("another transaction is not released yet");
				}
			}
			
			function onTransactionBegin(e:FirestoreEvents):void
			{
				trace(">> onTransactionBegin");
				/*
					If you want to read more that one DocumentReference, you must read each inside the prior
					onReadComplete functions.
				 */
				
				myTransaction.read(myDocument, onReadComplete);
			}
			
			function onReadComplete($snapshot:DocumentSnapshot, $err:String):void
			{
				if($err)
				{
					trace("could not read the document: " + $err);
					myTransaction.abort();
				}
				else
				{
					trace("ReadSuccess, data: " + JSON.stringify($snapshot.data));
					
					// increment the current value in database
					var newValue:int = $snapshot.data.incrementNumber + 1;
					
					
					if(newValue > 1010)
					{
						trace("value is more than what our game needs.");
						myTransaction.abort();
					}
					else
					{
						/*
							payload message will be delivered to the TRANSACTION_COMPLETE event.
							you must change your UI based on this message known as the transaction outcome.
							in our example, you must not use the "newValue" value to change your UI, instead
							you must pass it through the "keep()" method and change your UI when TRANSACTION_COMPLETE
							happens.
						 */
						myTransaction.outcome = "payload message which can be anything for example a json String";
						myTransaction.update(myDocument, {incrementNumber:newValue}, onUpdateComplete);
					}
				}
			}
			
			function onUpdateComplete():void
			{
				/*
					You must call the "keep" method when you are sure the "write, update or omit" commands have
					finished their job. In this example, we are calling the "keep" method when the last "update"
					method is finished through "onUpdateComplete"
				 */
				myTransaction.keep();
			}
			
			function onTransactionComplete(e:FirestoreEvents):void
			{
				trace("onTransactionComplete: " + e.transactionOutcome);
				
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_BEGIN, onTransactionBegin);
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_COMPLETE, onTransactionComplete);
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_FAILURE, onTransactionFailure);
			}
			
			function onTransactionFailure(e:FirestoreEvents):void
			{
				trace("onTransactionFailure: " + e.msg);
				
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_BEGIN, onTransactionBegin);
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_COMPLETE, onTransactionComplete);
				myTransaction.removeEventListener(FirestoreEvents.TRANSACTION_FAILURE, onTransactionFailure);
			}
			
			// -----------------------------------------------------------
			
			var btn08:MySprite = createBtn("7) batch write");
			btn08.addEventListener(MouseEvent.CLICK, batchWrite);
			_list.add(btn08);
			
			function batchWrite(e:MouseEvent):void
			{
				// Get a new write batch
				var batch:WriteBatch = Firestore.batch();
				batch.addEventListener(FirestoreEvents.BATCH_SUCCESS, onBatchSuccess);
				batch.addEventListener(FirestoreEvents.BATCH_FAILURE, onBatchFailure);
				
				// Set the value of 'NYC'
				var nycRef:DocumentReference = Firestore.collection("cities").document("NYC");
				batch.write(nycRef, {name: "New York", state: "NY", country: "USA"});
				
				// Update the population of 'LA'
				var laRef:DocumentReference = Firestore.collection("cities").document("LA");
				batch.update(laRef, {population: 1000000});
				
				// Delete the city 'BJ'
				var bjRef:DocumentReference = Firestore.collection("cities").document("BJ");
				batch.omit(bjRef);
				
				batch.commit();
			}
			
			function onBatchSuccess(e:FirestoreEvents):void
			{
				var b:WriteBatch = e.target as WriteBatch;
				b.removeEventListener(FirestoreEvents.BATCH_SUCCESS, onBatchSuccess);
				b.removeEventListener(FirestoreEvents.BATCH_FAILURE, onBatchFailure);
				
				trace("onBatchSuccess");
			}
			
			function onBatchFailure(e:FirestoreEvents):void
			{
				var b:WriteBatch = e.target as WriteBatch;
				b.removeEventListener(FirestoreEvents.BATCH_SUCCESS, onBatchSuccess);
				b.removeEventListener(FirestoreEvents.BATCH_FAILURE, onBatchFailure);
				
				trace("onBatchFailure: " + e.msg);
			}
			
			// -----------------------------------------------------------
			
			var btn09:MySprite = createBtn("9) delete document");
			btn09.addEventListener(MouseEvent.CLICK, toDeleteDoc);
			_list.add(btn09);
			
			function toDeleteDoc(e:MouseEvent):void
			{
				var laRef:DocumentReference = Firestore.collection("cities").document("LA");
				laRef.addEventListener(FirestoreEvents.DOCUMENT_DELETE_SUCCESS, onDocDeleteSuccess);
				laRef.addEventListener(FirestoreEvents.DOCUMENT_DELETE_FAILURE, onDocDeleteFailure);
				laRef.omit();
			}
			
			function onDocDeleteFailure(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_DELETE_SUCCESS, onDocDeleteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_DELETE_FAILURE, onDocDeleteFailure);
				
				trace("onDocDeleteFailure: " + e.msg);
			}
			
			function onDocDeleteSuccess(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_DELETE_SUCCESS, onDocDeleteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_DELETE_FAILURE, onDocDeleteFailure);
				
				trace("onDocDeleteSuccess");
			}
			
			var btn10:MySprite = createBtn("10) delete field");
			btn10.addEventListener(MouseEvent.CLICK, toDeleteField);
			_list.add(btn10);
			
			function toDeleteField(e:MouseEvent):void
			{
				var document:DocumentReference = Firestore.collection("data").document("one");
				document.addEventListener(FirestoreEvents.DOCUMENT_UPDATE_SUCCESS, onFieldDeleteSuccess);
				document.addEventListener(FirestoreEvents.DOCUMENT_UPDATE_FAILURE, onFieldDeleteFailure);
				
				// Remove the 'stringExample' field from the document
				document.update({stringExample: FieldValue.DELETE});
			}
			
			function onFieldDeleteFailure(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_UPDATE_SUCCESS, onFieldDeleteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_UPDATE_FAILURE, onFieldDeleteFailure);
				
				trace("onFailure: " + e.msg);
			}
			
			function onFieldDeleteSuccess(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_UPDATE_SUCCESS, onFieldDeleteSuccess);
				d.removeEventListener(FirestoreEvents.DOCUMENT_UPDATE_FAILURE, onFieldDeleteFailure);
				
				trace("onSuccess");
			}
			
			
			var btn11:MySprite = createBtn("read an unavailable document!");
			btn11.addEventListener(MouseEvent.CLICK, ee);
			_list.add(btn11);
			
			function ee(e:MouseEvent):void
			{
				var document:DocumentReference = Firestore.collection("cities").document("notAvailable");
				document.addEventListener(FirestoreEvents.DOCUMENT_GET_FAILURE, onReadFailure);
				document.addEventListener(FirestoreEvents.DOCUMENT_GET_SUCCESS, onReadSuccess);
				document.read();
			}
			
			
			function onReadFailure(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_GET_FAILURE, onReadFailure);
				d.removeEventListener(FirestoreEvents.DOCUMENT_GET_SUCCESS, onReadSuccess);
				
				trace("Read Failure: " + e.msg);
			}
			
			function onReadSuccess(e:FirestoreEvents):void
			{
				var d:DocumentReference = e.target as DocumentReference;
				d.removeEventListener(FirestoreEvents.DOCUMENT_GET_FAILURE, onReadFailure);
				d.removeEventListener(FirestoreEvents.DOCUMENT_GET_SUCCESS, onReadSuccess);
				
				if(e.documentSnapshot)
				{
					trace("DocumentSnapshot data: " + JSON.stringify(e.documentSnapshot.data));
				}
				else
				{
					trace("No such document");
				}
			}
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