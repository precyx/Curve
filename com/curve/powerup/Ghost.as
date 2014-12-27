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
	 * Unlock - Version 1.3
	 * View & Model
	 */
	public class Ghost extends Powerup
	{
		//
		//
		//
		public function Ghost():void{
			super(Powerup.SELF_MODE, Powerup.NORMAL_DURATION, "resources/curve/powerups/ghost_powerup.swf");
			this.name = "Invincible";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			for each( var curve:Curve in affectedCurves) {
				curve.itemghost = true;
			}
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			// Wenn Ghost schon aktiv ist dann wird es nicht überschrieben
			// @refractoring
			var activePowerups = Controller.powerupController.activePowerups;
			for each ( var powerup:Powerup in activePowerups ) {
				if (powerup is Ghost) return;
			}
			for each( var curve:Curve in affectedCurves) {
				curve.itemghost = false;
			}
		}
	}//end-class
}//end-pack