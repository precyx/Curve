package com.curve
{
	// adobe
	import flash.desktop.Clipboard;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	//
	import com.kiko.utils.Math2;
	//
	/*
	 * Curve - Version 1.3
	 * View & Model
	 */
	public class Curve extends Sprite
	{
		// interface
		private static const NORMAL_SPEED = 1.55; // std:1.55
		private static const NORMAL_SIZE = 7; // std:7
		private var xpos = 300;
		private var ypos = 100;
		public var curviness = 67; //std:93
		public var speed = Curve.NORMAL_SPEED;
		public var holesize = 250; // std:280
		public var holeProbability = 7000; // std:7000
		public var direction = 0; // (0,1,-1)
		private var _size:Number = Curve.NORMAL_SIZE;
		private var _color:uint = 0xff00aa;
		private var radius = 0;
		private var ydegree = 0;
		private var xdegree = 0;
		private var _stop = false; // @debug
		// curve
		private var tilewidth:Number = 0;
		private var tileheight:Number = 0;
		private var tile:Shape;
		private var tiles:Vector.<Shape>;
		// keys
		public var leftKey:uint = Keyboard.LEFT;
		public var rightKey:uint = Keyboard.RIGHT;
		// ghost
		private var _ghost = false;
		private var timer:Timer;
		private var ghostchanged:Boolean = false;
		// hitbox
		public var hitbox:Shape;
		//
		//
		public function Curve(xpos:Number = 0, ypos:Number = 0):void{
			this.xpos = xpos;
			this.ypos = ypos;
			xdegree = ydegree = Math.random() * Math.PI * 2;
			tileheight = size;
			tiles = new Vector.<Shape>;
			//
			timer = new Timer(Math2.randFloat(200, holeProbability));
			timer.addEventListener(TimerEvent.TIMER, ontime);
			timer.start();
			//
			hitbox = new Shape();
			addChild(hitbox);
		}
		public function draw():void {
			// tiles
			if(!ghost){
			tile = new Shape();
			this.addChild(tile);
			tile.graphics.beginFill(color);
			tile.graphics.drawRect( -tilewidth / 2, -tileheight / 2, tilewidth, tileheight);
			tiles.push(tile);
			tile.x = xpos;
			tile.y = ypos;
			tile.rotation = xdegree / (Math.PI * 2) * 360;
			//
			if ( speed > Curve.NORMAL_SPEED || size > Curve.NORMAL_SIZE) {
				tile = new Shape();
				this.addChild(tile);
				tile.graphics.beginFill(color);
				tile.graphics.drawRect( -tilewidth/2 +speed/2, -tileheight / 2, tilewidth, tileheight);
				tiles.push(tile);
				tile.x = xpos;
				tile.y = ypos;
				tile.rotation = xdegree / (Math.PI * 2) * 360;
			}
			}
			// hitbox
			hitbox.graphics.clear();
			hitbox.graphics.beginFill(0x000000, 1.0);
			drawHalfCircle(hitbox.graphics, 0, 0, size / 2);
			hitbox.x = xpos;
			hitbox.y = ypos;
			hitbox.rotation =  xdegree / (Math.PI*2) * 360 -90;
			setChildIndex(hitbox, numChildren - 1);
			//
			// movement
			xpos += Math.cos(xdegree) * speed;
			ypos += Math.sin(ydegree) * speed;
			radius =  curviness * (Math.sqrt(size)*0.3 + Math.sqrt(speed)*2 );
			ydegree += direction * (Math.PI*2 / radius * speed );
			xdegree += direction * (Math.PI*2 / radius * speed );
			tilewidth = Math.sqrt(speed) * 1.5;	
			
		}
		// events
		private function ontime(e:TimerEvent):void {
			ghost = ! ghost;
			ghostchanged = true;
			if (ghost) timer.delay = holesize * ((1/speed) + size*0.06);
			else timer.delay = Math2.randFloat(200, holeProbability); //std:7000
		}
		
		// privates
		private function drawHalfCircle(g:Graphics, x:Number,y:Number,r:Number):void {
			var c1:Number=r * (Math.SQRT2 - 1);
			var c2:Number=r * Math.SQRT2 / 2;
			g.moveTo(x+r,y);
			g.curveTo(x+r,y+c1,x+c2,y+c2);
			g.curveTo(x+c1,y+r,x,y+r);
			g.curveTo(x-c1,y+r,x-c2,y+c2);
			g.curveTo(x-r,y+c1,x-r,y);
			// full circle
			/*g.curveTo(x-r,y-c1,x-c2,y-c2);
			g.curveTo(x-c1,y-r,x,y-r);
			g.curveTo(x+c1,y-r,x+c2,y-c2);
			g.curveTo(x+r,y-c1,x+r,y);*/
		};
		
		// Publics
		public function restart():void {
			//xpos = Math.random() * stage.stageWidth;
			//ypos = Math.random() * stage.stageHeight;
			//xdegree = ydegree = Math.random() * Math.PI*2;
			this.graphics.clear();
			this.graphics.lineStyle(size, color);
			this.graphics.moveTo(xpos, ypos);
		}
		
		
		// Getters Setters
		public function set color(c:uint):void {
			this.graphics.lineStyle(size, c);
			_color = c;
		}
		public function get color():uint {
			return _color;
		}
		public function set size(s:Number):void {
			this.graphics.lineStyle(s, color);
			this.tileheight = s;
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
	}//end-class
}//end-pack