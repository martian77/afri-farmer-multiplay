﻿package uk.ac.sussex.view.components {		import flash.text.TextFormat;	import flash.text.TextField;	import flash.display.MovieClip;			public class GameDisplayText extends MovieClip {				private var displayText:TextField;				public function GameDisplayText() {			// constructor code			displayText = new TextField();			displayText.x = 5;			displayText.y = 5;			displayText.selectable= false;						var textStyle:TextFormat = new TextFormat();			textStyle.color = 0x006292;			textStyle.font = "verdana";			displayText.defaultTextFormat = textStyle;			this.addChild(displayText);		}		public function setDisplayText(newText:String):void{			displayText.text = newText;		}	}	}