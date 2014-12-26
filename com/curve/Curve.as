package com.curve
{
	// adobe
	import com.curve.powerup.Powerup;
	import flash.desktop.Clipboard;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.display.CapsStyle;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	
	//
	import com.kiko.utils.Math2;
	//
	/*
	 * Curve - Version 1.4
	 * View & Model
	 */
	public class Curve extends Sprite
	{
		// consts
		private static const NORMAL_SPEED = 1.55; // std:1.55
		private static const NORMAL_SIZE = 7; // std:7
		private static const MIN_COLLISION_SIZE = 2;
		// interface
		public var xpos = 300;
		public var ypos = 100;
		public var curviness = 92; //std:92
		public var speed = Curve.NORMAL_SPEED;
		public var holesize = 160; // std:280
		public var holeMaxProbability = 5000; // std:5000
		public var direction = 0; // (0,1,-1)
		public var leftKey:uint = Keyboard.LEFT;
		public var rightKey:uint = Keyboard.RIGHT;
		// internal
		private var _size:Number = Curve.NORMAL_SIZE;
		private var _color:uint = 0xff00aa;
		private var radius = 0;
		private var angle = 0;
		private var _stop = false; // @debug
		private var _debug = false; // @debug
		private var i:uint = 0;
		//private var powerups:Vector.<Powerup>;
		// graphics
		private var circle:Shape;
		//private var powerupDisplay:Sprite;
		public var hitbox:Sprite;
		// ghost
		private var _ghost = false;
		private var timer:Timer;
		private var ghostchanged:Boolean = false;
		//
		//
		public function Curve(xpos:Number = 0, ypos:Number = 0):void {
			this.graphics.moveTo(xpos, ypos);
			this.xpos = xpos;
			this.ypos = ypos;
			angle = Math.random() * Math.PI * 2;
			//
			timer = new Timer(Math2.randFloat(200, holeMaxProbability));
			timer.addEventListener(TimerEvent.TIMER, ontime);
			timer.start();
			//
			circle = new Shape();
			View.getCurveLayer().addChild(circle);
			//
			hitbox = new Sprite();
			View.getCurveLayer().addChild(hitbox);
			hitbox.alpha = 0;
			//
			/*powerupDisplay = new Sprite();
			View.getCurveLayer().addChild(powerupDisplay);*/
			
		}
		public function draw():void {
			if (!ghost) {
				/* #2 lineto render method */
				if( i % 2 == 0){
					if (ghostchanged) {
						this.graphics.moveTo(xpos, ypos);
						ghostchanged = false;
					}
					this.graphics.lineTo(xpos, ypos);
				}
			}
			// powerup display
			/*for each(var powerup:Powerup in powerups) {
				powerupDisplay.
			}*/
			
			// circle
			circle.graphics.clear();
			circle.graphics.beginFill(color);
			circle.graphics.drawCircle(
			xpos - 1 * Math.sin(angle + Math.PI / 2), 
			ypos - 1 * Math.sin(angle), 
			size/2);
			// hitbox
			hitbox.graphics.clear();
			hitbox.graphics.beginFill(0x000000, 1.0);
			drawHalfCircle(hitbox.graphics, 0, 0, size / 2);
			hitbox.x = xpos + (0.001*size*size +1) * Math.sin(angle + Math.PI / 2);
			hitbox.y = ypos + (0.001*size*size +1) * Math.sin(angle);
			hitbox.rotation =  angle / (Math.PI*2) * 360 -90;
			//View.getCurveLayer().setChildIndex(hitbox, numChildren - 1);
			//
			// movement
			xpos += Math.cos(angle) * speed;
			ypos += Math.sin(angle) * speed;
			radius = curviness * (Math.sqrt(size)*0.3 + Math.sqrt(speed)*Math.sqrt(speed) );
			angle += direction * (Math.PI*2 / radius * speed);
			i++;			
		}
		// events
		private function ontime(e:TimerEvent):void {
			ghost = ! ghost;
			ghostchanged = true;
			if (ghost) { timer.delay = holesize * ((1/speed) + size*0.06); }
			else {  timer.delay = Math2.randFloat(200, holeMaxProbability); } //std:7000 
		}
		
		// privates
		private function drawHalfCircle(g:Graphics, x:Number, y:Number, r:Number):void {
			r = Math.max(r, Curve.MIN_COLLISION_SIZE);
			var c1:Number=r * (Math.SQRT2 - 1);
			var c2:Number=r * Math.SQRT2 / 2;
			g.moveTo(x+r,y);
			g.curveTo(x+r,y+c1,x+c2,y+c2);
			g.curveTo(x+c1,y+r,x,y+r);
			g.curveTo(x-c1,y+r,x-c2,y+c2);
			g.curveTo(x-r,y+c1,x-r,y);
		};
		
		// Publics
		public function restart():void { //@debug
			xpos = Math.random() * stage.stageWidth;
			ypos = Math.random() * stage.stageHeight;
			//angle = Math.random() * Math.PI*2;
			this.graphics.clear();
			this.graphics.lineStyle(size, color, 1, false, "normal", CapsStyle.NONE);
			this.graphics.moveTo(xpos, ypos);
		}
		/*public function addPowerupTimer(powerup:Powerup):void {
			powerups.push(powerup);
		}*/
		public function dispose():void {
			this.graphics.clear();
			View.getCurveLayer().removeChild(hitbox);
			hitbox = null;
			View.getCurveLayer().removeChild(circle);
			circle = null;
		}
		
		
		// Getters Setters
		public function set color(c:uint):void {
			this.graphics.lineStyle(size, c, 1, false, "normal", CapsStyle.NONE);
			_color = c;
		}
		public function get color():uint {
			return _color;
		}
		public function set size(s:Number):void {
			this.graphics.lineStyle(s, color, 1, false, "normal", CapsStyle.NONE);
			_size = s;
		}
		public function get size():Number {
			return _size;
		}
		public function set ghost(b:Boolean):void {
			_ghost = b;
		}
		public function get ghost():Boolean {
			return _ghost;
		}
		// @debug
		public function set stop(b:Boolean) {
			this.timer.stop();
			_stop = b;
		}
		public function get stop():Boolean {
			return _stop;
		}
		public function set debug(b:Boolean) {
			if(b) {
				hitbox.alpha = 1;
				circle.alpha = 0;
			}
			else {
				hitbox.alpha = 0;
				circle.alpha = 1;
			}
			_debug = b;
		}
		public function get debug():Boolean {
			return _debug;
		}
	}//end-class
}//end-pack