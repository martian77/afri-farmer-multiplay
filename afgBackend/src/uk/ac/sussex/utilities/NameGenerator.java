/**
Copyright 2014 Future Agricultures Consortium  This file is part of the African Farmer Game - Multiplayer version.AFGAfrican Farmer Game - Multiplayer version is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

AFG-African Farmer Game - Multiplayer version is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with African Farmer Game - Multiplayer version.  If not, see <http://www.gnu.org/licenses/>.	
**/

package uk.ac.sussex.utilities;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import uk.ac.sussex.model.Role;

public class NameGenerator {
	public static String generateName(Role role, List<String> currentNames) {
		List<String> names = new ArrayList<String>();
		if(role.getId() == "WOMAN"){
			names.add("Jeruto");
			names.add("Mary");
			names.add("Faith");
			names.add("Eunice");
			names.add("Pamela");
			names.add("Doris");
			names.add("Margaret");
			names.add("Florence");
			names.add("Naomi");
			names.add("Jackline");
			names.add("Esther");
			names.add("Sally");
			names.add("Selina");
			names.add("Mercy");
			names.add("Caroline");
			names.add("Sharon");
			names.add("Rose");
			names.add("Sylvia");
			names.add("Viola");
			names.add("Irene");
			names.add("Hellen");
			names.add("Vivian");
			names.add("Peninah");
			names.add("Beatrice");
			names.add("Priscah");
			names.add("Delilah");
			names.add("Helena");
			names.add("Catherine");
			names.add("Emily");
			names.add("Gladys");
			names.add("Edna");
			names.add("Lornah");
			names.add("Agnes");
			names.add("Pauline");
			names.add("Lucia");
			names.add("Joyce");
			names.add("Magdaline");
			names.add("Alice");
			names.add("Jean");
			names.add("Joan");
			names.add("Edith");
			names.add("Jane");
            names.add("Emma");
            names.add("Lucy");
            names.add("Anne");
            names.add("Marie");
            names.add("Ruth");
            names.add("Valerie");
            names.add("Agnes");
            names.add("Angela");
            names.add("Louise");
            names.add("Ivy");
            names.add("Lulu");
            names.add("Abby");
            names.add("Liz");
            names.add("Lily");
            names.add("Cynthia");
            names.add("Jan");
            names.add("Claudia");
            names.add("Jo");
            names.add("Matilda");
            names.add("Sue");
            names.add("Milly");
            names.add("Nina");
            names.add("Gemma");
            names.add("Kirsty");
            names.add("Celia");
            names.add("Zoe");
            names.add("Rachel");
            names.add("Hilary");
		} else {
			names.add("McDonald");
			names.add("Victor");
			names.add("Dennis");
			names.add("Titus");
			names.add("Patrick");
			names.add("John");
			names.add("Simeon");
			names.add("Henry");
			names.add("Pascal");
			names.add("Kennedy");
			names.add("Sammy");
			names.add("Eric");
			names.add("George");
			names.add("Wycliffe");
			names.add("Austin");
			names.add("Robert");
			names.add("Bernard");
			names.add("Thomas");
			names.add("Ibrahim");
			names.add("James");
			names.add("Gideon");
			names.add("Lameck");
			names.add("Joseph");
			names.add("Mbarak");
			names.add("Simon");
			names.add("Jonas");
			names.add("David");
			names.add("Josaphat");
			names.add("Moses");
			names.add("Wilson");
			names.add("Richard");
			names.add("Joseph");
			names.add("Peter");
			names.add("Anthony");
			names.add("William");
			names.add("David");
			names.add("Frank");
			names.add("Fred");
			names.add("Andrew");
			names.add("Daniel");
			names.add("Bart");
			names.add("Aaron");
			names.add("Russell");
			names.add("Mark");
			names.add("Evan");
			names.add("Ralph");
			names.add("Nathan");
			names.add("Terry");
			names.add("Boyd");
			names.add("Neil");
			names.add("Eddie");
			names.add("Noah");
			names.add("Jude");
			names.add("Max");
			names.add("Jason");
			names.add("Spencer");
			names.add("Dean");
			names.add("Arthur");
			names.add("Basil");
			names.add("Morris");
		}
		names.removeAll(currentNames);
		int rnd = new Random().nextInt(names.size());
		return names.get(rnd);
	}
	public static String generateFamilyName() {
		List<String> names = new ArrayList<String>();
		names.add("Stroberi");
		names.add("Tufaha");
		names.add("Ubuyu");
		names.add("Matango");
		names.add("Carom");
		names.add("Ndimu");
		names.add("Tende");
		names.add("Tikiti");
		names.add("Limau");
		names.add("Mronge");
		names.add("Uyoga");
		int rnd = new Random().nextInt(names.size());
		
		return names.get(rnd);
	}
}
