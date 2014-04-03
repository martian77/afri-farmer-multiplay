package uk.ac.sussex.model.valueObjects.requestParams {
	import uk.ac.sussex.model.valueObjects.CallHistoryItem;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import uk.ac.sussex.model.valueObjects.requestParams.DataParam;

	/**
	 * @author em97
	 */
	public class DataParamCallHistory extends DataParam {
		private static var ID:String = "Id";
		private static var CALLER_ID:String = "CallFromId";
		private static var CALLER_NAME:String = "CallFromName";
		private static var RECEIVER_ID:String = "CallToId";
		private static var RECEIVER_NAME:String = "CallToName";
		private static var STARTED:String = "Started";
		private static var ANSWERED:String = "Answered";
		private static var FINISHED:String = "Finished";
		
		public function DataParamCallHistory(paramName : String) {
			super(paramName);
		}
		override public function getParamValue() {
			var value:CallHistoryItem = this.paramValue as CallHistoryItem;
			return value;
		}
		override public function setParamValue(paramValue) {
			var value:CallHistoryItem = paramValue as CallHistoryItem;
			this.paramValue = value;
		}
		override public function addToServerParam(existingObject:SFSObject):SFSObject {
			var callHistoryObj:SFSObject = SFSObject.newInstance();
			var callHistory:CallHistoryItem = this.getParamValue() as CallHistoryItem;
			callHistoryObj.putInt(ID, callHistory.getId());
			callHistoryObj.putInt(CALLER_ID, callHistory.getCallerId());
			callHistoryObj.putInt(RECEIVER_ID, callHistory.getReceiverId());
			callHistoryObj.putInt(STARTED, callHistory.getStarted());
			callHistoryObj.putInt(ANSWERED, callHistory.getAnswered());
			callHistoryObj.putInt(FINISHED, callHistory.getFinished());
			existingObject.putSFSObject(this.getParamName(), callHistoryObj);
			return existingObject;
		}
		override public function translateFromServerParam(existingObject:SFSObject):SFSObject {
			var callHistoryObj:SFSObject = existingObject.getSFSObject(this.getParamName()) as SFSObject;
			var CallHistory:CallHistoryItem = translateFromSFStoClass(callHistoryObj);
			this.setParamValue(CallHistory);
			return existingObject;
		}
		public static function translateFromSFStoClass(callHistoryObj:SFSObject):CallHistoryItem{
			var callHistory:CallHistoryItem = new CallHistoryItem();
			callHistory.setId(callHistoryObj.getInt(ID));
			callHistory.setCallerId(callHistoryObj.getInt(CALLER_ID));
			callHistory.setCallerName(callHistoryObj.getUtfString(CALLER_NAME));
			callHistory.setReceiverId(callHistoryObj.getInt(RECEIVER_ID));
			callHistory.setReceiverName(callHistoryObj.getUtfString(RECEIVER_NAME));
			callHistory.setStarted(callHistoryObj.getLong(STARTED));
			callHistory.setAnswered(callHistoryObj.getLong(ANSWERED));
			callHistory.setFinished(callHistoryObj.getLong(FINISHED));
			return callHistory;
		}
	}
}
