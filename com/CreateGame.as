package com
{
	// adobe
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	//
	// own
	//
	public class CreateGame extends Screen
	{
		// graphics
		private var globalSettings:FlatIconButton;
		private var backButton:FlatIconButton;
		private var title:TextField;
		private var play:TextButton;
		private var playerStepper:FlatStepper;
		//
		// data
		private const PATH:String = "resources/curve/screens/";
		private var sw:Number;
		private var sh:Number;
		//
		//
		public function CreateGame():void
		{
			//
			sw = View.getStage().stageWidth;
			sh = View.getStage().stageHeight;
			//
			globalSettings = new FlatIconButton(PATH + "settings2_icon.swf", function() {
				globalSettings.x = sw - globalSettings.width;
				globalSettings.y = 0;
			});
			addChild(globalSettings);
			
			backButton = new FlatIconButton(PATH + "back_icon.swf", function() {
				backButton.x = 0; backButton.y = 0;
			});
			addChild(backButton);
			backButton.addEventListener(MouseEvent.CLICK, function() {
				Controller.screenController.changeScreen("com.MainMenu");
			});
			
			title = new TextField();
			var format:TextFormat = new TextFormat("Open Sans Semibold", 36, 0x262626);
			title.setTextFormat(format);
			title.defaultTextFormat = format;
			addChild(title);
			title.text = "Create a Game";
			title.x = 0;
			//title.background = true; title.backgroundColor = 0xff00aa;
			title.width = sw;
			title.multiline = true;
			title.selectable = false;
			
			trace(title.width);
			title.y = 100;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.embedFonts = true;
			
			playerStepper = new FlatStepper();
			addChild(playerStepper);
			playerStepper.x = 225;
			playerStepper.y = 260;
			
			
			
			play = new TextButton("Play", 0xff4fed, 150);
			addChild(play);
			play.x = sw / 2 - play.width / 2;
			play.y = 380;
			play.addEventListener(MouseEvent.CLICK, function() {
				Controller.screenController.changeScreen("com.MainMenu");
			});
		}
	}//end-class
}//end-pack