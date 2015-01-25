package com
{
	// adobe
	import flash.display.ColorCorrection;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	//
	// own
	import com.kiko.display.Image;
	//
	public class FlatIconButton extends Sprite
	{
		// graphics
		private var bg:Sprite;
		private var ico:Image;
		//
		// config
		private var color:uint = 0xffffff;
		private var hoverColor:uint = 0x00adb8;
		//
		//
		public function FlatIconButton(icopath:String, onComplete:Function):void
		{
			this.buttonMode = true;
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0, 0, 80, 80);
			addChild(bg);
			bg.filters = [new DropShadowFilter(0, 0, 0, 0.05, 15, 15, 1, 3)];
			
			ico = new Image(icopath, function() {
				addChild(ico );
				ico.x = bg.width / 2;
				ico.y = bg.height / 2;
				onComplete();
			}, true, false);
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseover);
			addEventListener(MouseEvent.MOUSE_OUT, mouseout);
		}
		
		private function mouseover(e:MouseEvent):void {
			var ct:ColorTransform = new ColorTransform(); ct.color = hoverColor;
			bg.transform.colorTransform = ct;
			var ct2:ColorTransform = new ColorTransform(); ct2.color = 0xffffff;
			ico.transform.colorTransform = ct2;
			
		}
		private function mouseout(e:MouseEvent):void {
			bg.transform.colorTransform = new ColorTransform();
			//var ct2:ColorTransform = new ColorTransform(); ct2.color = 0x000000;
			ico.transform.colorTransform = new ColorTransform();
		}
	}//end-class
}//end-pack