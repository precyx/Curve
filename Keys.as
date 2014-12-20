package
{
	// adobe
	import flash.display.Sprite
	import flash.events.KeyboardEvent;
	//
	// own
	//
	public class Keys extends Sprite
	{
		//
		static private var keys:Keys;
		private var keyObject:Object;
		//
		//
		public function Keys():void {}
		
		/**
		 * Einmaliges erstellen (Singleton)
		 */
		static public function init() {
			keys = new Keys();
			keys.keyObject = { };
			View.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keydown);
			View.getStage().addEventListener(KeyboardEvent.KEY_UP, keyup);		
		}
		
		static private function keydown(e:KeyboardEvent):void {
			keys.keyObject[e.keyCode] = true;
		}
		static private function keyup(e:KeyboardEvent):void {
			keys.keyObject[e.keyCode] = false;
		}
		
		/**
		 * Interface
		 */
		static public function press(code:uint):Boolean {
			return Boolean(keys.keyObject[code]);
		}
	}//end-class
}//end-pack