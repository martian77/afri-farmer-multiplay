/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.AFGAfrican Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

AFG-African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.gameEvents;

import java.util.List;
import java.util.Set;

import uk.ac.sussex.model.*;
import uk.ac.sussex.model.game.Game;
/**
 * This event works best as a pre-stage event for the start of a new year. 
 * @author em97
 *
 */
public class CoreGenerateFieldHistoryEvent extends GameEvent {
	public CoreGenerateFieldHistoryEvent(Game game) {
		super(game);
	}
	
	@Override
	public void fireEvent() throws Exception {
		FieldFactory ff = new FieldFactory();
		HearthFactory hf = new HearthFactory();
		PlayerCharFactory pcf = new PlayerCharFactory();
		
		Set<Hearth> hearths = hf.fetchGameHearths(game);
		for (Hearth hearth : hearths){
			List<Field> fields = ff.getHearthFields(hearth);
			for(Field field: fields){
				ff.createHearthFieldHistory(field, hearth);
			}
		}
		
		Set<PlayerChar> pcs = pcf.fetchGamePCs(game);
		for(PlayerChar pc: pcs){
			List<Field> fields = ff.getPCFields(pc);
			for(Field field: fields){
				ff.createPCFieldHistory(field, pc);
			}
		}
		//TODO do this for the game manager fields as well. 
	}

	@Override
	public void generateNotifications() throws Exception {
		// TODO Auto-generated method stub

	}

}
