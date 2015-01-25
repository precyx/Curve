package com
{
	// adobe
	import com.kiko.display.Image;
	import flash.display.Sprite
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	//
	// own
	//
	public class FlatStepper extends Sprite
	{
		// graphis
		private var bg:Sprite;
		private var title:TextField;
		private var valTf:TextField;
		private var format:TextFormat;
		private var arrUp:Image;
		private var arrDown:Image;
		//
		// data
		private var TEXT_Y_GAP:Number;
		private var PATH:String = "resources/curve/flatstepper";
		//
		//
		public function FlatStepper(color:uint = 0x7ba6ff, titleText:String = "Players", startVal:Number = 0, minVal:Number = 0, maxVal:Number = 8 ):void
		{
			title = new TextField();
			var f2:TextFormat = new TextFormat("Open Sans", 18, color);
			title.setTextFormat(f2);
			title.defaultTextFormat = f2;
			addChild(title);
			title.text = titleText;
			//
			TEXT_Y_GAP = title.textHeight + 5;
			
			bg = new Sprite();
			bg.graphics.beginFill(color);
			bg.graphics.drawRect(0, 0, 90, 37);
			addChild(bg);
			bg.y = TEXT_Y_GAP;
			
		
			
			valTf = new TextField();
			format = new TextFormat("Open Sans", 18, 0xffffff);
			valTf.setTextFormat(format),
			valTf.defaultTextFormat = format;
			valTf.autoSize = TextFieldAutoSize.LEFT;
			valTf.multiline = true;
			valTf.text = String(startVal);
			valTf.selectable = false;
			valTf.embedFonts = true;
			//title.background = true; title.backgroundColor = 0x000000;
			valTf.y = bg.height / 2 - title.textHeight / 2 - 3 + TEXT_Y_GAP;
			valTf.x = 5;
			addChild(valTf);
			
			
			arrUp = new Image(PATH + "/arrow_mini.swf", function() {
				arrUp.x = bg.width - 20;
				arrUp.y = TEXT_Y_GAP +5;
			}, false);
			addChild(arrUp);
			var white:ColorTransform = new ColorTransform();
			white.color = 0xffffff;
			arrUp.transform.colorTransform = white;
			
			
			arrDown = new Image(PATH + "/arrow_mini.swf", function() {
				arrDown.x = bg.width - 10;
				arrDown.y = TEXT_Y_GAP + bg.height - 5;
			}, false);
			addChild(arrDown);
			arrDown.rotation = 180;
			var white:ColorTransform = new ColorTransform();
			white.color = 0xffffff;
			arrDown.transform.colorTransform = white;
			
		}
	}//end-class
}//end-pack