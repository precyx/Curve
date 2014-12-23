package com.curve.powerup
{
	// adobe
	import com.kiko.display.Image;
	import flash.display.Sprite
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	//
	// curve
	import com.curve.Curve;
	import com.curve.GameEvent;
	//
	/*
	 * Powerup - Version 1.2
	 * View & Model
	 */
	public class Powerup extends Sprite
	{
		//
		public static const ENEMY_MODE:String = "enemy_mode";
		public  static const SELF_MODE:String = "self_mode";
		//
		public  static const SPEED_UP:String = "speed_up";
		public  static const SPEED_DOWN:String = "speed_down";
		//
		private var _name:String;
		private var mode:String;
		private var lifetime:Number;
		private var timer:Timer;
		private var img:Image;
		public var active:Boolean = false;
		protected var affectedCurves:Vector.<Curve>;
		//
		//
		/**
		 * @param	mode Anwendemodus Powerup.SELF_MODE, Powerup.ENEMY_MODE
		 * @param	lifetime Lebenszeit in ms
		 */
		public function Powerup(mode:String, lifetime:Number, imgpath:String):void{
			this.mode = mode;
			this.lifetime = lifetime;
			timer = new Timer(lifetime);
			affectedCurves = new Vector.<Curve>();
			//
			img = new Image(imgpath, imgloaded, true);
			addChild(img);
		}
		private function imgloaded():void {
			dispatchEvent(new GameEvent(GameEvent.POWERUP_READY));
		}
		
		// @override
		public function powerupStart(curve:Curve):void {
			this.active = true;
			affectedCurves.push(curve);
			this.alpha = 0.5;
			trace("powerup start");
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, powerupEnd);
		}
		protected function powerupEnd(e:TimerEvent):void {
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, powerupEnd);
			trace("powerup end");
			dispatchEvent(new GameEvent(GameEvent.POWERUP_END));
		}
		
		
		// Getters Setters
		override public function get name () : String {
			return _name;
		}
		override public function set name (value:String) : void {
			_name = value;
		}
		
	}//end-class
}//end-pack