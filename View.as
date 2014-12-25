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
	 * View V 1.1
	 * MainView
	 */
	public class View extends Sprite
	{
		//
		private static var view:View;
		//
		//
		public function View():void { }
		
		/**
		 * Einmaliges erstellen (Singleton)
		 */
		static public function init():View {
			view = new View();
			return view;
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
	}//end-class
}//end-pack