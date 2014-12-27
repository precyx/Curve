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
	public class Unlock extends Powerup
	{
		//
		//
		//
		public function Unlock():void{
			super(Powerup.GLOBAL_MODE, 8000, "resources/curve/powerups/unlock_powerup.swf");
			this.name = "Clear All Curves";
		}
		// Publics
		override public function powerupStart(triggerCurve:Curve):void {
			super.powerupStart(triggerCurve);
			Controller.curveController.walls.active = false;
		}
		override protected function powerupEnd(e:TimerEvent):void {
			super.powerupEnd(e);
			// Wenn Unlock schon aktiv ist dann wird es nicht überschrieben
			var activePowerups = Controller.powerupController.activePowerups;
			for each ( var powerup:Powerup in activePowerups ) {
				if (powerup is Unlock) return;
			}
			Controller.curveController.walls.active = true;
		}
	}//end-class
}//end-pack