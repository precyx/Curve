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
			//
			make(1, function(){
				//createCurve( 300, Math.random() *500);
				createCurve( 400, 250);
			});
			
			addEventListener(Event.ENTER_FRAME, loopCurves);
			
		}
		
		private function initVars():void {
			curves = new Vector.<Curve>();
		}
		
		private function loopCurves(e:Event):void {
			for each( var curve:Curve in curves) {
				// @todo powerup collision
				for each( var powerup:Powerup in controller.powerupController.powerups ) {
					if (curve.hitbox.hitTestObject(powerup)) {
						controller.powerupController.activate(powerup, curve);
					}
				}
				
				// @todo curve collision
				for each ( var curve2:Curve in curves) {
						if (pixelCollision(curve, curve2.hitbox)) {
							//curve2.stop = true;
							remove(curve2);
							break;
							//curve2.alpha = 0.2;
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
		
		private function pixelCollision(clip1:DisplayObjectContainer, clip2:DisplayObjectContainer):Boolean {
			var collision;
			var twoRectangle:Rectangle = clip1.getBounds(clip1);// get bounds will only get it’s none rotate x,y,width,height
			var oneOffset = clip1.transform.matrix;
			// registation point always top left to make the bitmapdata draw every pixel of the movieclip.
			oneOffset.tx = (clip1.x - clip2.x)-twoRectangle.x;
			oneOffset.ty = (clip1.y - clip2.y)-twoRectangle.y;
			var twoClipBmpData = new BitmapData(twoRectangle.width, twoRectangle.height, true, 0);
			twoClipBmpData.draw(clip1, oneOffset);
			var oneRectangle = clip2.getBounds(clip2);
			var oneClipBmpData = new BitmapData(twoRectangle.width,twoRectangle.height, true, 0);
			var twoOffset = clip2.transform.matrix;
			twoOffset.tx = (clip2.x - clip2.x)-oneRectangle.x;
			twoOffset.ty = (clip2.y - clip2.y)-oneRectangle.y;
			oneClipBmpData.draw(clip2, twoOffset);
			var onePoint = new Point(oneRectangle.x, oneRectangle.y);
			var twoPoint = new Point(twoRectangle.x, twoRectangle.y);
			if(oneClipBmpData.hitTest(onePoint, 255, twoClipBmpData, twoPoint, 255)) {
				// pixels that have a slight alpha will not detect. make sure theres no alpha.
				collision = true;
			}
			twoClipBmpData.dispose();
			oneClipBmpData.dispose();
			return collision;
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
		
		
		// publics
		public function restart():void {
			for each(var curve:Curve in curves) {
				curve.restart();
			}
		}
		public function remove(curve:Curve):void {
			curves.splice(curves.indexOf(curve), 1);
			curve.dispose();
			View.getStage().removeChild(curve);
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
			if(this.numCurves) make(this.numCurves, function(){ createCurve( Math.random() * 500, 250); });
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