﻿package uk.ac.sussex.controller {	import org.puremvc.as3.multicore.interfaces.INotification;	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	import uk.ac.sussex.model.RequestProxy;	import uk.ac.sussex.serverhandlers.CommsHandlers;	/**	 * @author em97	 */	public class SubmitClearTickerCommand extends SimpleCommand {		override public function execute(note:INotification):void {			trace("SubmitClearTickerCommand sez: I has been fired. " + note.getName());			var clearTicker:RequestProxy = facade.retrieveProxy(CommsHandlers.TICKER_MESSAGE_CLEAR 																+ RequestProxy.NAME) as RequestProxy;			clearTicker.sendRequest();																		}	}}