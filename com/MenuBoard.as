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
	public class MenuBoard extends Sprite
	{
		// graphics
		private var bg:Sprite;
		private var logo:Image;
		private var btn:TextIconButton;
		//
		// public
		private var playButton:TextIconButton;
		//
		// data
		private const PATH:String = "resources/curve/screens/";
		private var h:Number = 0;
		//
		// effects
		private var dropshadow:DropShadowFilter = new DropShadowFilter(0, 0, 0, 0.05, 15, 15, 1, 3);
		//
		public function MenuBoard():void
		{
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0, 0, 295, 448);
			addChild(bg);
			bg.filters = [dropshadow];
			
			logo = new Image(PATH + "logo.swf", function() {
				logo.x = bg.width / 2; 
				logo.y = 100;
			},true,false);
			addChild(logo);
			
			
			playButton = addButton("Play", 0x7ba6ff, "resources/curve/screens/play_icon.swf");
			addButton("Settings", 0xffc72e, "resources/curve/screens/settings_icon.swf");
			addButton("About", 0xff4fed, "resources/curve/screens/about_icon.swf");
			
			playButton.addEventListener(MouseEvent.CLICK, function() {
				Controller.screenController.changeScreen( "com.CreateGame" );
			});
		}
		
		private function addButton(txt, color, path):TextIconButton {
			btn = new TextIconButton(txt,color,path);
			addChild(btn);  btn.y = h+215;
			h += btn.height + 5;
			return btn;
		}
	}//end-class
}//end-pack