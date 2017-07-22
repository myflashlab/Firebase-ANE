package com.doitflash.mobileProject.commonCpuSrc
{
	import flash.system.Capabilities;
	import flash.system.TouchscreenType;
	import flash.ui.Multitouch;
	import flash.ui.KeyboardType;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MultitouchInputMode;
	
	import flash.sensors.Accelerometer;
	import flash.sensors.Geolocation;
	
	import flash.media.CameraUI;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.StageWebView;
	
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 3/3/2012 6:38 PM
	 */
	public class DeviceInfo
	{
		public static const LDPI:String = "ldpi";
		public static const MDPI:String = "mdpi";
		public static const HDPI:String = "hdpi";
		public static const XHDPI:String = "xhdpi";
		
		public function DeviceInfo():void 
		{
			
		}
		
// ----------------------------------------------------------------------------------------------------------------------- Privates
		
		
		
// ----------------------------------------------------------------------------------------------------------------------- Methods
		
		
		
// ----------------------------------------------------------------------------------------------------------------------- Properties
		
		public static function get info():String
		{
			var info:String;
			
			info = "touchscreenType = " + DeviceInfo.touchscreenType + "\n";
			info += "supportsCursor = " + DeviceInfo.supportsCursor + "\n";
			info += "physicalKeyboardType = " + DeviceInfo.physicalKeyboardType + "\n";
			info += "hasVirtualKeyboard = " + DeviceInfo.hasVirtualKeyboard + "\n";
			info += "supportsGestureEvents = " + DeviceInfo.supportsGestureEvents + "\n";
			info += "supportsTouchEvents = " + DeviceInfo.supportsTouchEvents + "\n";
			info += "supportsGestures = " + DeviceInfo.supportsGestures + "\n";
			info += "supportedGestures = " + DeviceInfo.supportedGestures + "\n";
			info += "supportsAccelerometer = " + DeviceInfo.supportsAccelerometer + "\n";
			info += "supportsGeolocation = " + DeviceInfo.supportsGeolocation + "\n";
			info += "supportsCameraUI = " + DeviceInfo.supportsCameraUI + "\n";
			info += "supportsCamera = " + DeviceInfo.supportsCamera + "\n";
			info += "supportsMicrophone = " + DeviceInfo.supportsMicrophone + "\n";
			info += "pixelAspectRatio = " + DeviceInfo.pixelAspectRatio + "\n";
			info += "dpi = " + DeviceInfo.dpi + "\n";
			info += "dpiCategory = " + DeviceInfo.dpiCategory + "\n";
			info += "dpiScaleMultiplier = " + DeviceInfo.dpiScaleMultiplier + "\n";
			info += "screenResolutionX = " + DeviceInfo.screenResolutionX + "\n";
			info += "screenResolutionY = " + DeviceInfo.screenResolutionY + "\n";
			info += "cpuArchitecture = " + DeviceInfo.cpuArchitecture + "\n";
			info += "supportsStageWebView = " + DeviceInfo.supportsStageWebView + "\n";
			
			return info;
		}
		
		
		
		public static function get touchscreenType():String
		{
			return Capabilities.touchscreenType;
		}
		
		public static function get supportsCursor():Boolean
		{
			return Mouse.supportsCursor;
		}
		
		public static function get physicalKeyboardType():String
		{
			return Keyboard.physicalKeyboardType;
		}
		
		public static function get hasVirtualKeyboard():Boolean
		{
			return Keyboard.hasVirtualKeyboard;
		}
		
		public static function get supportsGestureEvents():Boolean
		{
			return Multitouch.supportsGestureEvents;
		}
		
		public static function get supportsTouchEvents():Boolean
		{
			return Multitouch.supportsTouchEvents;
		}
		
		public static function get supportsGestures():Boolean
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			if (Multitouch.supportedGestures) return true;
			
			return false;
		}
		
		public static function get supportedGestures():Vector.<String>
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			if (Multitouch.supportedGestures) return Multitouch.supportedGestures;
			
			return null;
		}
		
		public static function get supportsAccelerometer():Boolean
		{
			return Accelerometer.isSupported;
		}
		
		public static function get supportsGeolocation():Boolean
		{
			return Geolocation.isSupported;
		}
		
		public static function get supportsCameraUI():Boolean
		{
			return CameraUI.isSupported;
		}
		
		public static function get supportsCamera():Boolean
		{
			return Camera.isSupported;
		}
		
		public static function get supportsMicrophone():Boolean
		{
			return Microphone.isSupported;
		}
		
		public static function get pixelAspectRatio():Number
		{
			return Capabilities.pixelAspectRatio;
		}
		
		public static function get dpi():Number
		{
			return Capabilities.screenDPI;
		}
		
		public static function get dpiCategory():String
		{
			var currDpi:Number = Capabilities.screenDPI;
			var currDpiCat:String = DeviceInfo.MDPI;
			
			if (currDpi <= 140)
			{
				currDpiCat = DeviceInfo.LDPI;
			}
			else if (currDpi > 140 && currDpi <= 200)
			{
				currDpiCat = DeviceInfo.MDPI;
			}
			else if (currDpi > 200 && currDpi <= 280)
			{
				currDpiCat = DeviceInfo.HDPI;
			}
			else if (currDpi > 280)
			{
				currDpiCat = DeviceInfo.XHDPI;
			}
			
			return currDpiCat;
		}
		
		public static function get dpiScaleMultiplier():Number
		{
			var currDpi:Number = Capabilities.screenDPI;
			var multiplier:Number = 1;
			
			if (currDpi <= 140)
			{
				multiplier = 0.75;
			}
			else if (currDpi > 140 && currDpi <= 200)
			{
				multiplier = 1;
			}
			else if (currDpi > 200 && currDpi <= 280)
			{
				multiplier = 1.5;
			}
			else if (currDpi > 280)
			{
				multiplier = 2;
			}
			
			return multiplier;
		}
		
		public static function get screenResolutionX():Number
		{
			return Capabilities.screenResolutionX;
		}
		
		public static function get screenResolutionY():Number
		{
			return Capabilities.screenResolutionY;
		}
		
		public static function get cpuArchitecture():String
		{
			return Capabilities.cpuArchitecture;
		}
		
		public static function get supportsStageWebView():Boolean
		{
			return StageWebView.isSupported;
		}
		
		public static function get stageWebView():Class
		{
			return StageWebView;
		}
	}
	
}