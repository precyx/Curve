package com.curve.powerup
{
	// adobe
	import flash.display.Sprite
	import flash.events.TimerEvent;
	//
	// curve
	import com.curve.GameEvent;
	import com.curve.Curve;
	//
	/*
	 * Sun - Version 1.3
	 * View & Model
	 */
	public class Sun extends Powerup
	{
		//
		//
		//
		public function Sun(mode:String):void{
			var imgpath:String;
			if (mode == Powerup.GLOBAL_MODE) imgpath = "resources/curve/powerups/sun_powerup.swf";
			else if (mode == Powerup.SELF_MODE) imgpath = "resources/curve/powerups/sun_self_powerup.swf";
			else mode = null;
			super(mode, 1, imgpath);
			this.name = "Clear All Curves";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			for each( var curve:Curve in affectedCurves) {
				curve.clear();
			}
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
		}
	}//end-class
}//end-pack