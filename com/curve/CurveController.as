package com.curve
{
	// adobe
	import flash.display.Sprite
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	//
	// curve
	import com.curve.powerup.Powerup;
	import com.curve.powerup.PowerupController;
	//
	/*
	 * Curve - Version 1.2
	 * Controller
	 */
	public class CurveController extends Sprite
	{
		//
		private var controller:Controller;
		private var curves:Vector.<Curve>;
		//
		// @debug
		public var size:Number;
		public var speed:Number;
		public var curviness:Number;
		public var numCurves:Number =1;
		public var holesize:Number;
		public var colors:Array = [0xff4537, 0xff4fed, 0xffc72e, 0x63ba00, 0x00adb8, 0x7ba6ff, 0x842bff, 0xff9c03];
		private var colorIndex:uint = 0;
		//
		//
		public function CurveController(controller:Controller):void {
			this.controller = controller;
			initVars();
			addEventListener(Event.ENTER_FRAME, loopCurves);
			//
			make(1, function(){
				//createCurve( 300, Math.random() *500);
				createCurve( 400, 250);
			});
		}
		
		private function initVars():void {
			curves = new Vector.<Curve>();
		}
		
		private function loopCurves(e:Event):void {
			for each( var curve:Curve in curves) {
				// @todo collision detection
				for each( var powerup:Powerup in controller.powerupController.powerups ) {
					
					if (curve.hitbox.hitTestObject(powerup)) {
						controller.powerupController.activate(powerup, curve);
					}
				}
				//
				if (!curve.stop) curve.draw(); //@debug
				// keys
				if ( Keys.press(curve.leftKey) ) curve.direction = -1;
				else if ( Keys.press(curve.rightKey) ) curve.direction = 1;
				else curve.direction = 0;
			}
		}
		
		private function createCurve(xpos:Number, ypos:Number):void {
			var curve:Curve = new Curve(xpos, ypos);
			
			curve.color = colors[colorIndex];
			colorIndex++;
			if (colorIndex >= colors.length) colorIndex = 0;
			// @debug
			if(this.speed) curve.speed = this.speed;
			if(this.size) curve.size = this.size;
			if (this.curviness) curve.curviness = this.curviness;
			if (this.holesize) curve.holesize = this.holesize;
			//
			View.getStage().addChild(curve);
			curves.push(curve);
		}
		
		public function restart():void {
			for each(var curve:Curve in curves) {
				curve.restart();
			}
		}
		public function removeAll():void {
			for each(var curve:Curve in curves) {
				View.getStage().removeChild(curve);
				curve = null;
			}
			curves = new Vector.<Curve>();
		}
		// @debug
		public function createNum(n:uint):void {
			make(n, function(){ createCurve( 400, 250); });
		}
		public function createAll():void {
			if(this.numCurves) make(this.numCurves, function(){ createCurve( 400, 250); });
		}
		public function stopAll():void {
			for each( var curve:Curve in curves) {
				curve.stop = true;
			}
		}
		
		// helpers
		private function make(max:uint, func:Function) {
			for ( var i:uint = 0; i < max; i++) func();
		}
		
	}//end-class
}//end-pack