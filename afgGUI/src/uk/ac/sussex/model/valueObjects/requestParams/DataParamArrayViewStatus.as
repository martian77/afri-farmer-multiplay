/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.African Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.model.valueObjects.requestParams {
	import uk.ac.sussex.model.valueObjects.ViewStatus;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import uk.ac.sussex.model.valueObjects.requestParams.DataParamArray;

	/**
	 * @author em97
	 */
	public class DataParamArrayViewStatus extends DataParamArray {
		public function DataParamArrayViewStatus(paramName : String) {
			super(paramName);
		}
		override public function translateFromServerParam(existingObject:SFSObject):SFSObject {
			var sfsArray:SFSArray = existingObject.getSFSArray(this.getParamName()) as SFSArray;
			if(sfsArray != null){
				var myValue:Array = translateToArray(sfsArray);
			}
			this.setParamValue(myValue);
			
			return existingObject;
		}
		
		public static function translateToArray(sfsArray:SFSArray):Array {
			var sfsSize:int = sfsArray.size();
			var myValue:Array = new Array();
			for (var i:int = 0; i < sfsSize; i++) {
				var viewStatus:ViewStatus = new ViewStatus();
				var vsObj:SFSObject = sfsArray.getSFSObject(i) as SFSObject;
				viewStatus.setViewName(vsObj.getUtfString("view"));
				viewStatus.setStatus(vsObj.getInt("value"));
				myValue.push(viewStatus);
			}
			return myValue;	
		}
	}
}
