package com
{
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	// adobe
	//
	// own
	//
	public class ScreenController
	{
		// data
		public var screens:Vector.<Screen>;
		//
		// force import
		com.CreateGame;
		com.MainMenu;
		//
		public function ScreenController():void{
			screens = new Vector.<Screen>;
			//
			var mainMenu:MainMenu = new MainMenu();
			View.getScreenLayer().addChild(mainMenu);
			screens.push(mainMenu);
		}
		
		public function changeScreen(className:String = ""):void {
			clearAll();
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var nextScreen:Screen = (new ClassReference() as Screen);
			View.getScreenLayer().addChild(nextScreen);
			screens.push(nextScreen);
		}
		private function clearAll():void {
			for each( var screen:Screen in screens) {
				View.getScreenLayer().removeChild(screen);
				screen = null;
			}
			screens = new Vector.<Screen>;
		}
	}//end-class
}//end-pack