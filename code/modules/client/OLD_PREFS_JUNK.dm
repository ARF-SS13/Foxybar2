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


 * /


