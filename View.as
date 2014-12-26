package
{
	// adobe
	import flash.display.DisplayObject;
	import flash.display.Sprite
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	//
	// own
	//
	/*
	 * View - Version 1.1
	 * MainView
	 */
	public class View extends Sprite
	{
		//
		private static var view:View;
		private static var powerupLayer:Sprite;
		private static var curveLayer:Sprite;
		private static var effectLayer:Sprite;
		//
		//
		public function View():void { }
		
		/**
		 * Einmaliges erstellen (Singleton)
		 */
		static public function init():View {
			if (view) throw new Error("View darf nur einmal mit init() erstellt werden.");
			else{
				view = new View();
				powerupLayer = new Sprite();
				view.addChild(powerupLayer);
				curveLayer = new Sprite();
				view.addChild(curveLayer);
				effectLayer = new Sprite();
				view.addChild(effectLayer);
				return view;
			}
		}
		/**
		 * Interface
		 */
		static public function getStage():Stage {
			return view.stage;
		}
		static public function getSelf():View {
			return view;
		}
		static public function getPowerupLayer():Sprite {
			return powerupLayer;
		}
		static public function getCurveLayer():Sprite {
			return curveLayer;
		}
		static public function getEffectLayer():Sprite {
			return effectLayer;
		}
	}//end-class
}//end-pack