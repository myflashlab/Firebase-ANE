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
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLRequest;
import flash.system.LoaderContext;
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
import com.myflashlab.air.extensions.firebase.mlkit.*;

import flash.utils.ByteArray;


/**
 * ...
 * @author Hadi Tavakoli - 5/28/2016 10:36 AM
 *                         - 1/4/2017 7:39 PM
 */
public class MainMlkit extends Sprite
{
	private const BTN_WIDTH:Number = 150;
	private const BTN_HEIGHT:Number = 60;
	private const BTN_SPACE:Number = 2;
	private var _txt:TextField;
	private var _body:Sprite;
	private var _list:List;
	private var _numRows:int = 1;
	
	public function MainMlkit():void
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
		_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Firebase MLKIT V" + Firebase.VERSION + "</font>";
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
	
	private function onResize(e:* = null):void
	{
		if(_txt)
		{
			_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			
			C.x = 0;
			C.y = _txt.y + _txt.height + 0;
			C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
		}
		
		if(_list)
		{
			_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
			_list.row = _numRows;
			_list.itemArrange();
		}
		
		if(_body)
		{
			_body.y = stage.stageHeight - _body.height;
		}
	}
	
	private function init():void
	{
		// Remove OverrideAir debugger in production builds
		OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void
		{
			trace($ane+" ("+$class+") "+$msg);
		});
		
		var isConfigFound:Boolean = Firebase.init();
		Firebase.setLoggerLevel(FirebaseConfig.LOGGER_LEVEL_MAX);
		
		if(isConfigFound)
		{
			var config:FirebaseConfig = Firebase.getConfig();
			C.log("default_web_client_id = " + config.default_web_client_id);
			C.log("firebase_database_url = " + config.firebase_database_url);
			C.log("gcm_defaultSenderId = " + config.gcm_defaultSenderId);
			C.log("google_api_key = " + config.google_api_key);
			C.log("google_app_id = " + config.google_app_id);
			C.log("google_crash_reporting_api_key = " + config.google_crash_reporting_api_key);
			C.log("google_storage_bucket = " + config.google_storage_bucket);
			C.log("project_id = " + config.project_id);
			
			// You must initialize any of the other Firebase children after a successful initialization
			// of the Core ANE.
			initMlkit();
		} else
		{
			C.log("Config file is not found!");
		}
	}
	
	private function initMlkit():void
	{
		Mlkit.init();
		
		var file_scripts:File = File.applicationStorageDirectory.resolvePath("img-scripts.jpg");
		if(!file_scripts.exists) File.applicationDirectory.resolvePath("img-scripts.jpg").copyTo(file_scripts);
		
		var file_faces:File = File.applicationStorageDirectory.resolvePath("img-faces.jpg");
		if(!file_faces.exists) File.applicationDirectory.resolvePath("img-faces.jpg").copyTo(file_faces);
		
		var file_barcode:File = File.applicationStorageDirectory.resolvePath("img-barcode.jpg");
		if(!file_barcode.exists) File.applicationDirectory.resolvePath("img-barcode.jpg").copyTo(file_barcode);
		
		var file_label:File = File.applicationStorageDirectory.resolvePath("img-label.jpg");
		if(!file_label.exists) File.applicationDirectory.resolvePath("img-label.jpg").copyTo(file_label);
		
		var file_landmark:File = File.applicationStorageDirectory.resolvePath("img-landmark.jpg");
		if(!file_landmark.exists) File.applicationDirectory.resolvePath("img-landmark.jpg").copyTo(file_landmark);
		
		var visionImg_scripts:VisionImage;
		var visionImg_faces:VisionImage;
		var visionImg_barcode:VisionImage;
		var visionImg_label:VisionImage;
		var visionImg_landmark:VisionImage;
		
		// ----------------------------------------------------------------
		
		var btn00:MySprite = createBtn("Create vision imgs from BM");
		btn00.addEventListener(MouseEvent.CLICK, createVisionImageFromBM);
		_list.add(btn00);
		
		function createVisionImageFromBM(e:MouseEvent):void
		{
			var loader_scripts:Loader = new Loader();
			loader_scripts.load(new URLRequest(file_scripts.url));
			loader_scripts.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(e:Event):void
			{
				var bm:Bitmap = e.target.content as Bitmap;
				visionImg_scripts = Mlkit.createVisionImageFromBitmapData(bm.bitmapData);
				trace("visionImg_scripts.id = " + visionImg_scripts.id);
			});
			
			var loader_faces:Loader = new Loader();
			loader_faces.load(new URLRequest(file_faces.url));
			loader_faces.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(e:Event):void
			{
				var bm:Bitmap = e.target.content as Bitmap;
				visionImg_faces = Mlkit.createVisionImageFromBitmapData(bm.bitmapData);
				trace("visionImg_faces.id = " + visionImg_faces.id);
			});
			
			var loader_barcode:Loader = new Loader();
			loader_barcode.load(new URLRequest(file_barcode.url));
			loader_barcode.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(e:Event):void
			{
				var bm:Bitmap = e.target.content as Bitmap;
				visionImg_barcode = Mlkit.createVisionImageFromBitmapData(bm.bitmapData);
				trace("visionImg_barcode.id = " + visionImg_barcode.id);
			});
			
			var loader_label:Loader = new Loader();
			loader_label.load(new URLRequest(file_label.url));
			loader_label.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(e:Event):void
			{
				var bm:Bitmap = e.target.content as Bitmap;
				visionImg_label = Mlkit.createVisionImageFromBitmapData(bm.bitmapData);
				trace("visionImg_label.id = " + visionImg_label.id);
			});
			
			var loader_landmark:Loader = new Loader();
			loader_landmark.load(new URLRequest(file_landmark.url));
			loader_landmark.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(e:Event):void
			{
				var bm:Bitmap = e.target.content as Bitmap;
				visionImg_landmark = Mlkit.createVisionImageFromBitmapData(bm.bitmapData);
				trace("visionImg_landmark.id = " + visionImg_landmark.id);
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn1:MySprite = createBtn("recognize text");
		btn1.addEventListener(MouseEvent.CLICK, recognizeTxt);
		_list.add(btn1);
		
		function recognizeTxt(e:MouseEvent):void
		{
			var detector:TextRecognizer = Mlkit.initTextRecognizer(Mlkit.ON_DEVICE, null);
			detector.process(visionImg_scripts, function ($visionText:VisionText, $error:Error):void
			{
				if($error) trace($error.message);
				
				if($visionText) trace($visionText.toString());
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn2:MySprite = createBtn("detect face");
		btn2.addEventListener(MouseEvent.CLICK, detectFace);
		_list.add(btn2);
		
		function detectFace(e:MouseEvent):void
		{
			var detector:FaceDetector = Mlkit.initFaceDetector(null);
			detector.process(visionImg_faces, null,function ($faces:Vector.<VisionFace>, $error:Error):void
			{
				if($error) trace($error.message);
				
				if($faces)
				{
					trace("--------- VisionFace ------");
					for(var i:int=0; i < $faces.length; i++)
					{
						var face:VisionFace = $faces[i];
						trace("\t" + face.toString());
					}
					trace("---------------------------");
				}
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn3:MySprite = createBtn("detect barcode");
		btn3.addEventListener(MouseEvent.CLICK, detectBarcode);
		_list.add(btn3);
		
		function detectBarcode(e:MouseEvent):void
		{
			var detector:BarcodeDetector = Mlkit.initBarcodeDetector(null);
			detector.process(visionImg_barcode,function ($barcodes:Vector.<VisionBarcode>, $error:Error):void
			{
				if($error) trace($error.message);
				
				if($barcodes)
				{
					trace("--------- VisionBarcode ------");
					for(var i:int=0; i < $barcodes.length; i++)
					{
						var barcode:VisionBarcode = $barcodes[i];
						trace("\t" + barcode.toString());
					}
					trace("------------------------------");
				}
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn4:MySprite = createBtn("label image");
		btn4.addEventListener(MouseEvent.CLICK, labelImage);
		_list.add(btn4);
		
		function labelImage(e:MouseEvent):void
		{
			var detector:ImageLabeler = Mlkit.initImageLabeler(Mlkit.ON_DEVICE, null);
			detector.process(visionImg_label,function ($images:Vector.<VisionImageLabel>, $error:Error):void
			{
				if($error) trace($error.message);
				
				if($images)
				{
					trace("--------- VisionImageLabel ------");
					for(var i:int=0; i < $images.length; i++)
					{
						var img:VisionImageLabel = $images[i];
						trace("\t" + img.toString());
					}
					trace("---------------------------------");
				}
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn5:MySprite = createBtn("detect landmark");
		btn5.addEventListener(MouseEvent.CLICK, detectLandmark);
		_list.add(btn5);
		
		function detectLandmark(e:MouseEvent):void
		{
			var detector:LandmarkDetector = Mlkit.initLandmarkDetector(null);
			detector.process(visionImg_landmark,function ($landmarks:Vector.<VisionLandmark>, $error:Error):void
			{
				if($error) trace($error.message);
				
				if($landmarks)
				{
					trace("--------- VisionLandmark ------");
					for(var i:int=0; i < $landmarks.length; i++)
					{
						var landmark:VisionLandmark = $landmarks[i];
						trace("\t" + landmark.toString());
					}
					trace("-------------------------------");
				}
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn6:MySprite = createBtn("identify language");
		btn6.addEventListener(MouseEvent.CLICK, identifyLanguage);
		_list.add(btn6);
		
		function identifyLanguage(e:MouseEvent):void
		{
			var detector:LanguageIdentifier = Mlkit.initLanguageIdentifier(null);
			detector.identifyLanguage("This is a script in English language.",function ($languages:Vector.<IdentifiedLanguage>, $languageCode:String, $error:Error):void
			{
				if($error) trace($error.message);
				
				// this may be available if you call the 'identifyLanguage' method
				if($languageCode) trace("$languageCode: " + $languageCode);
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		var btn7:MySprite = createBtn("identify possible languages");
		btn7.addEventListener(MouseEvent.CLICK, identifyPossibleLanguage);
		_list.add(btn7);
		
		function identifyPossibleLanguage(e:MouseEvent):void
		{
			var detector:LanguageIdentifier = Mlkit.initLanguageIdentifier(null);
			detector.identifyPossibleLanguages("This is a script in English language.",function ($languages:Vector.<IdentifiedLanguage>, $languageCode:String, $error:Error):void
			{
				if($error) trace($error.message);
				
				// this may be available if you call the 'identifyPossibleLanguages' method
				if($languages)
				{
					trace("--------- IdentifiedLanguage ------");
					for(var i:int=0; i < $languages.length; i++)
					{
						var language:IdentifiedLanguage = $languages[i];
						trace("\t" + language.toString());
					}
					trace("-----------------------------------");
				}
				
				detector.close();
			});
		}
		
		// ----------------------------------------------------------------
		
		onResize();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private function createBtn($str:String):MySprite
	{
		var sp:MySprite = new MySprite();
		sp.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		sp.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		sp.addEventListener(MouseEvent.CLICK, onOut);
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