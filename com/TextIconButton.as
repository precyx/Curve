package com
{
	// adobe
	import com.kiko.display.Image;
	import flash.display.ColorCorrection;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	//
	// own
	//
	public class TextIconButton extends Sprite
	{
		// graphics
		private var bg:Sprite;
		private var tf:TextField;
		private var format:TextFormat;
		private var ico:Image;
		//
		// data
		private var color;
		//
		//
		public function TextIconButton(text:String, color:uint, icopath:String):void
		{
			this.color = color;
			//
			this.buttonMode = true;
			//
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);
			drawBg();
			addChild(bg);
			
			tf = new TextField();
			format = new TextFormat("Open Sans", 27, color);
			
			tf.text = text;
			tf.setTextFormat(format);
			tf.background = false; tf.backgroundColor = 0xff00aa;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.embedFonts = true;
			tf.width = bg.width;
			tf.height = bg.height;
			tf.selectable = false;
			tf.mouseEnabled = false;
			trace(tf.textHeight);
			tf.y = bg.height / 2 - tf.textHeight / 2 - 5;
			tf.x = bg.width/2-tf.width / 2;
			
			addChild(tf);

			
			ico = new Image(icopath, function() {
				ico.y = bg.height / 2;
				ico.x = 10 + ico.width / 2;
				var white:ColorTransform = new ColorTransform(); white.color = 0xffffff;
				//ico.transform.colorTransform = white;
			}, true, false);
			addChild(ico);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout);
		}
		
		private function mouseover(e:MouseEvent):void 
		{
			bg.graphics.beginFill(color);
			drawBg();
			format.color = 0xffffff;
			tf.setTextFormat(format);
			var white:ColorTransform = new ColorTransform(); white.color = 0xffffff;
			ico.transform.colorTransform = white;
		}
		private function mouseout(e:MouseEvent):void 
		{
			bg.graphics.beginFill(0xffffff);
			drawBg();
			format.color = color;
			tf.setTextFormat(format);
			var dye:ColorTransform = new ColorTransform(); dye.color = color;
			ico.transform.colorTransform = dye;
		}
		
		private function drawBg():void { bg.graphics.drawRect(0, 0, 295, 55); }
		
	}//end-class
}//end-pack