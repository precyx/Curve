package com.kiko.ui
{
	// adobe
	import flash.display.Sprite
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	//
	// own
	import com.kiko.ui.buttons.*;
	import com.kiko.ui.Box;
	//
	/*
	 * UiController - Version 1.1
	 * Controller
	 */
	public class UiController
	{
		//
		private var boxes:Vector.<Box>;
		private var stage:Stage;
		private var controller:Controller;
		//
		//
		public function UiController(controller:Controller ):void{
			this.controller = controller;
			stage = View.getStage();
			createBox();
		}
		
		public function createBox():void {
			var box:Box = new Box( new BoxConfig( { minimizeMode:true} ));
			View.getStage().addChild(box);
			box.height = 350;
			box.x = stage.stageWidth - box.width;
			box.title = "Curve Control";
			box.y = 0;
			box.active = true;
			box.addTextButton("Restart").addEventListener(MouseEvent.CLICK, function() {
				controller.curveController.removeAll();
				controller.curveController.createAll();
			});
			box.addTextButton("Stop & New").addEventListener(MouseEvent.CLICK, function() {
				controller.curveController.stopAll();
				controller.curveController.createAll();
			});
			box.addStepper("Num Curves", 1, 20, 1, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				controller.curveController.numCurves = s.value;
			});
			box.addStepper("Size", 0, 120, 7, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				controller.curveController.size = s.value;
			});
			box.addStepper("Speed", 0, 35, 1.55, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				controller.curveController.speed = s.value;
			});
			box.addStepper("Curviness", 0, 250, 78, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				controller.curveController.curviness = s.value;
			});
			box.addStepper("Holesize", 0, 2000, 250, 10).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				controller.curveController.holesize = s.value;
			});
			
		}
	}//end-class
}//end-pack