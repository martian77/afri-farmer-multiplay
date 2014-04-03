﻿package uk.ac.sussex.controller {	import uk.ac.sussex.model.valueObjects.HearthAsset;	import uk.ac.sussex.general.ApplicationFacade;	import uk.ac.sussex.model.*;	import uk.ac.sussex.model.valueObjects.VillageOverview;	import uk.ac.sussex.serverhandlers.VillageHandlers;	import uk.ac.sussex.view.*;	import org.puremvc.as3.multicore.interfaces.INotification;	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	/**	 * @author em97	 */	public class SubMenuVillageCommand extends SimpleCommand {		override public function execute( note:INotification ):void {						var subMenuItem:String = note.getBody() as String;			trace("SubMenuVillageCommand sez: Trying to fire off " + subMenuItem);						switch(subMenuItem){				case VillageHandlers.SUB_MENU_OVERVIEW:					displayVillageOverview();					showVillage(true);					showGiveForm(false);					break;				case VillageHandlers.SUB_MENU_LIKE:					sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, "Like");					break;				case VillageHandlers.SUB_MENU_GIVE:					var giveMessage:String = "Give";					giveMessage += "\n\n This allows you to give things that you own to someone else.";					giveMessage += "\n You need to negotiate what and when (if?) you get something in return.";					sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, giveMessage);					showVillage(false);					showGiveForm(true);					break;			}		}		private function showVillage(show:Boolean):void {		  	var hearthListProxy:HearthListProxy = facade.retrieveProxy(HearthListProxy.NAME) as HearthListProxy;	  		if(hearthListProxy!=null){				var hearthlist:Array = hearthListProxy.getHearthIds();				for each (var hearthId:int in hearthlist){					var hearthMediator:HearthMediator = facade.retrieveMediator(HearthMediator.NAME + hearthId) as HearthMediator;				  	if(hearthMediator != null){				  		hearthMediator.displayHearth(show);					}			  	}			}		}		private function showGiveForm(show:Boolean):void {			var formMediator:FormMediator = facade.retrieveMediator(VillageHandlers.GIVE_FORM) as FormMediator;			if(formMediator!=null){		    	trace("SubMenuVillageCommand sez: FormMediator isn't null");		    	if(show){		    		formMediator.addToViewArea();		    	} else {		    		formMediator.hideForm();				}			} else {	      		trace("SubMenuVillageCommand sez: FormMediator is null");	    	}		    var assetListMediator:InStockAssetListMediator = facade.retrieveMediator(InStockAssetListMediator.NAME) as InStockAssetListMediator;		    if(assetListMediator!=null){				if(show){					var hearthAssetsLP:HearthAssetListProxy = facade.retrieveProxy(HearthAsset.OWNER_HEARTH + HearthAssetListProxy.NAME) as HearthAssetListProxy;					if(hearthAssetsLP!= null){						assetListMediator.setContents(hearthAssetsLP.fetchNonZeroHearthAssets());					}					assetListMediator.setListTitle("Hearth Assets");				}	    		assetListMediator.showList(show);	    	}		}		private function displayVillageOverview():void {			var villageOverviewProxy:VillageOverviewProxy = facade.retrieveProxy(VillageOverviewProxy.NAME) as VillageOverviewProxy;			if(villageOverviewProxy == null) {				//Issue.	      	} else {		        var villageOverview:VillageOverview = villageOverviewProxy.getVillageOverview();		        var villageTitle:String = villageOverview.getName() + " Village";	  			var households:String = "Number of households: " + villageOverview.getHouseholds();	  			var adults:String = "Number of adults: " + villageOverview.getNumAdults();	  			var children:String = "Number of children: " + villageOverview.getNumKids();		  			var totalText:String = villageTitle + "\n\n" + households + "\n" + adults + "\n" + children;		  			sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, totalText);	    	}		}	}}