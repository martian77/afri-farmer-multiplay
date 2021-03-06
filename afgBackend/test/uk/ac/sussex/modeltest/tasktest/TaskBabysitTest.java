/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.AFGAfrican Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

AFG-African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.modeltest.tasktest;

import static org.junit.Assert.*;

import java.util.Set;

import org.junit.Test;

import uk.ac.sussex.model.Hearth;
import uk.ac.sussex.model.HearthFactory;
import uk.ac.sussex.model.game.Game;
import uk.ac.sussex.model.game.GameFactory;
import uk.ac.sussex.model.tasks.TaskBabysit;
import uk.ac.sussex.model.tasks.TaskList;
import uk.ac.sussex.model.tasks.TaskOption;

public class TaskBabysitTest {

	@Test
	public void testExecute() {
		fail("Not yet implemented");
	}

	@Test
	public void testFetchPossibleLocations() {
		Hearth household = this.getHousehold();
		TaskBabysit testTask = new TaskBabysit();
		Set<TaskOption> locations = testTask.fetchPossibleLocations(household);
		assertNotNull(locations);
		assertEquals(1, locations.size());
		for (TaskOption loc: locations){
			System.out.println(loc.getNotes());
			assertNull(loc.getNotes());
		}
	}

	@Test
	public void testFetchPossibleActors() {
		Hearth household = this.getHousehold();
		TaskBabysit testTask = new TaskBabysit();
		Set<TaskOption> actors = testTask.fetchPossibleActors(household);
		assertNotNull(actors);
		assertEquals(3, actors.size());
	}

	@Test
	public void testFetchPossibleAssets() {
		TaskBabysit testTask = new TaskBabysit();
		Hearth household = this.getHousehold();
		assertNull(testTask.fetchPossibleAssets(household));
	}
	
	@Test 
	public void testCreateNew() {
		TaskList tl = null;
		try {
			GameFactory gf = new GameFactory();
			Game game = gf.fetchGame(1);
			tl = game.fetchTaskList();
		} catch (Exception e) {
			e.printStackTrace();
			fail("Problem getting the tasklist");
		}
		try {
			TaskBabysit testTask = (TaskBabysit) tl.newTaskInstance(TaskBabysit.TASKTYPE);
			assertTrue(testTask.getDisplayName().equals("Babysit"));
		} catch (Exception e) {
			e.printStackTrace();
			fail("We didn't manage to create the task.");
		}
	}
	
	private Hearth getHousehold() {
		HearthFactory hf = new HearthFactory();
		try {
			Hearth household = hf.fetchHearth(160);
			return household;
		} catch (Exception e) {
			e.printStackTrace();
			fail("We didn't manage to get the household we needed.");
		}
		return null;
	}
}
