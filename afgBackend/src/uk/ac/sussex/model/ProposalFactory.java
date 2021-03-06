/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.AFGAfrican Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

AFG-African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.model;

import java.util.ArrayList;
import java.util.List;

import uk.ac.sussex.model.base.BaseFactory;
import uk.ac.sussex.model.base.BaseObject;
import uk.ac.sussex.model.base.RestrictionList;

public class ProposalFactory extends BaseFactory {
	public ProposalFactory(){
		super(new Proposal());
	}
	public Proposal fetchProposal(Integer propId) throws Exception {
		return (Proposal) this.fetchSingleObject(propId);
	}
	public List<Proposal> fetchOutgoingHearthProposals(Hearth hearth) throws Exception {
		RestrictionList rl = new RestrictionList();
		rl.addEqual("proposerHearth", hearth);
		List<BaseObject> objects = this.fetchManyObjects(rl);
		return translateFromBaseObjects(objects);
	}
	public List<Proposal> fetchIncomingHearthProposals(Hearth hearth) throws Exception {
		RestrictionList rl = new RestrictionList();
		rl.addEqual("targetHearth", hearth);
		List<BaseObject> objects = this.fetchManyObjects(rl);
		
		List<Proposal> proposals = new ArrayList<Proposal>();
		Integer hearthId = hearth.getId();
		for (BaseObject object: objects){
			Proposal prop = (Proposal) object;
			if(prop.getProposerHearth()==null || !prop.getProposerHearth().getId().equals(hearthId)){
				proposals.add(prop);
			}
		}
		
		RestrictionList rl2 = new RestrictionList();
		rl2.addEqual("currentHearth", hearth);
		List<BaseObject> objects2 = this.fetchManyObjects(rl2);
		for (BaseObject object: objects2) {
			Proposal prop = (Proposal) object;
			if(prop.getCurrentHearth()!=null && (prop.getProposerHearth()==null || !prop.getProposerHearth().getId().equals(hearthId))){
				proposals.add(prop);
			}
		}

		return proposals;
	}
	public List<Proposal> fetchOutgoingPersonProposals(PlayerChar pc) throws Exception {
		RestrictionList rl = new RestrictionList();
		rl.addEqual("proposer", pc);
		List<BaseObject> objects = this.fetchManyObjects(rl);
		return translateFromBaseObjects(objects);
	}
	public List<Proposal> fetchIncomingPersonProposals(AllChars pc) throws Exception {
		RestrictionList rl = new RestrictionList();
		rl.addEqual("target", pc);
		List<BaseObject> objects = this.fetchManyObjects(rl);
		return translateFromBaseObjects(objects);
	}
	private List<Proposal> translateFromBaseObjects(List<BaseObject> baseObjects){
		List<Proposal> proposals = new ArrayList<Proposal>();
		for (BaseObject object: baseObjects){
			proposals.add((Proposal) object);
		}
		return proposals;
	}
}
