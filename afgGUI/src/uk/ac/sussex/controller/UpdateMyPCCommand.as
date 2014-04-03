﻿package uk.ac.sussex.controller {	import uk.ac.sussex.model.valueObjects.PlayerChar;	import uk.ac.sussex.general.ApplicationFacade;	import uk.ac.sussex.model.PlayerCharProxy;	import org.puremvc.as3.multicore.patterns.command.*;	//import org.puremvc.as3.multicore.patterns.observer.*;	import org.puremvc.as3.multicore.interfaces.*;	/**	 * @author em97	 */	public class UpdateMyPCCommand extends SimpleCommand {		override public function execute( note:INotification ):void {			trace("UpdateMyPCCommand sez: Fired UpdateMyPCCommand " + note.getName());			var myPCProxy:PlayerCharProxy = facade.retrieveProxy(ApplicationFacade.MY_CHAR) as PlayerCharProxy;			var myPC:PlayerChar = note.getBody() as PlayerChar;			if(myPCProxy == null ){				trace("UpdateMyPCCommand sez: First time we've registered my proxy");				myPCProxy = new PlayerCharProxy(ApplicationFacade.MY_CHAR, myPC);				sendNotification(ApplicationFacade.FETCH_STATIC_DATA);				facade.registerProxy(myPCProxy);			} else {				trace("UpdateMyPCCommand sez: Updating my proxy");				myPCProxy.updateAvatar(myPC.getAvatarBody());				myPCProxy.updateFamilyName(myPC.getFamilyName());				myPCProxy.updateFirstName(myPC.getFirstName());				myPCProxy.updateHearthId(myPC.getHearthId());			}		}	}}