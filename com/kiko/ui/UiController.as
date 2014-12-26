package com.kiko.ui
{
	// adobe
	import flash.display.Sprite
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import flash.ui.Keyboard;
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
			box.alpha = 0.5;
			box.x = stage.stageWidth - box.width;
			box.title = "Curve Control";
			box.y = 0;
			box.active = true;
			box.addTextButton("Restart").addEventListener(MouseEvent.CLICK, function() {
				Controller.curveController.removeAll();
				Controller.curveController.createAll();
			});
			View.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keydown);
			
			box.addTextButton("Stop & New").addEventListener(MouseEvent.CLICK, function() {
				Controller.curveController.stopAll();
				Controller.curveController.createAll();
			});
			box.addStepper("Num Curves", 1, 20, 1, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				Controller.curveController.numCurves = s.value;
			});
			box.addStepper("Size", 0, 120, 7, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				Controller.curveController.size = s.value;
			});
			box.addStepper("Speed", 0, 35, 1.55, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				Controller.curveController.speed = s.value;
			});
			box.addStepper("Curviness", 0, 250, 92, 1).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				Controller.curveController.curviness = s.value;
			});
			box.addStepper("Holesize", 0, 2000, 160, 10).addEventListener(MouseEvent.CLICK, function(e) {
				var s:Stepper = Stepper( e.currentTarget);
				Controller.curveController.holesize = s.value;
			});
			box.addToggleButton("Debug").addEventListener(MouseEvent.CLICK, function(e) {
				var s:ToggleButton = ToggleButton( e.currentTarget);
				Controller.curveController.debug = s.toggleOn;
			});
			
		}
		
		private function keydown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) {
				Controller.curveController.removeAll();
				Controller.curveController.createAll();
			}
		}
	}//end-class
}//end-pack