package com.curve
{
	// adobe
	import flash.display.Bitmap;
	import flash.display.Sprite
	import flash.display.DisplayObjectContainer
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.utils.setTimeout;
	//
	// curve
	import com.curve.SkyCollisionDetection;
	import com.curve.powerup.Powerup;
	import com.curve.powerup.PowerupController;
	//
	/*
	 * Curve - Version 1.3
	 * Controller
	 */
	public class CurveController extends Sprite
	{
		//
		private var controller:Controller;
		private var curves:Vector.<Curve>;
		private var walls:Walls;
		//
		// @debug
		public var size:Number;
		public var speed:Number;
		public var curviness:Number;
		public var numCurves:Number =1;
		public var holesize:Number;
		public var debug:Boolean;
		public var colors:Array = [0xff4537, 0xff4fed, 0xffc72e, 0x63ba00, 0x00adb8, 0x7ba6ff, 0x842bff, 0xff9c03];
		private var colorIndex:uint = 0;
		//
		//
		public function CurveController(controller:Controller):void {
			this.controller = controller;
			initVars();
			//
			createCurve( 400, 250);
			//
			addEventListener(Event.ENTER_FRAME, loopCurves);
		}
		private function initVars():void {
			SkyCollisionDetection.registerRoot(View.getStage());
			curves = new Vector.<Curve>();
			var sw:Number = View.getStage().stageWidth;
			var sh:Number = View.getStage().stageHeight;
			walls = new Walls(sw, sh);
			View.getCurveLayer().addChild(walls);
			//walls.x = View.getStage().stageWidth - walls.width;
		}
		private function loopCurves(e:Event):void {
			for each( var curve:Curve in curves) {
				// @todo powerup collision
				for each( var powerup:Powerup in Controller.powerupController.powerups ) {
					if (SkyCollisionDetection.bitmapHitTest(curve.hitbox, powerup)) {
						Controller.powerupController.activate(powerup, curve);
					}
				}
				// @todo curve collision
				for each ( var curve2:Curve in curves) {
					if (SkyCollisionDetection.bitmapHitTest(curve.hitbox, curve2)) {
						curve.stop = true;
						//remove(curve);
					}
				}
				// @todo walls collision
				if (SkyCollisionDetection.bitmapHitTest(curve, walls)) {
					//remove(curve);
					curve.stop = true;
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
			if ( this.debug) curve.debug = this.debug;
			//
			View.getCurveLayer().addChild(curve);
			curves.push(curve);
		}
		
		
		// publics
		public function restart():void {
			for each(var curve:Curve in curves) {
				curve.restart();
			}
		}
		public function remove(curve:Curve):void {
			curves.splice(curves.indexOf(curve), 1);
			curve.stop = true;
			curve.dispose();
			View.getCurveLayer().removeChild(curve);
		}
		public function removeAll():void {
			for each(var curve:Curve in curves) {
				curve.dispose();
				View.getCurveLayer().removeChild(curve);
				curve = null;
			}
			curves = new Vector.<Curve>();
		}
		public function clearAll():void {
			for each(var curve:Curve in curves) {
				curve.clear();
			}
		}
		// @debug
		public function createNum(n:uint):void {
			make(n, function(){ createCurve( 400, 250); });
		}
		public function createAll():void {
			if(this.numCurves) make(this.numCurves, function(){ createCurve( Math.random() * 500, Math.random() * 500); });
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