package
{
	// adobe
	import com.kiko.ui.UiController;
	import com.ScreenController;
	import flash.display.Sprite
	import flash.events.StatusEvent;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.display.MovieClip;
	import net.hires.debug.Stats;
	//
	// curve
	import com.curve.CurveController;
	import com.curve.powerup.Powerup;
	import com.curve.powerup.PowerupController;
	//
	/*
	 * Controller - Version 1.1
	 * MainController
	 */
	public class Controller extends Sprite
	{
		// controllers
		static public var curveController:CurveController;
		static public var powerupController:PowerupController;
		static public var uiController:UiController;
		static public var screenController:ScreenController;
		//
		//
		public function Controller():void {
			// Module aktivieren
			addChild(View.init());
			Keys.init();
			addChild(new Stats());
			// Controllers aktivieren
			screenController = new ScreenController();
			curveController = new CurveController();
			powerupController = new PowerupController();
			uiController = new UiController();
		}
		
	}//end-class
}//end-pack