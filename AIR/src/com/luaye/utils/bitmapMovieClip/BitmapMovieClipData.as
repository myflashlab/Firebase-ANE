/**
	 * @author Lu Aye Oo | www.luaye.com
	 * 
	 * BitmapMovieClipData
	 * 
	 * This is an info class for use with BitmapMovieClip.
	 * See BitmapMovieClip for details.
	 * 
*/

package com.luaye.utils.bitmapMovieClip {
	
	public class BitmapMovieClipData{
		
		public var frames:Array;
		public var labels:Object;
		
		public function BitmapMovieClipData(frames:Array,labels:Object = null){
			this.frames = frames;
			if(labels){
				this.labels = labels;
			}else{
				this.labels = new Object();
			}
		}
		
	}
	
}