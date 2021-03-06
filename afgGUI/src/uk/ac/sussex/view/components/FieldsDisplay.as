/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.African Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.view.components {
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import uk.ac.sussex.model.valueObjects.Field;
	import flash.display.MovieClip;

	/**
	 * @author em97
	 */
	public class FieldsDisplay extends MovieClip {
		private var nextX:int = 0;
		private var nextY:int = 0;
		private var fieldCount:int = 0;
		private var fieldArray:Array;
		private var selectedField:Field_mc;
		private var highlight:GlowFilter;
		
		public static const FIELD_SELECTED:String = "FieldSelected";
		public static const FIELD_SELECTION_CLEARED:String = "FieldSelectionCleared";
		
		public function FieldsDisplay() {
			fieldArray = new Array();
			this.setupHighlight();
		}
		public function addField(fieldObj:Field):void {
			trace("FieldsDisplay sez: fieldObj is not null " + (fieldObj != null));
			var field:Field_mc = new Field_mc();
			field.setField(fieldObj);
			field.x = nextX;
			field.y = nextY;
			
			fieldCount ++;
			var rem:int = fieldCount % 2;
			nextX = nextX - field.width * (rem - 1);
			nextY = field.height * (rem); 
			fieldArray.push(field);
			field.addEventListener(MouseEvent.CLICK, fieldClicked);
			//scrollingContainer.addItemToContainer(field);
			this.addChild(field);
		}
		public function updateField(fieldObj:Field):void {
			var updateId:int = fieldObj.getId();
			for each (var field:Field_mc in fieldArray){
				if(field.getFieldId()==updateId){
					field.setField(fieldObj);
				}
			}
		}
		public function getSelectedField():Field{
			if(selectedField!= null){
				var field:Field = selectedField.getField();
				return field;
			}
			return null;
		}
		public function destroy():void {
			for each (var field:Field_mc in fieldArray){
				field.destroy();
			}
		}
		private function fieldClicked(e:MouseEvent):void{
			var field:Field_mc = e.currentTarget as Field_mc;
			if(selectedField==field){
				selectedField = null;
				field.filters = [];
				dispatchEvent(new Event(FIELD_SELECTION_CLEARED));
			} else {
				if (selectedField != null){
					selectedField.filters = [];
				}
				selectedField = field;
				field.filters = [highlight];
				dispatchEvent(new Event(FIELD_SELECTED));
			}
		}
		private function setupHighlight():void {
			highlight = new GlowFilter();
			highlight.color = 0xFFFFFF;
			highlight.alpha = 0.8;
			highlight.blurX = 12;
			highlight.blurY = 12;
			highlight.inner = true;	
		}
	}
}
