package com
{
	// adobe
	import flash.display.Sprite
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
		// graphics
		private var rings:Image;
		private var globalSettings:FlatIconButton;
		private var menuBoard:Sprite;
		private var logo:Image;
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
			rings.alpha = 0.5;
			
			
			menuBoard = new Sprite();
			menuBoard.graphics.beginFill(0xffffff);
			menuBoard.graphics.drawRect(0, 0, 295, 448);
			addChild(menuBoard);
			menuBoard.filters = [dropshadow];
			menuBoard.x = sw / 2 - menuBoard.width / 2;
			
			
			globalSettings = new FlatIconButton(PATH + "settings2_icon.swf", function() {
				globalSettings.x = sw - globalSettings.width;
				globalSettings.y = 0;
				
			});
			addChild(globalSettings);
			
			logo = new Image(PATH + "logo.swf", function() {
				logo.x = sw / 2; 
				logo.y = logo.height/2 + 25;
			},true,false);
			addChild(logo);
			
			
			
		}
	}//end-class
}//end-pack