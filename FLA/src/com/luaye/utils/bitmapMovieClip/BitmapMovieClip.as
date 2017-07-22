/**
	 * @author Lu Aye Oo | www.luaye.com
	 * 
	 * BitmapMovieClip.
	 * 
	 * What is it?:
	 * This class is essencially a Bitmap class that can hold sequence of BitmapData;
	 * 
	 * Imagine you have a lot (say 100s) of non-interactive movieclip that have the same animation
	 * (but not necerrially all show the same frame at the same time).
	 * If you make new movieClips to accompany all clips it will be very slow to render the vectors
	 * every frame...
	 * with BitmapMovieClip, it caches all the frames in the movieclip in an array of BitmapData and 
	 * use the same bitmapData across all instances. Therefore it only need to store a sequence of 
	 * BitmapData for an animation and get reused.
	 * 
	 * Advantages:
	 * - Doesnt have to duplicate bitmaps for the number of movieclips you need.
	 * - Very fast as it doesn't need to render vectors.
	 * - It got most functionality (and more) of MovieClip, such as play()/stop()/gotoAndPlay()
	 * - support labels
	 * 
	 * When you shouldn't use:
	 * - If your movieclip have simple vectors. There is no point to turn them into bitmapsData.
	 * - If there is only 1 frame in movieclip, just use Bitmap class.
	 * - Highly nested movieClips may not work as intended.
	 * - Scaling will pixelate, you can pre scale before generating the clip tho.
	 * 
	 * To be careful:
	 * If you make changes to the bitmapData of a frame in the sequence, it will update in all clips.
	 * 
	 * Example:
			import com.luaye.utils.bitmapMovieClip.*;
			
			var srcMC:MovieClip = new myClipFromLibrary();
			
			var clipData:BitmapMovieClipData = BitmapMovieClip.generate(srcMC, 150, 150);
			
			var mc:BitmapMovieClip = new BitmapMovieClip(clipData);
			addChild(mc);
			
			mc = new BitmapMovieClip(clipData);
			mc.x = 150;
			mc.loop = true;
			addChild(mc);
			
			mc = new BitmapMovieClip(clipData);
			mc.x = 300;
			mc.play(3,10);
			addChild(mc);
	 * 
	 */
	 
package com.luaye.utils.bitmapMovieClip {
	import flash.geom.Rectangle;	
	import flash.geom.Matrix;	
	import flash.display.*;
	import flash.events.Event;

	public class BitmapMovieClip extends Bitmap {
		
		// If you want to know when movieclip reached end
		public static const ENDED:String = "reachedEnd";
		
		private var _data:BitmapMovieClipData;
		private var _lastFrame:int = -1;
		private var _currentFrame:int = 0;
		private var _playing:Boolean = true;
		private var _manualUpdate:Boolean;
		
		//
		//
		//
		public var playingTo:int = 0; // playhead will stop on hitting this number, 0 = no stopping.
		public var useClone:Boolean; // if turned on, it will clone the BitmapData from original before updating
		public var loop:Boolean; // loop OR play once.
		
		
		//
		// This generates the BitmapMovieClipData required to run BitmapMovieClip
		// It captures all frames from the movieClip you pass in. 
		// You may need to pass in matrix with x and y if your source clip's origin is not at the top left.
		// Similar to params from BitmapData.draw();
		//
		public static function generate(mc:MovieClip, w:int = 0, h:int = 0, matrix:Matrix = null, clipRect:Rectangle = null):BitmapMovieClipData {
			if (w<=0) {
				w = mc.width;
			}
			if (h<=0) {
				h = mc.height;
			}
			var frames:Array = new Array();
			var len:int = mc.totalFrames;
			for (var i:int = 0; i < len; i++) {
				var bmd:BitmapData = new BitmapData(w, h, true, 0);
				bmd.draw(mc, matrix, null, null, clipRect, true);
				frames.push(bmd);
				mc.nextFrame();
			}
			var labels:Object = new Object();
			var currentLabels:Array = mc.currentLabels;
			for each(var label:FrameLabel in currentLabels){
				labels[label.name] = label.frame;
			}
			var data:BitmapMovieClipData = new BitmapMovieClipData(frames, labels);
			return data;
		}
		public function BitmapMovieClip(data:BitmapMovieClipData = null,clone:Boolean = false) {
			if (data) {
				setSource(data, clone);
			} else {
				_data = new BitmapMovieClipData([]);
			}
		}
		//
		//
		// Incase you want to change source BitmapMovieClipData on the fly.
		//
		public function setSource(data:BitmapMovieClipData,clone:Boolean = true):void {
			
			var frames:Array = data.frames;
			if (!frames || frames.length==0) {
				throw new Error("Requires an array of bitmaps to start BitmapMovieClip. Use BitmapMovieClip.generate(MovieClip) for ease of use.");
			}
			useClone = clone;
			_data = data;
			_lastFrame = -1;
			_currentFrame = _playing?-1:0;
			update();
			if(_playing){
				startUpdating();
			}
		}
		public function getSource():BitmapMovieClipData {
			return _data;
		}
		public function get manualUpdate():Boolean{
			return _manualUpdate;
		}
		//
		// If turned on, you need to call update() manually. 
		// Which is useful for games and such where you need to sync frame rate.
		//
		public function set manualUpdate(b:Boolean):void{
			if(_manualUpdate == b) return;
			_manualUpdate = b;
			if(b){
				stopUpdating();
			}else if(_playing){
				startUpdating();
			}
		}
		public function update(e:Event = null):void {
			if (_playing) {
				_currentFrame++;
				if (_currentFrame>=_data.frames.length) {
					if(loop){
						_currentFrame = 0;
					}else{
						_currentFrame--;
						dispatchEvent(new Event(ENDED));
						stop();
						return;
					}
				}
			}
			if (_currentFrame == (playingTo-1)) {
				_playing = false;
				playingTo = 0;
				stopUpdating();
			}
			if (_lastFrame != _currentFrame) {
				if (useClone) {
					bitmapData = _data.frames[_currentFrame].clone();
				} else {
					bitmapData = _data.frames[_currentFrame];
				}
				_lastFrame = _currentFrame;
			}
		}
		private function startUpdating():void{
			stopUpdating();
			if(!_manualUpdate){
				addEventListener(Event.ENTER_FRAME, update, false, 0 , true);
			}
		}
		private function stopUpdating():void{
			removeEventListener(Event.ENTER_FRAME, update);
		}
		// label name or frame number
		public function play(frame:Object = 0, to:Object = 0):void {
			_playing = true;
			playingTo = getFrameFromLabel(to);
			var from:int = getFrameFromLabel(frame)-1;
			goto(from);
			startUpdating();
		}
		// label name or frame number
		public function stop(frame:Object = 0):void {
			_playing = false;
			playingTo = 0;
			goto(getFrameFromLabel(frame)-1);
			stopUpdating();
			update();
		}
		public function get currentFrame():int {
			return _currentFrame - 1;
		}
		public function get totalFrames():int {
			return (_data&&_data.frames)?_data.frames.length:0;
		}
		public function get playing():Boolean {
			return _playing;
		}
		
		
		
		//
		private function goto(frame:int):void{
			if (frame>=0) {
				var max:int = _data.frames.length-1;
				_currentFrame = frame>max?max:(frame<0?0:frame);
			}
		}
		//
		private function getFrameFromLabel(frame:Object = "0"):int{
			var frameno:int = 0;
			if(isNaN(Number(frame))){
				if(_data.labels[frame] != undefined){
					frameno = _data.labels[frame];
				}
			}else{
				frameno = int(frame);
			}
			return frameno;
		}
	}
}