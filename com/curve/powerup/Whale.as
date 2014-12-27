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
	public class Whale extends Powerup
	{
		//
		//
		//
		public function Whale(mode:String):void{
			var imgpath:String;
			if (mode == Powerup.SELF_MODE) imgpath = "resources/curve/powerups/whale_powerup.swf";
			else if (mode == Powerup.ENEMY_MODE) imgpath = "resources/curve/powerups/whale_enemy_powerup.swf";
			super(mode, Powerup.NORMAL_DURATION, imgpath);
			this.name = "Bigger";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			for each( var curve:Curve in affectedCurves) {
				curve.size *= 1.5;
			}
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			for each( var curve:Curve in affectedCurves) {
				curve.size /= 1.5;
			}
		}
	}//end-class
}//end-pack