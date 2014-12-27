package com.curve
{
	// adobe
	import flash.display.Shape;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	//
	// own
	//
	/*
	 * Walls - Version 1.0
	 * View
	 */
	public class Walls extends Shape
	{
		//
		private var _active:Boolean;
		//
		//
		public function Walls(w:Number, h:Number):void {
			_active = true;
			var size = 5;
			var color = 0x555555;
			this.graphics.lineStyle(size, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER );
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(w,0);
			this.graphics.lineTo(w,h);
			this.graphics.lineTo(0,h);
			this.graphics.lineTo(0,0);
		}
		
		public function set active(a:Boolean):void {
			if (a) this.alpha = 1;
			else this.alpha = 0.3;
			_active = a;
		}
		public function get active():Boolean {
			return _active;
		}
	}//end-class
}//end-pack