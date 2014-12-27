package com.curve.powerup
{
	// adobe
	import com.kiko.display.Image;
	import com.kiko.utils.DurationTimer;
	import flash.display.Sprite
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	//
	// curve
	import com.curve.Curve;
	import com.curve.GameEvent;
	//
	/*
	 * Powerup - Version 1.3
	 * View & Model
	 */
	public class Powerup extends Sprite
	{
		// modes
		public static const ENEMY_MODE:String = "enemy_mode";
		public static const SELF_MODE:String = "self_mode";
		public static const GLOBAL_MODE:String = "global_mode";
		// colors
		public static const RED:uint = 0xFA0C30;
		public static const BLUE:uint = 0x0684EA;
		public static const YELLOW:uint = 0xF9A800;
		// duration
		public static const NORMAL_DURATION:uint = 5000;
		public static const SHORT_DURATION:uint = 2500;
		// interface
		public var timer:DurationTimer;
		public var active:Boolean = false;
		public var affectedCurves:Vector.<Curve>; // Alle Curves, die vom Powerup beeinflusst werden.
		public var triggerCurve:Curve; // Curve, welche das Powerup betätigt hat.
		public var mode:String;
		// debug
		public var color:uint; //@debug
		public var imgpath:String; //@debug
		//
		//
		/**
		 * @param	mode Anwendemodus Powerup.SELF_MODE, Powerup.ENEMY_MODE, Powerup.GLOBAL_MODE
		 * @param	lifetime Lebenszeit in ms
		 */
		public function Powerup(mode:String, lifetime:Number, imgpath:String):void {
			if (mode == null) throw new Error("Powerup Modus nicht unterstützt. Bitte einen anderen wählen. zB. Powerup.SELF_MODE");
			this.mode = mode;
			this.imgpath = imgpath;
			timer = new DurationTimer(lifetime);
			affectedCurves = new Vector.<Curve>();
			//color = Math.random() > 0.5 ? 0x0059B3 : 0xAD0527; //@cleanup
			//
			var img:Image = new Image(imgpath, imgloaded, true);
			addChild(img);
		}
		private function imgloaded():void {
			dispatchEvent(new GameEvent(GameEvent.POWERUP_READY));
		}
		
		// @override
		public function powerupStart(triggerCurve:Curve):void {
			this.active = true;
			this.triggerCurve = triggerCurve;
			this.alpha = 0.2;
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, powerupEnd);
		}
		protected function powerupEnd(e:TimerEvent):void {
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, powerupEnd);
			dispatchEvent(new GameEvent(GameEvent.POWERUP_END));
		}
		
		
		// Getters Setters
	
		
	}//end-class
}//end-pack