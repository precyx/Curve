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
	public class Ant extends Powerup
	{
		//
		//
		//
		public function Ant():void{
			super(Powerup.SELF_MODE, 5000, "resources/curve/powerups/ant_powerup.swf");
			this.name = "Slower";
		}
		// Publics
		override public function powerupStart(curve:Curve):void {
			super.powerupStart(curve);
			curve.size /= 1.5;
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			for each( var curve:Curve in affectedCurves) {
				curve.size *= 1.5;
			}
		}
	}//end-class
}//end-pack