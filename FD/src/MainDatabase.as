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
	
	import com.myflashlab.air.extensions.firebase.core.Firebase;
	import com.myflashlab.air.extensions.firebase.core.FirebaseConfig;
	import com.myflashlab.air.extensions.firebase.db.*;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 7/17/2016 12:15 PM
	 */
	public class MainDatabase extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainDatabase():void 
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
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase Realtime Database V"+Firebase.VERSION+"</font>";
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
				
				initDatabase();
			}
			else
			{
				C.log("Config file is not found!");
			}
		}
		
		private function initDatabase():void
		{
			DB.init();
			
			if (DB.checkDependencies()) trace("All dependencies required by firebaseDatabase.ane are loaded successfully.");
			else trace("some dependencies are missing!");
			
			var refDisconnect:DBReference;
			if (Firebase.os == Firebase.IOS) refDisconnect = DB.getReference("disconFromIos");
			else refDisconnect = DB.getReference("disconFromAndroid");
			
			var whenDisconnected:DBWhenDisconnect = refDisconnect.whenDisconnect();
			whenDisconnected.addEventListener(DBEvents.WHEN_DISCONNECT_SET_VALUE_SUCCESS, whenDisconnectedSetValueSuccess);
			whenDisconnected.addEventListener(DBEvents.WHEN_DISCONNECT_SET_VALUE_FAILURE, whenDisconnectedSetValueFailure);
			whenDisconnected.setValue("I disconnected!");
			
			
			var refTransaction:DBReference = DB.getReference("count");
			refTransaction.addEventListener(DBEvents.TRANSACTION_PROGRESS, onTransactionProgress);
			refTransaction.addEventListener(DBEvents.TRANSACTION_COMPLETE, onTransactionSuccess);
			refTransaction.addEventListener(DBEvents.TRANSACTION_FAILURE, onTransactionFailure);
			
			var refRoot:DBReference = DB.getReference();
			refRoot.addEventListener(DBEvents.VALUE_CHANGED, onValueChanged);
			refRoot.addEventListener(DBEvents.VALUE_CHANGE_FAILED, onValueChangeFailed);
			
			
			var refTests:DBReference = DB.getReference("branch1");
			refTests.addEventListener(DBEvents.SET_VALUE_SUCCESS, onSetValueSuccess);
			refTests.addEventListener(DBEvents.SET_VALUE_FAILURE, onSetValueFailure);
			
			
			// -----------------------------------------------------------
			
			var btn0:MySprite = createBtn("do transaction");
			btn0.addEventListener(MouseEvent.CLICK, doTransaction);
			_list.add(btn0);
			
			function doTransaction(e:MouseEvent):void
			{
				if (!refTransaction.runTransaction())
				{
					C.log("transaction is currently busy, try again in a few seconds.");
				}
			}
			
			// -----------------------------------------------------------
			
			var btn1:MySprite = createBtn("setValue Number");
			btn1.addEventListener(MouseEvent.CLICK, setValueNumber);
			_list.add(btn1);
			
			function setValueNumber(e:MouseEvent):void
			{
				refTests.setValue(24);
			}
			
			// -----------------------------------------------------------
			
			var btn2:MySprite = createBtn("setValue String");
			btn2.addEventListener(MouseEvent.CLICK, setValueString);
			_list.add(btn2);
			
			function setValueString(e:MouseEvent):void
			{
				refTests.setValue("string from Flash!");
			}
			
			// -----------------------------------------------------------
			
			var btn3:MySprite = createBtn("setValue Object");
			btn3.addEventListener(MouseEvent.CLICK, setValueObject);
			_list.add(btn3);
			
			function setValueObject(e:MouseEvent):void
			{
				var obj:Object = {};
				obj.var1 = "You can add";
				obj.var2 = "String";
				obj.var3 = "Number";
				obj.var4 = "Boolean";
				obj.var5 = "Array";
				obj.var6 = "or another object!";
				refTests.setValue(obj);
			}
			
			// -----------------------------------------------------------
			
			var btn8:MySprite = createBtn("setValue Array");
			btn8.addEventListener(MouseEvent.CLICK, setValueArray);
			_list.add(btn8);
			
			function setValueArray(e:MouseEvent):void
			{
				var arr:Array = [];
				arr.push("You can add", "String", "Number", "Boolean", "Object", "or another Array!");
				refTests.setValue(arr);
			}
			
			// -----------------------------------------------------------
			
			var btn4:MySprite = createBtn("setValue Complex json data");
			btn4.addEventListener(MouseEvent.CLICK, setValueComplexJson);
			_list.add(btn4);
			
			function setValueComplexJson(e:MouseEvent):void
			{
				var obj:Object = {};
				obj.var1 = "val1";
				obj.var2 = 2;
				obj.var3 = ["a", "b", "c", {a:"a", b:0}];
				
				var arr:Array = [];
				arr.push("value1", obj);
				
				refTests.setValue(arr);
			}
			
			// -----------------------------------------------------------
			
			var btn5:MySprite = createBtn("setValue deep inside...");
			btn5.addEventListener(MouseEvent.CLICK, setValueDeepInside);
			_list.add(btn5);
			
			function setValueDeepInside(e:MouseEvent):void
			{
				refTests.child("myChild1").child("subChild1").setValue("value!");
			}
			
			// -----------------------------------------------------------
			
			var btn6:MySprite = createBtn("updateChildren");
			btn6.addEventListener(MouseEvent.CLICK, updateChildren);
			_list.add(btn6);
			
			function updateChildren(e:MouseEvent):void
			{
				// no matter what value a field has, you can remove it by passing an empty String ""
				
				var map:Object = {};
				map["/branch1/myChild1/subChild1/"] = "123465789";
				map["/branch1/myChild1/subChild2/"] = "adasdadsa";
				refTests.updateChildren(map);
			}
			
			// -----------------------------------------------------------
			
			var btn7:MySprite = createBtn("push");
			btn7.addEventListener(MouseEvent.CLICK, push);
			_list.add(btn7);
			
			function push(e:MouseEvent):void
			{
				var key:String = refTests.push().key;
				refTests.child(key).setValue("test the push command");
			}
			
			// -----------------------------------------------------------
			
			
		}
		
		private function whenDisconnectedSetValueSuccess(e:DBEvents):void
		{
			C.log("when Disconnected Set Value Success");
		}
		
		private function whenDisconnectedSetValueFailure(e:DBEvents):void
		{
			C.log("when Disconnected Set Value Failure: " + e.msg);
		}
		
		private function onTransactionProgress(e:DBEvents):void
		{
			if 		(e.mutableData.value is String) 	C.log("TransactionProgress current value (String) = " + e.mutableData.value);
			else if (e.mutableData.value is Number) 	C.log("TransactionProgress current value (Number) = " + e.mutableData.value);
			else if (e.mutableData.value is Boolean) 	C.log("TransactionProgress current value (Boolean) = " + e.mutableData.value);
			else if (e.mutableData.value is Array) 		C.log("TransactionProgress current value (Array) = " + JSON.stringify(e.mutableData.value));
			else 										C.log("TransactionProgress current value (Object) = " + JSON.stringify(e.mutableData.value));
			
			C.log("mutableData.key = " + e.mutableData.key);
			
			// get the current live value from server
			if (e.mutableData.value) 
			{
				// increment the current value by one
				e.mutableData.setValue(e.mutableData.value + 1);
			}
			else 
			{
				// if current value is not available, let's be the first one who writes it!
				e.mutableData.setValue(1);
			}
			
			e.mutableData.continueSuccess();
			//e.mutableData.continueAbort();
		}
		
		private function onTransactionFailure(e:DBEvents):void
		{
			C.log("onTransaction Done Failure: " + e.msg);
		}
		
		private function onTransactionSuccess(e:DBEvents):void
		{
			C.log("-------------------");
			
			if (e.dataSnapshot.exists)
			{
				if 		(e.dataSnapshot.value is String) 	C.log("onTransactionSuccess value (String) = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Number) 	C.log("onTransactionSuccess value (Number) = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Boolean) 	C.log("onTransactionSuccess value (Boolean) = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Array) 	C.log("onTransactionSuccess value (Array) = " + JSON.stringify(e.dataSnapshot.value));
				else 										C.log("onTransactionSuccess value (Object) = " + JSON.stringify(e.dataSnapshot.value));
			}
			
			C.log("-------------------");
		}
		
		private function onSetValueSuccess(e:DBEvents):void
		{
			C.log("onSetValueSuccess");
		}
		
		private function onSetValueFailure(e:DBEvents):void
		{
			C.log("onSetValueFailure > " + e.msg);
		}
		
		private function onValueChanged(e:DBEvents):void
		{
			C.log("-------------------");
			
			if (e.dataSnapshot.exists)
			{
				if (e.dataSnapshot.value is String) 		C.log("onValueChanged String value = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Number) 	C.log("onValueChanged Number value = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Boolean) 	C.log("onValueChanged Boolean value = " + e.dataSnapshot.value);
				else if (e.dataSnapshot.value is Array) 	C.log("onValueChanged Array value = " + JSON.stringify(e.dataSnapshot.value));
				else 										C.log("onValueChanged Object value = " + JSON.stringify(e.dataSnapshot.value));
			}
			
			C.log("-------------------");
		}
		
		private function onValueChangeFailed(e:DBEvents):void
		{
			C.log("onValueChangeFailed: " + e.msg);
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