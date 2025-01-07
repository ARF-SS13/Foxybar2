///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
/// DONT TICK THIS FILE

/* 
	dat += "<center><h2>Quest Board UID</h2>"
	dat += "[quester_uid]</center>"
	var/cash_change = SSeconomy.player_login(src)
	var/list/llogin_msg = list()
	llogin_msg += "<center><B>Last Login:</B> [time2text(last_quest_login)]"
	llogin_msg += " <B>Banked Cash:</B> [SSeconomy.format_currency(saved_unclaimed_points, TRUE)]"
	if(cash_change > 0)
		llogin_msg += " ([span_green("[SSeconomy.format_currency(cash_change, TRUE)]")] activity bonus)"
	else if(cash_change < 0)
		llogin_msg += " ([span_alert("[SSeconomy.format_currency(cash_change, TRUE)]")] inactivity tax)"
	llogin_msg += "</center>"
	dat += llogin_msg.Join()
	if(CONFIG_GET(flag/roundstart_traits))
		dat += "<center>"
		if(SSquirks.initialized && !(PMC_QUIRK_OVERHAUL_2K23 in current_version))
			dat += "<a href='?_src_=prefs;preference=quirk_migrate'>CLICK HERE to migrate your old quirks to the new system!</a>"
		dat += "<a href='?_src_=prefs;preference=quirkmenu'>"
		dat += "<h2>Configure Quirks</a></h2><br></center>"
		dat += "</a>"
		dat += "<center><b>Current Quirks:</b> [get_my_quirks()]</center>"
	dat += "<center><h2>S.P.E.C.I.A.L.</h2>"
	dat += "<a href='?_src_=prefs;preference=special;task=menu'>Allocate Points</a><br></center>"
	//Left Column
	dat += "<table><tr><td width='70%'valign='top'>"
	dat += "<h2>Identity</h2>"
	if(jobban_isbanned(user, "appearance"))
		dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"

	dat += "<a href='?_src_=prefs;preference=setup_hornychat;task=input'>Configure VisualChat / Profile Pictures!</a><BR>"
	dat += "<b>Name:</b> "
	dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

	dat += "<b>Gender:</b> <a href='?_src_=prefs;preference=gender;task=input'>[gender == MALE ? "Male" : (gender == FEMALE ? "Female" : (gender == PLURAL ? "Non-binary" : "Object"))]</a><BR>"
	dat += "<b>Age:</b> <a style='display:block;width:30px' href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"
	dat += "<b>Top/Bottom/Switch:</b> <a href='?_src_=prefs;preference=tbs;task=input'>[tbs || "Set me!"]</a><BR>"
	dat += "<b>Orientation:</b> <a href='?_src_=prefs;preference=kisser;task=input'>[kisser || "Set me!"]</a><BR>"
	dat += "<b>When you despawn, all your equipment...</b> <a href='?_src_=prefs;preference=stash_equipment_on_logout;task=input'>[stash_equipment_on_logout?"will be left where you despawn":"will be deleted"]</a><BR>"
	dat += "<b>Your equipment, if left behind...</b> <a href='?_src_=prefs;preference=lock_equipment_on_logout;task=input'>[lock_equipment_on_logout?"will be locked (only you can open it)":"will be open for everyone"]</a><BR>"
	dat += "</td>"
	// //Middle Column
	// dat +="<td width='30%' valign='top'>"
	// dat += "<h2>Matchmaking preferences:</h2>"
	// if(SSmatchmaking.initialized)
	// 	for(var/datum/matchmaking_pref/match_pref as anything in SSmatchmaking.all_match_types)
	// 		var/max_matches = initial(match_pref.max_matches)
	// 		if(!max_matches)
	// 			continue // Disabled.
	// 		var/current_value = clamp((matchmaking_prefs[match_pref] || 0), 0, max_matches)
	// 		var/set_name = !current_value ? "Disabled" : (max_matches == 1 ? "Enabled" : "[current_value]")
	// 		dat += "<b>[initial(match_pref.pref_text)]:</b> <a href='?_src_=prefs;preference=set_matchmaking_pref;matchmake_type=[match_pref]'>[set_name]</a><br>"
	// else
	// 	dat += "<b>Loading matchmaking preferences...</b><br>"
	// 	dat += "<b>Refresh once the game has finished setting up...</b><br>"
	// dat += "</td>"

	//Right column
	dat +="<td width='30%' valign='top'>"
	dat += "<a href='?_src_=prefs;preference=setup_hornychat;task=input'>Configure VisualChat / Profile Pictures!</a><BR>"
	// dat += "<h2>Profile Picture ([pfphost]):</h2><BR>"
	var/pfplink = SSchat.GetPicForMode(user, MODE_PROFILE_PIC)
	dat += "<b>Picture:</b> <a href='?_src_=prefs;preference=setup_hornychat;task=input'>[pfplink ? "<img src=[pfplink] width='125' height='auto' max-height='300'>" : "Upload a picture!"]</a><BR>"
	dat += "</td>"
	/*
	dat += "<b>Special Names:</b><BR>"
	var/old_group
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/namedata = GLOB.preferences_custom_names[custom_name_id]
		if(!old_group)
			old_group = namedata["group"]
		else if(old_group != namedata["group"])
			old_group = namedata["group"]
			dat += "<br>"
		dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
	dat += "<br><br>"

	Records disabled until a use for them is found
	dat += "<b>Custom job preferences:</b><BR>"
	dat += "<a href='?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"
	dat += "<a href='?_src_=prefs;preference=sec_dept;task=input'><b>Preferred Security Department:</b> [prefered_security_department]</a><BR></td>"
	dat += "<br>Records</b><br>"
	dat += "<br><a href='?_src_=prefs;preference=security_records;task=input'><b>Security Records</b></a><br>"
	if(length_char(security_records) <= 40)
		if(!length(security_records))
			dat += "\[...\]"
		else
			dat += "[security_records]"
	else
		dat += "[TextPreview(security_records)]...<BR>"

	dat += "<br><a href='?_src_=prefs;preference=medical_records;task=input'><b>Medical Records</b></a><br>"
	if(length_char(medical_records) <= 40)
		if(!length(medical_records))
			dat += "\[...\]<br>"
		else
			dat += "[medical_records]"
	else
		dat += "[TextPreview(medical_records)]...<BR>"
	dat += "<br><b>Hide ckey: <a href='?_src_=prefs;preference=hide_ckey;task=input'>[hide_ckey ? "Enabled" : "Disabled"]</b></a><br>"
	*/
	dat += "</tr></table>"
 */




/* 
	for(var/mutant_part in GLOB.all_mutant_parts)
		if(mutant_part == "mam_body_markings")
			continue
		if(parent.can_have_part(mutant_part))
			if(!mutant_category)
				dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<h3>[GLOB.all_mutant_parts[mutant_part]]</h3>"
			dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=[mutant_part];task=input'>[features[mutant_part]]</a>"
			var/color_type = GLOB.colored_mutant_parts[mutant_part] //if it can be coloured, show the appropriate button
			if(color_type)
				dat += "<span style='border:1px solid #161616; background-color: #[features[color_type]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[color_type];task=input'>Change</a><BR>"
			else
				if(features["color_scheme"] == ADVANCED_CHARACTER_COLORING) //advanced individual part colouring system
					//is it matrixed or does it have extra parts to be coloured?
					var/find_part = features[mutant_part] || pref_species.mutant_bodyparts[mutant_part]
					var/find_part_list = GLOB.mutant_reference_list[mutant_part]
					if(find_part && find_part != "None" && find_part_list)
						var/datum/sprite_accessory/accessory = find_part_list[find_part]
						if(accessory)
							if(accessory.color_src == MATRIXED || accessory.color_src == MUTCOLORS || accessory.color_src == MUTCOLORS2 || accessory.color_src == MUTCOLORS3) //mutcolors1-3 are deprecated now, please don't rely on these in the future
								var/mutant_string = accessory.mutant_part_string
								var/primary_feature = "[mutant_string]_primary"
								var/secondary_feature = "[mutant_string]_secondary"
								var/tertiary_feature = "[mutant_string]_tertiary"
								if(!features[primary_feature])
									features[primary_feature] = features["mcolor"]
								if(!features[secondary_feature])
									features[secondary_feature] = features["mcolor2"]
								if(!features[tertiary_feature])
									features[tertiary_feature] = features["mcolor3"]

					var/matrixed_sections = accessory.matrixed_sections
					if(accessory.color_src == MATRIXED && !matrixed_sections)
						message_admins("Sprite Accessory Failure (customization): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
						continue
					else if(accessory.color_src == MATRIXED)
						switch(matrixed_sections)
							if(MATRIX_GREEN) //only composed of a green section
								primary_feature = secondary_feature //swap primary for secondary, so it properly assigns the second colour, reserved for the green section
							if(MATRIX_BLUE)
								primary_feature = tertiary_feature //same as above, but the tertiary feature is for the blue section
							if(MATRIX_RED_BLUE) //composed of a red and blue section
								secondary_feature = tertiary_feature //swap secondary for tertiary, as blue should always be tertiary
							if(MATRIX_GREEN_BLUE) //composed of a green and blue section
								primary_feature = secondary_feature //swap primary for secondary, as first option is green, which is linked to the secondary
								secondary_feature = tertiary_feature //swap secondary for tertiary, as second option is blue, which is linked to the tertiary
					dat += "<b>Primary Color</b><BR>"
					dat += "<span style='border:1px solid #161616; background-color: #[features[primary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[primary_feature];task=input'>Change</a><BR>"
					if((accessory.color_src == MATRIXED && (matrixed_sections == MATRIX_RED_BLUE || matrixed_sections == MATRIX_GREEN_BLUE || matrixed_sections == MATRIX_RED_GREEN || matrixed_sections == MATRIX_ALL)) || (accessory.extra && (accessory.extra_color_src == MUTCOLORS || accessory.extra_color_src == MUTCOLORS2 || accessory.extra_color_src == MUTCOLORS3)))
						dat += "<b>Secondary Color</b><BR>"
						dat += "<span style='border:1px solid #161616; background-color: #[features[secondary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[secondary_feature];task=input'>Change</a><BR>"
						if((accessory.color_src == MATRIXED && matrixed_sections == MATRIX_ALL) || (accessory.extra2 && (accessory.extra2_color_src == MUTCOLORS || accessory.extra2_color_src == MUTCOLORS2 || accessory.extra2_color_src == MUTCOLORS3)))
							dat += "<b>Tertiary Color</b><BR>"
							dat += "<span style='border:1px solid #161616; background-color: #[features[tertiary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[tertiary_feature];task=input'>Change</a><BR>"

			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS)
				dat += "</td>"
				mutant_category = 0
 */

/* 

			//	START COLUMN 1
			dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Body</h3>"
			
			dat += "<b>Species:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><BR>"
			
			if(LAZYLEN(pref_species.alt_prefixes))
				dat += "<b>Alt Appearance:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=species_alt_prefix;task=input'>[alt_appearance ? alt_appearance : "Select"]</a><BR>"

			dat += "<b>Custom Species Name:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=custom_species;task=input'>[custom_species ? custom_species : "None"]</a><BR>"
			
			dat += "<b>Gender:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=gender;task=input'>[gender == MALE ? "Male" : (gender == FEMALE ? "Female" : (gender == PLURAL ? "Non-binary" : "Object"))]</a><br>"
			
			if(gender != NEUTER && pref_species.sexes)
				dat += "<b>Body Model:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=body_model'>[features["body_model"] == MALE ? "Masculine" : "Feminine"]</a><br>"
			
			if(length(pref_species.allowed_limb_ids))
				if(!chosen_limb_id || !(chosen_limb_id in pref_species.allowed_limb_ids))
					chosen_limb_id = pref_species.limbs_id || pref_species.id
				dat += "<b>Body Sprite:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=bodysprite;task=input'>[chosen_limb_id]</a><br>"
			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN
			var/use_skintones = pref_species.use_skintones			
			var/mutant_colors
			if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))
				if(!use_skintones)
					dat += "<b>Primary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"

					dat += "<b>Secondary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mcolor2;task=input'>Change</a><BR>"

					dat += "<b>Tertiary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mcolor3;task=input'>Change</a><BR>"
					mutant_colors = TRUE
			
			if(use_skintones)
				dat += "<h3>Skin Tone</h3>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=s_tone;task=input'>[use_custom_skin_tone ? "custom: <span style='border:1px solid #161616; background-color: [skin_tone];'>&nbsp;&nbsp;&nbsp;</span>" : skin_tone]</a><BR>"
			
			if (CONFIG_GET(number/body_size_min) != CONFIG_GET(number/body_size_max))
				dat += "<b>Sprite Size:</b> <a href='?_src_=prefs;preference=body_size;task=input'>[features["body_size"]*100]%</a><br>"
			if (CONFIG_GET(number/body_width_min) != CONFIG_GET(number/body_width_max))
				dat += "<b>Sprite Width:</b> <a href='?_src_=prefs;preference=body_width;task=input'>[features["body_width"]*100]%</a><br>"
			dat += "<b>Scaling:</b> <a href='?_src_=prefs;preference=toggle_fuzzy;task=input'>[fuzzy ? "Fuzzy" : "Sharp"]</a><br>"


			dat += "</td>"
			//	END COLUMN 1
			//  START COLUMN 2
			dat += APPEARANCE_CATEGORY_COLUMN
			if(!(NOEYES in pref_species.species_traits))
				dat += "<h3>Eyes</h3>"
				dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=eye_type;task=input'>[eye_type]</a>"
				if((EYECOLOR in pref_species.species_traits))
					if(!use_skintones && !mutant_colors)
						dat += APPEARANCE_CATEGORY_COLUMN
					if(left_eye_color != right_eye_color)
						split_eye_colors = TRUE
					dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_eye_over_hair;task=input'>[eye_over_hair ? "Over Hair" : "Under Hair"]</a>"
					dat += "<b>Heterochromia</b><br>"
					dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_split_eyes;task=input'>[split_eye_colors ? "Enabled" : "Disabled"]</a>"
					if(!split_eye_colors)
						dat += "<b>Eye Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[left_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a><br>"
					else
						dat += "<b>Left Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[left_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eye_left;task=input'>Change</a><br>"
						dat += "<b>Right Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[right_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eye_right;task=input'>Change</a><br>"
			//  END COLUMN 2
			dat += APPEARANCE_CATEGORY_COLUMN
			if(HAIR in pref_species.species_traits)
				dat += "<h3>Hair</h3>"
				dat += "<b>Style Up:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=hair_style;task=input'>[hair_style]<br>"
				dat += "<a href='?_src_=prefs;preference=previous_hair_style;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hair_style;task=input'>&gt;</a><br>"
				dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><br><BR>"

				// Coyote ADD: Hair gradients
				dat += "<b>Gradient Up:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=grad_style;task=input'>[features_override["grad_style"]]</a>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["grad_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=grad_color;task=input'>Change</a><br><BR>"
				// Coyote ADD: End

				dat += "<b>Style Down:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=hair_style_2;task=input'>[features_override["hair_style_2"]]</a>"
				dat += "<a href='?_src_=prefs;preference=previous_hair_style_2;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hair_style_2;task=input'>&gt;</a><br>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["hair_color_2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair_color_2;task=input'>Change</a><br><BR>"

				dat += "<b>Gradient Down:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=grad_style_2;task=input'>[features_override["grad_style_2"]]</a>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["grad_color_2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=grad_color_2;task=input'>Change</a><br><BR>"

				dat += "<b>Facial Style:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=facial_hair_style;task=input'>[facial_hair_style]<br>"
				dat += "<a href='?_src_=prefs;preference=previous_facehair_style;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_facehair_style;task=input'>&gt;</a><br>"
				dat += "<span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=facial;task=input'>Change</a><br><BR>"

			dat += "<b>Show/hide Undies:</b><br>"
			dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_undie_preview;task=input'>[preview_hide_undies ? "Hidden" : "Visible"]<br>"

			dat += "</td>"

			//end column 3 or something
			//start column 4
			dat += APPEARANCE_CATEGORY_COLUMN
			//Waddling
			dat += "<h3>Waddling</h3>"
			dat += "<b>Waddle Amount:</b><a href='?_src_=prefs;preference=waddle_amount;task=input'>[waddle_amount]</a><br>"
			if(waddle_amount > 0)
				dat += "</b><a href='?_src_=prefs;preference=up_waddle_time;task=input'>&harr; Speed:[up_waddle_time]</a><br>"
				dat += "</b><a href='?_src_=prefs;preference=side_waddle_time;task=input'>&#8597 Speed:[side_waddle_time]</a><br>"
			
			
			dat += "<h3>Misc</h3>"
			dat += "<b>Custom Taste:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=taste;task=input'>[features["taste"] ? features["taste"] : "something"]</a><br>"
			dat += "<b>Runechat Color:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=chat_color;task=input;background-color: #[features["chat_color"]]'>#[features["chat_color"]]</span></a><br>"
			dat += "<b>Blood Color:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=blood_color;task=input;background-color: #[features["blood_color"]]'>#[features["blood_color"]]</span></a><br>"
			dat += "<a href='?_src_=prefs;preference=reset_blood_color;task=input'>Reset Blood Color</A><BR>"
			dat += "<a href='?_src_=prefs;preference=rainbow_blood_color;task=input'>Rainbow Blood Color</A><BR>"
			dat += "<b>Background:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=cycle_bg;task=input'>[bgstate]</a><br>"
			dat += "<b>Pixel Offsets</b><br>"
			var/px = custom_pixel_x > 0 ? "+[custom_pixel_x]" : "[custom_pixel_x]"
			var/py = custom_pixel_y > 0 ? "+[custom_pixel_y]" : "[custom_pixel_y]"
			dat += "<a href='?_src_=prefs;preference=pixel_x;task=input'>&harr;[px]</a><br>"
			dat += "<a href='?_src_=prefs;preference=pixel_y;task=input'>&#8597;[py]</a><br>"
			
			dat += "</td>"
			//Mutant stuff
			var/mutant_category = 0
			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS) //just in case someone sets the max rows to 1 or something dumb like that
				dat += "</td>"
				mutant_category = 0

			// rp marking selection
			// assume you can only have mam markings or regular markings or none, never both
			var/marking_type
			dat += APPEARANCE_CATEGORY_COLUMN
			if(parent.can_have_part("mam_body_markings"))
				marking_type = "mam_body_markings"
			if(marking_type)
				dat += "<h3>[GLOB.all_mutant_parts[marking_type]]</h3>" // give it the appropriate title for the type of marking
				dat += "<a href='?_src_=prefs;preference=marking_add;marking_type=[marking_type];task=input'>Add marking</a>"
				// list out the current markings you have
				if(length(features[marking_type]))
					dat += "<table>"
					var/list/markings = features[marking_type]
					if(!islist(markings))
						// something went terribly wrong
						markings = list()
					var/list/reverse_markings = reverseList(markings)
					for(var/list/marking_list in reverse_markings)
						var/marking_index = markings.Find(marking_list) // consider changing loop to go through indexes over lists instead of using Find here
						var/limb_value = marking_list[1]
						var/actual_name = GLOB.bodypart_names[num2text(limb_value)] // get the actual name from the bitflag representing the part the marking is applied to
						var/color_marking_dat = ""
						var/number_colors = 1
						var/datum/sprite_accessory/mam_body_markings/S = GLOB.mam_body_markings_list[marking_list[2]]
						var/matrixed_sections = S.covered_limbs[actual_name]
						if(S && matrixed_sections)
							// if it has nothing initialize it to white
							if(length(marking_list) == 2)
								var/first = "#FFFFFF"
								var/second = "#FFFFFF"
								var/third = "#FFFFFF"
								if(features["mcolor"])
									first = "#[features["mcolor"]]"
								if(features["mcolor2"])
									second = "#[features["mcolor2"]]"
								if(features["mcolor3"])
									third = "#[features["mcolor3"]]"
								marking_list += list(list(first, second, third)) // just assume its 3 colours if it isnt it doesnt matter we just wont use the other values
							// index magic
							var/primary_index = 1
							var/secondary_index = 2
							var/tertiary_index = 3
							switch(matrixed_sections)
								if(MATRIX_GREEN)
									primary_index = 2
								if(MATRIX_BLUE)
									primary_index = 3
								if(MATRIX_RED_BLUE)
									secondary_index = 2
								if(MATRIX_GREEN_BLUE)
									primary_index = 2
									secondary_index = 3

							// we know it has one matrixed section at minimum
							color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][primary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
							// if it has a second section, add it
							if(matrixed_sections == MATRIX_RED_BLUE || matrixed_sections == MATRIX_GREEN_BLUE || matrixed_sections == MATRIX_RED_GREEN || matrixed_sections == MATRIX_ALL)
								color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][secondary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
								number_colors = 2
							// if it has a third section, add it
							if(matrixed_sections == MATRIX_ALL)
								color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][tertiary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
								number_colors = 3
							color_marking_dat += " <a href='?_src_=prefs;preference=marking_color;marking_index=[marking_index];marking_type=[marking_type];number_colors=[number_colors];task=input'>Change</a><BR>"
						dat += "<tr><td>[marking_list[2]] - [actual_name]</td> <td><a href='?_src_=prefs;preference=marking_down;task=input;marking_index=[marking_index];marking_type=[marking_type];'>&#708;</a> <a href='?_src_=prefs;preference=marking_up;task=input;marking_index=[marking_index];marking_type=[marking_type]'>&#709;</a> <a href='?_src_=prefs;preference=marking_remove;task=input;marking_index=[marking_index];marking_type=[marking_type]'>X</a> [color_marking_dat]</td></tr>"
					dat += "</table>"


///////////////////////////////////////////////////////////////////////////////////
			if(mutant_category)
				dat += "</td>"
				mutant_category = 0

			dat += "</tr></table>"

			dat += "</td>"

			dat += "</tr></table>"
			/*Uplink choice disabled since not implemented, pointless button
			dat += "<b>Uplink Location:</b><a style='display:block;width:100px' href ='?_src_=prefs;preference=uplink_loc;task=input'>[uplink_spawn_loc]</a>"
			dat += "</td>"*/

			/// HA HA! I HAVE DELETED YOUR PRECIOUS NAUGHTY PARTS, YOU HORNY ANIMALS! 
			/* dat +="<td width='220px' height='300px' valign='top'>" //
			if(NOGENITALS in pref_species.species_traits)
				dat += "<b>Your species ([pref_species.name]) does not support genitals!</b><br>"
			else
				dat += "<h3>Penis</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_cock'>[features["has_cock"] == TRUE ? "Yes" : "No"]</a>"
				if(features["has_cock"])
					if(!pref_species.use_skintones)
						dat += "<b>Penis Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["cock_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=cock_color;task=input'>Change</a><br>"
					var/tauric_shape = FALSE
					if(features["cock_taur"])
						var/datum/sprite_accessory/penis/P = GLOB.cock_shapes_list[features["cock_shape"]]
						if(P.taur_icon && parent.can_have_part("taur"))
							var/datum/sprite_accessory/taur/T = GLOB.taur_list[features["taur"]]
							if(T.taur_mode & P.accepted_taurs)
								tauric_shape = TRUE
					dat += "<b>Penis Shape:</b> <a style='display:block;width:120px' href='?_src_=prefs;preference=cock_shape;task=input'>[features["cock_shape"]][tauric_shape ? " (Taur)" : ""]</a>"
					dat += "<b>Penis Length:</b> <a style='display:block;width:120px' href='?_src_=prefs;preference=cock_length;task=input'>[features["cock_length"]] inch(es)</a>"
					dat += "<b>Penis Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=cock_visibility;task=input'>[features["cock_visibility"]]</a>"
					dat += "<b>Has Testicles:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=has_balls'>[features["has_balls"] == TRUE ? "Yes" : "No"]</a>"
					if(features["has_balls"])
						if(!pref_species.use_skintones)
							dat += "<b>Testicles Type:</b> <a style='display:block;width:100px' href='?_src_=prefs;preference=balls_shape;task=input'>[features["balls_shape"]]</a>"
							dat += "<b>Testicles Color:</b></a><BR>"
							dat += "<span style='border: 1px solid #161616; background-color: #[features["balls_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=balls_color;task=input'>Change</a><br>"
						dat += "<b>Testicles Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=balls_visibility;task=input'>[features["balls_visibility"]]</a>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Vagina</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_vag'>[features["has_vag"] == TRUE ? "Yes": "No" ]</a>"
				if(features["has_vag"])
					dat += "<b>Vagina Type:</b> <a style='display:block;width:100px' href='?_src_=prefs;preference=vag_shape;task=input'>[features["vag_shape"]]</a>"
					if(!pref_species.use_skintones)
						dat += "<b>Vagina Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["vag_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=vag_color;task=input'>Change</a><br>"
					dat += "<b>Vagina Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=vag_visibility;task=input'>[features["vag_visibility"]]</a>"
					dat += "<b>Has Womb:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=has_womb'>[features["has_womb"] == TRUE ? "Yes" : "No"]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Breasts</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_breasts'>[features["has_breasts"] == TRUE ? "Yes" : "No" ]</a>"
				if(features["has_breasts"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["breasts_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=breasts_color;task=input'>Change</a><br>"
					dat += "<b>Cup Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_size;task=input'>[features["breasts_size"]]</a>"
					dat += "<b>Breasts Shape:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_shape;task=input'>[features["breasts_shape"]]</a>"
					dat += "<b>Breasts Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=breasts_visibility;task=input'>[features["breasts_visibility"]]</a>"
					dat += "<b>Lactates:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_producing'>[features["breasts_producing"] == TRUE ? "Yes" : "No"]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Belly</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_belly'>[features["has_belly"] == TRUE ? "Yes" : "No" ]</a>"
				if(features["has_belly"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["belly_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=belly_color;task=input'>Change</a><br>"
					dat += "<b>Belly Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=belly_size;task=input'>[features["belly_size"]]</a>"
					dat += "<b>Belly Shape:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=belly_shape;task=input'>[features["belly_shape"]]</a>"
					dat += "<b>Belly Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=belly_visibility;task=input'>[features["belly_visibility"]]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Butt</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_butt'>[features["has_butt"] == TRUE ? "Yes" : "No"]</a>"
				if(features["has_butt"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["butt_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=butt_color;task=input'>Change</a><br>"
					dat += "<b>Butt Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=butt_size;task=input'>[features["butt_size"]]</a>"
					dat += "<b>Butt Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=butt_visibility;task=input'>[features["butt_visibility"]]</a>"
				dat += "</td>"
			dat += "</td>"
			dat += "</tr></table>"*/


///////////////////////////////////////////////////////
			if(NOGENITALS in pref_species.species_traits)
				dat += "<div class='gen_setting_name'>Your species ([pref_species.name]) does not support genitals! These won't apply to your species!</div><br><hr>"
			dat += {"<a 
						href='
							?_src_=prefs;
							preference=erp_tab;
							newtab=[ERP_TAB_REARRANGE]' 
							[current_tab == ERP_TAB_REARRANGE ? "class='linkOn'" : ""]>
								Layering and Visibility
					</a>"}
			dat += {"<a 
						href='
							?_src_=prefs;
							preference=erp_tab;
							newtab=[ERP_TAB_HOME]' 
							[current_tab == ERP_TAB_HOME ? "class='linkOn'" : ""]>
								Underwear and Socks
					</a>"}
			dat += "<br>"
			// here be gonads
			for(var/dic in PREFS_ALL_HAS_GENITALS)
				dat += {"<a 
							href='
								?_src_=prefs;
								preference=erp_tab;
								newtab=[dic];
								nonumber=yes' 
								[current_tab == dic ? "class='linkOn'" : ""]>
									[GLOB.hasgenital2genital[dic]]
						</a>"}
			dat += "</center>"
			dat += "<br>"

			switch(erp_tab_page)
				if(ERP_TAB_REARRANGE)
					var/list/all_genitals = decode_cockstring() // i made it i can call it whatever I want
					var/list/genitals_we_have = list()
					dat += "<table class='table_genital_list'>"
					dat += "<tr>"
					dat += "<td class='genital_name'></td>"
					dat += "<td colspan='2' class='genital_name'>Shift</td>"
					dat += "<td colspan='2' class='genital_name'>Hidden by...</td>"
					dat += "<td class='genital_name'>Override</td>"
					dat += "<td class='genital_name'>See on others?</td>"
					dat += "</tr>"

					for(var/nad in all_genitals)
						genitals_we_have += nad
					if(LAZYLEN(all_genitals))
						for(var/i in 1 to LAZYLEN(genitals_we_have))
							dat += add_genital_layer_piece(genitals_we_have[i], i, LAZYLEN(genitals_we_have))
					else
						dat += "I dont seem to have any movable genitals!"
					dat += "<tr>"
					dat += "<td colspan='4' class='genital_name'>Hide Undies In Preview</td>"
					/* var/genital_shirtlayer
					if(CHECK_BITFIELD(features["genital_visibility_flags"], GENITAL_ABOVE_UNDERWEAR))
						genital_shirtlayer = "Over Underwear"
					else if(CHECK_BITFIELD(features["genital_visibility_flags"], GENITAL_ABOVE_CLOTHING))
						genital_shirtlayer = "Over Clothes"
					else
						genital_shirtlayer = "Under Underwear" */
					dat += {"<td class='coverage_on'>
							<a 
								class='clicky' 
								href='
									?_src_=prefs;
									preference=toggle_undie_preview';
									task=input'>
										[preview_hide_undies ? "Hidden" : "Visible"]
							</a>
						</td>"}

					dat += {"<td colspan='1' class='coverage_on'>
							Over Clothes
							</td>"}
					dat += {"<td class='coverage_on'>
							<a 
								class='clicky_no_border'
								href='
									?_src_=prefs;
									preference=change_genital_whitelist'>
										Whitelisted Names
							</a>
							</td>"}
					dat += "</table>"
				if(ERP_TAB_HOME)/// UNDERWEAR GOES HERE
					dat += "<table class='undies_table'>"
					dat += "<tr class='undies_row'>"
					dat += "<td colspan='3'>"
					dat += "<h2 class='undies_header'>Clothing & Equipment</h2>"
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr class='undies_row'>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Topwear</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undershirt;
									task=input'>
										[undershirt]
							</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[shirt_color]' 
								href='
								?_src_=prefs;
								preference=shirt_color;
								task=input'>
									\t#[shirt_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undershirt_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, undershirt_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Bottomwear</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=underwear;
									task=input'>
										[underwear]
							</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[undie_color]' 
								href='
								?_src_=prefs;
								preference=undie_color;
								task=input'>
									\t#[undie_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undies_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, undies_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += {"<td class='undies_cell'>
								<div class='undies_label'>Legwear</div>
								<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=socks;
										task=input'>
											[socks]
								</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[socks_color]' 
								href='
								?_src_=prefs;
								preference=socks_color;
								task=input'>
									\t#[socks_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=socks_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, socks_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr class='undies_row'>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Backpack</div>"
					dat += {"<a 
								class='undies_link' 
								href='
								?_src_=prefs;
								preference=bag;
								task=input'>
								[backbag]
							</a>"}
					dat += "<div class='undies_link'>-</div>"
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Persistent Scars</div>"
					dat += {"<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=persistent_scars'>
											[persistent_scars ? "Enabled" : "Disabled"]
								</a>"}
					dat += {"<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=clear_scars'>
											\tClear them?
								</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Underwear Settings</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=underwear_hands'>
										Layered [underwear_overhands ? "OVER" : "UNDER"] hands
							</a>"}
					dat += {"<a 
								class='undies_link'>
									Cuteness: 100%
								</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Hide Undies In Preview</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=toggle_undie_preview'>
										[preview_hide_undies ? "Hidden" : "Visible"]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>PDA Style</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=choose_pda_skin'>
										[pda_skin]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>PDA Ringmessage</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=choose_pda_message'>
										[pda_ringmessage]
							</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "</table>"
				if(PREFS_ALL_HAS_GENITALS_SET) // fuck it
					dat += build_genital_setup()


 */

/* 


	//calculate your gear points from the chosen item
	gear_points = CONFIG_GET(number/initial_gear_points)
	var/list/chosen_gear = loadout_data["SAVE_[loadout_slot]"]
	if(chosen_gear)
		for(var/loadout_item in chosen_gear)
			var/loadout_item_path = loadout_item[LOADOUT_ITEM]
			if(loadout_item_path)
				var/datum/gear/loadout_gear = text2path(loadout_item_path)
				if(loadout_gear)
					gear_points -= initial(loadout_gear.cost)
	else
		chosen_gear = list()

	dat += "<table align='center' width='100%'>"
	dat += "<tr><td colspan=4><center><b><font color='[gear_points == 0 ? "#E62100" : "#CCDDFF"]'>[gear_points]</font> loadout points remaining.</b> \[<a href='?_src_=prefs;preference=gear;clear_loadout=1'>Clear Loadout</a>\]</center></td></tr>"
	dat += "<tr><td colspan=4><center>You can choose up to [MAX_FREE_PER_CAT] free items per category.</center></td></tr>"
	dat += "<tr><td colspan=4><center><b>"

	if(!length(GLOB.loadout_items))
		dat += "<center>ERROR: No loadout categories - something is horribly wrong!"
	else
		if(!GLOB.loadout_categories[gear_category])
			gear_category = GLOB.loadout_categories[1]
		var/firstcat = TRUE
		for(var/category in GLOB.loadout_categories)
			if(firstcat)
				firstcat = FALSE
			else
				dat += " |"
			if(category == gear_category)
				dat += " <span class='linkOn'>[category]</span> "
			else
				dat += " <a href='?_src_=prefs;preference=gear;select_category=[html_encode(category)]'>[category]</a> "

		dat += "</b></center></td></tr>"
		dat += "<tr><td colspan=4><hr></td></tr>"

		dat += "<tr><td colspan=4><center><b>"

		if(!length(GLOB.loadout_categories[gear_category]))
			dat += "No subcategories detected. Something is horribly wrong!"
		else
			var/list/subcategories = GLOB.loadout_categories[gear_category]
			if(!subcategories.Find(gear_subcategory))
				gear_subcategory = subcategories[1]

			var/firstsubcat = TRUE
			for(var/subcategory in subcategories)
				if(firstsubcat)
					firstsubcat = FALSE
				else
					dat += " |"
				if(gear_subcategory == subcategory)
					dat += " <span class='linkOn'>[subcategory]</span> "
				else
					dat += " <a href='?_src_=prefs;preference=gear;select_subcategory=[html_encode(subcategory)]'>[subcategory]</a> "
			dat += "</b></center></td></tr>"

			dat += "<tr width=10% style='vertical-align:top;'><td width=15%><b>Name</b></td>"
			dat += "<td style='vertical-align:top'><b>Cost</b></td>"
			dat += "<td width=10%><font size=2><b>Restrictions</b></font></td>"
			dat += "<td width=80%><font size=2><b>Description</b></font></td></tr>"
			for(var/name in GLOB.loadout_items[gear_category][gear_subcategory])
				var/datum/gear/gear = GLOB.loadout_items[gear_category][gear_subcategory][name]
				var/donoritem = gear.donoritem
				if(donoritem && !gear.donator_ckey_check(user.ckey))
					continue
				var/class_link = ""
				var/list/loadout_item = has_loadout_gear(loadout_slot, "[gear.type]")
				var/extra_loadout_data = ""
				if(loadout_item)
					class_link = "style='white-space:normal;' class='linkOn' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=0'"
					if(gear.loadout_flags & LOADOUT_CAN_NAME)
						extra_loadout_data += "<BR><a href='?_src_=prefs;preference=gear;loadout_rename=1;loadout_gear_name=[html_encode(gear.name)];'>Name</a> [loadout_item[LOADOUT_CUSTOM_NAME] ? loadout_item[LOADOUT_CUSTOM_NAME] : "N/A"]"
					if(gear.loadout_flags & LOADOUT_CAN_DESCRIPTION)
						extra_loadout_data += "<BR><a href='?_src_=prefs;preference=gear;loadout_redescribe=1;loadout_gear_name=[html_encode(gear.name)];'>Description</a>"
					if(gear.loadout_flags & LOADOUT_CAN_COLOR)
						extra_loadout_data += "<BR><a href='?_src_=prefs;preference=gear;loadout_recolor=1;loadout_gear_name=[html_encode(gear.name)];'>Color</a> <span style='border: 1px solid #161616; background-color: [loadout_item[LOADOUT_CUSTOM_COLOR] ? loadout_item[LOADOUT_CUSTOM_COLOR] : "#FFFFFF"];'>&nbsp;&nbsp;&nbsp;</span>"
				else if((gear_points - gear.cost) < 0)
					class_link = "style='white-space:normal;' class='linkOff'"
				else if(donoritem)
					class_link = "style='white-space:normal;background:#ebc42e;' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=1'"
				else
					class_link = "style='white-space:normal;' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=1'"
				dat += "<tr style='vertical-align:top;'><td width=15%><a [class_link]>[name]</a>[extra_loadout_data]</td>"
				dat += "<td width = 5% style='vertical-align:top'>[gear.cost]</td><td>"
				if(islist(gear.restricted_roles))
					if(gear.restricted_roles.len)
						if(gear.restricted_desc)
							dat += "<font size=2>"
							dat += gear.restricted_desc
							dat += "</font>"
						else
							dat += "<font size=2>"
							dat += gear.restricted_roles.Join(";")
							dat += "</font>"
				// the below line essentially means "if the loadout item is picked by the user and has a custom description, give it the custom description, otherwise give it the default description"
				//This would normally be part if an if else but because we dont have unlockable loadout items it's not
				dat += "</td><td><font size=2><i>[loadout_item ? (loadout_item[LOADOUT_CUSTOM_DESCRIPTION] ? loadout_item[LOADOUT_CUSTOM_DESCRIPTION] : gear.description) : gear.description]</i></font></td></tr>"

			dat += "</table>"

 */

/* 

		dat += "<table><tr><td width='340px' height='300px' valign='top'>"
		dat += "<h2>General Settings</h2>"
		dat += "<b>Input Mode Hotkey:</b> <a href='?_src_=prefs;task=input;preference=input_mode_hotkey'>[input_mode_hotkey]</a><br>"
		dat += "<b>UI Style:</b> <a href='?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
		dat += "<b>tgui Monitors:</b> <a href='?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary" : "All"]</a><br>"
		dat += "<b>tgui Style:</b> <a href='?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy" : "No Frills"]</a><br>"
		dat += "<b>Show Runechat Chat Bubbles:</b> <a href='?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Runechat message char limit:</b> <a href='?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
		dat += "<b>Runechat message width:</b> <a href='?_src_=prefs;preference=chat_width;task=input'>[chat_width]</a><br>"
		dat += "<b>Runechat off-screen:</b> <a href='?_src_=prefs;preference=offscreen;task=input'>[see_fancy_offscreen_runechat ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>See Runechat for non-mobs:</b> <a href='?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>See Runechat emotes:</b> <a href='?_src_=prefs;preference=see_rc_emotes'>[see_rc_emotes ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Use Runechat color in chat log:</b> <a href='?_src_=prefs;preference=color_chat_log'>[color_chat_log ? "Enabled" : "Disabled"]</a><br>"
		dat += "<br>"
		dat += "<b>See Runechat / hear sounds above/below you:</b> <a href='?_src_=prefs;preference=upperlowerfloor;task=input'>[hear_people_on_other_zs ? "Enabled" : "Disabled"]</a><br>"
		dat += "<br>"
		dat += "<b>Action Buttons:</b> <a href='?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
		dat += "<br>"
		dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
		//dat += "<b>PDA Style:</b> <a href='?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
		//dat += "<b>PDA Reskin:</b> <a href='?_src_=prefs;task=input;preference=pda_skin'>[pda_skin]</a><br>"
		dat += "<br>"
		dat += "<b>Ghost Ears:</b> <a href='?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ?  "All Speech":"Nearest Creatures"]</a><br>"
		dat += "<b>Ghost Radio:</b> <a href='?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
		dat += "<b>Ghost Sight:</b> <a href='?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes":"Nearest Creatures" ]</a><br>"
		dat += "<b>Ghost Whispers:</b> <a href='?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech":"Nearest Creatures"]</a><br>"
		dat += "<b>Ghost PDA:</b> <a href='?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"
		//dat += "<b>Window Flashing:</b> <a href='?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
		dat += "<br>"
		dat += "<b>Play Hunting Horn Sounds:</b> <a href='?_src_=prefs;preference=hear_hunting_horns'>[(toggles & SOUND_HUNTINGHORN) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>Sprint Depletion Sound:</b> <a href='?_src_=prefs;preference=hear_sprint_buffer'>[(toggles & SOUND_SPRINTBUFFER) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>Play Admin MIDIs:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>See Pull Requests:</b> <a href='?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
		dat += "<br>"
		if(user.client)
			if(unlock_content)
				dat += "<b>BYOND Membership Publicity:</b> <a href='?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"
			if(unlock_content || check_rights_for(user.client, R_ADMIN))
				dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"
				dat += "<b>Antag OOC Color:</b> <span style='border: 1px solid #161616; background-color: [aooccolor ? aooccolor : GLOB.normal_aooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=aooccolor;task=input'>Change</a><br>"

		dat += "</td>"
		if(user.client.holder)
			dat +="<td width='300px' height='300px' valign='top'>"
			dat += "<h2>Admin Settings</h2>"
			dat += "<b>Adminhelp Sounds:</b> <a href='?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
			dat += "<b>Announce Login:</b> <a href='?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Combo HUD Lighting:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
			dat += "<b>Split Admin Tabs:</b> <a href = '?_src_=prefs;preference=toggle_split_admin_tabs'>[(toggles & SPLIT_ADMIN_TABS)?"Enabled":"Disabled"]</a><br>"
			dat += "</td>"

		dat +="<td width='300px' height='300px' valign='top'>"
		dat += "<h2>Preferences</h2>" //Because fuck me if preferences can't be fucking modularized and expected to update in a reasonable timeframe.
		dat += "<b>End of round deathmatch:</b> <a href='?_src_=prefs;preference=end_of_round_deathmatch'>[end_of_round_deathmatch ? "Enabled" : "Disabled"]</a><br>"
		dat += "<h2>Citadel Preferences</h2>" //Because fuck me if preferences can't be fucking modularized and expected to update in a reasonable timeframe.
		dat += "<b>Widescreen:</b> <a href='?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled (15x15)"]</a><br>"
		dat += "<b>Auto stand:</b> <a href='?_src_=prefs;preference=autostand'>[autostand ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Auto OOC:</b> <a href='?_src_=prefs;preference=auto_ooc'>[auto_ooc ? "Disabled" : "Enabled" ]</a><br>"
		dat += "<b>Force Slot Storage HUD:</b> <a href='?_src_=prefs;preference=no_tetris_storage'>[no_tetris_storage ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Gun Cursor:</b> <a href='?_src_=prefs;preference=guncursor'>[(cb_toggles & AIM_CURSOR_ON) ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Screen Shake:</b> <a href='?_src_=prefs;preference=screenshake'>[(screenshake==100) ? "Full" : ((screenshake==0) ? "None" : "[screenshake]")]</a><br>"
		if (user && user.client && !user.client.prefs.screenshake==0)
			dat += "<b>Damage Screen Shake:</b> <a href='?_src_=prefs;preference=damagescreenshake'>[(damagescreenshake==1) ? "On" : ((damagescreenshake==0) ? "Off" : "Only when down")]</a><br>"

		dat += "<b>Show Health Smileys:</b> <a href='?_src_=prefs;preference=show_health_smilies;task=input'>[show_health_smilies ? "Enabled" : "Disabled"]</a><br>"
		dat += "<br>"
		dat += "<b>Max PFP Examine Image Height px:</b> <a href='?_src_=prefs;preference=max_pfp_hight;task=input'>[see_pfp_max_hight]px</a><br>"
		dat += "<b>Max PFP Examine Image Width %:</b> <a href='?_src_=prefs;preference=max_pfp_with;task=input'>[see_pfp_max_widht]%</a><br>"
		dat += "</td>"
		dat += "</tr></table>"
		if(unlock_content)
			dat += "<b>Ghost Form:</b> <a href='?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
			dat += "<B>Ghost Orbit: </B> <a href='?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"
		var/button_name = "If you see this something went wrong."
		switch(ghost_accs)
			if(GHOST_ACCS_FULL)
				button_name = GHOST_ACCS_FULL_NAME
			if(GHOST_ACCS_DIR)
				button_name = GHOST_ACCS_DIR_NAME
			if(GHOST_ACCS_NONE)
				button_name = GHOST_ACCS_NONE_NAME

		dat += "<b>Ghost Accessories:</b> <a href='?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"
		switch(ghost_others)
			if(GHOST_OTHERS_THEIR_SETTING)
				button_name = GHOST_OTHERS_THEIR_SETTING_NAME
			if(GHOST_OTHERS_DEFAULT_SPRITE)
				button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
			if(GHOST_OTHERS_SIMPLE)
				button_name = GHOST_OTHERS_SIMPLE_NAME

		dat += "<b>Ghosts of Others:</b> <a href='?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
		dat += "<br>"

		dat += "<b>FPS:</b> <a href='?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"

		dat += "<b>Income Updates:</b> <a href='?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
		dat += "<b>Hear Radio Static:</b> <a href='?_src_=prefs;preference=static_radio'>[(chat_toggles & CHAT_HEAR_RADIOSTATIC) ? "Allowed" : "Muted"]</a><br>"
		dat += "<b>Hear Radio Blurbles:</b> <a href='?_src_=prefs;preference=static_blurble'>[(chat_toggles & CHAT_HEAR_RADIOBLURBLES) ? "Allowed" : "Muted"]</a><br>"
		dat += "<br>"

		dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
		switch (parallax)
			if (PARALLAX_LOW)
				dat += "Low"
			if (PARALLAX_MED)
				dat += "Medium"
			if (PARALLAX_INSANE)
				dat += "Insane"
			if (PARALLAX_DISABLE)
				dat += "Disabled"
			else
				dat += "High"
		dat += "</a><br>"
		dat += "<b>Ambient Occlusion:</b> <a href='?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Fit Viewport:</b> <a href='?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
		dat += "<b>HUD Button Flashes:</b> <a href='?_src_=prefs;preference=hud_toggle_flash'>[hud_toggle_flash ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>HUD Button Flash Color:</b> <span style='border: 1px solid #161616; background-color: [hud_toggle_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hud_toggle_color;task=input'>Change</a><br>"

		if (CONFIG_GET(flag/maprotation) && CONFIG_GET(flag/tgstyle_maprotation))
			var/p_map = preferred_map
			if (!p_map)
				p_map = "Default"
				if (config.defaultmap)
					p_map += " ([config.defaultmap.map_name])"
			else
				if (p_map in config.maplist)
					var/datum/map_config/VM = config.maplist[p_map]
					if (!VM)
						p_map += " (No longer exists)"
					else
						p_map = VM.map_name
				else
					p_map += " (No longer exists)"
			if(CONFIG_GET(flag/allow_map_voting))
				dat += "<b>Preferred Map:</b> <a href='?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"

		dat += "</td><td width='300px' height='300px' valign='top'>"

		/*dat += "<h2>Special Role Settings</h2>"

		if(jobban_isbanned(user, ROLE_SYNDICATE))
			dat += "<font color=red><b>You are banned from antagonist roles.</b></font>"
			src.be_special = list()


		for (var/i in GLOB.special_roles)
			if(jobban_isbanned(user, i))
				dat += "<b>Be [capitalize(i)]:</b> <a href='?_src_=prefs;jobbancheck=[i]'>BANNED</a><br>"
			else
				var/days_remaining = null
				if(ispath(GLOB.special_roles[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
					var/mode_path = GLOB.special_roles[i]
					var/datum/game_mode/temp_mode = new mode_path
					days_remaining = temp_mode.get_remaining_days(user.client)

				if(days_remaining)
					dat += "<b>Be [capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
				else
					dat += "<b>Be [capitalize(i)]:</b> <a href='?_src_=prefs;preference=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"
		dat += "<b>Midround Antagonist:</b> <a href='?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"

		dat += "<br>"
		*/


			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>Adult content prefs</h2>"
			dat += "<b>Arousal:</b><a href='?_src_=prefs;preference=arousable'>[arousable == TRUE ? "Enabled" : "Disabled"]</a><BR>"
			dat += "<b>Genital examine text</b>:<a href='?_src_=prefs;preference=genital_examine'>[(cit_toggles & GENITAL_EXAMINE) ? "Enabled" : "Disabled"]</a><BR>"
			dat += "<b>Ass Slapping:</b> <a href='?_src_=prefs;preference=ass_slap'>[(cit_toggles & NO_BUTT_SLAP) ? "Disallowed" : "Allowed"]</a><br>"
			dat += "<h2>Vore prefs</h2>"
			dat += "<b>Master Vore Toggle:</b> <a href='?_src_=prefs;task=input;preference=master_vore_toggle'>[(master_vore_toggle) ? "Per Preferences" : "All Disabled"]</a><br>"
			if(master_vore_toggle)
				dat += "<b>Being Prey:</b> <a href='?_src_=prefs;task=input;preference=allow_being_prey'>[(allow_being_prey) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Being Fed Prey:</b> <a href='?_src_=prefs;task=input;preference=allow_being_fed_prey'>[(allow_being_fed_prey) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Digestion Damage:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_damage'>[(allow_digestion_damage) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Digestion Death:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_death'>[(allow_digestion_death) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Vore Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_vore_messages'>[(allow_vore_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Trash Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_trash_messages'>[(allow_trash_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Death Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_death_messages'>[(allow_death_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Eating Sounds:</b> <a href='?_src_=prefs;task=input;preference=allow_eating_sounds'>[(allow_eating_sounds) ? "Audible" : "Muted"]</a><br>"
				dat += "<b>Digestion Sounds:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_sounds'>[(allow_digestion_sounds) ? "Audible" : "Muted"]</a><br>"
			dat += "</tr></table>"
			dat += "<br>"

			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<h3>Flavor Text</h3>"
			dat += "<a href='?_src_=prefs;preference=flavor_text;task=input'><b>Set Examine Text</b></a><br>"
			dat += "<a href='?_src_=prefs;preference=setup_hornychat;task=input'>Configure VisualChat / Profile Pictures!</a><BR>"
			if(length(features["flavor_text"]) <= 40)
				if(!length(features["flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["flavor_text"]]"
			else
				dat += "[TextPreview(features["flavor_text"])]...<BR>"
			dat += "<h3>Silicon Flavor Text</h3>"
			dat += "<a href='?_src_=prefs;preference=silicon_flavor_text;task=input'><b>Set Silicon Examine Text</b></a><br>"
			if(length(features["silicon_flavor_text"]) <= 40)
				if(!length(features["silicon_flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["silicon_flavor_text"]]"
			else
				dat += "[TextPreview(features["silicon_flavor_text"])]...<BR>"
			dat += "<h3>OOC notes</h3>"
			dat += "<a href='?_src_=prefs;preference=ooc_notes;task=input'><b>Set OOC notes</b></a><br>"
			var/ooc_notes_len = length(features["ooc_notes"])
			if(ooc_notes_len <= 40)
				if(!ooc_notes_len)
					dat += "\[...\]<br>"
				else
					dat += "[features["ooc_notes"]]<br>"
			else
				dat += "[TextPreview(features["ooc_notes"])]...<br>"

			// dat += "<a href='?_src_=prefs;preference=background_info_notes;task=input'><b>Set Background Info Notes</b></a><br>"
			// var/background_info_notes_len = length(features["background_info_notes"])
			// if(background_info_notes_len <= 40)
			// 	if(!background_info_notes_len)
			// 		dat += "\[...\]<br>"
			// 	else
			// 		dat += "[features["background_info_notes"]]<br>"
			// else
			// 	dat += "[TextPreview(features["background_info_notes"])]...<br>"

			//outside link stuff
			dat += "<h3>Outer hyper-links settings</h3>"
			dat += "<a href='?_src_=prefs;preference=flist;task=input'><b>Set F-list link</b></a><br>"
			var/flist_len = length(features["flist"])
			if(flist_len <= 40)
				if(!flist_len)
					dat += "\[...\]"
				else
					dat += "[features["flist"]]"
			else
				dat += "[TextPreview(features["flist"])]...<br>"

			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN



			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h2>Voice</h2>"

			// Coyote ADD: Blurbleblurhs
			dat += "<b>Voice Sound:</b></b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_sound;task=input'>[features_speech["typing_indicator_sound"]]</a><br>"
			dat += "<b>Voice When:</b></b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_sound_play;task=input'>[features_speech["typing_indicator_sound_play"]]</a><br>"			
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_speed;task=input'>[features_speech["typing_indicator_speed"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_pitch;task=input'>[features_speech["typing_indicator_pitch"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_variance;task=input'>[features_speech["typing_indicator_variance"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_volume;task=input'>[features_speech["typing_indicator_volume"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_max_words_spoken;task=input'>[features_speech["typing_indicator_max_words_spoken"]]</a><br>"
			dat += "</td>"
			
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<center><h2>Custom Say Verbs</h2></center>"
			dat += "<a href='?_src_=prefs;preference=custom_say;verbtype=custom_say;task=input'>Says</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_whisper;task=input'>Whispers</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_ask;task=input'>Asks</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_exclaim;task=input'>Exclaims</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_yell;task=input'>Yells</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_sing;task=input'>Sings</a>"
			//dat += "<BR><a href='?_src_=prefs;preference=soundindicatorpreview'>Preview Sound Indicator</a><BR>"
			dat += "</td>"
			// Coyote ADD: End
		/// just kidding I moved it down here lol

			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			var/list/user_modless_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)
			for (var/key in modless_key_bindings)
				user_modless_binds[modless_key_bindings[key]] = key

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += {"
			<style>
			span.bindname { display: inline-block; position: absolute; width: 20% ; left: 5px; padding: 5px; } \
			span.bindings { display: inline-block; position: relative; width: auto; left: 20%; width: auto; right: 20%; padding: 5px; } \
			span.independent { display: inline-block; position: absolute; width: 20%; right: 5px; padding: 5px; } \
			</style><body>
			"}

			for (var/category in kb_categories)
				dat += "<h3>[category]</h3>"
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					var/current_independent_binding = user_modless_binds[kb.name] || "Unbound"
					if(!length(user_binds[kb.name]))
						dat += "<span class='bindname'>[kb.full_name]</span><span class='bindings'><a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "</span>"
						if(!kb.special && !kb.clientside)
							dat += "<span class='independent'>Independent Binding: <a href='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[current_independent_binding];independent=1'>[current_independent_binding]</a></span>"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<span class='bindname'l>[kb.full_name]</span><span class='bindings'><a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "</span>"
						if(!kb.special && !kb.clientside)
							dat += "<span class='independent'>Independent Binding: <a href='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[current_independent_binding];independent=1'>[current_independent_binding]</a></span>"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybindings_reset'>\[Reset to default\]</a>"
			dat += "</body>"


 */






	if(CONFIG_GET(flag/use_role_whitelist))
		user.client.set_job_whitelist_from_db()

	var/list/dat = list()
	dat += CharacterList()
	dat += CoolDivider()
	dat += HeaderTabs()
	dat += CoolDivider()
	dat += SubTabs()

	switch(current_tab)
		if(PPT_CHARCTER_PROPERTIES)
			switch(current_subtab)
				if(PPT_CHARCTER_PROPERTIES_INFO)
					dat += CharacterProperties()
				if(PPT_CHARCTER_PROPERTIES_VOICE)
					dat += VoiceProperties()
				if(PPT_CHARCTER_PROPERTIES_MISC)
					dat += MiscProperties()

		//Character Appearance
		if(PPT_CHARCTER_APPEARANCE)
			if(current_subtab != PPT_CHARCTER_APPEARANCE_UNDERLYING)
				dat += ColorToolbar()
			switch(current_subtab)
				if(PPT_CHARCTER_APPEARANCE_MISC)
					dat += AppearanceMisc()
				if(PPT_CHARCTER_APPEARANCE_HAIR_EYES)
					dat += AppearanceHairEyes()
				if(PPT_CHARCTER_APPEARANCE_PARTS)
					dat += AppearanceParts()
				if(PPT_CHARCTER_APPEARANCE_MARKINGS)
					dat += AppearanceMarkings()
				if(PPT_CHARCTER_APPEARANCE_UNDERLYING)
					dat += SubSubTabs()
					dat += ColorToolbar()
					var/static/list/allnads = list()
					if(!LAZYLEN(allnads))
						for(var/has_nad in GLOB.genital_data_system)
							var/datum/genital_data/GD = GLOB.genital_data_system[has_nad]
							if(GD.genital_flags & GENITAL_CAN_HAVE)
								allnads += GD.has_key
					switch(current_sub_subtab)
						if(PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES)
							dat += AppearanceUnderlyingUndies()
						if(PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING)
							dat += AppearanceUnderlyingLayering()
						else
							if(current_subtab in allnads)
								dat += AppearanceUnderlyingGenitals()
							else
								dat += "OH NO! This is a bug! Please report it to the staff! Error code SNACKY SWEET SUNFISH"
		
		//Loadout heck
		if(PPT_LOADOUT)
			dat += Loadout()
		
		//Game Preferences
		if(PPT_GAME_PREFERENCES)
			switch(current_subtab)
				if(PPT_GAME_PREFERENCES_GENERAL)
					dat += GamePreferencesGeneral()
				if(PPT_GAME_PREFERENCES_UI)
					dat += GamePreferencesUI()
				if(PPT_GAME_PREFERENCES_CHAT)
					dat += GamePreferencesChat()
				if(PPT_GAME_PREFERENCES_RUNECHAT)
					dat += GamePreferencesRunechat()
				if(PPT_GAME_PREFERENCES_GHOST)
					dat += GamePreferencesGhost()
				if(PPT_GAME_PREFERENCES_AUDIO)
					dat += GamePreferencesAudio()
				if(PPT_GAME_PREFERENCES_ADMIN)
					dat += GamePreferencesAdmin()
				if(PPT_GAME_PREFERENCES_CONTENT)
					dat += GamePreferencesContent()


		if(PPT_KEYBINDINGS) // Custom keybindings
			dat += Keybindings()

	// dat += CoolDivider()
	// dat += FooterBar()

	winset(user, "preferences_window", "is-visible=1;focus=0;")
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Setup - [real_name]</div>", 640, 770)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "preferences_window", src)


/datum/preferences/proc/HeaderTabs()
	var/static/list/tablist = list(
		"[PPT_CHARCTER_PROPERTIES]" = "Properties",
		"[PPT_CHARCTER_APPEARANCE]" = "Appearance",
		"[PPT_LOADOUT]" = "Loadout",
		"new_row",
		"[PPT_GAME_PREFERENCES]" = "Game Settings",
		"[PPT_KEYBINDINGS]" = "Keybindings",
	)
	var/list/dat = list()
	dat += "<center>"
	dat += "<table class='TabHeader'>"
	dat += "<tr>"
	var/colspan = 2
	for(var/supertab in tablist)
		if(supertab == "new_row")
			dat += "</tr><tr>"
			colspan = 3 // brilliant
		else
			dat += "<td colspan='[colspan]'>"
			var/cspan = current_tab == supertab ? "TabCellselected" : ""
			dat += PrefLink("[tablist["[supertab]"]]", PREFCMD_SET_TAB, list(PREFDAT_TAB = url_encode(supertab)), "BUTTON", cspan)
			dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
	if(!path)
		dat += "<div class='notice'>Hi Guest! You need to have a BYOND account to save anything.</div>"
	dat += "</center>"
	return dat.Join()

/datum/preferences/proc/SubTabs()
	var/static/list/subtablist = list(
		"[PPT_CHARCTER_PROPERTIES]" = list(
			"[PPT_CHARCTER_PROPERTIES_INFO]" = "Background",
			"[PPT_CHARCTER_PROPERTIES_VOICE]" = "Voice",
			"[PPT_CHARCTER_PROPERTIES_MISC]" = "Miscellaneous",
		),
		"[PPT_CHARCTER_APPEARANCE]" = list(
			"[PPT_CHARCTER_APPEARANCE_MISC]" = "General",
			"[PPT_CHARCTER_APPEARANCE_HAIR_EYES]" = "Hair & Eyes",
			"[PPT_CHARCTER_APPEARANCE_PARTS]" = "Body Parts",
			"[PPT_CHARCTER_APPEARANCE_MARKINGS]" = "Markings",
			"[PPT_CHARCTER_APPEARANCE_UNDERLYING]" = "Unmentionables",
		),
		"[PPT_GAME_PREFERENCES]" = list(
			"[PPT_GAME_PREFERENCES_GENERAL]" = "General",
			"[PPT_GAME_PREFERENCES_UI]" = "UI",
			"[PPT_GAME_PREFERENCES_CHAT]" = "Chat",
			"[PPT_GAME_PREFERENCES_RUNECHAT]" = "Runechat",
			"[PPT_GAME_PREFERENCES_GHOST]" = "Ghost",
			"[PPT_GAME_PREFERENCES_AUDIO]" = "Audio",
			"[PPT_GAME_PREFERENCES_ADMIN]" = "Admin",
			"[PPT_GAME_PREFERENCES_CONTENT]" = "Content",
		),
	)
	var/static/list/subtablist_nonadmin = list(
		"[PPT_CHARCTER_PROPERTIES]" = list(
			"[PPT_CHARCTER_PROPERTIES_INFO]" = "Background",
			"[PPT_CHARCTER_PROPERTIES_VOICE]" = "Voice",
			"[PPT_CHARCTER_PROPERTIES_MISC]" = "Miscellaneous",
		),
		"[PPT_CHARCTER_APPEARANCE]" = list(
			"[PPT_CHARCTER_APPEARANCE_MISC]" = "General",
			"[PPT_CHARCTER_APPEARANCE_HAIR_EYES]" = "Hair & Eyes",
			"[PPT_CHARCTER_APPEARANCE_PARTS]" = "Body Parts",
			"[PPT_CHARCTER_APPEARANCE_MARKINGS]" = "Markings",
			"[PPT_CHARCTER_APPEARANCE_UNDERLYING]" = "Unmentionables",
		),
		"[PPT_GAME_PREFERENCES]" = list(
			"[PPT_GAME_PREFERENCES_GENERAL]" = "General",
			"[PPT_GAME_PREFERENCES_UI]" = "UI",
			"[PPT_GAME_PREFERENCES_CHAT]" = "Chat",
			"[PPT_GAME_PREFERENCES_RUNECHAT]" = "Runechat",
			"[PPT_GAME_PREFERENCES_AUDIO]" = "Audio",
			"[PPT_GAME_PREFERENCES_CONTENT]" = "Content",
		),
	)
	var/list/touse
	if(check_rights(R_ADMIN, FALSE))
		touse = subtablist
	else
		touse = subtablist_nonadmin
	if(!LAZYLEN(touse["[current_tab]"]))
		return ""
	var/list/dat = list()
	dat += "<center>"
	dat += "<table class='TabHeader'>"
	dat += "<tr>"
	var/list/sub_listab = touse["[current_tab]"]
	for(var/subtab in sub_listab)
		dat += "<td>"
		var/cspan = current_subtab == subtab ? "TabCellselected" : ""
		var/textsay = "[sub_listab["[subtab]"]]"
		dat += PrefLink(textsay, PREFCMD_SET_SUBTAB, list(PREFDAT_SUBTAB = url_encode(subtab)), span = cspan)
		dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
	dat += "</center>"
	return dat.Join()

/// sub tabs, for undies, genitals, and layering
/datum/preferences/proc/SubSubTabs()
	var/list/dat = list()
	dat += "<center>"
	dat += "<div class='SettingArray'>"
	dat += "<div class='FlexTable'>"
	var/coolstyle = "flex-basis: 48%;"
	var/undiespan = current_sub_subtab == PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES ? "TabCellselected" : ""
	dat += PrefLink("Underwear", PREFCMD_SET_SUBSUBTAB, list(PREFDAT_SUBSUBTAB = url_encode(PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES)), span = undiespan, style = coolstyle)
	var/layeringspan = current_sub_subtab == PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING ? "TabCellselected" : ""
	dat += PrefLink("Layering", PREFCMD_SET_SUBSUBTAB, list(PREFDAT_SUBSUBTAB = url_encode(PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING)), span = layeringspan, style = coolstyle)
	/// and now, the rest of the tabs
	for(var/datum/genital_data/GD in GLOB.genital_data_system)
		var/genispan = current_sub_subtab == GD.has_key ? "TabCellselected" : ""
		dat += PrefLink(GD.name, PREFCMD_SET_SUBSUBTAB, list(PREFDAT_SUBSUBTAB = url_encode(GD.has_key)), span = genispan)
	dat += "</div>"
	dat += "</div>"
	dat += "</center>"
	return dat.Join()

/datum/preferences/proc/CharacterList()
	if(!path)
		return "You're a guest! You can't save characters, you dorito!"
	var/savefile/S = new /savefile(path)
	if(!S)
		return "Error loading savefile! Please contact an admin."
	var/list/dat = list()
	dat += "<center>"
	dat += "<div class='FlexTable WellPadded'>"
	if(charlist_hidden)
		dat += PrefLink("Show Character List", PREFCMD_TOGGLE_SHOW_CHARACTER_LIST)
		dat += "</center>"
	else
		var/name
		for(var/i=1, i<=min(max_save_slots, show_this_many), i++)
			S.cd = "/character[i]"
			S["real_name"] >> name
			if(!name)
				name = "Character[i]"
			var/coolspan = i == default_slot ? "TabCellselected" : ""
			dat += PrefLink("[name]", PREFCMD_CHANGE_SLOT, list(PREFDAT_SLOT = i), span = coolspan)
		dat += "</div>"
		dat += "<div class='WideBarDark'>"
		dat += "Showing [PrefLink("[show_this_many]", PREFCMD_SHOW_THIS_MANY_CHARS)] characters"
		dat += "<br>"
		dat += PrefLink("Copy", PREFCMD_SLOT_COPY)
		dat += PrefLink("Paste", PREFCMD_SLOT_PASTE)
		if(copyslot)
			dat += "<br>Copying FROM: [copyslot] ([copyname])"
		dat += "<br>"
		dat += PrefLink("Hide Character List", PREFCMD_TOGGLE_SHOW_CHARACTER_LIST)
		dat += "</div>"
		dat += "</center>"
	return dat.Join()


/datum/preferences/proc/FooterBar()
	var/list/dat = list()
	dat += "<center>"
	dat += PrefLink("Visual Chat Options", PREFCMD_VCHAT, span = "WideBarDark")
	dat += PrefLink("Save", PREFCMD_SAVE, span = "WideBarDark")
	dat += "<table class='TabHeader'>"
	dat += "<tr>"
	dat += "<td width='50%'>"
	dat += PrefLink("Undo", PREFCMD_UNDO)
	dat += "</td>"
	dat += "<td width='50%'>"
	dat += PrefLink("Delete", PREFCMD_SLOT_DELETE)
	dat += "</td>"
	dat += "</center>"
	return dat.Join()

/datum/preferences/proc/CharacterProperties()
	var/list/dat = list()
	dat += "<div class='BGsplitContainer'>" // DIV A
	dat += "<div class='BGsplit'>" // DIV A A
	dat += "<div class='SettingArray'>" // DIV A A A
	dat += "<div class='SettingFlex' style='flex-basis: 100%;'>" // DIV A A A A
	var/pfplink = SSchat.GetPicForMode(src, MODE_PROFILE_PIC)
	if(pfplink)
		pfplink = "<img src='[pfplink]' style='width: 125px; height: auto;'>"
	else
		pfplink = "<img src='https://via.placeholder.com/150' style='width: 125px; height: auto;'>"
	dat += "<center>"
	dat += PrefLink(pfplink, PREFCMD_VCHAT)
	dat += "</center>"
	dat += "</div>" // End of DIV A A A A
	dat += "<div class='SettingFlex' style='flex-basis: 100%;'>" // DIV A A A B
	dat += "<div class='SettingName'>" // DIV A A A B A
	dat += "Name:"
	dat += "</div>" // End of DIV A A A B A
	dat += PrefLink("[real_name]", PREFCMD_CHANGE_NAME)
	dat += "</div>" // End of DIV A A A B
	dat += "<div class='SettingFlex'>" // DIV A A A C
	dat += "<div class='SettingName'>" // DIV A A A C A
	dat += "Age:"
	dat += "</div>" // End of DIV A A A C A
	dat += PrefLink("[age]", PREFCMD_CHANGE_AGE)
	dat += "</div>" // End of DIV A A A C
	dat += "<div class='SettingFlex'>" // DIV A A A D
	dat += "<div class='SettingName'>" // DIV A A A D A
	dat += "Gender:"
	dat += "</div>" // End of DIV A A A D A
	var/genwords = "amazing"
	switch(gender)
		if(MALE)
			genwords = "Male"
		if(FEMALE)
			genwords = "Female"
		if("object")
			genwords = "Agender"
		if("nonbinary")
			genwords = "Nonbinary"
	dat += PrefLink("[genwords]", PREFCMD_CHANGE_GENDER)
	dat += "</div>" // End of DIV A A A D
	dat += "<div class='SettingFlex' style='flex-basis: 100%;'>" // DIV A A A E
	dat += "<div class='SettingName'>" // DIV A A A E A
	dat += "I am a..."
	dat += "</div>" // End of DIV A A A E A
	dat += PrefLink("[tbs]", PREFCMD_CHANGE_TBS)
	dat += "</div>" // End of DIV A A A E
	dat += "<div class='SettingFlex' style='flex-basis: 100%;'>" // DIV A A A F
	dat += "<div class='SettingName'>" // DIV A A A F A
	dat += "I like to kiss..."
	dat += "</div>" // End of DIV A A A F A
	dat += PrefLink("[kisser]]", PREFCMD_CHANGE_KISSER)
	dat += "</div>" // End of DIV A A A F
	dat += "</div>" // End of DIV A A A
	dat += "</div>" // End of DIV A A
	dat += "<div class='BGsplit'>" // DIV A B
	dat += "<div class='SettingArrayCol'>" // DIV A B A
	dat += "<div class='SettingFlexCol'>" // DIV A B A A
	dat += "<div class='SettingNameCol'>" // DIV A B A A A
	dat += "Flavor Text:"
	dat += "</div>" // End of DIV A B A A A
	var/ftbutless = "[features["flavor_text"]]"
	if(ftbutless == initial(features["flavor_text"]))
		ftbutless = "Click to add flavor text!"
	if(LAZYLEN(ftbutless) > 100)
		ftbutless = copytext(ftbutless, 1, 100) + "..."
	dat += PrefLink("[ftbutless]", PREFCMD_CHANGE_FLAVOR_TEXT)
	dat += "</div>" // End of DIV A B A A
	dat += "<div class='SettingFlexCol'>" // DIV A B A B
	dat += "<div class='SettingNameCol'>" // DIV A B A B A
	dat += "OOC Notes:"
	dat += "</div>" // End of DIV A B A B A
	var/oocbutless = "[features["ooc_notes"]]"
	if(oocbutless == initial(features["ooc_notes"]))
		oocbutless = "Click to add OOC notes!"
	if(LAZYLEN(oocbutless) > 100)
		oocbutless = copytext(oocbutless, 1, 100) + "..."
	dat += PrefLink("[oocbutless]", PREFCMD_CHANGE_OOC_NOTES)
	dat += "</div>" // End of DIV A B A B
	dat += "</div>" // End of DIV A B A
	dat += "</div>" // End of DIV A B
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/VoiceProperties()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 50%;'>" // DIV A A
	dat += "<div class='SettingNameCol'>" // DIV A A A
	dat += "Blurble Sound"
	dat += "</div>" // End of DIV A A A
	dat += PrefLink("[features_speech["typing_indicator_sound"]]", PREFCMD_BLURBLE_SOUND, span = "SettingValue")
	dat += "</div>" // End of DIV A A
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A B
	dat += "<div class='SettingNameCol'>" // DIV A B A
	dat += "You will blurble when you..."
	dat += "</div>" // End of DIV A B A
	dat += PrefLink("[features_speech["typing_indicator_sound_play"]]", PREFCMD_BLURBLE_TRIGGER, span = "SettingValue")
	dat += "</div>" // End of DIV A B
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A B
	dat += "<div class='SettingNameCol'>" // DIV A B A
	dat += "Your blurbles will vary..."
	dat += "</div>" // End of DIV A B A
	dat += PrefLink("[features_speech["typing_indicator_variance"]]", PREFCMD_BLURBLE_VARY, span = "SettingValue")
	dat += "</div>" // End of DIV A B
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A C
	dat += "<div class='SettingNameCol'>" // DIV A C A
	dat += "Blurble Speed"
	dat += "</div>" // End of DIV A C A
	dat += PrefLink("[features_speech["typing_indicator_speed"]]", PREFCMD_BLURBLE_SPEED, span = "SettingValue")
	dat += "</div>" // End of DIV A C
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A D
	dat += "<div class='SettingNameCol'>" // DIV A D A
	dat += "Blurble Volume"
	dat += "</div>" // End of DIV A D A
	dat += PrefLink("[features_speech["typing_indicator_volume"]]", PREFCMD_BLURBLE_VOLUME, span = "SettingValue")
	dat += "</div>" // End of DIV A D
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A E
	dat += "<div class='SettingNameCol'>" // DIV A E A
	dat += "Blurble Pitch"
	dat += "</div>" // End of DIV A E A
	dat += PrefLink("[features_speech["typing_indicator_pitch"]]", PREFCMD_BLURBLE_PITCH, span = "SettingValue")
	dat += "</div>" // End of DIV A E
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A F
	dat += "<div class='SettingNameCol'>" // DIV A F A
	dat += "Max Words Blurbled"
	dat += "</div>" // End of DIV A F A
	dat += PrefLink("[features_speech["typing_indicator_max_words_spoken"]]", PREFCMD_BLURBLE_MAX_WORDS, span = "SettingValue")
	dat += "</div>" // End of DIV A F
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 25%;'>" // DIV A G
	dat += "<div class='SettingNameCol'>" // DIV A G A
	dat += "Runechat Color"
	dat += "</div>" // End of DIV A G A
	var/list/data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
	dat += ColorBox("runechat_color", data = data)
	dat += "</div>" // End of DIV A G

	dat += "<div class='SettingFlexCol' style='flex-basis: 75%;'>" // DIV A H
	dat += "</div>" // End of DIV A H ^ This is a spacer
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/MiscProperties()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV Q
	dat += "<div class='SettingFlexCol' style='flex-basis: 100%;'>" // DIV Q A
	dat += "<div class='SettingValueSplit'>" // DIV Q A A
	dat += "<div class='SettingValueCol'>" // DIV Q A A A
	dat += "<div class='SettingNameCol'>" // DIV Q A A A A
	dat += "Account ID (Do not share!)"
	dat += "</div>" // End of DIV Q A A A A
	dat += "<div class='SettingFlexColInfo'>" // DIV Q A A A B
	dat += "[quester_uid]"
	dat += "</div>" // End of DIV Q A A A B
	dat += "</div>" // End of DIV Q A A A
	dat += "<div class='SettingFlexCol'>" // DIV Q A A B
	dat += "<div class='SettingNameCol'>" // DIV Q A A B A
	dat += "Account Balance"
	dat += "</div>" // End of DIV Q A A B A
	dat += "<div class='SettingFlexColInfo'>" // DIV Q A A B B
	dat += "[SSeconomy.format_currency(saved_unclaimed_points, TRUE)]"
	dat += "</div>" // End of DIV Q A A B B
	dat += "</div>" // End of DIV Q A A B
	dat += "</div>" // End of DIV Q A A
	dat += "</div>" // End of DIV Q A
	dat += "</div>" // End of DIV Q
	
	dat += "<div class='SettingArray'>" // DIV A
	
	dat += "<div class='SettingFlexCol' style='flex-basis: 33%;'>" // DIV A A
	dat += "<div class='SettingNameCol'>" // DIV A A A
	dat += "PDA Kind"
	dat += "</div>" // End of DIV A A A
	dat += PrefLink("[pda_skin]", PREFCMD_PDA_KIND, span = "SettingValueCol")
	dat += "</div>" // End of DIV A A

	dat += "<div class='SettingFlexCol' style='flex-basis: 33%;'>" // DIV A B
	dat += "<div class='SettingNameCol'>" // DIV A B A
	dat += "PDA Ringtone"
	dat += "</div>" // End of DIV A B A
	dat += PrefLink("[pda_ringmessage]", PREFCMD_PDA_RINGTONE, span = "SettingValueCol")
	dat += "</div>" // End of DIV A B

	dat += "<div class='SettingFlexCol' style='flex-basis: 33%;'>" // DIV A C
	dat += "<div class='SettingNameCol'>" // DIV A C A
	dat += "PDA Color"
	dat += "</div>" // End of DIV A C A

	var/list/data = list(PREFDAT_COLKEY_IS_VAR = TRUE)
	dat += ColorBox("pda_color", data = data)
	dat += "</div>" // End of DIV A C

	dat += "<div class='SettingFlexCol' style='flex-basis: 50%;'>" // DIV A D
	dat += "<div class='SettingNameCol'>" // DIV A D A
	dat += "Backpack Kind"
	dat += "</div>" // End of DIV A D A
	dat += PrefLink("[backbag]", PREFCMD_BACKPACK_KIND, span = "SettingValueCol")
	dat += "</div>" // End of DIV A D

	dat += "<div class='SettingFlexCol' style='flex-basis: 50%;'>" // DIV A E
	dat += "<div class='SettingNameCol'>" // DIV A E A
	dat += "Persistent Scars"
	dat += "<div class='SettingValueSplit'>" // DIV A E A A
	dat += "<div class='SettingValueCol' style='flex-basis: 50%;'>" // DIV A E A A A
	dat += PrefLink("[persistent_scars]", PREFCMD_SCARS, span = "SettingValueCol")
	dat += "</div>" // End of DIV A E A A A
	dat += "<div class='SettingValueCol' style='flex-basis: 50%;'>" // DIV A E A A B
	dat += PrefLink("Clear them?", PREFCMD_SCARS_CLEAR, span = "SettingValueCol")
	dat += "</div>" // End of DIV A E A A B
	dat += "</div>" // End of DIV A E A A
	dat += "</div>" // End of DIV A E A
	dat += "</div>" // End of DIV A E

	dat += "<div class='SettingFlexCol' style='flex-basis: 100%;'>" // DIV A F
	dat += "<div class='SettingNameCol'>" // DIV A F A
	dat += "Attribute Stats (Affects Rolls)"
	dat += "</div>" // End of DIV A F A
	dat += "<div class='SettingValueSplit'>" // DIV A F B

	dat += "<div class='SettingValueCol'>" // DIV A F B A
	dat += "<div class='SettingName'>" // DIV A F B A A
	dat += "Strength"
	dat += "</div>" // End of DIV A F B A A
	var/list/statthing = list(PREFDAT_STAT = "strength")
	dat += PrefLink("[special_s]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B A

	dat += "<div class='SettingValueCol'>" // DIV A F B B
	dat += "<div class='SettingName'>" // DIV A F B B A
	dat += "Perception"
	dat += "</div>" // End of DIV A F B B A
	statthing = list(PREFDAT_STAT = "perception")
	dat += PrefLink("[special_p]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B B

	dat += "<div class='SettingValueCol'>" // DIV A F B C
	dat += "<div class='SettingName'>" // DIV A F B C A
	dat += "Endurance"
	dat += "</div>" // End of DIV A F B C A
	statthing = list(PREFDAT_STAT = "endurance")
	dat += PrefLink("[special_e]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B C

	dat += "<div class='SettingValueCol'>" // DIV A F B D
	dat += "<div class='SettingName'>" // DIV A F B D A
	dat += "Charisma"
	dat += "</div>" // End of DIV A F B D A
	statthing = list(PREFDAT_STAT = "charisma")
	dat += PrefLink("[special_c]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B D

	dat += "<div class='SettingValueCol'>" // DIV A F B E
	dat += "<div class='SettingName'>" // DIV A F B E A
	dat += "Intelligence"
	dat += "</div>" // End of DIV A F B E A
	statthing = list(PREFDAT_STAT = "intelligence")
	dat += PrefLink("[special_i]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B E

	dat += "<div class='SettingValueCol'>" // DIV A F B F
	dat += "<div class='SettingName'>" // DIV A F B F A
	dat += "Agility"
	dat += "</div>" // End of DIV A F B F A
	statthing = list(PREFDAT_STAT = "agility")
	dat += PrefLink("[special_a]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B F

	dat += "<div class='SettingValueCol'>" // DIV A F B G
	dat += "<div class='SettingName'>" // DIV A F B G A
	dat += "Luck"
	dat += "</div>" // End of DIV A F B G A
	statthing = list(PREFDAT_STAT = "luck")
	dat += PrefLink("[special_l]", PREFCMD_STAT_CHANGE, statthing, span = "SettingValueCol")
	dat += "</div>" // End of DIV A F B G

	dat += "<div class='SettingValueCol'>" // DIV A F B G
	dat += "<div class='SettingName'>" // DIV A F B G A
	dat += "Total"
	dat += "</div>" // End of DIV A F B G A
	var/total = special_s + special_p + special_e + special_c + special_i + special_a + special_l
	var/maximum = 40
	statthing = list(PREFDAT_STAT = "luck")
	dat += "<div class='SettingFlexColInfo'>" // DIV A F B G A
	dat += "[total] / [maximum]"
	dat += "</div>" // End of DIV A F B G A
	dat += "</div>" // End of DIV A F B G

	dat += "</div>" // End of DIV A F B
	dat += "</div>" // End of DIV A F

	dat += "<div class='SettingFlexCol' style='flex-basis: 100%;'>" // DIV A G
	dat += "<div class='SettingName>" // DIV A G A
	dat += "Quirks"
	dat += "</div>" // End of DIV A G A
	dat += "<div class='SettingValueSplitRowable'>" // DIV A G B
	dat += RowifyQuirks()
	dat += "</div>" // End of DIV A G B
	dat += "</div>" // End of DIV A G
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/AppearanceMisc()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingFlex'>" // DIV A A
	dat += "<div class='SettingName'>" // DIV A A A
	dat += "Species Type:"
	dat += "</div>" // End of DIV A A A
	var/specname = pref_species.name
	dat += PrefLink(specname, PREFCMD_SPECIES)
	dat += "<div class='SettingName'>" // DIV A A B
	dat += "Body model:"
	dat += "</div>" // End of DIV A A B
	var/bmod = "N/A"
	if(gender != NEUTER && pref_species.sexes) // oh yeah, my pref species sexes a lot
		features["body_model"] = gender == MALE ? "Masculine" : "Feminine"
		dat += PrefLink(bmod, PREFCMD_BODY_MODEL)
	if(LAZYLEN(pref_species.allowed_limb_ids))
		if(!chosen_limb_id || !(chosen_limb_id in pref_species.allowed_limb_ids))
			chosen_limb_id = pref_species.limbs_id || pref_species.id
		dat += "<div class='SettingName'>" // DIV A A C
		dat += "Body Sprite:"
		dat += "</div>" // End of DIV A A C
		dat += PrefLink("[chosen_limb_id]", PREFCMD_BODY_SPRITE)
	if(LAZYLEN(pref_species.alt_prefixes))
		dat += "<div class='SettingName'>" // DIV A A C
		dat += "Alt Style:"
		dat += "</div>" // End of DIV A A C
		var/altfix = alt_appearance ? "[alt_appearance]" : "Select"
		dat += PrefLink(altfix, PREFCMD_ALT_PREFIX)
		dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	dat += "<div class='SettingArray'>" // DIV B
	dat += "<div class='SettingFlex'>" // DIV B A
	dat += "<div class='SettingName'>" // DIV B A A
	dat += "Species Name:"
	dat += "</div>" // End of DIV B A A
	var/spename = custom_species ? custom_species : pref_species.name
	dat += PrefLink(spename, PREFCMD_SPECIES_NAME)
	dat += "<div class='SettingName'>" // DIV B A B
	dat += "Blood Color:"
	dat += "</div>" // End of DIV B A B
	if(features["blood_color"] == "")
		features["blood_color"] = "FF0000" // red
	var/list/data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
	dat += ColorBox("blood_color", data = data)
	dat += "<div class='SettingName'>" // DIV B A C
	dat += "Rainbow Blood?"
	dat += "</div>" // End of DIV B A C
	var/rbw = features["blood_color"] == "rainbow" ? "Yes" : "No"
	dat += PrefLink("[rbw]", PREFCMD_RAINBOW_BLOOD)
	dat += "</div>" // End of DIV B A
	dat += "</div>" // End of DIV B
	dat += "<div class='SettingArray'>" // DIV C
	dat += "<div class='SettingFlex'>" // DIV C A
	dat += "<div class='SettingName'>" // DIV C A A
	dat += "Meat Type:"
	dat += "</div>" // End of DIV C A A
	var/meat = features["meat_type"] || "Meaty"
	dat += PrefLink("[meat]", PREFCMD_MEAT_TYPE)
	dat += "<div class='SettingName'>" // DIV C A B
	dat += "Taste:"
	dat += "</div>" // End of DIV C A B
	if(!features["taste"])
		features["taste"] = "something"
	var/tasted = features["taste"] || "somthing"
	dat += PrefLink(tasted, PREFCMD_TASTE)
	dat += "</div>" // End of DIV C A
	dat += "</div>" // End of DIV C
	dat += "<div class='SettingArray'>" // DIV D
	dat += "<div class='SettingFlex'>" // DIV D A
	dat += "<div class='SettingName'>" // DIV D A A
	dat += "Scale:"
	dat += "</div>" // End of DIV D A A
	var/bscale = features["body_size"]*100
	dat += PrefLink("[bscale]", PREFCMD_SCALE)
	dat += "<div class='SettingName'>" // DIV D A B
	dat += "Width:"
	dat += "</div>" // End of DIV D A B
	var/bwidth = features["body_width"]*100
	dat += PrefLink(bwidth, PREFCMD_WIDTH)
	dat += "<div class='SettingName'>" // DIV D A C
	dat += "Scaling"
	dat += "</div>" // End of DIV D A C
	var/fuzsharp = fuzzy ? "Fuzzy" : "Sharp"
	dat += PrefLink(fuzsharp, PREFCMD_FUZZY)
	dat += "</div>" // End of DIV D A
	dat += "</div>" // End of DIV D
	dat += "<div class='SettingArray'>" // DIV E
	dat += "<div class='SettingFlex'>" // DIV E A
	dat += "<div class='SettingName'>" // DIV E A A
	dat += "Offset &udarr;"
	dat += "</div>" // End of DIV E A A
	var/pye = features["pixel_y"] > 0 ? "+[features["pixel_y"]]" : "[features["pixel_y"]]"
	dat += PrefLink(pye, PREFCMD_PIXEL_Y)
	dat += "<div class='SettingName'>" // DIV E A B
	dat += "Offset &lrarr;"
	dat += "</div>" // End of DIV E A B
	var/pxe = features["pixel_x"] > 0 ? "+[features["pixel_x"]]" : "[features["pixel_x"]]"
	dat += PrefLink(pxe, PREFCMD_PIXEL_X)
	dat += "<div class='SettingName'>" // DIV E A C
	dat += "Legs:"
	dat += "</div>" // End of DIV E A C
	var/d_legs = features["legs"]
	dat += PrefLink(d_legs, PREFCMD_LEGS)
	dat += "</div>" // End of DIV E A
	var/use_skintones = pref_species.use_skintones
	if(use_skintones) // humans suck
		dat += "<div class='SettingFlex'>" // DIV E B
		dat += "<div class='SettingName'>" // DIV E B A
		dat += "Skintone:"
		dat += "</div>" // End of DIV E B A
		if(use_custom_skin_tone)
			data = list(PREFDAT_COLKEY_IS_VAR = TRUE)
			dat += ColorBox("skin_tone", data = data)
		else
			dat += PrefLink("[skin_tone]", PREFCMD_SKIN_TONE)
		dat += "</div>" // End of DIV E B
	dat += "</div>" // End of DIV E
	return dat.Join()

/datum/preferences/proc/AppearanceHairEyes()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingArray'>" // DIV A A
	// ^^ you might be wondering why theres two of these
	dat += "<div class='SettingFlexCol'>" // DIV A A A
	dat += "<div class='SettingName'>" // DIV A A A A
	dat += "Eyes"
	dat += "</div>" // End of DIV A A A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A B
	dat += "<div class='SettingNameCol'>" // DIV A A A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A A A B A
	dat += PrefLink("<", PREFCMD_EYE_TYPE, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_EYE_TYPE, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink(capitalize("[eye_type]"), PREFCMD_EYE_TYPE)
	dat += "<div class='SettingNameCol'>" // DIV A A A B B
	dat += "Left Color:"
	dat += "</div>" // End of DIV A A A B B
	var/list/feat_data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
	var/list/var_data = list(PREFDAT_COLKEY_IS_VAR = TRUE)
	dat += ColorBox("left_eye_color", data = var_data)
	dat += "<div class='SettingNameCol'>" // DIV A A A B C
	dat += "Right Color:"
	dat += "</div>" // End of DIV A A A B C
	dat += ColorBox("right_eye_color", data = var_data)
	dat += "</div>" // End of DIV A A A B
	dat += "</div>" // End of DIV A A A

	dat += "<div class='SettingFlexCol'>" // DIV A A B
	dat += "<div class='SettingName'>" // DIV A A B A
	dat += "Hairea 1"
	dat += "</div>" // End of DIV A A B A
	dat += "<div class='SettingValueSplit'>" // DIV A A B B
	dat += "<div class='SettingNameCol'>" // DIV A A B B A
	dat += "Style:"
	dat += "</div>" // End of DIV A A B B A
	dat += PrefLink("<", PREFCMD_HAIR_STYLE_1, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_HAIR_STYLE_1, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[hair_style]", PREFCMD_HAIR_STYLE_1)
	dat += "<div class='SettingNameCol'>" // DIV A A B B B
	dat += "Color:"
	dat += "</div>" // End of DIV A A B B B
	dat += ColorBox("hair_color", data = var_data)
	dat += "</div>" // End of DIV A A B B
	dat += "<div class='SettingValueSplit'>" // DIV A A B C
	dat += "<div class='SettingNameCol'>" // DIV A A B C A
	dat += "Gradient:"
	dat += "</div>" // End of DIV A A B C A
	dat += PrefLink("<", PREFCMD_HAIR_GRADIENT_1, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_HAIR_GRADIENT_1, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[features["grad_style"]]", PREFCMD_HAIR_GRADIENT_1)
	dat += "<div class='SettingNameCol'>" // DIV A A B C B
	dat += "Color:"
	dat += "</div>" // End of DIV A A B C B
	dat += ColorBox("hair_gradient_color_1", data = feat_data)
	dat += "</div>" // End of DIV A A B C
	dat += "</div>" // End of DIV A A B
	dat += "</div>" // End of DIV A A
	dat += "<div class='SettingArray'>" // DIV A B
	dat += "<div class='SettingFlexCol'>" // DIV A B A
	dat += "<div class='SettingName'>" // DIV A B A A
	dat += "Hairea 2"
	dat += "</div>" // End of DIV A B A A
	dat += "<div class='SettingValueSplit'>" // DIV A B A B
	dat += "<div class='SettingNameCol'>" // DIV A B A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A B A B A
	dat += PrefLink("<", PREFCMD_HAIR_STYLE_2, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_HAIR_STYLE_2, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[features["hair_style_2"]]", PREFCMD_HAIR_STYLE_2)
	dat += "<div class='SettingNameCol'>" // DIV A B A B B
	dat += "Color:"
	dat += "</div>" // End of DIV A B A B B
	dat += ColorBox("hair_color_2", data = feat_data)
	dat += "</div>" // End of DIV A B A B
	dat += "<div class='SettingValueSplit'>" // DIV A B A C
	dat += "<div class='SettingNameCol'>" // DIV A B A C A
	dat += "Gradient:"
	dat += "</div>" // End of DIV A B A C A
	dat += PrefLink("<", PREFCMD_HAIR_GRADIENT_2, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_HAIR_GRADIENT_2, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[features["grad_style_2"]]", PREFCMD_HAIR_GRADIENT_2)
	dat += "<div class='SettingNameCol'>" // DIV A B A C B
	dat += "Color:"
	dat += "</div>" // End of DIV A B A C B
	dat += ColorBox("grad_color_2", data = feat_data)
	dat += "</div>" // End of DIV A B A C
	dat += "</div>" // End of DIV A B A
	dat += "</div>" // End of DIV A B
	dat += "<div class='SettingArray'>" // DIV A C
	dat += "<div class='SettingFlexCol'>" // DIV A C A
	dat += "<div class='SettingName'>" // DIV A C A A
	dat += "Facial Hair"
	dat += "</div>" // End of DIV A C A A
	dat += "<div class='SettingValueSplit'>" // DIV A C A B
	dat += "<div class='SettingNameCol'>" // DIV A C A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A C A B A
	dat += PrefLink("<", PREFCMD_FACIAL_HAIR_STYLE, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_FACIAL_HAIR_STYLE, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[facial_hair_style]", PREFCMD_FACIAL_HAIR_STYLE)
	dat += "<div class='SettingNameCol'>" // DIV A C A B B
	dat += "Color:"
	dat += "</div>" // End of DIV A C A B B
	dat += ColorBox("facial_hair_color", data = var_data)
	dat += "</div>" // End of DIV A C A B
	dat += "</div>" // End of DIV A C A
	dat += "</div>" // End of DIV A C
	dat += "</div>" // End of DIV A
	// As am I
	return dat.Join()

/// Body parts, body parts, getting me erect
/datum/preferences/proc/AppearanceParts()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	// dat += "<div class='SettingFlexCol'>" // DIV A A
	// dat += "<div class='SettingValueSplit'>" // DIV A A A
	// var/mismash = "Show Mismatched Parts"
	// if(show_all_parts)
	// 	mismash = "Show Only Recommended Parts"
	// dat += PrefLink("[mismash]", PREFCMD_MISMATCHED_MARKINGS, span = "SmolBox")
	// dat += "<span class='Spacer'></span>"
	// dat += "</div>" // End of DIV A A A
	// dat += "</div>" // End of DIV A A
	dat += "<div class='PartsContainer'>" // DIV A A
	for(var/mutant_part in GLOB.all_mutant_parts)
		if(mutant_part == "mam_body_markings")
			continue // we'll get to this
		if(!parent.can_have_part(mutant_part))
			continue
		dat += "<div class='PartsFlex'>" // DIV A A A
		dat += "<div class='SettingFlexCol'>" // DIV A A A A
		dat += "<div class='SettingNameCol'>" // DIV A A A A A
		dat += "[GLOB.all_mutant_parts[mutant_part]]"
		dat += "</div>" // End of DIV A A A A A
		dat += "<div class='SettingValueSplit'>" // DIV A A A A B
		dat += "<div class='SettingNameCol'>" // DIV A A A A B A
		dat += "Style:"
		dat += "</div>" // End of DIV A A A A B A
		dat += PrefLink("<", PREFCMD_CHANGE_PART, list(PREFDAT_PARTKIND = mutant_part, PREFDAT_GO_PREV = TRUE), span = "SmolBox")
		dat += PrefLink(">", PREFCMD_CHANGE_PART, list(PREFDAT_PARTKIND = mutant_part, PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
		dat += PrefLink("[features[mutant_part]]", PREFCMD_CHANGE_PART, list(PREFDAT_PARTKIND = mutant_part))
		dat += "</div>" // End of DIV A A A A B
		/// now for the hell that is *colors*
		dat += "<div class='SettingValueSplit'>" // DIV A A A A C
		var/color_type = GLOB.colored_mutant_parts[mutant_part]
		var/list/feat_data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
		if(color_type)
			dat += ColorBox(color_type, data = feat_data)
		else // this is the hell
			if(features["color_scheme"] != ADVANCED_CHARACTER_COLORING)
				features["color_scheme"] = ADVANCED_CHARACTER_COLORING // screw you, use it
			var/find_part = features[mutant_part] || pref_species.mutant_bodyparts[mutant_part]
			var/find_part_list = GLOB.mutant_reference_list[mutant_part]
			if(!find_part || find_part == "None" || !find_part_list)
				continue
			var/datum/sprite_accessory/accessory = find_part_list[find_part]
			if(!accessory)
				continue
			// fuuck you POOJ
			if(accessory.color_src != MATRIXED && \
				accessory.color_src != MUTCOLORS && \
				accessory.color_src != MUTCOLORS2 && \
				accessory.color_src != MUTCOLORS3)
				continue // something something mutcolors are deprecated, not that it matters
			var/mutant_string = accessory.mutant_part_string
			var/primary_feature = "[mutant_string]_primary"
			var/secondary_feature = "[mutant_string]_secondary"
			var/tertiary_feature = "[mutant_string]_tertiary"
			/// these just sanitize the colors, pay no attention!!!
			if(!features[primary_feature])
				features[primary_feature] = features["mcolor"]
			if(!features[secondary_feature])
				features[secondary_feature] = features["mcolor2"]
			if(!features[tertiary_feature])
				features[tertiary_feature] = features["mcolor3"]
			var/matrixed_sections = accessory.matrixed_sections
			if(accessory.color_src == MATRIXED)
				if(!matrixed_sections)
					message_admins("Sprite Accessory Failure (customization): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
					continue
				// this part properly shuffles the colors around becausE THANKS POOJ
				switch(matrixed_sections)
					if(MATRIX_GREEN) //only composed of a green section
						primary_feature = secondary_feature //swap primary for secondary, so it properly assigns the second colour, reserved for the green section
					if(MATRIX_BLUE)
						primary_feature = tertiary_feature //same as above, but the tertiary feature is for the blue section
					if(MATRIX_RED_BLUE) //composed of a red and blue section
						secondary_feature = tertiary_feature //swap secondary for tertiary, as blue should always be tertiary
					if(MATRIX_GREEN_BLUE) //composed of a green and blue section
						primary_feature = secondary_feature //swap primary for secondary, as first option is green, which is linked to the secondary
						secondary_feature = tertiary_feature //swap secondary for tertiary, as second option is blue, which is linked to the tertiary
					// BUT WHAT ABOUT FULL RGB well tahts already set up
			/// NOW, the colors are all set up, display the color pickers
			dat += ColorBox(primary_feature, data = feat_data)
			if(accessory.ShouldHaveSecondaryColor())
				dat += ColorBox(secondary_feature, data = feat_data)
				if(accessory.ShouldHaveTertiaryColor())
					dat += ColorBox(tertiary_feature, data = feat_data) // WAS THAT SO HARD, POOJ?
		dat += "</div>" // End of DIV A A A A C
		dat += "</div>" // End of DIV A A A
	dat += "</div>" // End of DIV A A
	/// robot parts
	dat += "<div class='SettingArray'>" // DIV A B
	dat += "<div class='SettingFlexCol'>" // DIV A B A
	dat += "<div class='SettingName'>" // DIV A B A A
	dat += "Limb Modifications"
	for(var/modification in modified_limbs)
		dat += "<div class='SettingValueSplit'>"
		dat += "<div class='SettingNameCol'>"
		dat += "[modification]"
		dat += "</div>"
		dat += PrefLink("X", PREFCMD_REMOVE_LIMB, list(PREFDAT_REMOVE_LIMB_MOD = modification), span = "SmolBox")
		var/toshow = modified_limbs[modification][1]
		if(toshow == LOADOUT_LIMB_PROSTHETIC)
			toshow = modified_limbs[modification][2]
		dat += PrefLink(toshow, PREFCMD_MODIFY_LIMB, list(PREFDAT_MODIFY_LIMB_MOD = modification))
		dat += "</div>"
	dat += "<div class='SettingValueSplit'>" // DIV A B A B
	dat += PrefLink("+ Add Something!", PREFCMD_ADD_LIMB)
	dat += "</div>" // End of DIV A B A B
	dat += "</div>" // End of DIV A B A
	dat += "</div>" // End of DIV A B
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/AppearanceMarkings()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingFlexCol'>" // DIV A A
	dat += "<div class='SettingName'>" // DIV A A A
	dat += "Cool Markings"
	dat += "</div>" // End of DIV A A A
	if(!parent.can_have_part("mam_body_markings"))
		dat += "<div class='SettingNameCol'>" // DIV A A A B
		dat += "Oh no, you can't have any! Tough luck :("
		dat += "</div>" // End of DIV A A A B
		dat += "</div>" // End of DIV A A
		dat += "</div>" // End of DIV A
		return dat.Join()
	// we use mam markings, ma'am
	if(LAZYLEN(features["mam_body_markings"]))
		var/list/markings = features["mam_body_markings"]
		if(!islist(markings))
			markings = list()
		// we're gonna group em turnwise by the limb they're on
		/// FORMAT: list("Head" = list(HTML glonch))
		var/list/markings_by_part = list()
		var/list/rev_markings = reverseList(markings)
		for(var/list/mark in rev_markings)
			var/limb_value = mark[MARKING_LIMB_INDEX_NUM]
			var/limb_name = GLOB.bodypart_names[num2text(limb_value)]
			if(!markings_by_part[limb_name])
				markings_by_part[limb_name] = list()
			mark = SanitizeMarking(mark)
			/// make the HTML glonch
			var/m_uid = mark[MARKING_UID]
			var/cm_dat = ""
			cm_dat += "<div class='SettingValueSplit'>" // DIV A A A B A
			cm_dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A A B A A
			cm_dat += "[mark[MARKING_NAME]]"
			cm_dat += "</div>" // End of DIV A A A B A A
			cm_dat += MarkingPrefLink(
				"X",
				PREFCMD_MARKING_REMOVE,
				m_uid,
				span = "SmolBox"
			)
			cm_dat += MarkingPrefLink(
				"&uarr;",
				PREFCMD_MARKING_MOVE_UP,
				m_uid,
				span = "SmolBox"
			)
			cm_dat += MarkingPrefLink(
				"&darr;",
				PREFCMD_MARKING_MOVE_DOWN,
				m_uid,
				span = "SmolBox"
			)
			cm_dat += MarkingPrefLink(
				"<",
				PREFCMD_MARKING_PREV,
				m_uid,
				span = "SmolBox"
			)
			cm_dat += MarkingPrefLink(
				">",
				PREFCMD_MARKING_NEXT,
				m_uid,
				span = "SmolBox"
			)
			cm_dat += MarkingPrefLink(
				"[mark[MARKING_NAME]]",
				PREFCMD_MARKING_EDIT,
				m_uid
			)
			cm_dat += "</div>" // End of DIV A A A B A
			/// and here come the colors
			cm_dat += "<div class='SettingValueSplit'>" // DIV A A A B B
			var/datum/sprite_accessory/mam_body_markings/S = GLOB.mam_body_markings_list[mark[2]]
			if(S)
				var/matrixed_sections = S.covered_limbs[limb_name]
				if(matrixed_sections)
					// if it has nothing initialize it to white
					if(LAZYLEN(mark) == 2)
						mark.len = 3
						var/first = "#FFFFFF"
						var/second = "#FFFFFF"
						var/third = "#FFFFFF"
						if(features["mcolor"])
							first = "#[features["mcolor"]]"
						if(features["mcolor2"])
							second = "#[features["mcolor2"]]"
						if(features["mcolor3"])
							third = "#[features["mcolor3"]]"
						mark[MARKING_COLOR_LIST] = list(first, second, third) // just assume its 3 colours if it isnt it doesnt matter we just wont use the other values
					// index magic
					var/primary_index = 1
					var/secondary_index = 2
					var/tertiary_index = 3
					switch(matrixed_sections)
						if(MATRIX_GREEN)
							primary_index = 2
						if(MATRIX_BLUE)
							primary_index = 3
						if(MATRIX_RED_BLUE)
							secondary_index = 2
						if(MATRIX_GREEN_BLUE)
							primary_index = 2
							secondary_index = 3
					cm_dat += MarkingColorBox(mark, primary_index)
					if(matrixed_sections == MATRIX_RED_BLUE || \
						matrixed_sections == MATRIX_GREEN_BLUE || \
						matrixed_sections == MATRIX_RED_GREEN || \
						matrixed_sections == MATRIX_ALL)
						cm_dat += MarkingColorBox(mark, secondary_index)
					if(matrixed_sections == MATRIX_ALL)
						cm_dat += MarkingColorBox(mark, tertiary_index)
			cm_dat += "</div>" // End of DIV A A A B B
			/// just kidding, we're not sorting anything!
			markings_by_part += cm_dat
		/// now we display the markings
		for(var/part in markings_by_part)
			dat += "[part]"
	dat += "<div class='SettingValueSplit'>" // DIV A A B
	dat += PrefLink("+ Add Something!", PREFCMD_MARKING_ADD)
	dat += "</div>" // End of DIV A A B
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()


/datum/preferences/proc/AppearanceUnderlyingUndies()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingArray'>" // DIV A A	
	dat += "<div class='PartsContainer'>" // DIV A A A
	dat += "<div class='PartsFlex'>" // DIV A A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A A
	dat += "Topwear"
	dat += "</div>" // End of DIV A A A A A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A A A B
	dat += "<div class='SettingNameCol'>" // DIV A A A A A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A A A A A B A
	dat += PrefLink("<", PREFCMD_UNDERSHIRT, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_UNDERSHIRT, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[undershirt]", PREFCMD_UNDERSHIRT)
	var/whereisit = LAZYACCESS(GLOB.undie_position_strings, undershirt_overclothes + 1)
	dat += PrefLink("[whereisit]", PREFCMD_UNDERSHIRT_OVERCLOTHES, span = "SmolBox")
	dat += "</div>" // End of DIV A A A A A B
	dat += "<div class='SettingValueSplit'>" // DIV A A A A A C
	dat += "<div class='SettingNameCol'>" // DIV A A A A A C A
	dat += "Color:"
	dat += "</div>" // End of DIV A A A A A C A
	var/list/data = list(PREFDAT_COLKEY_IS_VAR = TRUE)
	dat += ColorBox("undershirt_color", data = data)
	dat += "</div>" // End of DIV A A A A A C
	dat += "</div>" // End of DIV A A A A A
	dat += "</div>" // End of DIV A A A
	dat += "<div class='PartsFlex'>" // DIV A A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A A B A A
	dat += "Underwear"
	dat += "</div>" // End of DIV A A A B A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A B A B
	dat += "<div class='SettingNameCol'>" // DIV A A A B A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A A A B A B A
	dat += PrefLink("<", PREFCMD_UNDERWEAR, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_UNDERWEAR, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[underwear]", PREFCMD_UNDERWEAR)
	var/underwear_position = LAZYACCESS(GLOB.undie_position_strings, undies_overclothes + 1)
	dat += PrefLink("[underwear_position]", PREFCMD_UNDERWEAR_OVERCLOTHES, span = "SmolBox")
	dat += "</div>" // End of DIV A A A B A B
	dat += "<div class='SettingValueSplit'>" // DIV A A A B A C
	dat += "<div class='SettingNameCol'>" // DIV A A A B A C A
	dat += "Color:"
	dat += "</div>" // End of DIV A A A B A C A
	dat += ColorBox("undie_color", data = data)
	dat += "</div>" // End of DIV A A A B A C
	dat += "</div>" // End of DIV A A A B A
	dat += "</div>" // End of DIV A A A
	dat += "<div class='PartsFlex'>" // DIV A A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A A C A A
	dat += "Socks"
	dat += "</div>" // End of DIV A A A C A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A C A B
	dat += "<div class='SettingNameCol'>" // DIV A A A C A B A
	dat += "Style:"
	dat += "</div>" // End of DIV A A A C A B A
	dat += PrefLink("<", PREFCMD_SOCKS, list(PREFDAT_GO_PREV = TRUE), span = "SmolBox")
	dat += PrefLink(">", PREFCMD_SOCKS, list(PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
	dat += PrefLink("[socks]", PREFCMD_SOCKS)
	var/socks_position = LAZYACCESS(GLOB.undie_position_strings, socks_overclothes + 1)
	dat += PrefLink("[socks_position]", PREFCMD_SOCKS_OVERCLOTHES, span = "SmolBox")
	dat += "</div>" // End of DIV A A A C A B
	dat += "<div class='SettingValueSplit'>" // DIV A A A C A C
	dat += "<div class='SettingNameCol'>" // DIV A A A C A C A
	dat += "Color:"
	dat += "</div>" // End of DIV A A A C A C A
	dat += ColorBox("socks_color", data = data)
	dat += "</div>" // End of DIV A A A C A C
	dat += "</div>" // End of DIV A A A C A
	dat += "</div>" // End of DIV A A A
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/AppearanceUnderlyingLayering()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<table class='TabHeader'>" // DIV A A
	// header row
	dat += "<tr>" // DIV A A A
	dat += "<td>" // DIV A A A A
	dat += "Part"
	dat += "</td>" // End of DIV A A A A
	dat += "<td colspan='2'>" // DIV A A A B
	dat += "Shift"
	dat += "</td>" // End of DIV A A A B
	dat += "<td colspan='2'>" // DIV A A A C
	dat += "Hidden by..."
	dat += "</td>" // End of DIV A A A C
	dat += "<td>" // DIV A A A D
	dat += "Override"
	dat += "</td>" // End of DIV A A A D
	dat += "<td>" // DIV A A A E
	dat += "See on others"
	dat += "</td>" // End of DIV A A A E
	dat += "<td>" // DIV A A A F
	dat += "Has"
	dat += "</td>" // End of DIV A A A F
	dat += "</tr>" // End of DIV A A A
	/// now the true fun begins
	/// okay we've all ahd our fun with the c_string, time to use json like a real adult
	var/list/cakestring = features["genital_order"]
	cakestring = reverseList(cakestring) // so the order makes sense
	//cakestring should have every genital known to man, so this should be fine
	// first, filter out any non-visible parts
	for(var/haz_donk in cakestring)
		var/datum/genital_data/GD = GLOB.genital_data_system[haz_donk]
		if(!(GD.genital_flags & GENITAL_CAN_HAVE))
			cakestring -= haz_donk
			continue
		if(!(GD.genital_flags & GENITAL_INTERNAL))
			cakestring -= haz_donk
			continue
	var/index = 1
	for(var/has_donk in cakestring)
		var/datum/genital_data/GD = GLOB.genital_data_system[has_donk]
		dat += "<tr>"
		dat += "<td>"
		dat += "[GD.name]"
		dat += "</td>"
		dat += "<td>"
		if(index > 1) // dir is flipped, because the list is reversed
			dat += PrefLink("&uarr;", PREFCMD_SHIFT_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk, PREFDAT_GO_PREV = TRUE), span = "SmolBox")
		else
			dat += "&nbsp;"
		dat += "</td>"
		dat += "<td>"
		if(index < LAZYLEN(cakestring))
			dat += PrefLink("&darr;", PREFCMD_SHIFT_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk, PREFDAT_GO_NEXT = TRUE), span = "SmolBox")
		else
			dat += "&nbsp;"
		dat += "</td>"
		dat += "<td>"
		var/undiehidspan
		if(features[GD.vis_flags_key] & GENITAL_RESPECT_UNDERWEAR)
			undiehidspan = "TabCellselected"
		dat += PrefLink("Underwear", PREFCMD_HIDE_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk, PREFDAT_HIDDEN_BY = "undies"), span = undiehidspan)
		dat += "</td>"
		dat += "<td>"
		var/clotheshidspan
		if(features[GD.vis_flags_key] & GENITAL_RESPECT_CLOTHING)
			clotheshidspan = "TabCellselected"
		dat += PrefLink("Clothes", PREFCMD_HIDE_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk, PREFDAT_HIDDEN_BY = "clothes"), span = clotheshidspan)
		dat += "</td>"
		dat += "<td>"
		var/peen_vis_override
		if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_HIDDEN))
			peen_vis_override = "Always Hidden"
		else if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_VISIBLE))
			peen_vis_override = "Always Visible"
		else
			peen_vis_override = "Check Coverage"
		dat += PrefLink(peen_vis_override, PREFCMD_OVERRIDE_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk), span = "SmolBox")
		dat += "</td>"
		dat += "<td>"
		var/peen_see_span
		if(!(features["genital_hide"] & GD.hide_flag))
			peen_see_span = "TabCellselected"
		dat += PrefLink("Yes", PREFCMD_SEE_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk), span = peen_see_span)
		dat += "</td>"
		dat += "<td>"
		var/peen_has_span
		var/peen_word = "No"
		if(features[GD.has_key])
			peen_has_span = "TabCellselected"
			peen_word = "Yes"
		dat += PrefLink(peen_word, PREFCMD_TOGGLE_GENITAL, list(PREFDAT_GENITAL_HAS = has_donk), span = peen_has_span)
		dat += "</td>"
		dat += "</tr>"
		index += 1
	dat += "<tr>"
	dat += "<td colspan='8'>"
	dat += PrefLink("P-Hud Whitelisting", PREFCMD_PHUD_WHITELIST)
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
	dat += "</div>"
	return dat.Join()

// this one is built based on which genital sub sub tab is open
/datum/preferences/proc/AppearanceUnderlyingGenitals()
	var/datum/genital_data/GD = GLOB.genital_data_system[current_sub_subtab]
	if(!GD)
		return "OH NO THERES A BUG HERE TELL DAN ERROR CODE: SQUISHY FOX BINGUS 2000"
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingFlexCol'>" // DIV A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A
	dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A A A
	dat += "Has one:"
	dat += "</div>" // End of DIV A A A A
	var/yesno = "No"
	if(features[GD.has_key])
		yesno = "Yes"
	dat += PrefLink(yesno, PREFCMD_TOGGLE_GENITAL, list(PREFDAT_GENITAL_HAS = current_sub_subtab))
	var/can_color = GD.genital_flags & GENITAL_CAN_RECOLOR
	if(can_color)
		var/list/feat_data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
		dat += ColorBox(GD.color_key, data = feat_data)
	dat += "</div>" // End of DIV A A A
	if(!(GD.genital_flags & GENITAL_INTERNAL))
		var/can_shape = GD.genital_flags & GENITAL_CAN_RESHAPE
		var/can_size = GD.genital_flags & GENITAL_CAN_RESIZE
		if(can_shape || can_size)
			dat += "<div class='SettingValueSplit'>" // DIV A A B
			if(can_shape)
				dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A B A
				dat += "Shape:"
				dat += "</div>" // End of DIV A A B A
				dat += PrefLink("[capitalize(features[GD.shape_key])]", PREFCMD_CHANGE_GENITAL_SHAPE, list(PREFDAT_GENITAL_HAS = current_sub_subtab))
			if(can_size)
				dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A B B
				dat += "Size:"
				dat += "</div>" // End of DIV A A B B
				dat += PrefLink("[GD.SizeString(features[GD.size_key])]", PREFCMD_CHANGE_GENITAL_SIZE, list(PREFDAT_GENITAL_HAS = current_sub_subtab))
			dat += "</div>" // End of DIV A A B
		var/hidden_by_clothes = GD.genital_flags & GENITAL_RESPECT_CLOTHING
		var/hbc_span = ""
		if(hidden_by_clothes)
			hbc_span = "TabCellselected"
		var/hidden_by_undies = GD.genital_flags & GENITAL_RESPECT_UNDERWEAR
		var/hbu_span = ""
		if(hidden_by_undies)
			hbu_span = "TabCellselected"
		dat += "<div class='SettingValueSplit'>" // DIV A A C
		dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A C A
		dat += "Hidden by:"
		dat += "</div>" // End of DIV A A C A
		dat += PrefLink("Clothes", PREFCMD_HIDE_GENITAL, list(PREFDAT_GENITAL_HAS = current_sub_subtab, PREFDAT_HIDDEN_BY = "clothes"), span = hbc_span)
		dat += PrefLink("Underpants", PREFCMD_HIDE_GENITAL, list(PREFDAT_GENITAL_HAS = current_sub_subtab, PREFDAT_HIDDEN_BY = "undies"), span = hbu_span)
		dat += "</div>" // End of DIV A A C
		var/override = "Check Coverage"
		if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_HIDDEN))
			override = "Always Hidden"
		else if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_VISIBLE))
			override = "Always Visible"
		dat += "<div class='SettingValueSplit'>" // DIV A A D
		dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A D A
		dat += "Override:"
		dat += "</div>" // End of DIV A A D A
		dat += PrefLink(override, PREFCMD_OVERRIDE_GENITAL, list(PREFDAT_GENITAL_HAS = current_sub_subtab))
		dat += "</div>" // End of DIV A A D
		var/see_on_others = "No"
		if(!(features["genital_hide"] & GD.hide_flag))
			see_on_others = "Yes"
		dat += "<div class='SettingValueSplit'>" // DIV A A E
		dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A E A
		dat += "See on others:"
		dat += "</div>" // End of DIV A A E A
		dat += PrefLink(see_on_others, PREFCMD_SEE_GENITAL, list(PREFDAT_GENITAL_HAS = current_sub_subtab))
		dat += "</div>" // End of DIV A A E
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/// the unholy evil death bringer of the preferences tab
/datum/preferences/proc/Loadout()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='FlexTable'>" // DIV A A
	dat += "<div class='SettingName'>" // DIV A A A
	var/gear_points = CONFIG_GET(number/initial_gear_points)
	var/list/chosen_gear = loadout_data["SAVE_[loadout_slot]"]
	if(chosen_gear)
		for(var/loadout_item in chosen_gear)
			var/loadout_item_path = loadout_item[LOADOUT_ITEM]
			if(loadout_item_path)
				var/datum/gear/loadout_gear = text2path(loadout_item_path)
				if(loadout_gear)
					gear_points -= initial(loadout_gear.cost)
	else
		chosen_gear = list()
	var/points_color = "#00FF00"
	if(gear_points <= 0)
		points_color = "#FF0000"
	dat += "You have <font color='[points_color]'>[gear_points]</font> points!"
	dat += "</div>" // End of DIV A A A
	dat += PrefLink("Reset", PREFCMD_LOADOUT_RESET, list(PREFDAT_LOADOUT_SLOT = loadout_slot), span = "SmolBox")
	dat += "<span class='Spacer'></span>"
	dat += PrefLink("X", PREFCMD_LOADOUT_SEARCH_CLEAR, span = "SmolBox")
	var/searchterm = loadout_search ? copytext(loadout_search, 1, 30) : "Search"
	dat += PrefLink("[searchterm]", PREFCMD_LOADOUT_SEARCH, span = "SmolBox Wider100")
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	// now we need to build the actual gear list
	// Categories!
	if(!GLOB.loadout_categories[gear_category] && gear_category != GEAR_CAT_ALL_EQUIPPED)
		gear_category = GLOB.loadout_categories[1]
	dat += "<div class='FlexTable'>" // DIV A A
	for(var/category in (list(GEAR_CAT_ALL_EQUIPPED = list()) | GLOB.loadout_categories))
		var/selspan = ""
		if(category == gear_category)
			selspan = "TabCellselected"
		dat += PrefLink(category, PREFCMD_LOADOUT_CATEGORY, list(PREFDAT_LOADOUT_CATEGORY = html_encode(category)), span = selspan)
	dat += "</div>" // End of DIV A A
	dat += "<div class='CoolDivider'></div>" // DIV A B End of DIV A B
	// Subcategories!
	var/list/subcategories = GLOB.loadout_categories[gear_category]
	if(gear_category != GEAR_CAT_ALL_EQUIPPED && !subcategories.Find(gear_subcategory))
		gear_subcategory = subcategories[1]
	if(!searchterm && gear_category != GEAR_CAT_ALL_EQUIPPED)
		dat += "<div class='FlexTable'>" // DIV A C
		for(var/subcategory in subcategories)
			var/selspan = ""
			if(subcategory == gear_subcategory)
				selspan = "TabCellselected"
			dat += PrefLink(subcategory, PREFCMD_LOADOUT_SUBCATEGORY, list(PREFDAT_LOADOUT_SUBCATEGORY = html_encode(subcategory)), span = selspan)
		dat += "</div>" // End of DIV A C
		dat += "<div class='CoolDivider'></div>" // DIV A D End of DIV A D
	// now we need to build the actual gear list
	// first lets get all the gear
	var/list/mystuff = list()
	var/list/my_saved = loadout_data["SAVE_[loadout_slot]"]
	for(var/loadout_gear in my_saved)
		mystuff["[loadout_gear[LOADOUT_ITEM]]"] = TRUE // typecache!
	var/list/flatlyss
	if(loadout_search || gear_category == GEAR_CAT_ALL_EQUIPPED)
		var/list/searchmine = list()
		if(gear_category == GEAR_CAT_ALL_EQUIPPED)
			searchmine = mystuff
		else
			searchmine = list()
		flatlyss = GetGearFlatList(loadout_search, searchmine)
	else
		flatlyss = flatten_list(GLOB.loadout_items[gear_category][gear_subcategory])
	// now we need to display the gear
	dat += "<div class='SettingArray'>" // DIV A E
	dat += "<div class='PartsContainer'>" // DIV A E A
	for(var/datum/gear/gear in flatlyss)
		var/donoritem = gear.donoritem
		if(donoritem && !gear.donator_ckey_check(parent.ckey))
			continue
		var/i_have_it = mystuff["[gear.type]"]
		var/edited_name
		var/edited_desc
		var/edited_color = "FFFFFF"
		if(i_have_it)
			var/list/loadout_item = has_loadout_gear(loadout_slot, "[gear.name]")
			if(loadout_item)
				if(!loadout_item[LOADOUT_CUSTOM_COLOR])
					loadout_item[LOADOUT_CUSTOM_COLOR] = "FFFFFF"
				edited_color = loadout_item[LOADOUT_CUSTOM_COLOR]
				if(LAZYLEN(loadout_item[LOADOUT_CUSTOM_NAME]))
					edited_name = loadout_item[LOADOUT_CUSTOM_NAME]
				if(LAZYLEN(loadout_item[LOADOUT_CUSTOM_DESCRIPTION]))
					edited_desc = loadout_item[LOADOUT_CUSTOM_DESCRIPTION]
		dat += "<div class='PartsFlex'>" // DIV A E A A
		dat += "<div class='FlexTable'>" // DIV A E A A A
		var/list/namespan = list()
		if(i_have_it)
			namespan += "TabCellselected"
		namespan += "NotSoSmolBox"
		if(edited_name)
			namespan += "EditedEntry"
		var/truenamespan = namespan.Join(" ")
		var/namedisplay = edited_name ? edited_name : gear.name
		dat += PrefLink(namedisplay, PREFCMD_LOADOUT_TOGGLE, list(PREFDAT_LOADOUT_GEAR_NAME = "[gear.type]"), span = truenamespan)
		var/canafford = (gear_points - gear.cost) >= 0
		var/costspan = "SettingName SmolBox"
		if(!canafford)
			costspan += " CantAfford"
		dat += "<div class='SettingName SmolBox'>" // DIV A E A A A B
		dat += "[gear.cost] pts"
		dat += "</div>" // End of DIV A E A A A B
		var/descspan = "SettingValueSplit"
		if(edited_desc)
			descspan += " EditedEntry"
		dat += "</div>" // End of DIV A E A A
		dat += "<div class='[descspan]'>" // DIV A E A A A C
		dat += "<div class='LoadoutDesc'>" // DIV A E A A A C A
		var/descdisplay = edited_desc ? edited_desc : gear.description
		dat += descdisplay
		dat += "</div>" // End of DIV A E A A A C A
		dat += "</div>" // End of DIV A E A A A C
		if(i_have_it) // show the customization things
			dat += "<div class='SettingValueSplit'>" // DIV A E A A A D
			dat += GearColorBox(gear, edited_color)
			dat += PrefLink("Edit <br>Name", PREFCMD_LOADOUT_RENAME, list(PREFDAT_GEAR_TYPE = "[gear.type]"), span = "SmolBox NotSoSmolBox")
			dat += PrefLink("Edit <br>Desc", PREFCMD_LOADOUT_REDESC, list(PREFDAT_GEAR_TYPE = "[gear.type]"), span = "SmolBox NotSoSmolBox")
			dat += "</div>" // End of DIV A E A A A D
		dat += "</div>" // End of DIV A E A A
	dat += "</div>" // End of DIV A E A
	dat += "</div>" // End of DIV A E
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesGeneral()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Widescreen
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Widescreen"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled (15x15)"
	if(widescreenpref)
		showtext1 = "Enabled ([CONFIG_GET(string/default_view)])"
	dat += PrefLink(showtext1, PREFCMD_WIDESCREEN_TOGGLE)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Auto Stand
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Auto Stand"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "Disabled"
	if(autostand)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_AUTOSTAND_TOGGLE)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Force Slot Storage HUD
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Force Slot Storage HUD"
	dat += "</div>" // End of DIV A A C A A
	var/showtext3 = "Disabled"
	if(no_tetris_storage)
		showtext3 = "Enabled"
	dat += PrefLink(showtext3, PREFCMD_TETRIS_STORAGE_TOGGLE)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Gun Cursor
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Gun Cursor"
	dat += "</div>" // End of DIV A A D A A
	var/showtext4 = "Disabled"
	if(cb_toggles & AIM_CURSOR_ON)
		showtext4 = "Enabled"
	dat += PrefLink(showtext4, PREFCMD_GUNCURSOR_TOGGLE)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	// Screen Shake
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "Screen Shake"
	dat += "</div>" // End of DIV A A E A A
	var/showtext5 = "None"
	if(screenshake == 100)
		showtext5 = "Full"
	else if(screenshake != 0)
		showtext5 = "[screenshake]"
	dat += PrefLink(showtext5, PREFCMD_SCREENSHAKE_TOGGLE)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	// Damage Screen Shake
	dat += "<div class='PartsFlex'>" // DIV A A F
	dat += "<div class='SettingFlexCol'>" // DIV A A F A
	dat += "<div class='SettingNameCol'>" // DIV A A F A A
	dat += "Damage Screen Shake"
	dat += "</div>" // End of DIV A A F A A
	var/showtext6 = "Only when down"
	if(damagescreenshake == 1)
		showtext6 = "On"
	else if(damagescreenshake == 0)
		showtext6 = "Off"
	dat += PrefLink(showtext6, PREFCMD_DAMAGESCREENSHAKE_TOGGLE)
	dat += "</div>" // End of DIV A A F A
	dat += "</div>" // End of DIV A A F
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesUI()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// UI Style
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "UI Style"
	dat += "</div>" // End of DIV A A A A A
	dat += PrefLink("[UI_style]", PREFCMD_UI_STYLE)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// tgui Monitors
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "tgui Monitors"
	dat += "</div>" // End of DIV A A B A A
	var/showtext1 = "All"
	if(tgui_lock)
		showtext1 = "Primary"
	dat += PrefLink(showtext1, PREFCMD_TGUI_LOCK)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// tgui Style
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "tgui Style"
	dat += "</div>" // End of DIV A A C A A
	var/showtext2 = "No Frills"
	if(tgui_fancy)
		showtext2 = "Fancy"
	dat += PrefLink(showtext2, PREFCMD_TGUI_FANCY)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Input Mode Hotkey
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Input Mode Hotkey"
	dat += "</div>" // End of DIV A A D A A
	dat += PrefLink("[input_mode_hotkey]", PREFCMD_INPUT_MODE_HOTKEY)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	// Action Buttons
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "Action Buttons"
	dat += "</div>" // End of DIV A A E A A
	var/showtext3 = "Unlocked"
	if(buttons_locked)
		showtext3 = "Locked In Place"
	dat += PrefLink(showtext3, PREFCMD_ACTION_BUTTONS)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	// Window Flashing
	dat += "<div class='PartsFlex'>" // DIV A A F
	dat += "<div class='SettingFlexCol'>" // DIV A A F A
	dat += "<div class='SettingNameCol'>" // DIV A A F A A
	dat += "Window Flashing"
	dat += "</div>" // End of DIV A A F A A
	var/showtext4 = "Disabled"
	if(windowflashing)
		showtext4 = "Enabled"
	dat += PrefLink(showtext4, PREFCMD_WINFLASH)
	dat += "</div>" // End of DIV A A F A
	dat += "</div>" // End of DIV A A F
	// Ambient Occlusion
	dat += "<div class='PartsFlex'>" // DIV A A G
	dat += "<div class='SettingFlexCol'>" // DIV A A G A
	dat += "<div class='SettingNameCol'>" // DIV A A G A A
	dat += "Ambient Occlusion"
	dat += "</div>" // End of DIV A A G A A
	var/showtext5 = "Disabled"
	if(ambientocclusion)
		showtext5 = "Enabled"
	dat += PrefLink(showtext5, PREFCMD_AMBIENTOCCLUSION)
	dat += "</div>" // End of DIV A A G A
	dat += "</div>" // End of DIV A A G
	// Fit Viewport
	dat += "<div class='PartsFlex'>" // DIV A A H
	dat += "<div class='SettingFlexCol'>" // DIV A A H A
	dat += "<div class='SettingNameCol'>" // DIV A A H A A
	dat += "Fit Viewport"
	dat += "</div>" // End of DIV A A H A A
	var/showtext6 = "Manual"
	if(auto_fit_viewport)
		showtext6 = "Auto"
	dat += PrefLink(showtext6, PREFCMD_AUTO_FIT_VIEWPORT)
	dat += "</div>" // End of DIV A A H A
	dat += "</div>" // End of DIV A A H
	// HUD Button Flashes
	dat += "<div class='PartsFlex'>" // DIV A A I
	dat += "<div class='SettingFlexCol'>" // DIV A A I A
	dat += "<div class='SettingNameCol'>" // DIV A A I A A
	dat += "HUD Button Flashes"
	dat += "</div>" // End of DIV A A I A A
	var/showtext7 = "Disabled"
	if(hud_toggle_flash)
		showtext7 = "Enabled"
	dat += PrefLink(showtext7, PREFCMD_HUD_TOGGLE_FLASH)
	dat += "</div>" // End of DIV A A I A
	dat += "</div>" // End of DIV A A I
	// HUD Button Flash Color
	dat += "<div class='PartsFlex'>" // DIV A A J
	dat += "<div class='SettingFlexCol'>" // DIV A A J A
	dat += "<div class='SettingNameCol'>" // DIV A A J A A
	dat += "HUD Button Flash Color"
	dat += "</div>" // End of DIV A A J A A
	dat += "<div class='SettingValueSplit'>" // DIV A A J A B
	dat += ColorBox("hud_toggle_color")
	dat += "</div>" // End of DIV A A J A B
	dat += "</div>" // End of DIV A A J A
	dat += "</div>" // End of DIV A A J
	// FPS
	dat += "<div class='PartsFlex'>" // DIV A A K
	dat += "<div class='SettingFlexCol'>" // DIV A A K A
	dat += "<div class='SettingNameCol'>" // DIV A A K A A
	dat += "FPS"
	dat += "</div>" // End of DIV A A K A A
	dat += PrefLink("[clientfps]", PREFCMD_CLIENTFPS)
	dat += "</div>" // End of DIV A A K A
	dat += "</div>" // End of DIV A A K
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesChat()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// See Pull Requests
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "See Pull Requests"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled"
	if(chat_toggles & CHAT_PULLR)
		showtext1 = "Enabled"
	dat += PrefLink(showtext1, PREFCMD_PULL_REQUESTS)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Show Health Smileys
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Show Health Smileys"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "Disabled"
	if(show_health_smilies)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_HEALTH_SMILEYS)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Max PFP Examine Image Height
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Max PFP Examine Image Height"
	dat += "</div>" // End of DIV A A C A A
	dat += PrefLink("[see_pfp_max_hight]px", PREFCMD_MAX_PFP_HEIGHT)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Max PFP Examine Image Width
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Max PFP Examine Image Width"
	dat += "</div>" // End of DIV A A D A A
	dat += PrefLink("[see_pfp_max_widht]%", PREFCMD_MAX_PFP_WIDTH)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	// Auto OOC
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "Auto OOC"
	dat += "</div>" // End of DIV A A E A A
	var/showtext3 = "Disabled"
	if(auto_ooc)
		showtext3 = "Enabled"
	dat += PrefLink(showtext3, PREFCMD_AUTO_OOC)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	// Income Updates
	dat += "<div class='PartsFlex'>" // DIV A A F
	dat += "<div class='SettingFlexCol'>" // DIV A A F A
	dat += "<div class='SettingNameCol'>" // DIV A A F A A
	dat += "Income Updates"
	dat += "</div>" // End of DIV A A F A A
	var/showtext4 = "Muted"
	if(chat_toggles & CHAT_BANKCARD)
		showtext4 = "Allowed"
	dat += PrefLink(showtext4, PREFCMD_INCOME_UPDATES)
	dat += "</div>" // End of DIV A A F A
	dat += "</div>" // End of DIV A A F
	// Hear Radio Static
	dat += "<div class='PartsFlex'>" // DIV A A G
	dat += "<div class='SettingFlexCol'>" // DIV A A G A
	dat += "<div class='SettingNameCol'>" // DIV A A G A A
	dat += "Hear Radio Static"
	dat += "</div>" // End of DIV A A G A A
	var/showtext5 = "Muted"
	if(chat_toggles & CHAT_HEAR_RADIOSTATIC)
		showtext5 = "Allowed"
	dat += PrefLink(showtext5, PREFCMD_RADIO_STATIC)
	dat += "</div>" // End of DIV A A G A
	dat += "</div>" // End of DIV A A G
	// Hear Radio Blurbles
	dat += "<div class='PartsFlex'>" // DIV A A H
	dat += "<div class='SettingFlexCol'>" // DIV A A H A
	dat += "<div class='SettingNameCol'>" // DIV A A H A A
	dat += "Hear Radio Blurbles"
	dat += "</div>" // End of DIV A A H A A
	var/showtext6 = "Muted"
	if(chat_toggles & CHAT_HEAR_RADIOBLURBLES)
		showtext6 = "Allowed"
	dat += PrefLink(showtext6, PREFCMD_RADIO_BLURBLES)
	dat += "</div>" // End of DIV A A H A
	dat += "</div>" // End of DIV A A H
	// BYOND Membership Publicity
	if(usr.client)
		if(unlock_content)
			dat += "<div class='PartsFlex'>" // DIV A A I
			dat += "<div class='SettingFlexCol'>" // DIV A A I A
			dat += "<div class='SettingNameCol'>" // DIV A A I A A
			dat += "BYOND Membership Publicity"
			dat += "</div>" // End of DIV A A I A A
			var/showtext7 = "Hidden"
			if(toggles & MEMBER_PUBLIC)
				showtext7 = "Public"
			dat += PrefLink(showtext7, PREFCMD_BYOND_PUBLICITY)
			dat += "</div>" // End of DIV A A I A
			dat += "</div>" // End of DIV A A I
		if(unlock_content || check_rights(R_ADMIN))
			// OOC Color
			dat += "<div class='PartsFlex'>" // DIV A A J
			dat += "<div class='SettingFlexCol'>" // DIV A A J A
			dat += "<div class='SettingNameCol'>" // DIV A A J A A
			dat += "OOC Color"
			dat += "</div>" // End of DIV A A J A A
			dat += "<div class='SettingValueSplit'>" // DIV A A J A B
			dat += ColorBox("ooccolor")
			dat += "</div>" // End of DIV A A J A B
			dat += "</div>" // End of DIV A A J A
			dat += "</div>" // End of DIV A A J
			// Antag OOC Color
			// div += "<div class='PartsFlex'>" // DIV A A K
			// div += "<div class='SettingFlexCol'>" // DIV A A K A
			// div += "<div class='SettingNameCol'>" // DIV A A K A A
			// div += "Antag OOC Color"
			// div += "</div>" // End of DIV A A K A A
			// div += "<div class='SettingValueSplit'>" // DIV A A K A B
			// div += ColorBox("aooccolor")
			// div += "</div>" // End of DIV A A K A B
			// div += "</div>" // End of DIV A A K A
			// div += "</div>" // End of DIV A A K
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesRunechat()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Show Runechat Chat Bubbles
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Show Runechat Chat Bubbles"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled"
	if(chat_on_map)
		showtext1 = "Enabled"
	dat += PrefLink(showtext1, PREFCMD_CHAT_ON_MAP)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Runechat message char limit
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Runechat message char limit"
	dat += "</div>" // End of DIV A A B A A
	dat += PrefLink("[max_chat_length]", PREFCMD_MAX_CHAT_LENGTH)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Runechat message width
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Runechat message width"
	dat += "</div>" // End of DIV A A C A A
	dat += PrefLink("[chat_width]", PREFCMD_CHAT_WIDTH)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Runechat off-screen
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Runechat off-screen"
	dat += "</div>" // End of DIV A A D A A
	var/showtext2 = "Disabled"
	if(see_fancy_offscreen_runechat)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_OFFSCREEN)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	// See Runechat for non-mobs
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "See Runechat for non-mobs"
	dat += "</div>" // End of DIV A A E A A
	var/showtext3 = "Disabled"
	if(see_chat_non_mob)
		showtext3 = "Enabled"
	dat += PrefLink(showtext3, PREFCMD_SEE_CHAT_NON_MOB)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	// See Runechat emotes
	dat += "<div class='PartsFlex'>" // DIV A A F
	dat += "<div class='SettingFlexCol'>" // DIV A A F A
	dat += "<div class='SettingNameCol'>" // DIV A A F A A
	dat += "See Runechat emotes"
	dat += "</div>" // End of DIV A A F A A
	var/showtext4 = "Disabled"
	if(see_rc_emotes)
		showtext4 = "Enabled"
	dat += PrefLink(showtext4, PREFCMD_SEE_RC_EMOTES)
	dat += "</div>" // End of DIV A A F A
	dat += "</div>" // End of DIV A A F
	// Use Runechat color in chat log
	dat += "<div class='PartsFlex'>" // DIV A A G
	dat += "<div class='SettingFlexCol'>" // DIV A A G A
	dat += "<div class='SettingNameCol'>" // DIV A A G A A
	dat += "Use Runechat color in chat log"
	dat += "</div>" // End of DIV A A G A A
	var/showtext5 = "Disabled"
	if(color_chat_log)
		showtext5 = "Enabled"
	dat += PrefLink(showtext5, PREFCMD_COLOR_CHAT_LOG)
	dat += "</div>" // End of DIV A A G A
	dat += "</div>" // End of DIV A A G
	// See Runechat / hear sounds above/below you
	// dat += "<div class='PartsFlex'>" // DIV A A H
	// dat += "<div class='SettingFlexCol'>" // DIV A A H A
	// dat += "<div class='SettingNameCol'>" // DIV A A H A A
	// dat += "See Runechat / hear sounds above/below you"
	// dat += "</div>" // End of DIV A A H A A
	// dat += PrefLink("[upperlowerfloor]", PREFCMD_UPPERLOWERFLOOR)
	// dat += "</div>" // End of DIV A A H A
	// dat += "</div>" // End of DIV A A H
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesGhost()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Ghost Ears
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Ghost Ears"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTEARS)
		showtext1 = "All Speech"
	dat += PrefLink(showtext1, PREFCMD_GHOST_EARS)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Ghost Radio
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Ghost Radio"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "No Messages"
	if(chat_toggles & CHAT_GHOSTRADIO)
		showtext2 = "All Messages"
	dat += PrefLink(showtext2, PREFCMD_GHOST_RADIO)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Ghost Sight
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Ghost Sight"
	dat += "</div>" // End of DIV A A C A A
	var/showtext3 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTSIGHT)
		showtext3 = "All Emotes"
	dat += PrefLink(showtext3, PREFCMD_GHOST_SIGHT)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Ghost Whispers
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Ghost Whispers"
	dat += "</div>" // End of DIV A A D A A
	var/showtext4 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTWHISPER)
		showtext4 = "All Speech"
	dat += PrefLink(showtext4, PREFCMD_GHOST_WHISPERS)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	// Ghost PDA
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "Ghost PDA"
	dat += "</div>" // End of DIV A A E A A
	var/showtext500 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTPDA)
		showtext500 = "All Messages"
	dat += PrefLink(showtext500, PREFCMD_GHOST_PDA)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	if(unlock_content || check_rights(R_ADMIN))
		// Ghost Form
		dat += "<div class='PartsFlex'>" // DIV A A F
		dat += "<div class='SettingFlexCol'>" // DIV A A F A
		dat += "<div class='SettingNameCol'>" // DIV A A F A A
		dat += "Ghost Form"
		dat += "</div>" // End of DIV A A F A A
		dat += PrefLink("[ghost_form]", PREFCMD_GHOST_FORM)
		dat += "</div>" // End of DIV A A F A
		dat += "</div>" // End of DIV A A F
		// Ghost Orbit
		dat += "<div class='PartsFlex'>" // DIV A A G
		dat += "<div class='SettingFlexCol'>" // DIV A A G A
		dat += "<div class='SettingNameCol'>" // DIV A A G A A
		dat += "Ghost Orbit"
		dat += "</div>" // End of DIV A A G A A
		dat += PrefLink("[ghost_orbit]", PREFCMD_GHOST_ORBIT)
		dat += "</div>" // End of DIV A A G A
		dat += "</div>" // End of DIV A A G
	var/showtext5 = "If you see this something went wrong."
	switch(ghost_accs)
		if(GHOST_ACCS_FULL)
			showtext5 = GHOST_ACCS_FULL_NAME
		if(GHOST_ACCS_DIR)
			showtext5 = GHOST_ACCS_DIR_NAME
		if(GHOST_ACCS_NONE)
			showtext5 = GHOST_ACCS_NONE_NAME
	// Ghost Accessories
	dat += "<div class='PartsFlex'>" // DIV A A H
	dat += "<div class='SettingFlexCol'>" // DIV A A H A
	dat += "<div class='SettingNameCol'>" // DIV A A H A A
	dat += "Ghost Accessories"
	dat += "</div>" // End of DIV A A H A A
	dat += PrefLink(showtext5, PREFCMD_GHOST_ACCS)
	dat += "</div>" // End of DIV A A H A
	dat += "</div>" // End of DIV A A H
	var/showtext6 = "If you see this something went wrong."
	switch(ghost_others)
		if(GHOST_OTHERS_THEIR_SETTING)
			showtext6 = GHOST_OTHERS_THEIR_SETTING_NAME
		if(GHOST_OTHERS_DEFAULT_SPRITE)
			showtext6 = GHOST_OTHERS_DEFAULT_SPRITE_NAME
		if(GHOST_OTHERS_SIMPLE)
			showtext6 = GHOST_OTHERS_SIMPLE_NAME
	// Ghosts of Others
	dat += "<div class='PartsFlex'>" // DIV A A I
	dat += "<div class='SettingFlexCol'>" // DIV A A I A
	dat += "<div class='SettingNameCol'>" // DIV A A I A A
	dat += "Ghosts of Others"
	dat += "</div>" // End of DIV A A I A A
	dat += PrefLink(showtext6, PREFCMD_GHOST_OTHERS)
	dat += "</div>" // End of DIV A A I A
	dat += "</div>" // End of DIV A A I
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesAudio()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Play Hunting Horn Sounds
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Play Hunting Horn Sounds"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled"
	if(toggles & SOUND_HUNTINGHORN)
		showtext1 = "Enabled"
	dat += PrefLink(showtext1, PREFCMD_HUNTINGHORN)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Sprint Depletion Sound
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Sprint Depletion Sound"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "Disabled"
	if(toggles & SOUND_SPRINTBUFFER)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_SPRINTBUFFER)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Play Admin MIDIs
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Play Admin MIDIs"
	dat += "</div>" // End of DIV A A C A A
	var/showtext3 = "Disabled"
	if(toggles & SOUND_MIDI)
		showtext3 = "Enabled"
	dat += PrefLink(showtext3, PREFCMD_MIDIS)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A
	// Play Lobby Music
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Play Lobby Music"
	dat += "</div>" // End of DIV A A D A A
	var/showtext4 = "Disabled"
	if(toggles & SOUND_LOBBY)
		showtext4 = "Enabled"
	dat += PrefLink(showtext4, PREFCMD_LOBBY_MUSIC)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesAdmin()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Adminhelp Sounds
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Adminhelp Sounds"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled"
	if(toggles & SOUND_ADMINHELP)
		showtext1 = "Enabled"
	dat += PrefLink(showtext1, PREFCMD_ADMINHELP)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Announce Login
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Announce Login"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "Disabled"
	if(toggles & ANNOUNCE_LOGIN)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_ANNOUNCE_LOGIN)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Combo HUD Lighting
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Combo HUD Lighting"
	dat += "</div>" // End of DIV A A C A A
	var/showtext3 = "No Change"
	if(toggles & COMBOHUD_LIGHTING)
		showtext3 = "Full-bright"
	dat += PrefLink(showtext3, PREFCMD_COMBOHUD_LIGHTING)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A C
	// Split Admin Tabs
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Split Admin Tabs"
	dat += "</div>" // End of DIV A A D A A
	var/showtext4 = "Disabled"
	if(toggles & SPLIT_ADMIN_TABS)
		showtext4 = "Enabled"
	dat += PrefLink(showtext4, PREFCMD_SPLIT_ADMIN_TABS)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A D
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GamePreferencesContent()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='PartsContainer'>" // DIV A A
	// Arousal
	dat += "<div class='PartsFlex'>" // DIV A A A
	dat += "<div class='SettingFlexCol'>" // DIV A A A A
	dat += "<div class='SettingNameCol'>" // DIV A A A A A
	dat += "Arousal"
	dat += "</div>" // End of DIV A A A A A
	var/showtext1 = "Disabled"
	if(arousable)
		showtext1 = "Enabled"
	dat += PrefLink(showtext1, PREFCMD_AROUSABLE)
	dat += "</div>" // End of DIV A A A A
	dat += "</div>" // End of DIV A A A
	// Genital examine text
	dat += "<div class='PartsFlex'>" // DIV A A B
	dat += "<div class='SettingFlexCol'>" // DIV A A B A
	dat += "<div class='SettingNameCol'>" // DIV A A B A A
	dat += "Genital examine text"
	dat += "</div>" // End of DIV A A B A A
	var/showtext2 = "Disabled"
	if(cit_toggles & GENITAL_EXAMINE)
		showtext2 = "Enabled"
	dat += PrefLink(showtext2, PREFCMD_GENITAL_EXAMINE)
	dat += "</div>" // End of DIV A A B A
	dat += "</div>" // End of DIV A A B
	// Butt Slapping
	dat += "<div class='PartsFlex'>" // DIV A A C
	dat += "<div class='SettingFlexCol'>" // DIV A A C A
	dat += "<div class='SettingNameCol'>" // DIV A A C A A
	dat += "Butt Slapping"
	dat += "</div>" // End of DIV A A C A A
	var/showtext3 = "Allowed"
	if(cit_toggles & NO_BUTT_SLAP)
		showtext3 = "Disallowed"
	dat += PrefLink(showtext3, PREFCMD_BUTT_SLAP)
	dat += "</div>" // End of DIV A A C A
	dat += "</div>" // End of DIV A A
	// Auto Wag
	dat += "<div class='PartsFlex'>" // DIV A A D
	dat += "<div class='SettingFlexCol'>" // DIV A A D A
	dat += "<div class='SettingNameCol'>" // DIV A A D A A
	dat += "Auto Wag"
	dat += "</div>" // End of DIV A A D A A
	var/showtext4 = "Enabled"
	if(cit_toggles & NO_AUTO_WAG)
		showtext4 = "Disabled"
	dat += PrefLink(showtext4, PREFCMD_AUTO_WAG)
	dat += "</div>" // End of DIV A A D A
	dat += "</div>" // End of DIV A A
	// Master Vore Toggle
	dat += "<div class='PartsFlex'>" // DIV A A E
	dat += "<div class='SettingFlexCol'>" // DIV A A E A
	dat += "<div class='SettingNameCol'>" // DIV A A E A A
	dat += "Master Vore Toggle"
	dat += "</div>" // End of DIV A A E A A
	var/showtext5 = "All Disabled"
	if(master_vore_toggle)
		showtext5 = "Per Preferences"
	dat += PrefLink(showtext5, PREFCMD_MASTER_VORE_TOGGLE)
	dat += "</div>" // End of DIV A A E A
	dat += "</div>" // End of DIV A A E
	// Being Prey
	dat += "<div class='PartsFlex'>" // DIV A A F
	dat += "<div class='SettingFlexCol'>" // DIV A A F A
	dat += "<div class='SettingNameCol'>" // DIV A A F A A
	dat += "Being Prey"
	dat += "</div>" // End of DIV A A F A A
	var/showtext6 = "Disallowed"
	if(allow_being_prey)
		showtext6 = "Allowed"
	dat += PrefLink(showtext6, PREFCMD_ALLOW_BEING_PREY)
	dat += "</div>" // End of DIV A A F A
	dat += "</div>" // End of DIV A A F
	// Being Fed Prey
	dat += "<div class='PartsFlex'>" // DIV A A G
	dat += "<div class='SettingFlexCol'>" // DIV A A G A
	dat += "<div class='SettingNameCol'>" // DIV A A G A A
	dat += "Being Fed Prey"
	dat += "</div>" // End of DIV A A G A A
	var/showtext7 = "Disallowed"
	if(allow_being_fed_prey)
		showtext7 = "Allowed"
	dat += PrefLink(showtext7, PREFCMD_ALLOW_BEING_FED_PREY)
	dat += "</div>" // End of DIV A A G A
	dat += "</div>" // End of DIV A A G
	// Digestion Damage
	dat += "<div class='PartsFlex'>" // DIV A A H
	dat += "<div class='SettingFlexCol'>" // DIV A A H A
	dat += "<div class='SettingNameCol'>" // DIV A A H A A
	dat += "Digestion Damage"
	dat += "</div>" // End of DIV A A H A A
	var/showtext8 = "Disallowed"
	if(allow_digestion_damage)
		showtext8 = "Allowed"
	dat += PrefLink(showtext8, PREFCMD_ALLOW_DIGESTION_DAMAGE)
	dat += "</div>" // End of DIV A A H A
	dat += "</div>" // End of DIV A A H
	// Digestion Death
	dat += "<div class='PartsFlex'>" // DIV A A I
	dat += "<div class='SettingFlexCol'>" // DIV A A I A
	dat += "<div class='SettingNameCol'>" // DIV A A I A A
	dat += "Digestion Death"
	dat += "</div>" // End of DIV A A I A A
	var/showtext9 = "Disallowed"
	if(allow_digestion_death)
		showtext9 = "Allowed"
	dat += PrefLink(showtext9, PREFCMD_ALLOW_DIGESTION_DEATH)
	dat += "</div>" // End of DIV A A I A
	dat += "</div>" // End of DIV A A I
	// Vore Messages
	dat += "<div class='PartsFlex'>" // DIV A A J
	dat += "<div class='SettingFlexCol'>" // DIV A A J A
	dat += "<div class='SettingNameCol'>" // DIV A A J A A
	dat += "Vore Messages"
	dat += "</div>" // End of DIV A A J A A
	var/showtext10 = "Hidden"
	if(allow_vore_messages)
		showtext10 = "Visible"
	dat += PrefLink(showtext10, PREFCMD_ALLOW_VORE_MESSAGES)
	dat += "</div>" // End of DIV A A J A
	dat += "</div>" // End of DIV A A J
	// Vore Trash Messages
	dat += "<div class='PartsFlex'>" // DIV A A K
	dat += "<div class='SettingFlexCol'>" // DIV A A K A
	dat += "<div class='SettingNameCol'>" // DIV A A K A A
	dat += "Vore Trash Messages"
	dat += "</div>" // End of DIV A A K A A
	var/showtext11 = "Hidden"
	if(allow_trash_messages)
		showtext11 = "Visible"
	dat += PrefLink(showtext11, PREFCMD_ALLOW_TRASH_MESSAGES)
	dat += "</div>" // End of DIV A A K A
	dat += "</div>" // End of DIV A A K
	// Vore Death Messages
	dat += "<div class='PartsFlex'>" // DIV A A L
	dat += "<div class='SettingFlexCol'>" // DIV A A L A
	dat += "<div class='SettingNameCol'>" // DIV A A L A A
	dat += "Vore Death Messages"
	dat += "</div>" // End of DIV A A L A A
	var/showtext12 = "Hidden"
	if(allow_death_messages)
		showtext12 = "Visible"
	dat += PrefLink(showtext12, PREFCMD_ALLOW_DEATH_MESSAGES)
	dat += "</div>" // End of DIV A A L A
	dat += "</div>" // End of DIV A A L
	// Vore Eating Sounds
	dat += "<div class='PartsFlex'>" // DIV A A M
	dat += "<div class='SettingFlexCol'>" // DIV A A M A
	dat += "<div class='SettingNameCol'>" // DIV A A M A A
	dat += "Vore Eating Sounds"
	dat += "</div>" // End of DIV A A M A A
	var/showtext13 = "Muted"
	if(allow_eating_sounds)
		showtext13 = "Audible"
	dat += PrefLink(showtext13, PREFCMD_ALLOW_EATING_SOUNDS)
	dat += "</div>" // End of DIV A A M A
	dat += "</div>" // End of DIV A A M
	// Digestion Sounds
	dat += "<div class='PartsFlex'>" // DIV A A N
	dat += "<div class='SettingFlexCol'>" // DIV A A N A
	dat += "<div class='SettingNameCol'>" // DIV A A N A A
	dat += "</div>" // End of DIV A A N A
	dat += "</div>" // End of DIV A A N
	dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/Keybindings()
	var/list/dat = list()
	dat += "<div class='SettingArray'>" // DIV A
	dat += "<div class='SettingFlexCol'>" // DIV A A
	dat += "<div class='SettingValueSplit'>" // DIV A A A
	dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A A A
	dat += "Keymode:"
	dat += "</div>" // End of DIV A A A A
	var/showtext1 = "Input"
	if(hotkeys)
		showtext1 = "Hotkeys"
	dat += PrefLink(showtext1, PREFCMD_HOTKEYS)
	dat += "<span class='Spacer'></span>"
	var/showtext2 = "What's hotkeys / input mean?"
	if(keybind_hotkey_helpmode)
		showtext2 = "Oh cool, thanks! (Hide help)"
	dat += PrefLink(showtext2, PREFCMD_HOTKEY_HELP)
	dat += "</div>" // End of DIV A A A
	dat += "</div>" // End of DIV A A
	if(keybind_hotkey_helpmode)
		dat += "<div class='SettingFlexColInfo NotCol'>" // DIV A B
		dat += "<p>Keybindings mode controls how the game behaves with tab and map/input focus."
		dat += "<p>If it is on <b>Hotkeys</b>, the game will always attempt to force you to map focus, meaning keypresses are sent directly to the map instead of the input. You will still be able to use the command bar, but you need to tab to do it every time you click on the game map."
		dat += "<p>If it is on <b>Input</b>, the game will not force focus away from the input bar, and you can switch focus using TAB between these two modes: If the input bar is pink, that means that you are in non-hotkey mode, sending all keypresses of the normal alphanumeric characters, punctuation, spacebar, backspace, enter, etc, typing keys into the input bar. If the input bar is white, you are in hotkey mode, meaning all keypresses go into the game's keybind handling system unless you manually click on the input bar to shift focus there."
		dat += "<p>Input mode is the closest thing to the old input system."
		dat += "<p><b>IMPORTANT:</b> While in input mode's non hotkey setting (tab toggled), Ctrl + KEY will send KEY to the keybind system as the key itself, not as Ctrl + KEY. This means Ctrl + T/W/A/S/D/all your familiar stuff still works, but you won't be able to access any regular Ctrl binds."
		dat += "<p><b>Modifier-Independent binding</b> - This is a singular bind that works regardless of if Ctrl/Shift/Alt are held down. For example, if combat mode is bound to C in modifier-independent binds, it'll trigger regardless of if you are holding down shift for sprint. <b>Each keybind can only have one independent binding, and each key can only have one keybind independently bound to it."
		dat += "</div>" // End of DIV A B
	// keybinds!
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	var/list/user_modless_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)
	for (var/key in modless_key_bindings)
		user_modless_binds[modless_key_bindings[key]] = key
	var/list/kb_categories = list()
	// Group keybinds by category
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		kb_categories[kb.category] += list(kb)
	for (var/category in kb_categories)
		dat += "<div class='SettingArray'>" // DIV A A
		dat += "<div class='SettingValueSplit'>" // DIV A A A
		var/arrowshow = ">"
		if(keybind_cat_open[category])
			arrowshow = "v"
		dat += PrefLink(arrowshow, PREFCMD_KEYBINDING_CATEGORY_TOGGLE, list(PREFDAT_CATEGORY = category))
		dat += "<div class='SettingNameCol Spacer'>" // DIV A A A A
		dat += category
		dat += "</div>" // End of DIV A A A A
		dat += "</div>" // End of DIV A A A
		dat += "</div>" // End of DIV A A
		if(!keybind_cat_open[category])
			continue // Skip if the category is closed
		for (var/i in kb_categories[category])
			var/datum/keybinding/kb = i
			var/current_independent_binding = "Unbound"
			if(user_modless_binds[kb.name])
				current_independent_binding = user_modless_binds[kb.name]
			var/list/binds_for_entry = list()
			for(var/j in 1 to MAX_KEYS_PER_KEYBIND)
				binds_for_entry += "None!"
			if(LAZYLEN(user_binds[kb.name])) // they have something set...?
				for(var/bound_key_index in 1 to length(user_binds[kb.name]))
					binds_for_entry[bound_key_index] = user_binds[kb.name][bound_key_index]
			var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
			var/defkeys = "None!"
			if(LAZYLEN(default_keys))
				defkeys = default_keys.Join(", ")
			dat += "<div class='SettingFlexCol'>" // DIV A A
			dat += "<div class='SettingValueSplit'>" // DIV A A A
			dat += "<div class='SettingNameCol ForceBuffer'>" // DIV A A A A
			dat += kb.full_name
			dat += "</div>" // End of DIV A A A A
			var/indx = 1
			for(var/bind in binds_for_entry)
				var/keydata = list(
					PREFDAT_KEYBINDING = kb.name,
					PREFDAT_OLD_KEY = bind
				)
				var/keyclass = "KeyButton Key[indx]Text"
				dat += PrefLink("[bind]", PREFCMD_KEYBINDING_CAPTURE, keydata, span = keyclass)
				indx++
			dat += "<div class='KeyBox DefaultKeyText'>" // DIV A A A A
			dat += defkeys
			dat += "</div>" // End of DIV A A A A
			/// then the special independent binding
			if(!kb.special && !kb.clientside)
				dat += "<div class='KeyBox DefaultKeyText'>" // DIV A A A A
				dat += "Independent Binding: "
				var/keydata = list(
					PREFDAT_KEYBINDING = kb.name,
					PREFDAT_OLD_KEY = current_independent_binding,
					PREFDAT_INDEPENDENT = 1
				)
				dat += PrefLink(current_independent_binding, PREFCMD_KEYBINDING_CAPTURE, keydata, span = "KeyButton Key[indx]Text")
				dat += "</div>" // End of DIV A A A A
			dat += "</div>" // End of DIV A A A
			dat += "</div>" // End of DIV A A
		dat += "</div>" // End of DIV A A
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GetGearFlatList(search, list/mystuff, mine)
	var/list/flatlyss = list()
	for(var/gitem in GLOB.flat_loadout_items)
		var/datum/gear/gear = GLOB.flat_loadout_items[gitem]
		if(gear)
			if(mine)
				if(!mystuff["[gear.type]"])
					continue
			if(search)
				if(!findtext(gitem, search))
					continue
			flatlyss += gear
	return flatlyss

/datum/preferences/proc/GearColorBox(datum/gear/gear, edited_color)
	var/list/datae = list(
		PREFDAT_COLKEY_IS_COLOR = TRUE,
		PREFDAT_IS_GEAR = TRUE,
		PREFDAT_GEAR_NAME = "[html_encode(gear.name)]",
		PREFDAT_GEAR_PATH = "[gear.type]",
		PREFDAT_LOADOUT_SLOT = "[loadout_slot]"
	)
	return ColorBox(edited_color, data = datae)

/datum/preferences/proc/RowifyQuirks()
	if(!LAZYLEN(char_quirks))
		return QuirkEntry("None!", "NEUTRAL")
	var/list/goodquirks = list()
	var/list/neutquirks = list()
	var/list/badquirks = list()
	for(var/quirk in char_quirks)
		var/datum/quirk/Q = SSquirks.GetQuirk(quirk)
		switch(Q.value)
			if(-INFINITY to -1)
				badquirks += Q
			if(1 to INFINITY)
				goodquirks += Q
			else
				neutquirks += Q
	var/list/dat = list()
	for(var/datum/quirk/Q in goodquirks)
		dat += QuirkEntry(Q.name, "GOOD")
	for(var/datum/quirk/Q in neutquirks)
		dat += QuirkEntry(Q.name, "NEUTRAL")
	for(var/datum/quirk/Q in badquirks)
		dat += QuirkEntry(Q.name, "BAD")
	return dat.Join()

/datum/preferences/proc/QuirkEntry(q_name, quality)
	var/list/dat = list()
	dat += "<div class='SettingValueRowable'>" // DIV A
	var/q_span = ""
	switch(quality)
		if("GOOD")
			q_span = "QuirkGood"
		if("BAD")
			q_span = "QuirkBad"
		else
			q_span = "QuirkNeutral"
	dat += "<span class='[q_span]'>[q_name]</span>"
	dat += "</div>" // End of DIV A
	return dat.Join()

/// Builds a cool toolbar for colorstuff
/// has two parts: a top and a bottom
/// the top has the Big Three mutant colors (and the undies button)
/// the bottom has a history of colors (up to, oh, 5?)
/datum/preferences/proc/ColorToolbar()
	var/list/dat = list()
	dat += "<div class='SettingFlexCol'>" // DIV A
	dat += "<div class='SettingValueSplit'>" // DIV A A
	var/list/data = list(PREFDAT_COLKEY_IS_FEATURE = TRUE)
	dat += ColorBox("mcolor", data = data)
	dat += ColorBox("mcolor2", data = data)
	dat += ColorBox("mcolor3", data = data)
	dat += "<span class='Spacer'></span>"
	var/chundies = preview_hide_undies ? "Hiding Undies" : "Showing Undies"
	dat += PrefLink("[chundies]", PREFDAT_TOGGLE_HIDE_UNDIES, span = "SettingName")
	dat += "</div>" // End of DIV A A
	/// History of colors
	dat += "<div class='SettingValueSplit'>" // DIV A B
	CleanupColorHistory()
	for(var/color in color_history)
		dat += ColorBox(color, TRUE)
	dat += "</div>" // End of DIV A B
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/ColorBox(colkey, history = FALSE, list/data = list())
	var/list/dat = list()
	data[PREFDAT_COLOR_KEY] = colkey
	dat += "<div class='ColorContainer'>" // DIV A
	var/col = "FFFFFF"
	if(history)
		col = colkey
		data[PREFDAT_COLOR_HEX] = col
		dat += "<div class='ColorBoxxo CrunchBox' style='background-color: #[col];'>"
		dat += "[colkey]"
		dat += "</div>" // End of DIV A A
	else
		if(data[PREFDAT_COLKEY_IS_COLOR])
			col = colkey
		else
			col = GetColor(colkey)
		data[PREFDAT_COLOR_HEX] = col
		dat += PrefLink("[col]", PREFCMD_COLOR_CHANGE, data, span = "ColorBoxxo", style = "background-color: #[col];")
	var/cbut = "<i class='fa fa-copy'></i>"
	var/pbut = "<i class='fa fa-paste'></i>"
	dat += PrefLink("[cbut]", PREFCMD_COLOR_COPY, data, span = "SmolBox")
	dat += PrefLink("[pbut]", PREFCMD_COLOR_PASTE, data, span = "SmolBox")
	if(history)
		dat += PrefLink("X", PREFCMD_COLOR_DEL, data, span = "SmolBox")
	dat += "</div>" // End of DIV A
	return dat.Join()

/datum/preferences/proc/GetColor(colkey)
	if(GLOB.features_that_are_colors[colkey])
		if(!is_color(features[colkey]))
			features[colkey] = "FFFFFF"
		return features[colkey]
	/// because we have some colors in the features and SOME colors as hardvars
	/// we need to suck this dikc
	if(colkey in vars)
		var/maybecolor = vars["[colkey]"]
		if(is_color(maybecolor))
			return maybecolor
	stack_trace("GetColor: Couldn't find color for [colkey]!")
	return "FFFFFF"

// pda_color
// undie_color
// shirt_color
// socks_color
// hair_color
// facial_hair_color
// left_eye_color
// right_eye_color
// personal_chat_color
// hud_toggle_color

/datum/preferences/proc/MarkingColorBox(list/marking = list(), col_index)
	var/truecolor = marking[MARKING_COLOR_LIST][col_index]
	var/marking_uid = marking[MARKING_UID]
	var/marking_slot = col_index
	var/list/data = list(
		PREFDAT_COLKEY_IS_COLOR = TRUE,
		PREFDAT_IS_MARKING = TRUE,
		PREFDAT_MARKING_UID = marking_uid,
		PREFDAT_MARKING_SLOT = marking_slot
	)
	return ColorBox(truecolor, data = data)

/datum/preferences/proc/MarkingPrefLink(text, cmd, marking_uid, span)
	var/command = PREFCMD_MARKING_EDIT
	var/list/data = list(PREFDAT_MARKING_UID = marking_uid)
	data[PREFDAT_MARKING_ACTION] = cmd
	return PrefLink(text, command, data, span = span)

/datum/preferences/proc/CoolDivider()
	return "<div class='WideDivider'></div>"



