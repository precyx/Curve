package com.curve
{
	// adobe
	import flash.events.Event;
	//
	/**
	 * GameEvent - Version 1.0
	 * Event
	 */
	public class GameEvent extends Event
	{
		//
		public static const POWERUP_READY:String = "powerup_ready";
		public static const POWERUP_END:String = "powerup_end";
		//
		//
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=true):void{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event {
			return new GameEvent(type, bubbles, cancelable);
		}
	}//end-class
}//end-pack