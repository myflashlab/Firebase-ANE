/**
	 * 
	 * @author Lu Aye Oo
	 * 
	 * Thread.
	 * 
	 * *What is it?*:
	 * 
	 * Flash runs in a single thread. Which means if you execute an intensive script, 
	 * flash would lag/un-respond until your script finishes.
	 * You would want to spread the process over a number of frames to avoid this lag.
	 * 
	 * This class allows you to call a function over and over again while keeping the frameRate 
	 * and interface response fairly stable and also avoid falling into script timeout.
	 * 
	 * 
	 * *Example use*:
	 * 
	 * I used this for 'path finding' which can take between 10ms to 1000ms (depending on map size).
	 * I don't want user to lag out everytime they choose a path.
	 * instead I trade it off by taking 1-10 frames for path to be found.
	 * 
	 * In an arcade style game, I needed to pre render the background + static objects into tiled bitmaps
	 * Some long levels takes quite a long time to render so using Thread lets me spread the process and 
	 * have a smoother 'building' screen animation (rather than a stucked/lagged screen).
	 * 
	 * 
	 * *When you shouldn't use*:
	 * - If you want the outcome of the process straight away, this will not always delivery -
	 * 	 because it will spread your function calls over a number of frames if needed.
	 * 
	 * 
	 * *To be careful*:
	 * - This class DOES NOT stop the function from excuting half way through. 
	 * 	 It only spreads the time between each function call (when needed).
	 * - If your process is not only a 'loop' you could make a function that manage the sequence
	 * 	 in which it should excute by looking at 'steps' to know which step of thread you are on.
	 * - You can call multiple Threads to execute at the same time - However each thread does not share
	 * 'givenTime' with others so you will need to manage it for better processing spread.
	 * 
	 * 
	 * *Example Code*:
	 * 
	 * Example below is using Thread to increament an integer 'n' up to 500,000
	 * giving 20 ms per frame to excute (it let go a frame when 20ms is passed).
	 * Change countUpTo var if you are getting 1-2 frames/threadStep - your machine must be fast then!
	 * 

	 	import com.luaye.utils.thread.Thread;

		var countUpTo:int = 500000;
		var traceEvery:int = 20000;

		new Thread(stepFun, {n:0}, false, 20);

		function stepFun(thread:Thread):void{
			var vars:Object = thread.vars;
			vars.n++;
			if(vars.n%traceEvery == 0){
				trace("n = ", vars.n, ", threadStep = ", thread.threadSteps);
			}
			if(vars.n >= countUpTo){
				// need to call end() to stop executing.
				thread.end();
				trace("Ended process after "+thread.threadSteps+" frames/threadSteps");
			}
		}

	 * 
	 */
	 
package com.luaye.utils.thread {
	import flash.display.Shape;	
	import flash.events.Event;	
	import flash.utils.getTimer;
	
	
	public class Thread {
		
		private static var _Threads:Array = [];
		// this is used to store the refernce to all threads (unless it was chosen to be 'weak')
		// Because threads without any reference elsewhere can get garbage collected before finishing.
		
		
		private var _maxTime:uint = 10;
		private var _steps:uint;
		private var _threadSteps:uint;
		private var _step:Function;
		private var _excuting:Boolean;
		private var _weak:Boolean;
		// uses Shape's enterFrame event to know the ticks... don't know other way - Timer doesnt work as good as this way...
		// Shape is more lightweight than Sprite, etc, I THINK
		private var _ticker:Shape;
		//

		public var vars:Object;
		
		
		/*
		 * stepFun: Step function. example: function threadStep(thread:Thread):void {...}
		 * vars: variables to keep with thread (optional)
		 * m: manual control? if true, you need to call step() to execute each frame/step
		 * maxt: maximum time given per step
		 * weak: if true it can get garbage collected before function end unless you keep the Thread's reference.
		 *       (it is better practice to make it weak and keep the thread's reference in your code to prevent from 
		 *       being garbage collected. This way, if the code that keeps the thread is garbage collected, the thread
		 *       will also go with it - rather than it keep holding on till it end for nothing.
		 */
		public function Thread(stepFun:Function, vrs:Object = null, m:Boolean = false, maxt:uint = 20, weak:Boolean = false){
			if(stepFun == null){
				throw new Error("Thread: step Function can not be null");
			}
			_step = stepFun;
			vars = vrs;
			maxTime = maxt;
		 	manual = m;
		 	//
		 	_weak = weak;
			if(!weak){
				_Threads.push(this);
			}
		}
		
		/*
		 * Excute thread step
		 * You can manually call this to force run the excutition.
		 * You can not exactly control how many times you want to call your step function
		 * It will keep calling till it run out of your 'givenTime' OR 'maxTime' OR when 'thread.end()'
		 * leave param blank (or 0) to use default time.
		 * 
		 */
		public function step(givenTime:uint = 0):int{
			if(_excuting || _step == null) return -1;
			if(givenTime == 0) givenTime = _maxTime;
			_excuting = true;
			_threadSteps++;
			var st:uint = getTimer();
			var tt:uint = 0;
			do{
				_steps++;
				try{
					_step(this);
				} catch(e:Error){
					throw new Error("Thread: There was a problem running the step function at step "+_step);
				}
				tt = getTimer()-st;
			}while(_step != null && tt < givenTime);
			_excuting = false;
			return tt;
		}
		/*
		 * End excution
		 * You need to call this when you no longer want to run the thread
		 * This also cleans up it self so calling '.vars' OR '.step()' after ending will fail.
		 */
		public function end():void{
			manual = true;
			vars = null;
			if(_step != null){
				_step = null;
				if(!_weak){
					var ind:int = _Threads.indexOf(this);
					if(ind>=0){
						_Threads.splice(ind,1);
					}
				}
			}
		}
		public function get excuting():Boolean{
			return _excuting;
		}
		// how many times it has called step() function
		public function get steps():uint{
			return _steps;
		}
		// how many thread frames/steps it has passed
		public function get threadSteps():uint{
			return _threadSteps;
		}
		public function get ended():Boolean{
			return _step == null;
		}
		public function get weak():Boolean{
			return _weak;
		}
		public function get maxTime():uint{
			return _maxTime;
		}
		public function set maxTime(n:uint):void{
			_maxTime = n<1?1:n;
		}
		//
		// Once set to manual, you have to call step() to excute manually
		public function set manual(b:Boolean):void{
			if(b && _ticker){
				_ticker.removeEventListener(Event.ENTER_FRAME, onTick);
				_ticker = null;
			}else if(!b && !_ticker){
				_ticker = new Shape();
				_ticker.addEventListener(Event.ENTER_FRAME, onTick, false, 0, true);
			}
		}
		public function get manual():Boolean{
			return (_ticker==null);
		}


		private function onTick(e:Event):void{
			step();
		}
	}
}
