﻿package uk.ac.sussex.view.components {	import flash.display.MovieClip;		public class CreateNewGameButton extends MovieClip{		private static const DEFAULT_Y_SPACER:uint = 10;		private static const DEFAULT_X_SPACER:uint = 10;		private static const DEFAULT_LINE_COLOUR:uint = 0x002299;				public function CreateNewGameButton() {			// constructor code			trace("CreateNewGameButton sez: I is created");			var button:GameButton = new GameButton("Create New Game");			button.x = DEFAULT_X_SPACER;			button.y = DEFAULT_Y_SPACER;			this.addChild(button);			var maxX:Number = button.x + button.width + DEFAULT_X_SPACER;			var maxY:Number = button.y + button.height + DEFAULT_Y_SPACER;			this.graphics.moveTo(0,0);			this.graphics.lineStyle(2, DEFAULT_LINE_COLOUR);			this.graphics.lineTo(maxX, 0);			this.graphics.lineTo(maxX, maxY);			this.graphics.lineTo(0, maxY);			this.graphics.lineTo(0, 0);		}	}	}