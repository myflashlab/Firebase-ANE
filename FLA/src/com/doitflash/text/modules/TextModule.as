package com.doitflash.text.modules
{
	import flash.geom.Point;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	import flash.events.TimerEvent;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	import com.doitflash.text.modules.MySprite;
	
	//import com.luaye.console.C;
	
	/**
	 * ...
	 * 
	 * <b>Copyright 2011, DoItFlash. All rights reserved.</b> This work is subject to the terms and software agreements in <a href="http://doitflash.com/">http://www.doitflash.com/</a>.
	 * 
	 * @author Hadi Tavakoli - 9/12/2010 2:38 PM
	 */
	public class TextModule extends MySprite 
	{
		protected var _paramList:Object; // holds flashVars
		protected var _moduleId:String = "";
		protected var _tagName:String = "";
		protected var _assetsPath:String;
		protected var _swfPath:String;
		
		protected var _tooltip:Object;
		
		protected var _textArea:*; // a reference to the TextArea which has loaded this module
		protected var _loader:Loader; // a reference to the Loader which has loaded this module (adobe is scaling this Loader automatically!)
		
		private var _contentTimer:Timer;
		
		public function TextModule():void
		{
			_width = 100;
			_height = 100;
			
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			// save flashVars
			_paramList = this.root.loaderInfo.parameters;
			
			this._xml = new XML(restorCDATA(unescape(decodeURIComponent(_paramList.config))));
			this._serverPath = _paramList.serverPath;
			
			_assetsPath = _paramList.assetsPath;
			_swfPath = _paramList.swfPath;
			_moduleId = this._xml.@id;
			_tagName = this._xml.name();
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private Functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private function stageAdded(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			_loader = this.parent as Loader;
			
			/*var loaderInfo:LoaderInfo = _loader.contentLoaderInfo;
			setTimeout(tt, 500);
			
			function tt():void
			{
				
				for (var name:String in loaderInfo.parameters) 
				{
					C.log(name + " = " + loaderInfo.parameters[name])
				}
			}*/
			
			/*_textArea = _loader.parent as Object;
			_embedFonts = _textArea.embedFonts;
			
			// connect to the tooltip
			//_tooltip = this.stage.getChildByName("myTooltip");
			
			// save data from the TextArea
			if (_textArea.base) _base = _textArea.base;
			else _base = _textArea.holder;
			
			_holder = _textArea.holder;
			
			_contentTimer = new Timer(50);
			_contentTimer.addEventListener(TimerEvent.TIMER, checkContent);
			_contentTimer.start();*/
		}
		
		public function construct($textArea:*):void
		{
			_textArea = $textArea;
			_embedFonts = _textArea.embedFonts;
			
			// connect to the tooltip
			//_tooltip = this.stage.getChildByName("myTooltip");
			
			// save data from the TextArea
			if (_textArea.base) _base = _textArea.base;
			else _base = _textArea.holder;
			
			_holder = _textArea.holder;
			
			_contentTimer = new Timer(50);
			_contentTimer.addEventListener(TimerEvent.TIMER, checkContent);
			_contentTimer.start();
		}
		
		private function checkContent(e:TimerEvent=null):void
		{
			if (_loader.width && _loader.height &&  _loader.width > 0, _loader.height > 0)
			{
				// stop the timer
				_contentTimer.stop();
				_contentTimer.removeEventListener(TimerEvent.TIMER, checkContent);
				
				// save the width and height of the module based on the user input
				_width = this.root.loaderInfo.width * _loader.scaleX;
				_height = this.root.loaderInfo.height * _loader.scaleY;
				
				drawBg(); // draw the final background for the module
				
				// Adobe scales the module and we need to stop that!
				_loader.scaleX = 1;
				_loader.scaleY = 1;
				
				init();
				
				// let TextArea know that this module is loaded and added to stage
				_textArea.onModuleLoaded(this);
			}
		}
		
		protected function init():void { }
		
		protected function restorCDATA($str:String):String
		{
			while ($str.indexOf("@![CDATA[") > -1)
			{
				$str = $str.replace("@![CDATA[", "<![CDATA[");
				$str = $str.replace("]]@", "]]>");
			}
			
			return $str;
		}
		
		protected function convertXmlToObject($config:XML):Object
		{
			var param:String;
			var value:String;
			var configVars:Object = { };
			
			for (var i:int = 0; i < $config..@*.length(); i++) 
			{
				param = $config..@ * [i].name();
				value = $config..@ * [i];
				
				configVars[param] = value;
			}
			
			for (var j:int = 0; j < $config.children().length(); j++) 
			{
				var currNode:XML = new XML($config.children()[j]);
				
				for (var k:int = 0; k < currNode.children().length(); k++) 
				{
					var currAttribute:XML = new XML(currNode.children()[k]);
					
					param = currAttribute.name();
					value = currAttribute.text();
					
					configVars[param] = value;
				}
			}
			
			return configVars;
		}
		
		protected function domainLock($Array:Array):Boolean
		{
			var domainLock:Boolean = true;
			
			var urlStart:int = root.loaderInfo.loaderURL.indexOf("://")+3;
			var urlEnd:int = root.loaderInfo.loaderURL.indexOf("/", urlStart);
			var domain:String = root.loaderInfo.loaderURL.substring(urlStart, urlEnd);
			var LastDot:int = domain.lastIndexOf(".")-1;
			var domEnd:int = domain.lastIndexOf(".", LastDot)+1;
			domain = domain.substring(domEnd, domain.length);
			
			for (var i:int = 0; i < $Array.length; i++) 
			{
				if (domain == $Array[i]) 
				{
					domainLock = false;
					break;
				}
			}
			
			if ($Array.length == 0) domainLock = false; // if the user didn't write any domain name, execute the movie freely
			if (domain == "") domainLock = false; // if the user is executing the movie from his/her computer offline
			if (domainLock) throw new Error("The movie can not be executed on this domain");
			
			return domainLock;
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////// Helpful Private Functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function getLocation():Point
		{	
			return new Point(_loader.x, _loader.y)
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function get moduleId():String
		{
			return _moduleId;
		}
		
		public function get tagName():String
		{
			return _tagName;
		}
		
	}
	
}