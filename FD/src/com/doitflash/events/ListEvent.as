package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 3/18/2010 5:39 PM
	 */
	public class ListEvent extends Event
	{
		/**
		 * @private
		 */
		public static const RESIZE:String = "onListResize";
		public static const ITEM_ADDED:String = "onItemAdded";
		
		private var _param:*;
		
		/**
		 * 
		 */
		public function ListEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public function get param():*
		{
			return _param;
		}
	}
}