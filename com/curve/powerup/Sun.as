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
	public class Sun extends Powerup
	{
		//
		//
		//
		public function Sun():void{
			super(Powerup.GLOBAL_MODE, 1, "resources/curve/powerups/sun_powerup.swf");
			this.name = "Clear All Curves";
		}
		// Publics
		override public function powerupStart(curve:Curve):void {
			super.powerupStart(curve);
			Controller.curveController.clearAll();
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
		}
	}//end-class
}//end-pack