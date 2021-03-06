/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.African Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.view.components {
	import flash.filters.DropShadowFilter;
	import flash.events.*;
	import flash.display.MovieClip;

	/**
	 * @author em97
	 */
	public class SubMenu extends MovieClip {
		public static const BUTTON_CLICKED:String = "ButtonClicked";
		
		private var menuButtons:Array;
		private var selectedButtonName:String;
		private var taskShadow:DropShadowFilter;
		private static const BUTTON_Y_SPACING:int = 10;
		private static const BUTTON_X_SPACING:int = 10;
		
		public function SubMenu() {
			menuButtons = new Array();
			this.setUpFilter();
		}
		public function addButton(buttonName:String):void {
			var myNewButton:SubMenuButton = new SubMenuButton();
			myNewButton.setButtonName(buttonName);
			myNewButton.setButtonText(buttonName);
			myNewButton.addEventListener(SubMenuButton.SUB_MENU_BUTTON_CLICKED, buttonClicked);
			myNewButton.x = BUTTON_X_SPACING;
			myNewButton.y = menuButtons.length * (myNewButton.height + BUTTON_Y_SPACING) + BUTTON_Y_SPACING;
			menuButtons.push(myNewButton);
			this.addChild(myNewButton);
		}
		public function getSelected():String {
			return this.selectedButtonName;
		}
		public function setSelected(buttonName:String) :void {
			//This is going to need to check that the button requested actually exists. 
			for each (var menuButton:SubMenuButton in menuButtons){
				if(buttonName == menuButton.getButtonName()){
					selectedButtonName = buttonName;
					menuButton.filters = [taskShadow];
				} else {
					menuButton.filters = [];
				}
			}
		}
		public function getScreenWidth():Number {
			return this.width + 2*BUTTON_X_SPACING;
		}
		public function clearSubMenu():void {
			this.setSelected("");
			selectedButtonName = "";
			var totalChildren:int = this.numChildren - 1;
			for(var index:int = totalChildren; index==0; index--){
				this.removeChildAt(index);
			}
			menuButtons = new Array();
		}
		private function buttonClicked(e:Event):void {
			var button:SubMenuButton = e.target as SubMenuButton;
			if(button != null){
				this.setSelected(button.getButtonName());
				this.dispatchEvent(new Event(BUTTON_CLICKED));
			}
		}
		private function setUpFilter():void {
			taskShadow = new DropShadowFilter();
			taskShadow.distance = 0;
			taskShadow.angle = 45;
			taskShadow.color = 0xFFFFFF;
			taskShadow.blurX = 4;
			taskShadow.blurY = 4;
			taskShadow.strength = 4;
			taskShadow.quality = 15;
			taskShadow.inner = false;
			taskShadow.knockout = false;
			taskShadow.hideObject = false;
		}
	}
}
