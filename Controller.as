package
{
	// adobe
	import com.kiko.ui.UiController;
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
		public var curveController:CurveController;
		public var powerupController:PowerupController;
		public var uiController:UiController;
		//
		//
		public function Controller():void {
			
			// Module aktivieren
			addChild(View.init());
			Keys.init();
			addChild(new Stats());
			
			// Controllers
			curveController = new CurveController(this);
			powerupController = new PowerupController(this);
			uiController = new UiController(this);
			
		}
	}//end-class
}//end-pack