﻿package uk.ac.sussex.model.valueObjects.requestParams {	import com.smartfoxserver.v2.entities.data.SFSObject;		public class DataParamInt extends DataParam {		public function DataParamInt(paramName:String) {			super(paramName);			this.paramType = DataParam.INT;		}		override public function getParamValue() {			var value:int = this.paramValue as int;			return value;		}		override public function setParamValue(paramValue) {			var value:int = int(paramValue);			this.paramValue = value;		}		override public function addToServerParam(existingObject:SFSObject):SFSObject {			existingObject.putInt(this.getParamName(), this.getParamValue() as int);			return existingObject;		}		override public function translateFromServerParam(existingObject:SFSObject):SFSObject {			var myValue:int = existingObject.getInt(this.getParamName());			this.setParamValue(myValue);			return existingObject;		}	}}