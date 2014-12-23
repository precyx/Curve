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
	public class Flash extends Powerup
	{
		//
		//
		//
		public function Flash():void{
			super(Powerup.SELF_MODE, 5000, "resources/curve/powerups/flash_powerup.swf");
			this.name = "Faster";
		}
		// Publics
		override public function powerupStart(curve:Curve):void {
			super.powerupStart(curve);
			curve.speed *= 1.5;
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			for each( var curve:Curve in affectedCurves) {
				curve.speed /= 1.5;
			}
		}
	}//end-class
}//end-pack