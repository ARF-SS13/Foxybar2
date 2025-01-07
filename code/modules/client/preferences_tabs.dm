/* 
 * File:   preferences_tabs.dm
 * Author: Kelly
 * Date: 2021-07-07
 * License: WWW.PLAYAPOCALYPSE.COM
 * 
 * TGUI preferences is a pipe dream.
 * 
 * This file holds more accessible preferences for the player.
 * Part of the Great Preferences Cleanup of 2021. (its actually 2024)
 * 
 *  */

/* 
 * This proc takes in its args and outputs a link that'll be printed in the preferences window.
 * cus ew, href spam
 * @param showtext The text that will be displayed in the link
 * @param pref The preference action (basically always TRUE)
 * @param list/data A list of key-value pairs that will be added to the URL
 * @param kind Used to tell the game what kind of sound to play when the link is clicked
 * @param span Extra spans used for styling on your foes
 */
/datum/preferences/proc/PrefLink(showtext, pref, list/data = list(), kind, span, style)
	var/argos = "?_src_=prefs;preference=[pref];"
	if(kind)
		argos += "p_kind=[kind];"
	for(var/key in data)
		argos += "[key]=[data[key]];"
	var/stylepro = ""
	if(style)
		stylepro = "style='[style]'"
	if(span)
		return "<a href='[argos]' class='[span]' [stylepro]>[showtext]</a>"
	else
		return "<a href='[argos]' [stylepro]>[showtext]</a>"

/datum/preferences/proc/ShowChoices(mob/user)
	if(!user || !user.client)
		return
	update_preview_icon(current_tab)
	ui_interact(user)
	return

/datum/preferences/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PreferencesMenu")
		ui.open()
		ui.set_autoupdate(FALSE)

/// packages the entire preferences menu into a handy massive list
/datum/preferences/ui_static_data(mob/user)
	var/list/data = list()
	var/savefile/S = new /savefile(path)
	if(!S)
		data["fatal_error"] = TRUE
		return data
	/// All the characters!
	var/list/charlist = list()
	var/numslots2show = min(max_save_slots, show_this_many)
	charlist.len = numslots2show
	for(var/i in 1 to min(max_save_slots, show_this_many))
		var/list/char = list()
		S.cd = "/character[i]"
		S["real_name"] >> name
		if(!name)
			name = "Character[i]"
		if(i == default_slot)
			char["is_selected"] = TRUE
		else
			char["is_selected"] = FALSE
		char["name"] = name
		char["command"] = PREFCMD_CHANGE_SLOT
		char["data"] = list(PREFDAT_SLOT = i)
		charlist[i] = char
	data["characters"] = charlist
	data["current_slot"] = default_slot
	data["copy_slot"] = copyslot
	data["copy_slot_name"] = copyname
	data["category_tabs_line1"] = list(
		PPT_CHARCTER_PROPERTIES,
		PPT_CHARCTER_APPEARANCE,
		PPT_LOADOUT,
	)
	data["category_tabs_line2"] = list(
		PPT_GAME_PREFERENCES,
		PPT_KEYBINDINGS,
	)
	data["subcategory_tabs"] = list()
	switch(current_tab)
		if(PPT_CHARCTER_PROPERTIES)
			GetCharacterPropertiesData(data)
		if(PPT_CHARCTER_APPEARANCE)
			GetCharacterAppearanceData(data)
		if(PPT_LOADOUT)
			GetLoadoutData(data)
		if(PPT_GAME_PREFERENCES)
			GetGamePreferencesData(data)
			data["subcategory_tabs"] = list(
				PPT_GAME_PREFERENCES_GENERAL,
				PPT_GAME_PREFERENCES_UI,
				PPT_GAME_PREFERENCES_CHAT,
				PPT_GAME_PREFERENCES_RUNECHAT,
				PPT_GAME_PREFERENCES_GHOST,
				PPT_GAME_PREFERENCES_AUDIO,
				PPT_GAME_PREFERENCES_ADMIN,
				PPT_GAME_PREFERENCES_CONTENT,
			)
		if(PPT_KEYBINDINGS)
			GetKeybindingsData(data)

	return data

// it does a little magic trick and modifies the data in-place
/datum/preferences/proc/GetCharacterPropertiesData(list/data = list())
	data["subcategory_tabs"] = list(
		PPT_CHARCTER_PROPERTIES_INFO,
		PPT_CHARCTER_PROPERTIES_VOICE,
		PPT_CHARCTER_PROPERTIES_MISC,
	)
	if(!(current_subtab in data["subcategory_tabs"]))
		current_subtab = PPT_CHARCTER_PROPERTIES_INFO
	switch(current_subtab)
		if(PPT_CHARCTER_PROPERTIES_INFO)
			GetCharacterInfoData(data)
		if(PPT_CHARCTER_PROPERTIES_VOICE)
			GetCharacterVoiceData(data)
		if(PPT_CHARCTER_PROPERTIES_MISC)
			GetCharacterMiscData(data)
	return data

/datum/preferences/proc/GetCharacterInfoData(list/data = list())
	data["name"] = real_name
	var/pfplink = SSchat.GetPicForMode(src, MODE_PROFILE_PIC)
	data["pfp_link"] = pfplink || "https://via.placeholder.com/150"
	data["age"] = age
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
	data["gender"] = genwords
	data["tbs"] = "[tbs]"
	data["kisser"] = "[kisser]"
	var/ftbutless = "[features["flavor_text"]]"
	if(ftbutless == initial(features["flavor_text"]))
		ftbutless = "Click to add flavor text!"
	if(LAZYLEN(ftbutless) > 100)
		ftbutless = "[copytext(ftbutless, 1, 100)]..."
	data["flavor_text"] = ftbutless
	var/oocbutless = "[features["ooc_notes"]]"
	if(oocbutless == initial(features["ooc_notes"]))
		oocbutless = "Click to add OOC notes!"
	if(LAZYLEN(oocbutless) > 100)
		oocbutless = "[copytext(oocbutless, 1, 100)]..."
	data["ooc_notes"] = oocbutless
	return data

/datum/preferences/proc/GetCharacterVoiceData(list/data = list())
	data["typing_indicator_sound"] = features["typing_indicator_sound"]
	data["typing_indicator_sound_play"] = features["typing_indicator_sound_play"]
	data["typing_indicator_variance"] = features["typing_indicator_variance"]
	data["typing_indicator_speed"] = features["typing_indicator_speed"]
	data["typing_indicator_volume"] = features["typing_indicator_volume"]
	data["typing_indicator_pitch"] = features["typing_indicator_pitch"]
	data["typing_indicator_max_words_spoken"] = features["typing_indicator_max_words_spoken"]
	data["runechat_color"] = features["runechat_color"]
	return data

/datum/preferences/proc/GetCharacterMiscData(list/data = list())
	data["quester_uid"] = quester_uid
	data["money_string"] = "[SSeconomy.format_currency(saved_unclaimed_points, TRUE)]"
	data["pda_skin"] = pda_skin
	data["pda_ringmessage"] = pda_ringmessage
	data["pda_color"] = pda_color
	data["backbag"] = backbag
	data["persistent_scars"] = !!persistent_scars
	data["quirks"] = RowifyQuirks()
	data["special_s"] = special_s
	data["special_p"] = special_p
	data["special_e"] = special_e
	data["special_c"] = special_c
	data["special_i"] = special_i
	data["special_a"] = special_a
	data["special_l"] = special_l
	var/tot = special_s + special_p + special_e + special_c + special_i + special_a + special_l
	data["special_totals"] = "[tot] / 40"
	return data

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
		dat += list(list(
			"name" = Q.name,
			"class" = "QuirkGood",
		))
	for(var/datum/quirk/Q in neutquirks)
		dat += list(list(
			"name" = Q.name,
			"class" = "QuirkNeutral",
		))
	for(var/datum/quirk/Q in badquirks)
		dat += list(list(
			"name" = Q.name,
			"class" = "QuirkBad",
		))
	return dat

/datum/preferences/proc/GetCharacterAppearanceData(list/data = list())
	data["subcategory_tabs"] = list(
		PPT_CHARCTER_APPEARANCE_MISC,
		PPT_CHARCTER_APPEARANCE_HAIR_EYES,
		PPT_CHARCTER_APPEARANCE_PARTS,
		PPT_CHARCTER_APPEARANCE_MARKINGS,
		PPT_CHARCTER_APPEARANCE_UNDERLYING,
	)
	switch(current_subtab)
		if(PPT_CHARCTER_APPEARANCE_MISC)
			GetCharacterMiscAppearanceData(data)
		if(PPT_CHARCTER_APPEARANCE_HAIR_EYES)
			GetCharacterHairEyesData(data)
		if(PPT_CHARCTER_APPEARANCE_PARTS)
			GetCharacterPartsData(data)
		if(PPT_CHARCTER_APPEARANCE_MARKINGS)
			GetCharacterMarkingsData(data)
		if(PPT_CHARCTER_APPEARANCE_UNDERLYING)
			GetCharacterUnderlyingData(data)
	return data

/datum/preferences/proc/GetCharacterMiscAppearanceData(list/data = list())
	data["species_name"] = pref_species.name
	data["species_custom_name"] = custom_species ? custom_species : pref_species.name
	var/bmod = "N/A"
	if(gender != NEUTER && pref_species.sexes) // oh yeah, my pref species sexes a lot
		data["show_body_model"] = TRUE
		features["body_model"] = gender == MALE ? "Masculine" : "Feminine"
	data["body_model"] = bmod
	if(LAZYLEN(pref_species.allowed_limb_ids))
		data["show_body_sprite"] = TRUE
		if(!chosen_limb_id || !(chosen_limb_id in pref_species.allowed_limb_ids))
			chosen_limb_id = pref_species.limbs_id || pref_species.id
	data["body_sprite"] = chosen_limb_id
	if(LAZYLEN(pref_species.alt_prefixes))
		data["show_alt_appearance"] = TRUE
	data["alt_appearance"] = alt_appearance ? "[alt_appearance]" : "Select"
	data["blood_color"] = features["blood_color"]
	data["blood_rainbow"] = features["blood_color"] == "Rainbow"
	data["meat_type"] = features["meat_type"]
	data["taste"] = features["taste"]
	data["body_scale"] = features["body_scale"]*100
	data["body_width"] = features["body_width"]*100
	var/fuzsharp = fuzzy ? "Fuzzy" : "Sharp"
	data["fuzzysharp"] = fuzsharp
	var/pye = features["pixel_y"] > 0 ? "+[features["pixel_y"]]" : "[features["pixel_y"]]"
	data["pixel_y"] = pye
	var/pxe = features["pixel_x"] > 0 ? "+[features["pixel_x"]]" : "[features["pixel_x"]]"
	data["pixel_x"] = pxe
	data["legs"] = features["legs"]
	if(pref_species.use_skintones) // humans suck
		data["show_skin_tone"] = TRUE
		if(use_custom_skin_tone)
			data["skin_tone"] = custom_skin_tone
		else
			data["skin_tone"] = skin_tone
	return data

/datum/preferences/proc/GetCharacterHairEyesData(list/data = list())
	data["eye_type"] = capitalize("[eye_type]")
	split_eye_colors = TRUE // just makes it easier
	data["eye_over_hair"] = eye_over_hair
	data["left_eye_color"] = left_eye_color
	data["right_eye_color"] = right_eye_color
	data["hair_1_style"] = hair_style
	data["hair_1_color"] = hair_color
	data["gradient_1_style"] = features["grad_style"]
	data["gradient_1_color"] = features["grad_color"]
	data["hair_2_style"] = features["hair_style_2"]
	data["hair_2_color"] = features["hair_color_2"]
	data["gradient_2_style"] = features["grad_style_2"]
	data["gradient_2_color"] = features["grad_color_2"]
	data["facial_hair_style"] = facial_hair_style
	data["facial_hair_color"] = facial_hair_color
	return data

/datum/preferences/proc/GetCharacterPartsData(list/data = list())
	data["all_parts"] = list()
	if(features["color_scheme"] != ADVANCED_CHARACTER_COLORING)
		features["color_scheme"] = ADVANCED_CHARACTER_COLORING // screw you, use it
	for(var/mutant_part in GLOB.all_mutant_parts)
		if(mutant_part == "mam_body_markings")
			continue // we'll get to this
		if(!parent.can_have_part(mutant_part))
			continue
		var/part_data = list()
		part_data["displayname"] = GLOB.all_mutant_parts[mutant_part]
		part_data["featurekey"] = mutant_part
		part_data["currentshape"] = features[mutant_part]
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
			part_data["no_color"] = TRUE
			data["all_parts"] += list(part_data)
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
		part_data["color1"] = features[primary_feature]
		part_data["color1_key"] = primary_feature

		part_data["color2"] = features[secondary_feature]
		part_data["color2_key"] = secondary_feature
		part_data["color2_show"] = accessory.ShouldHaveSecondaryColor()

		part_data["color3"] = features[tertiary_feature]
		part_data["color3_key"] = tertiary_feature
		part_data["color3_show"] = accessory.ShouldHaveTertiaryColor()

		data["all_parts"] += list(part_data)
	data["all_limb_mods"] = list()
	for(var/modification in modified_limbs) // mofidiecation is a string, the limb mod
		var/limb_mod_data = list()
		limb_mod_data["area"] = modification
		var/list/mod_data = modified_limbs[modification]
		var/pora = mod_data[1]
		if(pora == LOADOUT_LIMB_PROSTHETIC)
			limb_mod_data["pros_or_amp"] = "Prosthetic"
			limb_mod_data["style"] = mod_data[2]
		else
			limb_mod_data["pros_or_amp"] = "Amputated"
			limb_mod_data["style"] = "Missing D:"
		data["all_limb_mods"] += list(limb_mod_data)
	return data

/datum/preferences/proc/GetCharacterMarkingsData(list/data = list())
	data["markings"] = list()
	if(!parent.can_have_part("mam_body_markings"))
		data["can_have_markings"] = FALSE
		return data // lousy humans
	if(!islist(features["mam_body_markings"]))
		features["mam_body_markings"] = list()
	if(!LAZYLEN(features["mam_body_markings"]))
		return data // no markings 3:
	var/list/markings = features["mam_body_markings"]
	var/list/rev_markings = reverseList(markings)
	for(var/list/mark in rev_markings)
		mark = SanitizeMarking(mark)
		var/m_uid = mark[MARKING_UID]
		var/limb_num = mark[MARKING_LIMB_INDEX_NUM]
		var/limb_name = GLOB.bodypart_names[num2text(limb_num)]
		var/list/mark_data = list()
		mark_data["displayname"] = capitalize(mark[MARKING_NAME])
		mark_data["location_display"] = capitalize(limb_name)
		mark_data["marking_uid"] = m_uid
		// and here come the colors!
		var/datum/sprite_accessory/mam_body_markings/S = GLOB.mam_body_markings_list[mark[2]]
		if(!S)
			continue
		var/matrixed_sections = S.covered_limbs[limb_name]
		if(!matrixed_sections)
			continue
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
		mark_data["color1"] = mark[MARKING_COLOR_LIST][primary_index]
		mark_data["color1_index"] = primary_index
		if(matrixed_sections == MATRIX_RED_BLUE || \
			matrixed_sections == MATRIX_GREEN_BLUE || \
			matrixed_sections == MATRIX_RED_GREEN || \
			matrixed_sections == MATRIX_ALL)
			mark_data["color2"] = mark[MARKING_COLOR_LIST][secondary_index]
			mark_data["color2_index"] = secondary_index
			mark_data["color2_show"] = TRUE
			if(matrixed_sections == MATRIX_ALL)
				mark_data["color3"] = mark[MARKING_COLOR_LIST][tertiary_index]
				mark_data["color3_index"] = tertiary_index
				mark_data["color3_show"] = TRUE
		data["markings"] += list(mark_data)
	return data

// teehees and hoohaws
/datum/preferences/proc/GetCharacterUnderlyingData(list/data = list())
	data["subsubcategory_tabs_line1"] = list(
		PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES,
		PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING,
	)
	data["subsubcategory_tabs_genitals"] = list()
	for(var/hasbit in GLOB.genital_data)
		var/datum/genital_data/GD = GLOB.genital_data[hasbit]
		data["subsubcategory_tabs_genitals"] += GD.has_key
	switch(current_sub_subtab)
		if(PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES)
			GetCharacterUnderlyingUndiesData(data)
		if(PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING)
			GetCharacterUnderlyingLayeringData(data)
		else
			if(GLOB.genital_data[current_sub_subtab])
				GetCharacterUnderlyingGenitalData(data, GLOB.genital_data[current_sub_subtab])

/datum/preferences/proc/GetCharacterUnderlyingUndiesData(list/data = list())
	data["underwear_overhands"] = underwear_overhands
	data["undies"] = list() // some day this will be FULL of undies
	var/list/underpants = list()
	underpants["displayname"] = "Bottomwear"
	underpants["style"] = underwear
	underpants["color1"] = undie_color
	underpants["color1_key"] = "undie_color"
	underpants["overclothes"] = undies_overclothes
	underpants["undie_command"] = PREFCMD_UNDERWEAR
	underpants["over_command"] = PREFCMD_UNDERWEAR_OVERCLOTHES
	data["undies"] += list(underpants)
	var/list/undershirt = list()
	undershirt["displayname"] = "Topwear"
	undershirt["style"] = undershirt
	undershirt["color1"] = shirt_color
	undershirt["color1_key"] = "shirt_color"
	undershirt["overclothes"] = undershirt_overclothes
	undershirt["undie_command"] = PREFCMD_UNDERSHIRT
	undershirt["over_command"] = PREFCMD_UNDERSHIRT_OVERCLOTHES
	data["undies"] += list(undershirt)
	var/list/socks = list()
	socks["displayname"] = "Footwear"
	socks["style"] = socks
	socks["color1"] = socks_color
	socks["color1_key"] = "socks_color"
	socks["overclothes"] = socks_overclothes
	socks["undie_command"] = PREFCMD_SOCKS
	socks["over_command"] = PREFCMD_SOCKS_OVERCLOTHES
	data["undies"] += list(socks)
	return data

/datum/preferences/proc/GetCharacterUnderlyingLayeringData(list/data = list())
	data["genitals"] = list()
	var/list/allnads = list()
	for(var/hasbit in GLOB.genital_data)
		var/datum/genital_data/GD = GLOB.genital_data[hasbit]
		if(!GD.CanLayer())
			continue
		allnads += GD
	var/indecency = 1
	for(var/datum/genital_data/GD in allnads)
		var/gen_data = list()
		gen_data["displayname"] = capitalize(GD.name)
		gen_data["has_key"] = GD.has_key
		var/vfbit = features[GD.vis_flags_key]
		gen_data["respect_clothing"] = CHECK_BITFIELD(vfbit, GENITAL_RESPECT_CLOTHING)
		gen_data["respect_underwear"] = CHECK_BITFIELD(vfbit, GENITAL_RESPECT_UNDERWEAR)
		var/peen_vis_override
		if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_HIDDEN))
			peen_vis_override = "Always Hidden"
		else if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_VISIBLE))
			peen_vis_override = "Always Visible"
		else
			peen_vis_override = "Check Coverage"
		gen_data["override_coverings"] = peen_vis_override
		gen_data["see_on_others"] = CHECK_BITFIELD(features["genital_hide"], GD.hide_flag)
		gen_data["has_one"] = !!features[GD.has_key]
		//now for the uppydowny arrows
		if(indecency > 1)
			gen_data["uparrow"] = TRUE
		if(indecency < LAZYLEN(GLOB.genital_data))
			gen_data["downarrow"] = TRUE
		data["genitals"] += list(gen_data)
		indecency++
	return data

/datum/preferences/proc/GetCharacterUnderlyingGenitalData(list/data = list(), datum/genital_data/GD)
	if(!(current_sub_subtab in GLOB.genital_data))
		data["fatal_error"] = "BONBON'S BUTT"
		return data
	data["this_bingus"] = list()
	var/GD = GLOB.genital_data[current_sub_subtab]
	var/list/genidata = list()
	genidata["displayname"] = capitalize(GD.name)
	genidata["one_or_some"] = GD.one_or_some
	genidata["has_key"] = GD.has_key
	genidata["has_one"] = !!features[GD.has_key]
	genidata["can_see"] = !CHECK_BITFIELD(GD.genital_flags, GENITAL_INTERNAL)
	genidata["can_color1"] = CHECK_BITFIELD(GD.genital_flags, GENITAL_CAN_RECOLOR)
	genidata["color1"] = features[GD.color_key]
	genidata["color1_key"] = GD.color_key
	genidata["can_shape"] = CHECK_BITFIELD(GD.genital_flags, GENITAL_CAN_RESHAPE)
	genidata["shape"] = features[GD.shape_key]
	genidata["can_size"] = CHECK_BITFIELD(GD.genital_flags, GENITAL_CAN_RESIZE)
	genidata["size"] = features[GD.size_key]
	genidata["size_unit"] = GD.size_units
	genidata["respect_clothing"] = CHECK_BITFIELD(features[GD.vis_flags_key], GENITAL_RESPECT_CLOTHING)
	genidata["respect_underwear"] = CHECK_BITFIELD(features[GD.vis_flags_key], GENITAL_RESPECT_UNDERWEAR)
	var/peen_vis_override
	if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_HIDDEN))
		peen_vis_override = "Always Hidden"
	else if(CHECK_BITFIELD(features[GD.override_key], GENITAL_ALWAYS_VISIBLE))
		peen_vis_override = "Always Visible"
	else
		peen_vis_override = "Check Coverage"
	genidata["override_coverings"] = peen_vis_override
	genidata["see_on_others"] = CHECK_BITFIELD(features["genital_hide"], GD.hide_flag)
	data["this_bingus"] = genidata
	return data

/datum/preferences/proc/GetLoadoutData(list/data = list())
	data["points_left"] = GetLoadoutPointsLeft()
	if(data["points_left"] <= 0)
		data["points_span"] = "OutOfPoints"
	WashLoadoutCats()
	data["primary_categories"] = GetLoadoutCategories()
	data["secondary_categories"] = GetLoadoutSubcategories()
	data["current_category"] = gear_category
	data["current_subcategory"] = gear_subcategory
	data["search"] = loadout_search
	data["gear_list"] = GetGearList(gear_category, gear_subcategory, loadout_search)
	return data

/datum/preferences/proc/GetGamePreferencesData(list/data = list())
	data["subcategory_tabs"] = list(
		PPT_GAME_PREFERENCES_GENERAL,
		PPT_GAME_PREFERENCES_UI,
		PPT_GAME_PREFERENCES_CHAT,
		PPT_GAME_PREFERENCES_RUNECHAT,
		PPT_GAME_PREFERENCES_GHOST,
		PPT_GAME_PREFERENCES_AUDIO,
		PPT_GAME_PREFERENCES_ADMIN,
		PPT_GAME_PREFERENCES_CONTENT,
	)
	if(!(current_subtab in data["subcategory_tabs"]))
		current_subtab = PPT_GAME_PREFERENCES_GENERAL
	switch(current_subtab)
		if(PPT_GAME_PREFERENCES_GENERAL)
			GetGamePreferencesGeneralData(data)
		if(PPT_GAME_PREFERENCES_UI)
			GetGamePreferencesUIData(data)
		if(PPT_GAME_PREFERENCES_CHAT)
			GetGamePreferencesChatData(data)
		if(PPT_GAME_PREFERENCES_RUNECHAT)
			GetGamePreferencesRunechatData(data)
		if(PPT_GAME_PREFERENCES_GHOST)
			GetGamePreferencesGhostData(data)
		if(PPT_GAME_PREFERENCES_AUDIO)
			GetGamePreferencesAudioData(data)
		if(PPT_GAME_PREFERENCES_ADMIN)
			GetGamePreferencesAdminData(data)
		if(PPT_GAME_PREFERENCES_CONTENT)
			GetGamePreferencesContentData(data)
	return data

#define ADD_OP(lyst, name, value, command) lyst += list(list("name" = name, "value" = value, "command" = command))
/datum/preferences/proc/GetGamePreferencesGeneralData(list/data = list())
	var/list/op = list()
	var/showtext = "Disabled (15x15)"
	if(widescreenpref)
		showtext = "Enabled ([CONFIG_GET(string/default_view)])"
	ADD_OP(op, "Widescreen", "[showtext]", PREFCMD_WIDESCREEN_TOGGLE)
	var/showtext2 = "Disabled"
	if(autostand)
		showtext2 = "Enabled"
	ADD_OP(op, "Auto Stand", "[showtext2]", PREFCMD_AUTOSTAND_TOGGLE)
	var/showtext3 = "Disabled"
	if(no_tetris_storage)
		showtext3 = "Enabled"
	ADD_OP(op, "Force Slot Storage HUD", "[showtext3]", PREFCMD_TETRIS_STORAGE_TOGGLE)
	var/showtext4 = "Disabled"
	if(cb_toggles & AIM_CURSOR_ON)
		showtext4 = "Enabled"
	ADD_OP(op, "Gun Cursor", "[showtext4]", PREFCMD_GUNCURSOR_TOGGLE)
	var/showtext5 = "None"
	if(screenshake == 100)
		showtext5 = "Full"
	else if(screenshake != 0)
		showtext5 = "[screenshake]"
	ADD_OP(op, "Screen Shake", "[showtext5]", PREFCMD_SCREENSHAKE_TOGGLE)
	var/showtext6 = "Only when down"
	if(damagescreenshake == 1)
		showtext6 = "On"
	else if(damagescreenshake == 0)
		showtext6 = "Off"
	ADD_OP(op, "Damage Screen Shake", "[showtext6]", PREFCMD_DAMAGESCREENSHAKE_TOGGLE)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesUIData(list/data = list())
	var/list/op = list()
	ADD_OP(op, "UI Style", UI_style, PREFCMD_UI_STYLE)
	var/showtext1 = "All"
	if(tgui_lock)
		showtext1 = "Primary"
	ADD_OP(op, "TGUI Lock", "[showtext1]", PREFCMD_TGUI_LOCK)
	var/showtext2 = "No Frills"
	if(tgui_fancy)
		showtext2 = "Fancy"
	ADD_OP(op, "TGUI Fancy", "[showtext2]", PREFCMD_TGUI_FANCY)
	ADD_OP(op, "Input Mode Hotkey", "[input_mode_hotkey]", PREFCMD_INPUT_MODE_HOTKEY)
	var/showtext3 = "Unlocked"
	if(buttons_locked)
		showtext3 = "Locked In Place"
	ADD_OP(op, "Action Buttons", "[showtext3]", PREFCMD_ACTION_BUTTONS)
	var/showtext4 = "Disabled"
	if(windowflashing)
		showtext4 = "Enabled"
	ADD_OP(op, "Window Flashing", "[showtext4]", PREFCMD_WINFLASH)
	var/showtext5 = "Disabled"
	if(ambientocclusion)
		showtext5 = "Enabled"
	ADD_OP(op, "Ambient Occlusion", "[showtext5]", PREFCMD_AMBIENTOCCLUSION)
	var/showtext6 = "Manual"
	if(auto_fit_viewport)
		showtext6 = "Auto"
	ADD_OP(op, "Fit Viewport", "[showtext6]", PREFCMD_AUTO_FIT_VIEWPORT)
	var/showtext7 = "Disabled"
	if(hud_toggle_flash)
		showtext7 = "Enabled"
	ADD_OP(op, "HUD Button Flashes", "[showtext7]", PREFCMD_HUD_TOGGLE_FLASH)
	ADD_OP(op, "FPS", "[showtext8]", PREFCMD_CLIENTFPS)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesChatData(list/data = list())
	var/list/op = list()
	var/showtext1 = "Disabled"
	if(chat_toggles & CHAT_PULLR)
		showtext1 = "Enabled"
	ADD_OP(op, "See Pull Requests", "[showtext1]", PREFCMD_PULL_REQUESTS)
	var/showtext2 = "Disabled"
	if(show_health_smilies)
		showtext2 = "Enabled"
	ADD_OP(op, "Show Health Smileys", "[showtext2]", PREFCMD_HEALTH_SMILEYS)
	ADD_OP(op, "Max PFP Examine Image Height", "[see_pfp_max_hight]px", PREFCMD_MAX_PFP_HEIGHT)
	ADD_OP(op, "Max PFP Examine Image Width", "[see_pfp_max_widht]%", PREFCMD_MAX_PFP_WIDTH)
	// var/showtext3 = "Disabled"
	// if(auto_ooc)
	// 	showtext3 = "Enabled"
	// ADD_OP(op, "Auto OOC", "[showtext3]", PREFCMD_AUTO_OOC)
	// var/showtext4 = "Muted"
	// if(chat_toggles & CHAT_BANKCARD)
	// 	showtext4 = "Allowed"
	// ADD_OP(op, "Income Updates", "[showtext4]", PREFCMD_INCOME_UPDATES)
	var/showtext5 = "Muted"
	if(chat_toggles & CHAT_HEAR_RADIOSTATIC)
		showtext5 = "Allowed"
	ADD_OP(op, "Hear Radio Static", "[showtext5]", PREFCMD_RADIO_STATIC)
	var/showtext6 = "Muted"
	if(chat_toggles & CHAT_HEAR_RADIOBLURBLES)
		showtext6 = "Allowed"
	ADD_OP(op, "Hear Radio Blurbles", "[showtext6]", PREFCMD_RADIO_BLURBLES)
	if(usr.client) // byond!
		if(unlock_content)
			var/showtext7 = "Hidden"
			if(toggles & MEMBER_PUBLIC)
				showtext7 = "Public"
			ADD_OP(op, "BYOND Membership Publicity", "[showtext7]", PREFCMD_BYOND_PUBLICITY)
		if(unlock_content || check_rights(R_ADMIN, FALSE))
			ADD_OP(op, "OOC Color", "[ooccolor]", PREFCMD_OOC_COLOR)
			ADD_OP(op, "AnonOOC Color", "[aooccolor]", PREFCMD_AOOC_COLOR)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesRunechatData(list/data = list())
	var/list/op = list()
	var/showtext1 = "Disabled"
	if(chat_on_map)
		showtext1 = "Enabled"
	ADD_OP(op, "Show Runechat Chat Bubbles", "[showtext1]", PREFCMD_CHAT_ON_MAP)
	ADD_OP(op, "Runechat Message Char Limit", "[max_chat_length]", PREFCMD_MAX_CHAT_LENGTH)
	ADD_OP(op, "Runechat Message Width", "[chat_width]", PREFCMD_CHAT_WIDTH)
	var/showtext2 = "Disabled"
	if(see_fancy_offscreen_runechat)
		showtext2 = "Enabled"
	ADD_OP(op, "Runechat off-screen", "[showtext2]", PREFCMD_OFFSCREEN)
	var/showtext3 = "Disabled"
	if(see_chat_non_mob)
		showtext3 = "Enabled"
	ADD_OP(op, "See Runechat for non-mobs", "[showtext3]", PREFCMD_SEE_CHAT_NON_MOB)
	var/showtext4 = "Disabled"
	if(see_rc_emotes)
		showtext4 = "Enabled"
	ADD_OP(op, "See Runechat emotes", "[showtext4]", PREFCMD_SEE_RC_EMOTES)
	var/showtext5 = "Disabled"
	if(color_chat_log)
		showtext5 = "Enabled"
	ADD_OP(op, "Runechat Color in Chat Log", "[showtext5]", PREFCMD_COLOR_CHAT_LOG)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesGhostData(list/data = list())
	if(!check_rights(R_ADMIN, FALSE))
		data["options"] = list(
			"name" = "Hey, you're not an admin! Nice job finding this, please report error code LYRA'S BUTT",
			"value" = "Oh no!",
			"command" = "Oh no!",
		)
		return data
	var/list/op = list()
	var/showtext1 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTEARS)
		showtext1 = "All Speech"
	ADD_OP(op, "Hear All Speech", "[showtext1]", PREFCMD_GHOST_EARS)
	var/showtext2 = "No Messages"
	if(chat_toggles & CHAT_GHOSTRADIO)
		showtext2 = "All Messages"
	ADD_OP(op, "Hear All Radios", "[showtext2]", PREFCMD_GHOST_RADIO)
	var/showtext3 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTSIGHT)
		showtext3 = "All Emotes"
	ADD_OP(op, "See All Emotes", "[showtext3]", PREFCMD_GHOST_SIGHT)
	var/showtext4 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTWHISPER)
		showtext4 = "All Speech"
	ADD_OP(op, "Hear All Whispers", "[showtext4]", PREFCMD_GHOST_WHISPERS)
	var/showtext500 = "Nearest Creatures"
	if(chat_toggles & CHAT_GHOSTPDA)
		showtext500 = "All Messages"
	ADD_OP(op, "Hear All PDA Messages", "[showtext500]", PREFCMD_GHOST_PDA)
	if(unlock_content || check_rights(R_ADMIN)) // ghost customization!
		ADD_OP(op, "Ghost Form", "[ghost_form]", PREFCMD_GHOST_FORM)
		ADD_OP(op, "Ghost Orbit", "[ghost_orbit]", PREFCMD_GHOST_ORBIT)
	var/showtext5 = "If you see this something went wrong."
	switch(ghost_accs)
		if(GHOST_ACCS_FULL)
			showtext5 = GHOST_ACCS_FULL_NAME
		if(GHOST_ACCS_DIR)
			showtext5 = GHOST_ACCS_DIR_NAME
		if(GHOST_ACCS_NONE)
			showtext5 = GHOST_ACCS_NONE_NAME
	// Ghost Accessories
	ADD_OP(op, "How you look to others", "[showtext5]", PREFCMD_GHOST_ACCS)
	var/showtext6 = "If you see this something went wrong."
	switch(ghost_others)
		if(GHOST_OTHERS_THEIR_SETTING)
			showtext6 = GHOST_OTHERS_THEIR_SETTING_NAME
		if(GHOST_OTHERS_DEFAULT_SPRITE)
			showtext6 = GHOST_OTHERS_DEFAULT_SPRITE_NAME
		if(GHOST_OTHERS_SIMPLE)
			showtext6 = GHOST_OTHERS_SIMPLE_NAME
	// Ghosts of Others
	ADD_OP(op, "How you see others", "[showtext6]", PREFCMD_GHOST_OTHERS)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesAudioData(list/data = list())
	var/list/op = list()
	var/showtext1 = "Disabled"
	if(toggles & SOUND_HUNTINGHORN)
		showtext1 = "Enabled"
	ADD_OP(op, "Hear Hunting Horn Sounds", "[showtext1]", PREFCMD_HUNTINGHORN)
	var/showtext2 = "Disabled"
	if(toggles & SOUND_SPRINTBUFFER)
		showtext2 = "Enabled"
	ADD_OP(op, "Hear Sprint Depletion Sound", "[showtext2]", PREFCMD_SPRINTBUFFER)
	var/showtext3 = "Disabled"
	if(toggles & SOUND_MIDI)
		showtext3 = "Enabled"
	ADD_OP(op, "Hear Admin MIDIs", "[showtext3]", PREFCMD_MIDIS)
	var/showtext4 = "Disabled"
	if(toggles & SOUND_LOBBY)
		showtext4 = "Enabled"
	ADD_OP(op, "Hear Lobby Music", "[showtext4]", PREFCMD_LOBBY_MUSIC)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesAdminData(list/data = list())
	if(!check_rights(R_ADMIN, FALSE))
		data["options"] = list(
			"name" = "Hey, you're not an admin! Nice job finding this, please report error code BUBBLECUP'S BUTT",
			"value" = "Oh no!",
			"command" = "Oh no!",
		)
		return data
	var/list/op = list()
	var/showtext1 = "Disabled"
	if(toggles & SOUND_ADMINHELP)
		showtext1 = "Enabled"
	ADD_OP(op, "Hear All Adminhelp Sounds", "[showtext1]", PREFCMD_ADMINHELP)
	var/showtext2 = "Disabled"
	if(toggles & ANNOUNCE_LOGIN)
		showtext2 = "Enabled"
	ADD_OP(op, "Announce Your Arrival", "[showtext2]", PREFCMD_ANNOUNCE_LOGIN)
	var/showtext3 = "No Change"
	if(toggles & COMBOHUD_LIGHTING)
		showtext3 = "Full-bright"
	ADD_OP(op, "Combo HUD Lighting", "[showtext3]", PREFCMD_COMBOHUD_LIGHTING)
	var/showtext4 = "Disabled"
	if(toggles & SPLIT_ADMIN_TABS)
		showtext4 = "Enabled"
	ADD_OP(op, "Split Admin Tabs", "[showtext4]", PREFCMD_SPLIT_ADMIN_TABS)
	data["options"] = op
	return data

/datum/preferences/proc/GetGamePreferencesContentData(list/data = list())
	var/list/op = list()
	var/showtext1 = "Disabled"
	if(arousable)
		showtext1 = "Enabled"
	ADD_OP(op, "You can be aroused", "[showtext1]", PREFCMD_AROUSABLE)
	var/showtext2 = "Disabled"
	if(cit_toggles & GENITAL_EXAMINE)
		showtext2 = "Enabled"
	ADD_OP(op, "You can see genital examine text", "[showtext2]", PREFCMD_GENITAL_EXAMINE)
	var/showtext3 = "Allowed"
	if(cit_toggles & NO_BUTT_SLAP)
		showtext3 = "Disallowed"
	ADD_OP(op, "Your butt can be smacked", "[showtext3]", PREFCMD_BUTT_SLAP)
	var/showtext4 = "Enabled"
	if(cit_toggles & NO_AUTO_WAG)
		showtext4 = "Disabled"
	ADD_OP(op, "Your tail will wag if you're petted", "[showtext4]", PREFCMD_AUTO_WAG)
	var/showtext5 = "All Disabled"
	if(master_vore_toggle)
		showtext5 = "Per Preferences"
	ADD_OP(op, "Master Vore Toggle", "[showtext5]", PREFCMD_MASTER_VORE_TOGGLE)
	var/showtext6 = "Disallowed"
	if(allow_being_prey)
		showtext6 = "Allowed"
	ADD_OP(op, "You can be prey", "[showtext6]", PREFCMD_ALLOW_BEING_PREY)
	var/showtext7 = "Disallowed"
	if(allow_being_fed_prey)
		showtext7 = "Allowed"
	ADD_OP(op, "You can be fed prey", "[showtext7]", PREFCMD_ALLOW_BEING_FED_PREY)
	var/showtext8 = "Disallowed"
	if(allow_digestion_damage)
		showtext8 = "Allowed"
	ADD_OP(op, "You can take digestion damage", "[showtext8]", PREFCMD_ALLOW_DIGESTION_DAMAGE)
	var/showtext9 = "Disallowed"
	if(allow_digestion_death)
		showtext9 = "Allowed"
	ADD_OP(op, "You can die from digestion", "[showtext9]", PREFCMD_ALLOW_DIGESTION_DEATH)
	var/showtext10 = "Hidden"
	if(allow_vore_messages)
		showtext10 = "Visible"
	ADD_OP(op, "You can see vore messages", "[showtext10]", PREFCMD_ALLOW_VORE_MESSAGES)
	var/showtext11 = "Hidden"
	if(allow_trash_messages)
		showtext11 = "Visible"
	ADD_OP(op, "You can see trash messages", "[showtext11]", PREFCMD_ALLOW_TRASH_MESSAGES)
	var/showtext12 = "Hidden"
	if(allow_death_messages)
		showtext12 = "Visible"
	ADD_OP(op, "You can see death messages", "[showtext12]", PREFCMD_ALLOW_DEATH_MESSAGES)
	var/showtext13 = "Muted"
	if(allow_eating_sounds)
		showtext13 = "Audible"
	ADD_OP(op, "You can hear eating sounds", "[showtext13]", PREFCMD_ALLOW_EATING_SOUNDS)
	var/showtext14 = "Muted"
	if(allow_digestion_sounds)
		showtext14 = "Audible"
	ADD_OP(op, "You can hear digestion sounds", "[showtext14]", PREFCMD_ALLOW_DIGESTION_SOUNDS)
	data["options"] = op
	return data

/datum/preferences/proc/Keybindings(list/data = list())
	data["hotkeys_mode"] = hotkeys_mode
	data["categories"] = list()
	for(var/cat in GLOB.keybindings_by_category)
		data["categories"] += cat
	// and the keybinds for this category
	data["keybindings"] = list()
	if(!(keybind_category in GLOB.keybindings_by_category))
		keybind_category = GLOB.keybindings_by_category[1]
	data["current_category"] = keybind_category
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	var/list/user_modless_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)
	for (var/key in modless_key_bindings)
		user_modless_binds[modless_key_bindings[key]] = key
	for(var/keybind in GLOB.keybindings_by_category[keybind_category])
		var/datum/keybinding/KB = GLOB.keybindings_by_category[keybind_category][keybind]
		var/current_independent_binding = "Unbound"
		if(user_modless_binds[KB.name])
			current_independent_binding = user_modless_binds[KB.name]
		var/list/kb_data = list()
		var/list/ourbinds = user_binds[KB.name]
		var/list/defaultbinds = hotkeys ? KB.classic_keys : KB.hotkey_keys
		var/bind1 = LAZYACCESS(ourbinds, 1) || LAZYACCESS(defaultbinds, 1)
		var/bind2 = LAZYACCESS(ourbinds, 2) || LAZYACCESS(defaultbinds, 2)
		var/bind3 = LAZYACCESS(ourbinds, 3) || LAZYACCESS(defaultbinds, 3)
		var/defaults = defaultbinds.Join(", ")
		kb_data["displayname"] = KB.full_name
		kb_data["description"] = KB.description
		kb_data["key1"] = bind1
		kb_data["key2"] = bind2
		kb_data["key3"] = bind3
		kb_data["default"] = defaults
		kb_data["independent_key"] = current_independent_binding
		data["keybindings"] += list(kb_data)
	return data

/datum/preferences/proc/GetLoadoutPointsLeft()
	var/gear_points = CONFIG_GET(number/initial_gear_points)
	var/list/chosen_gear = loadout_data["SAVE_[loadout_slot]"]
	if(chosen_gear)
		for(var/loadout_item in chosen_gear)
			var/loadout_item_path = loadout_item[LOADOUT_ITEM]
			if(loadout_item_path)
				var/datum/gear/loadout_gear = text2path(loadout_item_path)
				if(loadout_gear)
					gear_points -= initial(loadout_gear.cost)
	return gear_points

/datum/preferences/proc/GetLoadoutCategories()
	var/list/cats = list()
	cats += LOADOUT_CATEGORY_EQUIPPED
	for(var/cat in GLOB.loadout_categories)
		cats += cat
	return cats

/datum/preferences/proc/GetLoadoutSubcategories()
	if(gear_category == GEAR_CAT_ALL_EQUIPPED)
		return list("My Stuff")
	if(loadout_search)
		return list("Results")
	var/list/subcats = list() // merek
	for(var/subcat in GLOB.loadout_categories[gear_category])
		subcats += subcat // merek
	return subcats

/datum/preferences/proc/GetGearList(gear_category, gear_subcategory, loadout_search)
	var/list/gearlist = list() // merek
	// okay this can go one (or two) of two (or three) ways
	// 1. we're searching for something
	//    which gets everything that relates to the search,
	//    which *then* gets capped at some point
	// 2. we're looking at all equipped gear
	//    which gets everything that's equipped, and thats it
	// 3. we're looking at a specific subcategory
	//    which gets everything in that category, and thats it
	// and it checks those things, in that order!

	if(loadout_search)
		var/found = 0
		for(var/gname in GLOB.flat_loadout_items)
			if(found > 50)
				break
			if(findtext(gname, loadout_search))
				gearlist += gname
				found++
	
	else if(gear_category == GEAR_CAT_ALL_EQUIPPED)
		var/list/my_saved = loadout_data["SAVE_[loadout_slot]"]
		for(var/list/loadout_gear in my_saved)
			var/gpat = loadout_gear[LOADOUT_ITEM]
			if(istype(GLOB.flat_loadout_items[gpat], /datum/gear))
				gearlist += GLOB.flat_loadout_items[gpat]
			else
				// this is a bad thing, we should remove it
				loadout_data["SAVE_[loadout_slot]"] -= loadout_gear
	else
		if(!LAZYLEN(GLOB.loadout_items[gear_category]) || !LAZYLEN(GLOB.loadout_items[gear_category][gear_subcategory]))
			WashLoadoutCats() // quick! get us to safety!
		for(var/pathG in GLOB.loadout_items[gear_category][gear_subcategory])
			var/datum/gear/G = GLOB.loadout_items[gear_category][gear_subcategory][pathG]
			if(G)
				gearlist += G
	// now we have the stuff! now, lets turn em into juicy tgui
	var/list/geardata = list()
	for(var/datum/gear/loag in gearlist)
		var/list/cooldat = list()
		var/list/gots = has_loadout_gear(loadout_slot, loag.name)
		if(gots)
			cooldat["has"] = TRUE
			if(LAZYLEN(gots[LOADOUT_CUSTOM_NAME]))
				cooldat["displayname"] = gots[LOADOUT_CUSTOM_NAME]
				cooldat["renamed"] = TRUE
			if(LAZYLEN(gots[LOADOUT_CUSTOM_DESCRIPTION]))
				cooldat["description"] = gots[LOADOUT_CUSTOM_DESCRIPTION]
				cooldat["redesc"] = TRUE
			if(LAZYLEN(gots[LOADOUT_CUSTOM_COLOR]))
				cooldat["color"] = gots[LOADOUT_CUSTOM_COLOR]
		else
			cooldat["displayname"] = loag.name
			cooldat["description"] = loag.description
		cooldat["cost"] = loag.cost
		cooldat["gear_path"] = loag.path
		cooldat["can_afford"] = (gear_points - loag.cost) >= 0
		geardata += list(cooldat)
	return geardata

// meow
/datum/preferences/proc/WashLoadoutCats()
	if(gear_category == GEAR_CAT_ALL_EQUIPPED)
		gear_subcategory = "My Stuff"
		return
	if(loadout_search)
		gear_category = "Search Results"
		gear_subcategory = "Results"
		return
	if(!LAZYLEN(GLOB.loadout_items[gear_category]))
		for(var/cat in GLOB.loadout_categories)
			if(cat == gear_category)
				continue
			if(LAZYLEN(GLOB.loadout_items[cat]))
				gear_category = cat
				gear_subcategory = GLOB.loadout_categories[cat][1]
				return
		stack_trace("WashLoadoutCats: No valid categories found!")
		return
	if(!LAZYLEN(GLOB.loadout_items[gear_category][gear_subcategory]))
		for(var/subcat in GLOB.loadout_categories[gear_category])
			if(subcat == gear_subcategory)
				continue
			if(LAZYLEN(GLOB.loadout_items[gear_category][subcat]))
				gear_subcategory = subcat
				return
		stack_trace("WashLoadoutCats: No valid subcategories found!")
		return
	// finally, we're good
	return

/datum/preferences/proc/SanitizeMarking(list/marking)
	if(!islist(marking))
		marking = list()
	marking.len = 4
	var/list/colist = marking[MARKING_COLOR_LIST]
	colist.len = 3
	if(!LAZYACCESS(colist, 1))
		colist[1] = features["mcolor"]
	if(!LAZYACCESS(colist, 2))
		colist[2] = features["mcolor2"]
	if(!LAZYACCESS(colist, 3))
		colist[3] = features["mcolor3"]
	marking[MARKING_COLOR_LIST] = colist
	if(!LAZYLEN(marking[MARKING_UID]))
		marking[MARKING_UID] = GenerateMarkingUID()
	return marking



/* 
	if(current_subtab == PPT_CHARCTER_APPEARANCE_UNDERLYING)
		GetCharacterUnderlyingData(data)
		data["subsubcategory_tabs_line1"] = list(
			PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES,
			PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING,
		)
		data["subsubcategory_tabs_genitals"] = list()
		for(var/hasbit in GLOB.genital_data)
			var/datum/genital_data/GD = GLOB.genital_data[hasbit]
			data["subsubcategory_tabs_genitals"] += GD.has_key

 */


// Author: GremlingSS
// Not all of my work, it's porting over vorestation's gradient system into TG and adapting it basically.
// This is gonna be fun, wish me luck!~
//
// Also, as obligated to my coding standards, I must design a shitpost related to the code, but because it's hard to think of a meme
// I'm gonna just pull one out my ass and hope it's funny.


/* // Disabled random features from providing random gradients, simply to avoid reloading save file errors.
random_features(intendedspecies, intended_gender)
	. = ..(intendedspecies, intended_gender)
	
	var/grad_color = random_color()

	var/list/output = .

	output += list(
		"grad_color"			= grad_color,
		"grad_style"			= pick(GLOB.hair_gradients))

	return output


randomize_human(mob/living/carbon/human/H)
//	H.dna.features["flavor_text"] = "" // I'm so tempted to put lorem ipsum in the flavor text so freaking badly please someone hold me back god.
	H.dna.features["grad_color"] = random_color()
	H.dna.features["grad_style"] = pick(GLOB.hair_gradients)
	..(H)
*/

/mob/living/carbon/human/proc/change_hair_gradient(hair_gradient)
	if(dna.features["grad_style"] == hair_gradient)
		return

	if(!(hair_gradient in GLOB.hair_gradients))
		return

	dna.features["grad_style"] = hair_gradient

	update_hair()
	return 1



/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				// if("grad_color")
				// 	var/new_grad_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features["grad_color"]) as color|null
				// 	if(new_grad_color)
				// 		features["grad_color"] = sanitize_hexcolor(new_grad_color, 6, default = COLOR_ALMOST_BLACK)

				// if("grad_style")
				// 	var/new_grad_style
				// 	new_grad_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_gradients
				// 	if(new_grad_style)
				// 		features["grad_style"] = new_grad_style
				
				// if("grad_color_2")
				// 	var/new_grad_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features["grad_color_2"]) as color|null
				// 	if(new_grad_color)
				// 		features["grad_color_2"] = sanitize_hexcolor(new_grad_color, 6, default = COLOR_ALMOST_BLACK)

				// if("grad_style_2")
				// 	var/new_grad_style
				// 	new_grad_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_gradients
				// 	if(new_grad_style)
				// 		features["grad_style_2"] = new_grad_style
				
				// if("hair_color_2")
				// 	var/new_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features["hair_color_2"]) as color|null
				// 	if(new_color)
				// 		features["hair_color_2"] = sanitize_hexcolor(new_color, 6, default = COLOR_ALMOST_BLACK)

				if("hair_style_2")
					var/new_style
					new_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_styles_list
					if(new_style)
						features["hair_style_2"] = new_style
				
				// if("previous_hair_style_2")
				// 	features["hair_style_2"] = previous_list_item(features["hair_style_2"], GLOB.hair_styles_list)
				
				// if("next_hair_style_2")
				// 	features["hair_style_2"] = next_list_item(features["hair_style_2"], GLOB.hair_styles_list)
	..()


