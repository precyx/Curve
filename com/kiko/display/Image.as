package com.kiko.display
{
	// adobe
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	//
	//
	/*
	 * Image - Version 1.1
	 * View
	 */
	public class Image extends Sprite
	{
		//
		public var loader:Loader;
		private var info:LoaderInfo;
		private var onComplete:Function;
		private var centered:Boolean;
		private var debug:Boolean;
		//
		//
		/**
		 * @param	source Pfad zur Datei, die geladen werden soll, zB: (.swf, .jpg, .png, .mov)
		 * @param	onComplete Funktion die bei fertig geladener Datei aufgerufen wird.
		 * @param	centered Bestimmt ob das Bild eingemittet wird. Hilfreich zum mittig platzieren oder rotieren.
		 * @param	debug Wenn aktiviert, kann man das geladene Bild dragen, man sieht den RegPoint und es wird die x & y Position angezeigt.
		 */
		public function Image(source:String, onComplete:Function, centered:Boolean = false, debug:Boolean = false):void
		{
			loader = new Loader();
			this.onComplete = onComplete;
			this.centered = centered;
			this.debug = debug;
			this.info = loader.contentLoaderInfo;
			//
			info.addEventListener( Event.COMPLETE, imgLoaded );
			loader.load( new URLRequest(source) );
			addChild(loader);
		}
		private function imgLoaded(e:Event):void  {
			//info.removeEventListener( Event.COMPLETE, imgLoaded );
			onComplete();
			if ( centered ) { 
				loader.x = -loader.width / 2;
				loader.y = -loader.height / 2;
			}
			if ( debug ) {
				var self:Sprite = this;
				//
				this.addEventListener(MouseEvent.MOUSE_DOWN, function() { self.startDrag(); });
				this.addEventListener(MouseEvent.MOUSE_UP, function() { self.stopDrag(); } );
				var regPoint:Sprite = new Sprite();
				regPoint.graphics.beginFill(0x444444, 0.5); regPoint.graphics.drawCircle(0, 0, 5);
				addChild(regPoint);
				var bg:Sprite = new Sprite();
				bg.graphics.beginFill(0x000000); bg.graphics.drawRect(0, 0, 100, 30); bg.alpha = 0.5;
				addChild(bg);
				var tf1:TextField = new TextField();
				var format:TextFormat = new TextFormat("Arial", 12, 0xffffff);
				addChild(tf1);
				tf1.setTextFormat(format); tf1.defaultTextFormat = format;
				addEventListener(Event.ENTER_FRAME, function() {
					tf1.text = "x: " + self.x +" " + "y: " + self.y; 
				});
			}
		}
		public function dispose():void {
			loader.unloadAndStop();
		}
	}//end-class
}//end-pack