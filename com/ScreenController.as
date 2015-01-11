package com
{
	// adobe
	//
	// own
	//
	public class ScreenController
	{
		// data
		public var screens:Vector.<Screen>;
		//
		//
		public function ScreenController():void{
			screens = new Vector.<Screen>;
			//
			var mainMenu:MainMenu = new MainMenu();
			View.getScreenLayer().addChild(mainMenu);
		}
	}//end-class
}//end-pack