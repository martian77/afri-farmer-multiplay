package uk.ac.sussex.gameEvents;

import java.util.List;
import java.util.Set;

import uk.ac.sussex.model.*;
import uk.ac.sussex.model.game.Game;
import uk.ac.sussex.model.tasks.*;

public class CoreCompleteTasksEvent extends GameEvent {

	public CoreCompleteTasksEvent(Game game) {
		super(game);
	}

	@Override
	public void fireEvent() throws Exception {
		TaskList taskList = game.fetchTaskList();
		HearthFactory hf = new HearthFactory();
		Set<Hearth> hearths = hf.fetchGameHearths(game);
		for (Hearth hearth : hearths){
			List<Task> hearthTasks = taskList.getHouseholdTasks(hearth);
			for (Task hearthTask : hearthTasks){
				if((hearthTask.getDeleted()==0) && (hearthTask.getStatus() == Task.PENDING)){
					hearthTask.execute();
				}
			}
		}
	}

	@Override
	public void generateNotifications() throws Exception {
		Set<Hearth> hearths = game.fetchHearths();
		PlayerCharFactory pcf = new PlayerCharFactory();
		SeasonNotificationFactory snf = new SeasonNotificationFactory();
		TaskList tl = game.fetchTaskList();
		
		String gmNotification = "Task Completion:\n";
		
		for(Hearth hearth: hearths){
			Set<PlayerChar> pcs = pcf.fetchHearthPCs(hearth);
			String notification = "Task Completion:\n";
			List<Task> seasonalTasks = tl.getCurrentHouseholdTasks(hearth);
			int taskCount = 0;
			int taskSuccess = 0;
			int taskFail = 0;
			for(Task task : seasonalTasks){
				if(task.getDeleted().equals(0)){
					taskCount++;
					notification += "Task " + task.getTaskNumber();
					if(task.getStatus().equals(Task.COMPLETED)){
						notification += " was completed successfully. ";
						taskSuccess ++;
					} else {
						notification += " could not be completed. ";
						taskFail++;
					}
					if(task.getNotes()!=null){
						notification += task.getNotes();
					}
					notification += "\n";
				}
			}
			snf.updateSeasonNotifications(notification, pcs);
			gmNotification += "Household " + hearth.getName() + " had " + taskCount + " tasks to complete. They successfully completed ";
			if(taskFail>0){
				gmNotification += taskSuccess + " and failed to complete " + taskFail + ".\n"; 
			} else {
				gmNotification += "all of them.\n";
			}
		}
		snf.updateBankerNotifications(gmNotification, game);
	}

}