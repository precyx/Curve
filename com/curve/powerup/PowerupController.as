package com.curve.powerup
{
	// adobe
	import flash.display.Sprite
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
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
		private var controller:Controller;
		private var timer:Timer;
		//
		//
		public function PowerupController(controller:Controller):void {
			this.controller = controller;
			this.stage = View.getStage();
			powerups = new Vector.<Powerup>();
			//
			timer = new Timer(Math2.rand(500, 1000));
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, timertick);
		}
		
		public function timertick(e:TimerEvent):void {
			timer.delay = Math2.rand(500, 1000);
			createRandom();
		}
		
		public function createWhale():void {
			var p:Whale = new Whale();
			View.getStage().addChild(p);
			p.x = Math.random() * stage.stageWidth;
			p.y = Math.random() * stage.stageHeight;
			powerups.push(p);
		}
		public function createRandom():void {
			var i:uint = Math2.rand(0, 5);
			var powerup:Powerup;
			if (i == 0) powerup = new Whale();
			if (i == 1) powerup = new Flash();
			if (i == 2) powerup = new Ant();
			if (i == 3) powerup = new Snail();
			if (i == 4) powerup = new Sun();
			powerup.x = Math.random() * stage.stageWidth;
			powerup.y = Math.random() * stage.stageHeight;
			powerups.push(powerup);
			View.getPowerupLayer().addChild(powerup);
		}
		
		public function activate(powerup:Powerup, curve:Curve):void {
			if (!powerup.active) {
				curve.addPowerupTimer(powerup);
				powerup.powerupStart(curve);
				powerup.addEventListener(GameEvent.POWERUP_END, powerupEnd);
			}
		}
		
		private function powerupEnd(e:GameEvent):void {
			var powerup:Powerup = (e.target as Powerup);
			for each(var curve:Curve in powerup.affectedCurves) {
				curve.removePowerupTimer(powerup);
			}
			powerup.rotation = 90;
			powerups.splice(powerups.indexOf(powerup), 1);
			View.getPowerupLayer().removeChild(powerup);
			trace(powerups.length);
		}
		
		//@cleanup
		public function create(type:String):void {
			//var powerup:Powerup = new Powerup();
			//View.getStage().addChild(powerup);
		}
	}//end-class
}//end-pack