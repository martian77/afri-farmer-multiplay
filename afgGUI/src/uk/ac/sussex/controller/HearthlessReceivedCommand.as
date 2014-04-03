package uk.ac.sussex.controller {
	import uk.ac.sussex.model.PCListProxy;
	import uk.ac.sussex.serverhandlers.VillageHandlers;
	import uk.ac.sussex.model.valueObjects.IncomingData;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * @author em97
	 */
	public class HearthlessReceivedCommand extends SimpleCommand {
		override public function execute(note:INotification):void {
			trace("HearthlessReceivedCommand sez: I's been a-fired.");
			var incomingData:IncomingData = note.getBody() as IncomingData;
			var pcArray:Array = incomingData.getParamValue(VillageHandlers.HEARTHLESS_ARRAY) as Array;
			if(pcArray==null){
				throw new Error("The pcarray that I was counting on is null. Crying now.");
			}
			//Now let's get the list for the hearthless. 
			var hearthlessList:PCListProxy = facade.retrieveProxy(VillageHandlers.HEARTHLESS_LIST) as PCListProxy;
			if(hearthlessList==null){
				throw new Error("The list of the hearthless has got lost somewhere. I can't work in these conditions");
			}
			hearthlessList.addManyPCs(pcArray);
		}
	}
}