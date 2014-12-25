package com.curve
{
	// adobe
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
	 * Curve - Version 1.3
	 * View & Model
	 */
	public class Curve extends Sprite
	{
		// interface
		private static const NORMAL_SPEED = 1.55; // std:1.55
		private static const NORMAL_SIZE = 7; // std:7
		public var xpos = 300;
		public var ypos = 100;
		public var curviness = 67; //std:93
		public var speed = Curve.NORMAL_SPEED;
		public var holesize = 250; // std:280
		public var holeProbability = 7000; // std:7000
		public var direction = 0; // (0,1,-1)
		private var _size:Number = Curve.NORMAL_SIZE;
		private var _color:uint = 0xff00aa;
		private var radius = 0;
		private var angle = 0;
		private var _stop = false; // @debug
		private var i:uint = 0;
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
		public var hitbox:Sprite;
		//
		//
		public function Curve(xpos:Number = 0, ypos:Number = 0):void {
			var startDraw:Sprite = new Sprite();
			startDraw.graphics.drawCircle(0, 0, 1); // @bitmapdata-hack (sonst gibts keine höhe und breite)
			addChild(startDraw);
			//
			this.graphics.moveTo(xpos, ypos);
			this.xpos = xpos;
			this.ypos = ypos;
			angle = Math.random() * Math.PI * 2;
			/* #2 tile render method */
			/*tileheight = size;
			tiles = new Vector.<Shape>;*/
			//
			timer = new Timer(Math2.randFloat(200, holeProbability));
			timer.addEventListener(TimerEvent.TIMER, ontime);
			timer.start();
			//
			hitbox = new Sprite();
			hitbox.graphics.drawRect(0, 0, 1, 1); // @bitmapdata-hack (sonst gibts keine höhe und breite)
			View.getStage().addChild(hitbox);
		}
		public function draw():void {
			// rendering
			if (!ghost) {
			
			/* #2 lineto render method */
			if( i % 3 == 0){
			if (ghostchanged) {
				this.graphics.moveTo(xpos, ypos);
				ghostchanged = false;
			}
			this.graphics.lineTo(xpos, ypos);
			}
				
			/* #1 tile render method */
			/*tile = new Shape();
			this.addChild(tile);
			tile.graphics.beginFill(color);
			tile.graphics.drawRect( -tilewidth / 2, -tileheight / 2, tilewidth, tileheight);
			tiles.push(tile);
			tile.x = xpos;
			tile.y = ypos;
			tile.rotation = angle / (Math.PI * 2) * 360;
			//
			if ( speed > Curve.NORMAL_SPEED || size > Curve.NORMAL_SIZE) {
				tile = new Shape();
				this.addChild(tile);
				tile.graphics.beginFill(color);
				tile.graphics.drawRect( -tilewidth/2 +speed/2, -tileheight / 2, tilewidth, tileheight);
				tiles.push(tile);
				tile.x = xpos;
				tile.y = ypos;
				tile.rotation = angle / (Math.PI * 2) * 360;
			}*/
			
			}//endghost
			
			// hitbox
			hitbox.graphics.clear();
			hitbox.graphics.beginFill(0x000000, 1.0);
			drawHalfCircle(hitbox.graphics, 0, 0, size / 2);
			hitbox.x = xpos + 8 * Math.sin(angle+Math.PI/2)
			hitbox.y = ypos + 8 * Math.sin(angle)
			hitbox.rotation =  angle / (Math.PI*2) * 360 -90;
			View.getStage().setChildIndex(hitbox, numChildren - 1);
			//
			// movement
			xpos += Math.cos(angle) * speed;
			ypos += Math.sin(angle) * speed;
			radius = curviness * (Math.sqrt(size)*0.3 + Math.sqrt(speed)*2 );
			angle += direction * (Math.PI*2 / radius * speed);
			i++;
			//tilewidth = Math.sqrt(speed) * 1.5; // #1 tile render method
			
		}
		// events
		private function ontime(e:TimerEvent):void {
			ghost = ! ghost;
			ghostchanged = true;
			if (ghost) { timer.delay = holesize * ((1/speed) + size*0.06); }
			else {  timer.delay = Math2.randFloat(200, holeProbability); } //std:7000 
		}
		
		// privates
		private function drawHalfCircle(g:Graphics, x:Number, y:Number, r:Number):void {
			g.drawCircle(x, y, r);
			/*var c1:Number=r * (Math.SQRT2 - 1);
			var c2:Number=r * Math.SQRT2 / 2;
			g.moveTo(x+r,y);
			g.curveTo(x+r,y+c1,x+c2,y+c2);
			g.curveTo(x+c1,y+r,x,y+r);
			g.curveTo(x-c1,y+r,x-c2,y+c2);
			g.curveTo(x-r,y+c1,x-r,y);*/
			// full circle
			/*g.curveTo(x-r,y-c1,x-c2,y-c2);
			g.curveTo(x-c1,y-r,x,y-r);
			g.curveTo(x+c1,y-r,x+c2,y-c2);
			g.curveTo(x+r,y-c1,x+r,y);*/
		};
		
		// Publics
		public function restart():void {
			xpos = Math.random() * stage.stageWidth;
			ypos = Math.random() * stage.stageHeight;
			//angle = Math.random() * Math.PI*2;
			this.graphics.clear();
			this.graphics.lineStyle(size, color, 1, false, "normal", CapsStyle.NONE);
			this.graphics.moveTo(xpos, ypos);
		}
		public function dispose():void {
			this.graphics.clear();
			View.getStage().removeChild(hitbox);
			hitbox = null;
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