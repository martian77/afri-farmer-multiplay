﻿package uk.ac.sussex.model.valueObjects {		public class Server {				private var username:String;		private var password:String;		private var receivedParams:Object;		private var requestName:String;				public function Server():void {			this.receivedParams = new Array();		}					public function getUsername():String {			return username;		}		public function setUsername(newName:String):void {			this.username = newName;		}		public function setPassword(newPassword:String):void {			this.password = newPassword;		}		public function getPassword():String {			return this.password;		}		public function setReceivedParams(params:Object):void {			this.receivedParams = params;		}		public function getReceivedParams():Object {			return this.receivedParams;		}		public function getRequestName():String {			return this.requestName;		}		public function setRequestName(name:String):void {			this.requestName = name;		}	}	}