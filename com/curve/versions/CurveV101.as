package com.curve
{
	// adobe
	import flash.display.Sprite
	import flash.ui.Keyboard;
	//
	/*
	 * Curve V 1.2
	 * View & Model
	 */
	public class Curve extends Sprite
	{
		//
		private var xpos = 300;
		private var ypos = 100;
		public var radius = 25; //std:80
		public var speed = 3; // std:3
		public var direction = 0; // (0,1,-1)
		private var ydegree = 0;
		private var xdegree = 0;
		//
		private var _size:Number = 7;
		private var _color:uint = 0xff00aa;
		//
		public var leftKey:uint = Keyboard.LEFT;
		public var rightKey:uint = Keyboard.RIGHT;
		//
		//
		public function Curve(xpos:Number = 0, ypos:Number = 0):void{
			this.xpos = xpos;
			this.ypos = ypos;
			this.graphics.lineStyle(_size, _color);
			this.graphics.moveTo(xpos, ypos);
		}
		public function draw():void {
			this.graphics.lineTo(xpos, ypos);
			xpos += Math.cos(xdegree) * speed;
			ypos += Math.sin(ydegree) * speed;
			ydegree += direction * (Math.PI / (radius*4)*speed);
			xdegree += direction * (Math.PI / (radius*4)*speed);
		}
		
		// Getters Setters
		public function set color(c:uint):void {
			this.graphics.lineStyle(_size, c);
			_color = c;
		}
		public function set size(s:Number):void {
			this.graphics.lineStyle(s, _color);
			_size = s;
		}
	}//end-class
}//end-pack