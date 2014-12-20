package com.curve
{
	// adobe
	import flash.display.Sprite
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	//
	// own
	//
	/*
	 * Curve - Version 1.1
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
				if(!curve.stop) curve.draw(); //@debug
				if ( Keys.press(curve.leftKey) ) curve.direction = -1;
				else if ( Keys.press(curve.rightKey) ) curve.direction = 1;
				else curve.direction = 0;
			}
		}
		
		private function createCurve(xpos:Number, ypos:Number):void {
			var curve:Curve = new Curve(xpos, ypos);
			curve.color = Math.random() * 0xffffff;
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