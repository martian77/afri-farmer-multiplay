/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.African Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import uk.ac.sussex.model.valueObjects.IncomingData;
	import uk.ac.sussex.general.ApplicationFacade;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * @author em97
	 */
	public class AfriVillageHearthAssetsReceivedCommand extends SimpleCommand {
		override public function execute( note:INotification ):void {
			var incomingData:IncomingData = note.getBody() as IncomingData;
			var numAdults:int = incomingData.getParamValue("NumberAdults") as int;
			var numChildren:int = incomingData.getParamValue("NumberChildren") as int;
			//var socialStatus:Number = incomingData.getParamValue("SocialStatus") as Number;
			var numFields:int = incomingData.getParamValue("NumberFields") as int;
			var hearthName:String = incomingData.getParamValue("HearthName") as String;
			var hearthHeads:Array = incomingData.getParamValue("HearthHeads") as Array;
			
			var outputString:String = hearthName + "\n";
			if(hearthHeads.length>0){
				outputString += "\nHeads of Household:\n";
				for each (var hearthHead:String in hearthHeads){
					outputString += "   " + hearthHead + "\n";
				}
			}
			
			outputString += "\nAdults: " + numAdults + "\n\n";
			outputString += "Children: " + numChildren + "\n\n";
			outputString += "Fields: " + numFields + "\n\n";
			//outputString += "Social Status: " + socialStatus;
			
			sendNotification(ApplicationFacade.DISPLAY_TEMP_INFO_TEXT, outputString);
		}
	}
}
