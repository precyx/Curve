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
	 * Reverse - Version 1.3
	 * View & Model
	 */
	public class Reverse extends Powerup
	{
		//
		//
		//
		public function Reverse(mode = Powerup.ENEMY_MODE):void {
			if (mode == Powerup.SELF_MODE){}
			else if (mode == Powerup.ENEMY_MODE){}
			else mode = null;
			super(mode, Powerup.NORMAL_DURATION, "resources/curve/powerups/reverse_powerup.swf");
			this.name = "Reverse Keyboard Control";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			// Wenn Reverse schon aktiv ist dann wird es nicht überschrieben
			// @refractoring
			var activePowerups = Controller.powerupController.activePowerups;
			for each ( var powerup:Powerup in activePowerups ) {
				if (powerup is Reverse) return;
			}
			for each( var curve:Curve in affectedCurves) {
				curve.reverseKeys = true;
			}
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			// Wenn Reverse schon aktiv ist dann wird es nicht überschrieben
			// @refractoring
			var activePowerups = Controller.powerupController.activePowerups;
			for each ( var powerup:Powerup in activePowerups ) {
				if (powerup is Reverse) return;
			}
			for each( var curve:Curve in affectedCurves) {
				curve.reverseKeys = false;
			}
		}
	}//end-class
}//end-pack