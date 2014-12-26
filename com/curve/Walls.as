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
		//
		public function Walls(w:Number, h:Number):void{
			var size = 5;
			var color = 0x555555;
			this.graphics.lineStyle(size, color, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER );
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(w,0);
			this.graphics.lineTo(w,h);
			this.graphics.lineTo(0,h);
			this.graphics.lineTo(0,0);
		}
	}//end-class
}//end-pack