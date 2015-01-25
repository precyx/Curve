package com
{
	// adobe
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	//
	// own
	import com.kiko.display.Image;
	//
	public class MainMenu extends Screen
	{
		// config
		private const PATH:String = "resources/curve/screens/";
		private var sw:Number;
		private var sh:Number;
		//
		// public
		public var playButton:TextIconButton;
		//
		// graphics
		private var rings:Image;
		private var globalSettings:FlatIconButton;
		private var menuBoard:MenuBoard;
		//
		// effects
		private var dropshadow:DropShadowFilter = new DropShadowFilter(0, 0, 0, 0.05, 15, 15, 1, 3);
		//
		//
		public function MainMenu():void {
			var self:MainMenu = this;
			//
			sw = View.getStage().stageWidth;
			sh = View.getStage().stageHeight;
			rings = new Image(PATH + "rings.swf", function() {
				rings.x = sw / 2;
				rings.y = sh / 2 - 70;
			}, true, false);
			addChild(rings);
			rings.alpha = 0.1;
			
			menuBoard = new MenuBoard();
			menuBoard.x = sw / 2 - menuBoard.width / 2;
			addChild(menuBoard);
			
			menuBoard.addEventListener(MouseEvent.MOUSE_OVER, function() { 
				rings.alpha = 0.2;
			} );
			menuBoard.addEventListener(MouseEvent.MOUSE_OUT, function() { 
				rings.alpha = 0.1;
			} );
			
			
			globalSettings = new FlatIconButton(PATH + "settings2_icon.swf", function() {
				globalSettings.x = sw - globalSettings.width;
				globalSettings.y = 0;
			});
			addChild(globalSettings);
		}
	}//end-class
}//end-pack