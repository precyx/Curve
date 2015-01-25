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
	public class TextButton extends Sprite
	{
		// graphics
		protected var bg:Sprite;
		protected var tf:TextField;
		protected var format:TextFormat;
		protected var btnWidth:Number;
		//
		// data
		protected var color;
		//
		//
		public function TextButton(text:String, color:uint, width:Number = 295):void
		{
			this.color = color;
			this.btnWidth = width;
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
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout);
		}
		
		protected function mouseover(e:MouseEvent):void {
			bg.graphics.beginFill(color);
			drawBg();
			format.color = 0xffffff;
			tf.setTextFormat(format);
		}
		protected function mouseout(e:MouseEvent):void {
			bg.graphics.beginFill(0xffffff);
			drawBg();
			format.color = color;
			tf.setTextFormat(format);
		}
		
		protected function drawBg():void { bg.graphics.drawRect(0, 0, btnWidth, 55); }
		
	}//end-class
}//end-pack