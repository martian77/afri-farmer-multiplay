/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.African Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.model {
	import flash.events.Event;
	import uk.ac.sussex.model.valueObjects.TextMessage;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	/**
	 * @author em97
	 */
	public class TextMessageListProxy extends Proxy implements IProxy {
		public static const NAME:String = "TextMessageListProxy";
		public static const TEXT_MESSAGE_UPDATED:String = "TextMessageUpdated";
		public static const TEXT_MESSAGE_LIST_UPDATED:String = "TextMessageListUpdated";
		
		public function TextMessageListProxy() {
			super(NAME, new Array());
		}
		public function addTexts(newTexts:Array):void {
			for each (var text:TextMessage in newTexts){
				textMessages.push(text);
				text.addEventListener(TextMessage.UPDATED, tmUpdated);
			}
			sendNotification(TEXT_MESSAGE_LIST_UPDATED);
		}
		public function updateText(textMessage:TextMessage):void {
			var existingSMS:TextMessage = this.getTextFromId(textMessage.getId());
			if(existingSMS != null){
				//Should only be able to update these two things. 
				existingSMS.setDeleted(textMessage.getDeleted());
				existingSMS.setUnread(textMessage.getUnread());
				sendNotification(TEXT_MESSAGE_UPDATED, existingSMS);
			}
		}
		public function addText(newText:TextMessage):void{
			textMessages.push(newText);
			newText.addEventListener(TextMessage.UPDATED, tmUpdated);
			sendNotification(TEXT_MESSAGE_LIST_UPDATED);
		}
		public function getTextFromId(textId:int):TextMessage {
			for each (var sms:TextMessage in textMessages){
				if(sms.getId() == textId){
					return sms;
				}
			}
			throw new Error("Text Message " + textId + " not found.");
		}
		public function getUnreadCount():uint{
			var unread:uint = 0;
			for each (var sms:TextMessage in textMessages){
				if(sms.getUnread()){
					unread++;
				}
			}
			return unread;
		}
		public function getTextMessages():Array {
			return textMessages.sort(sortTimeStamp);
		}
		private function tmUpdated(e:Event):void {
			var tm:TextMessage = e.target as TextMessage;
			sendNotification(TEXT_MESSAGE_UPDATED, tm);
		}
		private function sortTimeStamp(a:TextMessage, b:TextMessage):int{
			var aTimeStamp:Number = a.getTimeStamp();
			var bTimeStamp:Number = b.getTimeStamp();
			if(aTimeStamp>bTimeStamp){
				return 1;
			} else if (aTimeStamp<bTimeStamp){
				return -1;
			} else {
				return 0;
			}
			
		}
		protected function get textMessages():Array {
			return data as Array;
		}

	}
}
