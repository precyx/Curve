package com.curve
{
	// adobe
	import com.curve.powerup.Powerup;
	import com.kiko.display.Image;
	import flash.desktop.Clipboard;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.BlendMode;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	//
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
		private static const MIN_COLLISION_SIZE = 4;
		// interface
		public var xpos = 300;
		public var ypos = 100;
		public var curviness = 92; //std:92
		public var speed = Curve.NORMAL_SPEED;
		public var holesize = 140; // std:140
		public var holeMaxProbability = 5000; // std:5000
		public var direction = 0; // (0,1,-1)
		public var leftKey:uint = Keyboard.LEFT;
		public var rightKey:uint = Keyboard.RIGHT;
		private var _reverseKeys:Boolean = false;
		// internal
		private var _size:Number = Curve.NORMAL_SIZE;
		private var _color:uint = 0xff00aa;
		private var radius = 0;
		private var angle = 0;
		private var _stop = false; // @debug
		private var _debug = false; // @debug
		private var time:uint = 0;
		private var powerups:Vector.<Powerup>;
		// graphics
		private var circle:Shape;
		private var powerupDisplay:Sprite;
		public var hitbox:Sprite;
		// ghost
		private var ghost = false;
		private var timer:Timer;
		private var ghostchanged:Boolean = false;
		private var _itemghost:Boolean = false;
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
			powerups = new Vector.<Powerup>();
			powerupDisplay = new Sprite();
			View.getEffectLayer().addChild(powerupDisplay);
			
		}
		public function draw():void {
			if (!ghost && !itemghost) {
				/* #2 lineto render method */
				if ( time % 3 == 0) {
					if (ghostchanged) {
						
						this.graphics.moveTo(xpos, ypos);
						ghostchanged = false;
					}
					//@cleanup
					if (xpos > View.getStage().stageWidth) { xpos = 0 + speed; this.graphics.moveTo(xpos, ypos); }
					else if (ypos > View.getStage().stageHeight) { ypos = 0+speed; this.graphics.moveTo(xpos, ypos);}
					else if ( xpos < 0 ) { xpos = View.getStage().stageWidth - speed; this.graphics.moveTo(xpos, ypos);}
					else if ( ypos < 0) { ypos = View.getStage().stageHeight - speed; this.graphics.moveTo(xpos, ypos);}
					this.graphics.lineTo(xpos, ypos);
				}
			}
			// powerup display
			powerupDisplay.graphics.clear();
			for ( var j:uint = 0; j < powerups.length; j++) {
				var powerup:Powerup = Powerup(powerups[j]);
				powerupDisplay.rotation = angle / (Math.PI * 2) * 360 ;
				powerupDisplay.x = xpos;
				powerupDisplay.y = ypos;
				powerupDisplay.graphics.lineStyle(4, powerup.color, 0.9, false, "normal", CapsStyle.ROUND);
				var degree:Number = 360 - powerup.timer.time / powerup.timer.delay * 360;
				drawArc(powerupDisplay, 0, 0, size/2+5+j*6, 0, degree, 1);
			}
			// circle
			circle.graphics.clear();
			circle.graphics.beginFill(color);
			circle.graphics.drawCircle(
			xpos - 1 * Math.sin(angle + Math.PI / 2), 
			ypos - 1 * Math.sin(angle), 
			size / 2);
			if (reverseKeys) { circle.graphics.beginFill(0);  circle.graphics.drawCircle(xpos, ypos, size / 2); }
			View.getCurveLayer().setChildIndex(circle, View.getCurveLayer().numChildren - 1);
			// hitbox
			hitbox.graphics.clear();
			hitbox.graphics.beginFill(0x000000, 1.0);
			drawHalfCircle(hitbox.graphics, 0, 0, size / 2);
			hitbox.x = xpos + (0.001*size*size +1) * Math.sin(angle + Math.PI / 2); //@graph
			hitbox.y = ypos + (0.001*size*size +1) * Math.sin(angle); //@graph
			hitbox.rotation =  angle / (Math.PI*2) * 360 -90;
			//
			// movement
			xpos += Math.cos(angle) * speed;
			ypos += Math.sin(angle) * speed;
			
			radius = curviness * (Math.sqrt(size)*0.3 + speed ); //@graph
			angle += direction * (Math.PI*2 / radius * speed);
			time++;			
		}
		// events
		private function ontime(e:TimerEvent):void {
			ghost = ! ghost;
			ghostchanged = true;
			if (ghost) { timer.delay = holesize * ((1/speed) + size*0.06); }//@graph
			else {  timer.delay = Math2.randFloat(200, holeMaxProbability); }
		}
		
		// privates
		private function drawHalfCircle(g:Graphics, x:Number, y:Number, r:Number):void {
			r = Math.max(r, Curve.MIN_COLLISION_SIZE/2);
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
		public function addPowerupTimer(powerup:Powerup):void {
			powerups.push(powerup);
		}
		public function removePowerupTimer(powerup:Powerup):void {
			powerups.splice(powerups.indexOf(powerup), 1);
		}
		public function clear():void {
			this.graphics.clear();
			this.graphics.lineStyle(size, color, 1, false, "normal", CapsStyle.NONE);
			this.graphics.moveTo(xpos, ypos);
		}
		public function dispose():void {
			this.graphics.clear();
			View.getCurveLayer().removeChild(hitbox);
			hitbox = null;
			View.getCurveLayer().removeChild(circle);
			circle = null;
			View.getEffectLayer().removeChild(powerupDisplay);
			powerupDisplay = null;
		}
		
		
		// Privates
		private function drawArc(sprite:Sprite, center_x:Number, center_y:Number, radius:Number, angle_from:Number, angle_to:Number, precision:uint) {
			var deg_to_rad=0.0174532925;
			var angle_diff=angle_to-angle_from;
			var steps=Math.round(angle_diff*precision);
			var angle=angle_from;
			var px=center_x+radius*Math.cos(angle*deg_to_rad);
			var py=center_y+radius*Math.sin(angle*deg_to_rad);
			sprite.graphics.moveTo(px,py);
			for (var i:int=1; i<=steps; i++) {
				angle=angle_from+angle_diff/steps*i;
				sprite.graphics.lineTo(center_x+radius*Math.cos(angle*deg_to_rad),center_y+radius*Math.sin(angle*deg_to_rad));
			}
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
		public function set itemghost(b:Boolean):void {
			_itemghost = b;
		}
		public function get itemghost():Boolean {
			return _itemghost;
		}
		public function set reverseKeys(b:Boolean):void {
			if( b != _reverseKeys){
				var left:uint = leftKey;
				var right:uint = rightKey;
				leftKey = right;
				rightKey = left;
			}
			_reverseKeys = b;
		}
		public function get reverseKeys():Boolean {
			return _reverseKeys;
		}
		public function set stop(b:Boolean) {// @debug
			this.timer.stop();
			powerupDisplay.graphics.clear();
			_stop = b;
		}
		public function get stop():Boolean {// @debug
			return _stop;
		}
		public function set debug(b:Boolean) {// @debug
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
		public function get debug():Boolean {// @debug
			return _debug;
		}
	}//end-class
}//end-pack