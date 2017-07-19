package com.doitflash.tools
{
	//import com.luaye.console.C;
	/**
	 * With the help of this class you can convert strings into function calls.
	 * your string must be in the following format, as you can see, we have the function name as <code>myFunc</code>
	 * and you may optionally send different styles of arguments to that function, it supports arguments in form of
	 * simple strings, arrays or objects.
	 * <code>myFunc(val1,val2,[arr1,arr2,arr3],{var1:value1,var2:value2,var3:value3})</code>
	 * 
	 * 
	 * 	function myFunc($str1:String, $str2:String, $arr:Array, $obj:Object):void
	 *	{
	 *		trace($str1);
	 *		trace($str2);
	 *		trace($arr);
	 *		trace($obj);
	 *	}
	 * 
	 * 
	 * @author Hadi Tavakoli - 9/11/2010 1:32 PM
	 * @author Hadi Tavakoli - Modified - 5/14/2011 5:34 PM
	 * @author Hadi Tavakoli - Modified - 8/30/2011 6:56 PM
	 * @example The following example shows how a string is converted to an actuall function call.
	 * 
	 * <listing version="3.0">
	 * var myString:String = "myFunc(value,value2,[arr1,arr2,arr3],{var1:value1,var2:value2,var3:value3})";
	 * var df:DynamicFunc = new DynamicFunc(myString);
	 * this[df.funcName].apply(null, df.inputs);
	 * 
	 * function myFunc($str1:String, $str2:String, $arr:Array, $obj:Object):void
	 * {
	 * 		trace($str1);
	 * 		trace($str2);
	 * 		trace($arr);
	 * 		trace($obj);
	 * }
	 * </listing>
	 */
	public class DynamicFunc 
	{
		private var _funcName:String;
		private var _inputs:Array = [];
		
		public static const OBJECT_PATTERN:RegExp = /[\w_!.@\$\?%]+:[\w_!.@\$\?%\s\/\[\]]+/g;
		public static const STRING_PATTERN_FOR_OBJECT:RegExp = /[\w_!.@\$\?%\s\/\[\]]+/g;
		public static const STRING_PATTERN:RegExp = /[\w_!:.@\$\?%\s\/\(\)'-]+/g;
		
		/**
		 * initialize the class and send your <code>string</code> to be converted to a function call.
		 * @param	$str
		 * 
		 * @see		#funcName
		 * @see		#inputs
		 */
		public function DynamicFunc($str:String):void
		{
			//required patterns for analyzing the string
			var funcPattern:RegExp = /[\w_]+/;
			var valuePattern:RegExp = /\[?\{?((([\w_!.@\$\?%]+):?([\w_!.@\$\?%\s\/]+)?),?\s?)+\}?\]?/g;
			//var stringPattern:RegExp = /[\w_!:.@\$\?%\s\/]+/g;
			//var stringPatternForObject:RegExp = /[\w_!.@\$\?%\s\/]+/g;
			//var objectPattern:RegExp = /[\w_!.@\$\?%]+:[\w_!.@\$\?%\s\/]+/g;
			
			// save the function name in string
			_funcName = $str.match(funcPattern)[0];
			
			// overwrite the raw string and remove the function name from the beggining
			$str = $str.replace(_funcName, "");
			
			// identify different kinds of inputs and save them in an array
			var rawValues:Array = $str.match(valuePattern);
			
			for (var i:int = 0; i < rawValues.length; i++ )
			{
				var curr:String = rawValues[i];
				
				if (curr.charAt(0) == "[")
				{
					// save the input as an array
					_inputs.push(curr.match(DynamicFunc.STRING_PATTERN));
				}
				else if (curr.charAt(0) == "{")
				{
					// save the input as an object
					var finalObject:Object = {};
					var objMatchArray:Array = curr.match(DynamicFunc.OBJECT_PATTERN);
					for (var k:int = 0; k < objMatchArray.length; k++ )
					{
						var eachPair:Array = objMatchArray[k].match(DynamicFunc.STRING_PATTERN_FOR_OBJECT);
						finalObject[eachPair[0]] = eachPair[1];
					}
					_inputs.push(finalObject);
				}
				else
				{
					// save the input as a string
					var curStringArr:Array = curr.match(DynamicFunc.STRING_PATTERN);
					for (var j:int = 0; j < curStringArr.length; j++ )
					{
						_inputs.push(curStringArr[j]);
					}
				}
			}
		}
		
		/**
		 * returns the function name in string type
		 */
		public function get funcName():String
		{
			return _funcName;
		}
		
		/**
		 * returns all arguments, if any, for the function.
		 */
		public function get inputs():Array
		{
			return _inputs;
		}
		
		public static function getObject($str:String):Object
		{
			var finalObject:Object = {};
			var objMatchArray:Array = $str.match(DynamicFunc.OBJECT_PATTERN);
			for (var k:int = 0; k < objMatchArray.length; k++ )
			{
				var eachPair:Array = objMatchArray[k].match(DynamicFunc.STRING_PATTERN_FOR_OBJECT);
				finalObject[eachPair[0]] = eachPair[1];
			}
			
			return finalObject;
		}
		
		public static function getArray($str:String):Array
		{
			return $str.match(DynamicFunc.STRING_PATTERN);
		}
		
		public static function run($delegate:*, $stringFunc:String):void
		{
			var inputs:Array = [];
			
			var funcPattern:RegExp = /[\w_]+/;
			var valuePattern:RegExp = /\[?\{?((([\w_!.@\$\?%]+):?([\w_!.@\$\?%\s\/'-]+)?),?\s?)+\}?\]?/g;
			
			// save the function name in string
			var funcName:String = $stringFunc.match(funcPattern)[0];
			
			// overwrite the raw string and remove the function name from the beggining
			$stringFunc = $stringFunc.replace(funcName, "");
			
			// identify different kinds of inputs and save them in an array
			var rawValues:Array = $stringFunc.match(valuePattern);
			
			var curr:String;
			for (var i:int = 0; i < rawValues.length; i++ )
			{
				curr = rawValues[i];
				
				if (curr.charAt(0) == "[")
				{
					// save the input as an array
					inputs.push(curr.match(DynamicFunc.STRING_PATTERN));
				}
				else if (curr.charAt(0) == "{")
				{
					// save the input as an object
					var finalObject:Object = {};
					var objMatchArray:Array = curr.match(DynamicFunc.OBJECT_PATTERN);
					
					for (var k:int = 0; k < objMatchArray.length; k++ )
					{
						var eachPair:Array = objMatchArray[k].match(DynamicFunc.STRING_PATTERN_FOR_OBJECT);
						finalObject[eachPair[0]] = eachPair[1];
					}
					
					inputs.push(finalObject);
				}
				else
				{
					// save the input as a string
					var curStringArr:Array = curr.match(DynamicFunc.STRING_PATTERN);
					for (var j:int = 0; j < curStringArr.length; j++ )
					{
						if (curStringArr[j] == "true")
						{
							inputs.push(true);
						}
						else if (curStringArr[j] == "false")
						{
							inputs.push(false);
						}
						else
						{
							inputs.push(curStringArr[j]);
						}
					}
				}
			}
			
			$delegate[funcName].apply(null, inputs);
		}
	}
	
}