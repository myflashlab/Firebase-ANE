package com.doitflash.starling.utils.list
{
	import flash.events.EventDispatcher
	
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.events.ListEvent;
	
	
	/**
	 * List is a class to list the items that you add to it in Starling projects.
	 * 
	 * <b>Copyright 2012, DoItFlash. All rights reserved.</b>
	 * For seeing the preview and sample files visit <a href="http://myappsnippet.com/">http://www.myappsnippet.com/</a>
	 * 
	 * @see com.doitflash.events.ListEvent;
	 * @see com.doitflash.consts.Direction
	 * @see com.doitflash.consts.Orientation
	 * 
	 * @author Ali Tavakoli - 8/8/2012 3:05 PM
	 * @version 1.0
	 * 
	 * @example The following example shows you how to create a simple List.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.events.ListEvent;
	 * import com.doitflash.consts.Direction;
	 * import com.doitflash.consts.Orientation;
	 * import com.doitflash.starling.utils.list.List;
	 * 
	 * import com.doitflash.starling.MyStarlingSprite;
	 * 
	 * import starling.extensions.ClippedSprite;
	 * import starling.display.Sprite;
	 * import starling.display.DisplayObject;
	 * import starling.events.Touch;
	 * import starling.events.TouchPhase;
	 * import starling.events.TouchEvent;
	 * import flash.geom.Point;
	 * 
	 * 
	 * var list:List = new List();
	 * 
	 * // holder and itemsHolder properties can also be null, you can simply addChild your items anywhere and call list.add(), but best practice is to add all of your items in one place
	 * //var holder:Sprite = new Sprite(); // you can have your own holders
	 * //var itemsHolder:ClippedSprite = new ClippedSprite();
	 * //this.addChild(holder);
	 * //holder.addChild(itemsHolder);
	 * 
	 * list.holder = this;
	 * list.itemsHolder = new ClippedSprite();
	 * list.addEventListener(ListEvent.ITEM_ADDED, onItemAdded);
	 * 
	 * function onItemAdded(e:ListEvent):void
	 * {
	 * 		//trace(e.param.item.id);
	 * 		//trace(e.param.item.content);
	 * 		//trace(e.param.item.index);
	 * }
	 * 
	 * 
	 * list.itemsHolder.addEventListener(TouchEvent.TOUCH, onTouch);
	 * list.itemsHolder.clipRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
	 * 
	 * function onTouch(e:TouchEvent):void
	 * {
	 * 		var touch:Touch = e.getTouch(stage);
	 * 		var pos:Point = touch.getLocation(stage);
	 * 		
	 * 		// to scroll list
	 * 		//if (touch.phase == TouchPhase.BEGAN) _scroll.startScroll(pos);
	 * 		//else if (touch.phase == TouchPhase.MOVED) _scroll.startScroll(pos);
	 * 		//else if (touch.phase == TouchPhase.ENDED) _scroll.fling();
	 * }
	 * 
	 * 
	 * for (var j:int = 0; j < 5; j++) // sample added items to list
	 * {
	 * 		var item:MyStarlingSprite = new MyStarlingSprite();
	 * 		item.addEventListener(TouchEvent.TOUCH, onListItemTouch);
	 * 		item.name = "item" + j;
	 * 		item.width = randomRange(100, 100);
	 * 		item.height = randomRange(20, 60);
	 * 		item.drawBg(1, 0x00FF00, 1, 0x990055, 1);
	 * 		item.addChild(new TextField(item.width, item.height, "List item: " + j))
	 * 		
	 * 		//itemsHolder.addChild(item); // if you had your own holder and didn't set the list.itemsHolder property
	 * 		list.add(item);
	 * }
	 * 
	 * function onListItemTouch(e:TouchEvent):void
	 * {
	 * 		var touch:Touch = e.getTouch(stage);
	 * 		var clicked:DisplayObject = e.currentTarget as DisplayObject;
	 * 		
	 * 		if (touch.phase == TouchPhase.ENDED)
	 * 		{
	 * 			//trace("clicked:", clicked.name)
	 * 		}
	 * }
	 * 
	 * 
	 * list.hDirection = Direction.LEFT_TO_RIGHT;
	 * list.vDirection = Direction.TOP_TO_BOTTOM;
	 * list.orientation = Orientation.VERTICAL; // HORIZONTAL, VERTICAL
	 * list.row = 1;
	 * 
	 * list.space = 5;
	 * list.spaceX = 0;
	 * list.spaceY = 0;
	 * 
	 * list.reverseAddChild = false; // if true, item will be added under the previous items
	 * list.compactArrange = true; // set false if you like items in the next rows to be added according to the biggest item in the previous row, when row is more than 1
	 * //list.data = myObject; // if you like to save an Object in list for future usage
	 * 
	 * list.itemArrange(); // after you have set all of the settings, now arrange them all (you can call this function anytime that you needed)
	 * 
	 * 
	 * //list.items[0].content; // items Array
	 * //list.rows[0][0].content; // rows Array, if row is more than 1, then all of the items in one row are saved in an Array which is saved in rows Array respectively
	 * //list.idCount;
	 * 
	 * //list.remove(item);
	 * //list.removeById(0);
	 * //list.removeByIndex(0);
	 * //list.removeAll();
	 * 
	 * //var myItem:* = list.getItemByIndex(0);
	 * //var myItem:* = list.getItemById(0);
	 * 
	 * //list.getItemIndex(item); // returns Number
	 * //list.hasItem(item); // returns Boolean
	 * //list.swapItems(0, 1); // swap two items
	 * 
	 * 
	 * function randomRange(minNum:Number, maxNum:Number):Number   
	 * {  
	 * 		return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);  
	 * } 
	 * </listing>
	 */
	public class List extends EventDispatcher
	{
// ----------------------------------------------------------------------------------------------------------------------- vars
		
		// input vars
		private var _hDirection:String = Direction.LEFT_TO_RIGHT;
		private var _vDirection:String = Direction.TOP_TO_BOTTOM;
		private var _orientation:String = Orientation.VERTICAL; // HORIZONTAL, VERTICAL
		
		private var _data:Object = new Object();
		
		private var _space:Number = 5;
		private var _spaceX:Number = 0;
		private var _spaceY:Number = 0;
		
		private var _holder:*;
		private var _itemsHolder:*;
		private var _reverseAddChild:Boolean = false;
		private var _row:int = 1;
		private var _compactArrange:Boolean = true;
		
		
		// needed vars
		private var _items:Array = new Array();
		private var _rows:Array = new Array();
		private var _firstArrange:Boolean = true;
		private var _maxHItemInRow:Number = 0;
		private var _maxWItemInRow:Number = 0;
		
		private var _idCount:int = 0;
		
		//private var _oldWidth:Number;
		//private var _oldHeight:Number;
		
// ----------------------------------------------------------------------------------------------------------------------- constructor func
		public function List():void
		{
			
		}
		
// ----------------------------------------------------------------------------------------------------------------------- funcs
		
		private function cleanUp($target:*):void
		{
			for (var i:int = $target.numChildren-1; i >= 0; i--)
			{
				$target.removeChildAt(i);
			}
		}
		
// ----------------------------------------------------------------------------------------------------------------------- Methods
		
		public function add($item:*, $index:Number = NaN):void
		{
			if (isNaN($index)) $index = _items.length; // if we didn't set index, set it the Array length to put the item in last place in the list
			
			_items.splice($index, 0 , { content:$item, id:_idCount, index:$index, initWidth:$item.width, initHeight:$item.height } );
			if (_itemsHolder) (!_reverseAddChild) ? _itemsHolder.addChild($item) : _itemsHolder.addChildAt($item, 0);
			_idCount++; // _idCount always gets higher each time on this function call, and won't get less by removing one item to make sure we always have unique id
			
			this.dispatchEvent(new ListEvent(ListEvent.ITEM_ADDED, { item:$item } ));
		}
		
		public function itemArrange():void
		{	
			/*
			if (_firstArrange) // if this is the first time that we wanna arrange items, let's just arrange them all
			{
				arrange();
				_firstArrange = false;
			}
			else // if it's not our first arrangment
			{
				var i:int;
				for (i = 0; i < _items.length; i++ )
				{
					var item:* = _items[i];
					
					if (item.initWidth != item.content.width || item.initHeight != item.content.height) // check size of which item has been changed
					{
						var diff:Object = new Object();
						
						diff.diffH =  item.content.height - item.initHeight;
						if (diff.diffH != 0) // set other items new positions according to height
						{
							arrange(diff, i + 1);
							item.initHeight = item.content.height;
						}
						
						diff.diffW =  item.content.width - item.initWidth;
						if (diff.diffW != 0) // set other items new positions according to width
						{
							arrange(diff, i + 1);
							item.initWidth = item.content.width;
						}
						
						// break; // don't break after seeing that one of the items size has been changed, because there may be more items in the way
					}
				}
			}
			*/
			
			arrange();
			_firstArrange = false; // so that, it won't set _rows Array again if user has called this function again and again
			
			function arrange($diff:Object = null, $startPoint:int = 0):void
			{
				//if ($diff) // if first arrangment has been done already, and we have the $diff.diffW or $diff.diffH, then we set the items which are after the modified one new position according to this amount
				// not useful at this time!
				
				
				var passedItems:int = 0; // count the items we pass in a row
				var passedRows:int = 0; // count the rows we pass
				
				var lastItem:*;
				var currItem:*;
				var prevRowSamecolumnItem:*;
				
				
				var j:int;
				for(j = $startPoint; j < _items.length; j++) // arrange all of the items
				{
					switch(_orientation)
					{
						case Orientation.VERTICAL:
						
							if(j != 0) // if we have more than one item
							{
								lastItem = _items[j - 1].content; // now that we have more than one item, we have last item too
								currItem =  _items[j].content;
								
								if (_row > 1 && _row != passedItems + 1) // if _row is more than 1 and we didn't reach the _row value yet
								{
									passedItems++;
									
									if (passedItems == _row - 1 && _firstArrange) // if we are at the last item in this row and this is our first arrangment, because next time on this function call, we have _rows Array ready already
									{
										// we like to save each row when the row is just finished and we're going to the next row, so
										// k = j - (_row - 1); to start saving from exactly the first item in this current row (current item id = j)
										// j + 1; length of our loop starts from the first item in this row and ends exactly on the last item in this row, because the if happens on the last item in this row, so we like the loop to happen exactly till the last item as well
										
										var thisRowItems:Array = new Array();
										//var currRowLength:int = (j - (_row - 1)) + (_row - 1);
										for (var k:int = j - (_row - 1); k < j + 1; k++) // we're exactly going to save this row items
										{
											thisRowItems.push(_items[k]);
										}
										_rows.push(thisRowItems); // save the row
									}
									
									
									// set currItem x location
									hDirectionAlign(currItem, lastItem.x + lastItem.width + _space + _spaceX, lastItem.x - currItem.width - _space + _spaceX);
									
									
									if (passedRows > 0) // if we have passed one row at least
									{
										prevRowSamecolumnItem =  _items[j - _row].content; // get the item in the last row that is in the same column that the current item is
										
										// set currItem y location
										vCompactCheck(prevRowSamecolumnItem, passedRows - 1); // returns _maxHItemInRow
										vDirectionAlign(currItem, prevRowSamecolumnItem.y + _maxHItemInRow + _space + _spaceY, prevRowSamecolumnItem.y - currItem.height - _space + _spaceY);
									}
									else
									{
										// set currItem y location
										vDirectionAlign(currItem, 0, lastItem.y + lastItem.height - currItem.height);
									}
								}
								else if (_row > 1 && _row == passedItems + 1) // if _row is more than 1 and we have reached the _row value
								{
									prevRowSamecolumnItem =  _items[j - _row].content; // get the item in the last row that is in the same column that the current item is
									
									// set currItem x location
									hDirectionAlign(currItem, 0, prevRowSamecolumnItem.x + prevRowSamecolumnItem.width - currItem.width);
									
									// set currItem y location
									vCompactCheck(prevRowSamecolumnItem, passedRows); // returns _maxHItemInRow
									vDirectionAlign(currItem, prevRowSamecolumnItem.y + _maxHItemInRow + _space + _spaceY, prevRowSamecolumnItem.y - currItem.height - _space + _spaceY);
									
									
									passedItems = 0; // now that we are at the begining of the next row, again set the passedItems to 0
									passedRows++; // add one to passedRows to know that how many rows we have passed till now
								}
								else // if _row is 1
								{
									// set currItem x location
									hDirectionAlign(currItem, 0, lastItem.x + lastItem.width - currItem.width);
									
									
									// we can use diff here, we add all the diff amount to the current position of the next items after the currItem
									// var newY:Number = (!$diff) ? lastItem.y + lastItem.height + _space + _spaceY : currItem.y + $diff.diffH;
									
									// set currItem y location
									vDirectionAlign(currItem, lastItem.y + lastItem.height + _space + _spaceY, lastItem.y - currItem.height - _space + _spaceY);
								}
							}
							else
							{
								currItem = _items[j].content;
								currItem.x = 0;
								currItem.y = 0;
							}
						break;
						
						case Orientation.HORIZONTAL:
						
							if(j != 0) // if we have more than one item
							{
								lastItem = _items[j - 1].content; // now that we have more than one item, we have last item too
								currItem =  _items[j].content;
								
								if (_row > 1 && _row != passedItems + 1) // if _row is more than 1 and we didn't reach the _row value yet
								{
									passedItems++;
									
									
									if (passedItems == _row - 1 && _firstArrange) // if we are at the last item in this row and this is our first arrangment, because next time on this function call, we have _rows Array ready already
									{
										// we like to save each row when the row is just finished and we're going to the next row, so
										// m = j - (_row - 1); to start saving from exactly the first item in this current row (current item id = j)
										// j + 1; length of our loop starts from the first item in this row and ends exactly on the last item in this row, because the if happens on the last item in this row, so we like the loop to happen exactly till the last item as well
										
										var thisRowItems2:Array = new Array();
										//var currRowLength2:int = (j - (_row - 1)) + (_row - 1);
										for (var m:int = j - (_row - 1); m < j + 1; m++) // we're exactly going to save this row items
										{
											thisRowItems2.push(_items[m]);
										}
										_rows.push(thisRowItems2); // save the row
									}
									
									
									// set currItem y location
									vDirectionAlign(currItem, lastItem.y + lastItem.height + _space + _spaceY, lastItem.y - currItem.height - _space + _spaceY);
									
									
									if (passedRows > 0) // if we have passed one row at least
									{
										prevRowSamecolumnItem =  _items[j - _row].content; // get the item in the last row that is in the same column that the current item is
										
										// set currItem x location
										hCompactCheck(prevRowSamecolumnItem, passedRows - 1); // returns _maxWItemInRow
										hDirectionAlign(currItem, prevRowSamecolumnItem.x + _maxWItemInRow + _space + _spaceX, prevRowSamecolumnItem.x - currItem.width - _space + _spaceX);
									}
									else
									{
										// set currItem x location
										hDirectionAlign(currItem, 0, lastItem.x + lastItem.width - currItem.width);
									}
								}
								else if (_row > 1 && _row == passedItems + 1) // if _row is more than 1 and we have reached the _row value
								{
									prevRowSamecolumnItem =  _items[j - _row].content; // get the item in the last row that is in the same column that the current item is
									
									// set currItem y location
									vDirectionAlign(currItem, 0, prevRowSamecolumnItem.y + prevRowSamecolumnItem.height - currItem.height);
									
									// set currItem x location
									hCompactCheck(prevRowSamecolumnItem, passedRows); // returns _maxWItemInRow
									hDirectionAlign(currItem, prevRowSamecolumnItem.x + _maxWItemInRow + _space + _spaceX, prevRowSamecolumnItem.x - currItem.width - _space + _spaceX);
									
									
									passedItems = 0; // now that we are at the begining of the next row, again set the passedItems to 0
									passedRows++; // add one to passedRows to know that how many rows we have passed till now
								}
								else // if _row is 1
								{
									// set currItem y location
									vDirectionAlign(currItem, 0, lastItem.y + lastItem.height - currItem.height);
									
									
									// we can use diff here, we add all the diff amount to the current position of the next items after the currItem
									// var newX:Number = (!$diff) ? lastItem.x + lastItem.width + _space + _spaceX : currItem.x + $diff.diffW;
									
									// set currItem y location
									hDirectionAlign(currItem, lastItem.x + lastItem.width + _space + _spaceX, lastItem.x - currItem.width - _space + _spaceX);
								}
							}
							else
							{
								currItem = _items[j].content;
								currItem.x = 0;
								currItem.y = 0;
							}
						break;
					}
				}
			}
			
			
			
			
			function hDirectionAlign($content:*, $LTRx:Number, $RTLx:Number):void
			{
				var newPos:Number;
				if (_hDirection == Direction.LEFT_TO_RIGHT) newPos = $LTRx;
				else if (_hDirection == Direction.RIGHT_TO_LEFT) newPos = $RTLx;
				
				$content.x = newPos;
				//TweenMax.to($content, _duration, {bezierThrough:[{x:newPos}], ease:_easeType});
			}
			function vDirectionAlign($content:*, $TTBy:Number, $BTTy:Number):void
			{
				var newPos:Number;
				if (_vDirection == Direction.TOP_TO_BOTTOM) newPos = $TTBy;
				else if (_vDirection == Direction.BOTTOM_TO_TOP) newPos = $BTTy;
				
				$content.y = newPos;
				//TweenMax.to($content, _duration, {bezierThrough:[{y:newPos}], ease:_easeType});
			}
			
			function vCompactCheck($prevRowSamecolumnItem:*, $RowNum:Number, $isNormal:Boolean = true):Number
			{
				_maxHItemInRow = 0;
				
				if (!_compactArrange) 
				{
					for (var l:int = 0; l < _rows[$RowNum].length; l++) 
					{
						if (_rows[$RowNum][l].content.height > _maxHItemInRow) _maxHItemInRow = _rows[$RowNum][l].content.height;
					}
					
					//TODO: add _compactArrange support for Direction.BOTTOM_TO_TOP, using $isNormal argument
				}
				else _maxHItemInRow = $prevRowSamecolumnItem.height;
				
				return _maxHItemInRow;
			}
			
			function hCompactCheck($prevRowSamecolumnItem:*, RowNum:Number, $isNormal:Boolean = true):Number
			{
				_maxWItemInRow = 0;
				
				if (!_compactArrange) 
				{
					for (var l:int = 0; l < _rows[RowNum].length; l++) 
					{
						if (_rows[RowNum][l].content.width > _maxWItemInRow) _maxWItemInRow = _rows[RowNum][l].content.width;
					}
				}
				else _maxWItemInRow = $prevRowSamecolumnItem.width;
				
				return _maxWItemInRow;
			}
			
			
			
			
			if (_holder && _itemsHolder)
			{
				if (!_itemsHolder.stage) _holder.addChild(_itemsHolder);
			}
		}
		
		
		
		
		public function remove($item:*):void
		{
			for (var i:int = 0; i < _items.length; i++ ) // find the item inside the array
			{
				if (_items[i].content == $item)
				{
					if (_itemsHolder) _itemsHolder.removeChild(_items[i].content);
					_items.splice(_items[i].index, 1);
					return;
				}
			}
		}
		
		public function removeById($id:int):void
		{
			for (var i:int = 0; i < _items.length; i++ ) // find the item inside the array
			{
				if (_items[i].id == $id)
				{
					if (_itemsHolder) _itemsHolder.removeChild(_items[i].content);
					_items.splice(_items[i].index, 1);
					return;
				}
			}
		}
		
		public function removeByIndex($index:int):void
		{
			if (_itemsHolder) _itemsHolder.removeChild(_items[$index].content);
			_items.splice($index, 1);
		}
		
		public function removeAll():void
		{
			if (_itemsHolder) cleanUp(_itemsHolder);
			_items.splice(0);
			_idCount = 0; // we have no item anymore, so _idCount can be rest too
		}
		
		
		
		
		public function getItemByIndex($index:int):Object
		{
			return _items[$index];
		}
		
		public function getItemById($id:int):Object
		{
			var i:int;
			for (i = 0; i < _items.length; i++ ) // find the item inside the array
			{
				if (_items[i].id == $id) break;
			}
			
			return _items[i];
		}
		
		
		
		
		public function getItemIndex($item:*):Number
		{
			for (var i:int = 0; i < _items.length; i++ )
			{
				if (_items[i].content == $item)
				{
					return _items[i].index;
				}
			}
			
			return NaN;
		}
		
		/**
		 * checks the passed item to indicate if that item is available in the list.
		 * @param	$item
		 * @return 		if <code>true</code>, it means that the passes item is available in the list
		 */
		public function hasItem($item:*):Boolean
		{
			for (var i:int = 0; i < _items.length; i++ )
			{
				if (_items[i].content == $item)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function swapItems($index1:int, $index2:int):void
		{
			// take out the bigger item
			var biggerItem:Object = _items.splice(Math.max($index1, $index2), 1)[0];
			
			// take out the smaller item
			var smallerItem:Object = _items.splice(Math.min($index1, $index2), 1)[0];
			
			// put the bigger item in place of the smaller one
			_items.splice(Math.min($index1, $index2), 0 , biggerItem);
			
			// now put the smaller item in place of the bigger one
			_items.splice(Math.max($index1, $index2), 0 , smallerItem);
			
			itemArrange();
		}
		
// ----------------------------------------------------------------------------------------------------------------------- Properties
		
		public function get holder():*
		{
			return _holder;
		}
		public function set holder(a:*):void
		{
			if(a != _holder)
			{
				_holder = a;
			}
		}
		
		public function get itemsHolder():*
		{
			return _itemsHolder;
		}
		public function set itemsHolder(a:*):void
		{
			if(a != _itemsHolder)
			{
				_itemsHolder = a;
			}
		}
		
		
		
		
		/**
		 * indicates the vertical direction.
		 * @default Direction.TOP_TO_BOTTOM
		 * @see Direction
		 */
		public function get vDirection():String
		{
			return _vDirection;
		}
		/**
		 * @private
		 */
		public function set vDirection(a:String):void
		{
			if(a != _vDirection)
			{
				_vDirection = a;
			}
		}
		
		/**
		 * indicates the horizontal direction.
		 * @default Direction.LEFT_TO_RIGHT
		 * @see Direction
		 */
		public function get hDirection():String
		{
			return _hDirection;
		}
		/**
		 * @private
		 */
		public function set hDirection(a:String):void
		{
			if(a != _hDirection)
			{
				_hDirection = a;
			}
		}
		
		/**
		 * indicates the row.
		 * @default 1
		 */
		public function get row():int
		{
			return _row;
		}
		/**
		 * @private
		 */
		public function set row(a:int):void
		{
			if(a != _row)
			{
				_row = a;
			}
		}
		
		/**
		 * if <code>true</code>, item will be added under the previous items,
		 * if <code>false</code>, item will be added upon the previous items.
		 * @default false
		 */
		public function get reverseAddChild():Boolean
		{
			return _reverseAddChild;
		}
		/**
		 * @private
		 */
		public function set reverseAddChild(a:Boolean):void
		{
			_reverseAddChild = a;
		}
		
		/**
		 * if <code>true</code>, and if row is more than 1, items in rows will be right next to each other,
		 * if <code>false</code>, and if row is more than 1, items in the next rows will be added according to the biggest item in the previous row.
		 * @default true
		 */
		public function get compactArrange():Boolean
		{
			return _compactArrange;
		}
		/**
		 * @private
		 */
		public function set compactArrange(a:Boolean):void
		{
			_compactArrange = a;
		}
		
		/**
		 * indicates the space between the items.
		 * @default 5
		 */
		public function get space():Number
		{
			return _space;
		}
		/**
		 * @private
		 */
		public function set space(a:Number):void
		{
			_space = a;
		}
		
		/**
		 * indicates the horizontal space between the items.
		 * @default 0
		 */
		public function get spaceX():Number
		{
			return _spaceX;
		}
		/**
		 * @private
		 */
		public function set spaceX(a:Number):void
		{
			_spaceX = a;
		}
		
		/**
		 * indicates the vertical space between the items.
		 * @default 0
		 */
		public function get spaceY():Number
		{
			return _spaceY;
		}
		/**
		 * @private
		 */
		public function set spaceY(a:Number):void
		{
			_spaceY = a;
		}
		
		
		
		
		/**
		 * indicates the type of orientation.
		 * @default Orientation.VERTICAL
		 * @see Orientation
		 */
		public function get orientation():String
		{
			return _orientation;
		}
		/**
		 * @private
		 */
		public function set orientation(a:String):void
		{
			if(a != _orientation)
			{
				_orientation = a;
				
				if (_rows) _rows.splice(0);
				_firstArrange = true;
				itemArrange();
			}
		}
		
		public function get idCount():int
		{
			return _idCount;
		}
		
		public function get rows():Array
		{
			return _rows;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function get data():Object
		{
			return _data;
		}
		public function set data(a:Object):void
		{
			_data = a;
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}