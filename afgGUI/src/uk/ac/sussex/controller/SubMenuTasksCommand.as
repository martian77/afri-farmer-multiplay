﻿package uk.ac.sussex.controller {	import uk.ac.sussex.model.valueObjects.Form;	import uk.ac.sussex.model.FormProxy;	import uk.ac.sussex.model.valueObjects.Task;	import uk.ac.sussex.model.TaskListProxy;	import uk.ac.sussex.view.FormMediator;	import uk.ac.sussex.model.PlayerCharProxy;	import uk.ac.sussex.model.ServerRoomProxy;	import uk.ac.sussex.general.ApplicationFacade;	import uk.ac.sussex.serverhandlers.FarmHandlers;	import org.puremvc.as3.multicore.interfaces.INotification;	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	import uk.ac.sussex.view.TaskListMediator;	/**	 * @author em97	 */	public class SubMenuTasksCommand extends SimpleCommand {		override public function execute(note:INotification):void {			var subMenuItem:String = note.getBody() as String;			var taskFormMediator:FormMediator = facade.retrieveMediator(FarmHandlers.TASK_EDIT_FORM) as FormMediator;			if(taskFormMediator != null){				facade.removeMediator(FarmHandlers.TASK_EDIT_FORM);			}			var taskListMediator:TaskListMediator = facade.retrieveMediator(TaskListMediator.NAME) as TaskListMediator;			taskListMediator.setDeleting(false);						switch(subMenuItem){				case FarmHandlers.TASK_SUB_MENU_DELETE:					if(taskFormMediator != null){						facade.removeMediator(FarmHandlers.TASK_EDIT_FORM);					}					taskListMediator.showList(true);					taskListMediator.listenForSelection(false);					taskListMediator.setDeleting(true);					this.showDeleteText();					break;				case FarmHandlers.TASK_SUB_MENU_EDIT:					this.displayEdit(taskFormMediator, taskListMediator);					break;				case FarmHandlers.TASK_SUB_MENU_EXIT:					var serverRoomProxy:ServerRoomProxy = facade.retrieveProxy(ServerRoomProxy.NAME) as ServerRoomProxy;					var myChar:PlayerCharProxy = facade.retrieveProxy(ApplicationFacade.MY_CHAR) as PlayerCharProxy;					sendNotification(ApplicationFacade.CHANGE_STATE, serverRoomProxy.getRoomType(myChar.isBanker()));					break;				case FarmHandlers.TASK_SUB_MENU_LIST:					showListText();					taskListMediator.showList(true);					taskListMediator.listenForSelection(false);					break;				case FarmHandlers.TASK_SUB_MENU_NEW:					var taskFormProxy:FormProxy = facade.retrieveProxy(FarmHandlers.TASK_EDIT_FORM) as FormProxy;					var taskForm:Form = taskFormProxy.getForm();					taskForm.setFieldEnabled(FarmHandlers.TASK_TYPE, true);					taskFormProxy.resetForm();					taskListMediator.showList(false);					taskFormMediator = new FormMediator(FarmHandlers.TASK_EDIT_FORM, null);					facade.registerMediator(taskFormMediator);										taskFormMediator.addToViewArea();										break;			}		}		private function displayEdit(taskFormMediator:FormMediator, taskListMediator:TaskListMediator):void {			var selectedId:String = taskListMediator.getSelectedTaskId();			var sideTxt:String = "Edit Task \n";			if(selectedId == null){				trace("SubMenuTasksCommand sez: We haz no tasks selected.");				taskListMediator.listenForSelection(true);				taskListMediator.showList(true);				taskListMediator.setDeleting(false);				sideTxt += "Select a task from the list to edit, complete the necessary changes, then click save to confirm.\n";				sideTxt += "\nClicking cancel will discard any changes you have made and return to the overview.";				sideTxt += "\n\nIf you need to change the type of task you will need to delete the task and create a new one.";				sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, sideTxt);			} else {				trace("SubMenuTasksCommand sez: We have task " + selectedId + " selected");				sideTxt += "Complete the changes you need to make to this task, then click save to confirm.\n";				sideTxt += "\nClicking cancel will discard any changes you have made and return to the overview.";								sideTxt += "\n\nIf you need to change the type of task you will need to cancel this edit, delete the task and create a new one.";				sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, sideTxt);				var taskListProxy:TaskListProxy = facade.retrieveProxy(TaskListProxy.NAME) as TaskListProxy;				var selectedTask:Task = taskListProxy.retrieveHouseholdTask(int(selectedId));				if(selectedTask == null){					throw new Error("We have a problem retrieving the task with id " + selectedId);				}				trace("SubMenuTasksCommand sez: We have retrieved task " + selectedId + " it is of type " + selectedTask.getType());				taskListMediator.showList(false);				taskFormMediator = new FormMediator(FarmHandlers.TASK_EDIT_FORM, null);				facade.registerMediator(taskFormMediator);									taskFormMediator.addToViewArea();								var taskFormProxy:FormProxy = facade.retrieveProxy(FarmHandlers.TASK_EDIT_FORM) as FormProxy;				var taskForm:Form = taskFormProxy.getForm();				taskForm.setFieldEnabled(FarmHandlers.TASK_TYPE, false);				taskFormProxy.updateFieldValue(FarmHandlers.TASK_TYPE, selectedTask.getType());				taskFormProxy.updateFieldValue(FarmHandlers.TASK_ID, selectedTask.getId().toString());				taskFormProxy.updateFieldValue(FarmHandlers.TASK_HEARTH, selectedTask.getHearthId().toString());				if(selectedTask.getLocation()!=null){					taskFormProxy.updateFieldValue(FarmHandlers.TASK_LOCATION, selectedTask.getLocation().getId().toString());				} else {					taskFormProxy.updateFieldValue(FarmHandlers.TASK_LOCATION, "0");				}				if(selectedTask.getActor()!=null){					taskFormProxy.updateFieldValue(FarmHandlers.TASK_ACTOR, selectedTask.getActor().getId().toString());				} else {					taskFormProxy.updateFieldValue(FarmHandlers.TASK_ACTOR, "0");				}				if(selectedTask.getAsset()!=null){					taskFormProxy.updateFieldValue(FarmHandlers.TASK_ASSET, selectedTask.getAsset().getId().toString());				} else {					taskFormProxy.updateFieldValue(FarmHandlers.TASK_ASSET, "0");				}			}		}		private function showListText():void {			var sideTxt:String = "Tasks \n";			sideTxt += "This is where you assign domestic and farming tasks for your household. Mandatory tasks (household chores and baby minding,  ";			sideTxt += "if there are babies in your household) are automatically created and must be completed or the household will incur a financial penalty. ";			sideTxt += "The farming tasks you can assign will change with the season.\n\n";			sideTxt += "Adults (characters 14 years and older) can complete 2 tasks each season; children can complete 1 domestic task each season.";			sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, sideTxt);		}		private function showDeleteText():void {			var sideTxt:String = "Tasks \n";			sideTxt += "Select a task from the list to delete and click confirm. Cancel exits without deleting.\n"; 			sideTxt += "\nDeleting cannot be undone!";			sendNotification(ApplicationFacade.DISPLAY_INFO_TEXT, sideTxt);		}	}}