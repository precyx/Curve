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
	 * Snail - Version 1.3
	 * View & Model
	 */
	public class Snail extends Powerup
	{
		//
		//
		//
		public function Snail(mode:String):void {
			var imgpath:String;
			if (mode == Powerup.SELF_MODE) imgpath = "resources/curve/powerups/snail_powerup.swf";
			else if (mode == Powerup.ENEMY_MODE) imgpath = "resources/curve/powerups/snail_enemy_powerup.swf";
			else mode = null;
			super(mode, Powerup.NORMAL_DURATION, imgpath);
			this.name = "Slower";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			for each( var curve:Curve in affectedCurves) {
				curve.speed /= 1.5;
			}
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			for each( var curve:Curve in affectedCurves) {
				curve.speed *= 1.5;
			}
		}
	}//end-class
}//end-pack