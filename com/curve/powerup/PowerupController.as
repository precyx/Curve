

package com.curve.powerup
{
	// adobe
	import flash.display.DisplayObject;
	import flash.display.Sprite
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	//
	// curve
	import com.kiko.utils.Math2;
	import com.curve.GameEvent;
	import com.curve.Curve;
	//
	/*
	 * Powerup - Version 1.2
	 * Controller
	 */
	public class PowerupController extends Object
	{
		//
		private var stage:Stage;
		public var powerups:Vector.<Powerup>;
		public var activePowerups:Vector.<Powerup>;
		private var timer:Timer;
		//
		//
		public function PowerupController():void {
			this.stage = View.getStage();
			powerups = new Vector.<Powerup>();
			activePowerups = new Vector.<Powerup>;
			//
			timer = new Timer(Math2.rand(500, 1000));
			//timer.start();
			timer.addEventListener(TimerEvent.TIMER, timertick);
		}
		private function timertick(e:TimerEvent):void {
			timer.delay = Math2.rand(500, 1000);
			createRandom();
		}
		
		// Publics
		public function createRandom():void {
			var i:uint = Math2.rand(0, 9);
			var powerup:Powerup;
			//powerup = new Sun(Powerup.SELF_MODE);
			//if (i > 3) powerup = new Unlock();
			//
			//powerup = new Reverse(Powerup.SELF_MODE);
			//
			if(1){ //@refractoring
			if (i == 0) powerup = new Whale(Powerup.ENEMY_MODE);
			if (i == 1) powerup = new Flash(Powerup.SELF_MODE);
			if (i == 2) powerup = new Ant(Powerup.SELF_MODE);
			if (i == 3) powerup = new Snail(Powerup.ENEMY_MODE);
			if (i == 4) powerup = new Sun(Powerup.GLOBAL_MODE);
			if (i == 5) powerup = new Unlock();
			if (i == 6) powerup = new Ghost();
			if (i == 7) powerup = new Reverse();
			if (i == 8) powerup = new Whale(Powerup.SELF_MODE);
			}
			powerup.x = Math.random() * stage.stageWidth;
			powerup.y = Math.random() * stage.stageHeight;
			powerups.push(powerup);
			View.getPowerupLayer().addChild(powerup);
		}
		public function activate(powerup:Powerup, triggerCurve:Curve):void {
			if (!powerup.active && isAllowed(powerup)) {
				// powerup modes
				if (powerup.mode == Powerup.SELF_MODE) {
					powerup.affectedCurves.push(triggerCurve);
				}
				else if (powerup.mode == Powerup.ENEMY_MODE) {
					powerup.affectedCurves = Controller.curveController.getAllExcept(triggerCurve);
				}
				else if (powerup.mode == Powerup.GLOBAL_MODE) {
					powerup.affectedCurves = Controller.curveController.getAll();
				}
				// start powerup
				for each( var affectedCurve:Curve in powerup.affectedCurves ) {
					affectedCurve.addPowerupTimer(powerup);
				}
				powerup.powerupStart(triggerCurve);
				activePowerups.push(powerup);
				powerup.addEventListener(GameEvent.POWERUP_END, powerupEnd);
			}
		}
		private function powerupEnd(e:GameEvent):void { //@event
			var powerup:Powerup = (e.target as Powerup);
			for each(var curve:Curve in powerup.affectedCurves) {
				curve.removePowerupTimer(powerup);
			}
			powerup.rotation = 90;
			activePowerups.splice(activePowerups.indexOf(powerup), 1);
			powerups.splice(powerups.indexOf(powerup), 1);
			View.getPowerupLayer().removeChild(powerup);
			//trace(powerups.length); //@debug
		}
		public function isAllowed(powerup:Powerup):Boolean {//@naming
			if (activePowerups.length == 0) return true;
			/*if ( powerup.stackable ) return true;
			else {
				for each( var p:Powerup in activePowerups) {
					if ( p.name == powerup.name ) return false;
				}
			}*/ //@feature stackable
			return true;
		}
		
		
	}//end-class
}//end-pack