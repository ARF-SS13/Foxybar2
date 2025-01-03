/* 
 * File:   preferences_actions.dm
 * Author: Awesome Possum (https://tgstation13.org/phpBB/memberlist.php?mode=viewprofile&u=244)
 * Date:   2019-12-10
 * License: WWW.PLAYAPOCALYPSE.COM
 * 
 * This thing takes in an action from the prefs thing and does the thing
 * */

#define MAX_FREE_PER_CAT  4
#define HANDS_SLOT_AMT    2
#define BACKPACK_SLOT_AMT 4


/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	if(lockdown)
		return
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(lockdown)
		return
	var/what_did
	var/do_vis_update = FALSE
	var/command = href_list["preference"]
	switch(command)
		// Set whether or not the action buttons are locked
		if(PREFCMD_ACTION_BUTTONS)
			TOGGLE_VAR(buttons_locked)
			what_did = PRACT_TOGGLE_INV(buttons_locked)
		// Change your limbs to be prosthetic, amputated, or normal
		if(PREFCMD_ADD_LIMB)
			what_did = AddLimbMod(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not the adminhelp sound plays (mainly just for admins)
		if(PREFCMD_ADMINHELP)
			TOGGLE_BITFIELD(toggles, SOUND_ADMINHELP)
			what_did = PRACT_TOGGLE(toggles & SOUND_ADMINHELP)
		// vore prefs
		// Toggle whether or not you can be fed prey
		if(PREFCMD_ALLOW_BEING_FED_PREY)
			TOGGLE_VAR(allow_being_fed_prey)
			what_did = PRACT_TOGGLE(allow_being_fed_prey)
		// Toggle whether or not you can be prey
		if(PREFCMD_ALLOW_BEING_PREY)
			TOGGLE_VAR(allow_being_prey)
			what_did = PRACT_TOGGLE(allow_being_prey)
		// Toggle whether or not you see messages about vore death
		if(PREFCMD_ALLOW_DEATH_MESSAGES)
			TOGGLE_VAR(allow_death_messages)
			what_did = PRACT_TOGGLE(allow_death_messages)
		// Toggle whether or not you take damage from digestion
		if(PREFCMD_ALLOW_DIGESTION_DAMAGE)
			TOGGLE_VAR(allow_digestion_damage)
			what_did = PRACT_TOGGLE(allow_digestion_damage)
		// Toggle whether or not you can die from digestion
		if(PREFCMD_ALLOW_DIGESTION_DEATH)
			TOGGLE_VAR(allow_digestion_death)
			what_did = PRACT_TOGGLE(allow_digestion_death)
		// Toggle whether or not you can hear digestion sounds
		if(PREFCMD_ALLOW_DIGESTION_SOUNDS)
			TOGGLE_VAR(allow_digestion_sounds)
			what_did = PRACT_TOGGLE(allow_digestion_sounds)
		// Toggle whether or not you can hear vore eating sounds
		if(PREFCMD_ALLOW_EATING_SOUNDS)
			TOGGLE_VAR(allow_eating_sounds)
			what_did = PRACT_TOGGLE(allow_eating_sounds)
		// Toggle whether or not you see trash messages ??
		if(PREFCMD_ALLOW_TRASH_MESSAGES)
			TOGGLE_VAR(allow_trash_messages)
			what_did = PRACT_TOGGLE(allow_trash_messages)
		// Toggle whether or not you can see vore messages in general
		if(PREFCMD_ALLOW_VORE_MESSAGES)
			TOGGLE_VAR(allow_vore_messages)
			what_did = PRACT_TOGGLE(allow_vore_messages)
		// Change the appearance of your alternate species (for pokemon, make em shiny or something)
		if(PREFCMD_ALT_PREFIX)
			do_vis_update = TRUE
			what_did = ChangeAltPrefix(user, href_list)
		// Toggle whether or not you can see the ambient occlusion
		if(PREFCMD_AMBIENTOCCLUSION)
			TOGGLE_VAR(ambientocclusion)
			if(parent && parent.screen && parent.screen.len)
				var/atom/movable/screen/plane_master/game_world/G = parent.mob.hud_used.plane_masters["[GAME_PLANE]"]
				var/atom/movable/screen/plane_master/objitem/OI = parent.mob.hud_used.plane_masters["[OBJITEM_PLANE]"]
				var/atom/movable/screen/plane_master/mob/M = parent.mob.hud_used.plane_masters["[MOB_PLANE]"]
				var/atom/movable/screen/plane_master/above_wall/A = parent.mob.hud_used.plane_masters["[ABOVE_WALL_PLANE]"]
				var/atom/movable/screen/plane_master/wall/W = parent.mob.hud_used.plane_masters["[WALL_PLANE]"]
				G.backdrop(parent.mob)
				OI.backdrop(parent.mob)
				M.backdrop(parent.mob)
				A.backdrop(parent.mob)
				W.backdrop(parent.mob)
			what_did = PRACT_TOGGLE(ambientocclusion)
		// If you're an admin, toggle whether or not you tell the rest of the admins you're logging in
		if(PREFCMD_ANNOUNCE_LOGIN)
			TOGGLE_BITFIELD(toggles, ANNOUNCE_LOGIN)
			what_did = PRACT_TOGGLE(toggles & ANNOUNCE_LOGIN)
		// Toggle whether or not you're arrousable
		if(PREFCMD_AROUSABLE)
			TOGGLE_VAR(arousable)
			what_did = PRACT_TOGGLE(arousable)
		// Toggle whether or not the viewport will auto-resize to fit the screen occasionally
		if(PREFCMD_AUTO_FIT_VIEWPORT)
			TOGGLE_VAR(auto_fit_viewport)
			if(auto_fit_viewport && parent)
				parent.fit_viewport()
			what_did = PRACT_TOGGLE(auto_fit_viewport)
		// Toggle whether or not your OOC turns on after the round? unclear
		if(PREFCMD_AUTO_OOC)
			TOGGLE_VAR(auto_ooc)
			what_did = PRACT_TOGGLE(auto_ooc)
		// Toggle whether or not you wag your tail automatically when someone pats you and calls you a good puppy
		if(PREFCMD_AUTO_WAG)
			TOGGLE_BITFIELD(cit_toggles, NO_AUTO_WAG)
			what_did = PRACT_TOGGLE_INV(cit_toggles & NO_AUTO_WAG)
		// Toggle whether or not you stand up automatically when you're downed
		if(PREFCMD_AUTOSTAND_TOGGLE)
			TOGGLE_VAR(autostand)
			what_did = PRACT_TOGGLE(autostand)
		// Change the kind of backpack you have
		if(PREFCMD_BACKPACK_KIND)
			what_did = ChangeBackpackKind(user, href_list)
		// Change the maximum number of words you'll blurble
		if(PREFCMD_BLURBLE_MAX_WORDS)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user, 
				"When you speak, a sound will be played for every word you say. \
				How many words should be the maximum before the sound stops playing? \
				Note that this only really works if the sound behavior is set to \
				Animal Crossing!",
				"Sound Indicator"
			) as null|anything in GLOB.typing_indicator_max_words_spoken_list
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the maximum words spoken to [new_input]!"))
				features_speech["typing_indicator_max_words_spoken"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change the pitch of the blurble sound
		if(PREFCMD_BLURBLE_PITCH)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				What pitch should the sound be?",
				"Sound Indicator"
			) as null|anything in GLOB.typing_indicator_pitches
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the pitch to [new_input]!"))
				features_speech["typing_indicator_pitch"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change your blurble sound
		if(PREFCMD_BLURBLE_SOUND)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				What sound should be played?",
				"Sound Indicator"
			) as null|anything in GLOB.typing_sounds
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the sound to [new_input]!"))
				features_speech["typing_indicator_sound"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change the speed of the blurble sound
		if(PREFCMD_BLURBLE_SPEED)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				How rapidly should the sound be played?",
				"Sound Indicator"
			) as null|anything in GLOB.typing_indicator_speeds
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the speed to [new_input]!"))
				features_speech["typing_indicator_speed"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change the trigger for the blurble sound
		if(PREFCMD_BLURBLE_TRIGGER)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				What should trigger the sound?",
				"Sound Indicator"
			) as null|anything in GLOB.play_methods
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the trigger to [new_input]!"))
				features_speech["typing_indicator_trigger"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change how much the blurble sound varies
		if(PREFCMD_BLURBLE_VARY)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				How much should the sound vary?",
				"Sound Indicator"
			) as null|anything in GLOB.typing_indicator_variances
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the variance to [new_input]!"))
				features_speech["typing_indicator_variance"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change the volume of the blurble sound
		if(PREFCMD_BLURBLE_VOLUME)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_input = input(
				user,
				"When you speak, a sound will be played for every word you say. \
				How loud should the sound be?",
				"Sound Indicator"
			) as null|anything in GLOB.typing_indicator_volumes
			if(new_input)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set the volume to [new_input]!"))
				features_speech["typing_indicator_volume"] = new_input
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change the model of your body, mainly for removing two (2) pixels from the sprite
		if(PREFCMD_BODY_MODEL)
			do_vis_update = TRUE
			features["body_model"] = features["body_model"] == MALE ? FEMALE : MALE
			what_did = PRACT_TOGGLE(features["body_model"] == FEMALE) // sure, female is on
		// Change the sprite of your body
		if(PREFCMD_BODY_SPRITE)
			do_vis_update = TRUE
			PlayBoop(user, BOOP_MENU_OPEN)
			var/selbodspr = input(
				user,
				"You can change what the base sprite of your character looks like! \
				Note that if you use markings, they'll probably hide this sprite. \
				However it does make a really cool looking shadekin!",
				"Body Sprite",
			) as null|anything in pref_species.allowed_limb_ids
			if(selbodspr)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set your body sprite to [selbodspr]!"))
				chosen_limb_id = selbodspr
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Toggle whether or not people can slap ur butt
		if(PREFCMD_BUTT_SLAP)
			TOGGLE_BITFIELD(cit_toggles, NO_BUTT_SLAP)
			what_did = PRACT_TOGGLE_INV(cit_toggles & NO_BUTT_SLAP)
		// Toggle whether or not you want people to know you paid for BYOND (its a good thing to do so! support the dev!)
		if(PREFCMD_BYOND_PUBLICITY)
			if(!unlock_content)
				what_did = PRACT_DIALOG_DENIED
			else
				TOGGLE_BITFIELD(toggles, MEMBER_PUBLIC)
				what_did = PRACT_TOGGLE(toggles & MEMBER_PUBLIC)
		// Change your age
		if(PREFCMD_CHANGE_AGE)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_age = input(
				user,
				"How old is your character?\n\
				([AGE_MIN] - [AGE_MAX])",
				"Character Preference"
			) as num|null
			if(new_age)
				age = clamp(numberfy(new_age), AGE_MIN, AGE_MAX)
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("You have set your age to [age]!"))
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change your flavor text
		if(PREFCMD_CHANGE_FLAVOR_TEXT)
			PlayBoop(user, BOOP_BIG_MENU_OPEN)
			var/numessage = stripped_multiline_input(
				user,
				"Set your flavor text! This is where you can describe your character's appearance, personality, \
				or anything else you want to share about them. Feel free to get juicy with it!",
				"Flavor Text",
				html_decode(features["flavor_text"]),
				MAX_FLAVOR_LEN,
				TRUE
			)
			if(!isnull(numessage))
				if(numessage == "")
					PlayBoop(user, BOOP_SUB_PROMPT)
					var/usure = alert(
						user,
						"Are you sure you want to clear your flavor text?",
						"Character Preference",
						"Yes clear it",
						"No keep it"
					)
					if(usure != "Yes clear it")
						to_chat(user, span_warning("Okay nevermind!!"))
						return PRACT_DIALOG_CANCEL
				features["flavor_text"] = numessage
				what_did = PRACT_DIALOG_ACCEPT_BIG
				to_chat(user, span_green("You have set your flavor text!"))
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change your gender
		if(PREFCMD_CHANGE_GENDER)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/chosengender = input(
				user,
				"Select a gender for your character!",
				"Gender Selection",
				gender,
			) as null|anything in list(MALE,FEMALE,"nonbinary","object")
			if(!chosengender)
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				var/bm_b4 = features["body_model"]
				switch(chosengender)
					if("nonbinary")
						chosengender = PLURAL
						features["body_model"] = pick(MALE, FEMALE)
					if("object")
						chosengender = NEUTER
						features["body_model"] = MALE
					else
						features["body_model"] = chosengender
				if(bm_b4 != features["body_model"])
					do_vis_update = TRUE
				to_chat(user, span_green("You have set your gender to [chosengender]!"))
				gender = chosengender
				what_did = PRACT_DIALOG_ACCEPT
		// Change the shape of your genitals (circle, square, etc)
		if(PREFCMD_CHANGE_GENITAL_SHAPE)
			what_did = ChangeGenitalShape(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the size of your genitals
		if(PREFCMD_CHANGE_GENITAL_SIZE)
			what_did = ChangeGenitalSize(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change who you like to kiss uwu kissu
		if(PREFCMD_CHANGE_KISSER)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newkiss = input(
				user,
				"What sort of person do you like to kiss?",
				"Character Preference"
			) as null|anything in KISS_LIST
			if(newkiss)
				kisser = newkiss
				to_chat(user, span_green("[newkiss]!"))
				what_did = PRACT_DIALOG_ACCEPT
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change your name
		if(PREFCMD_CHANGE_NAME)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_name = input(
				user,
				"What's your character's name?",
				"Character Preference"
			) as null|text
			if(isnull(new_name))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				new_name = reject_bad_name(new_name)
			if(!new_name)
				to_chat(user, span_warning("Oh no! That name is invalid! Please have a name that is at least 2 characters long and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and ."))
				what_did = PRACT_DIALOG_DENIED
			else
				real_name = new_name
				if(isnewplayer(parent.mob))
					var/mob/dead/new_player/player_mob = parent.mob
					player_mob.new_player_panel()
				what_did = PRACT_DIALOG_ACCEPT
				to_chat(user, span_green("Hi, [new_name]!"))
		// Change your OOC notes
		if(PREFCMD_CHANGE_OOC_NOTES)
			PlayBoop(user, BOOP_BIG_MENU_OPEN)
			var/numessage = stripped_multiline_input(
				user,
				"Set your OOC notes! This is where you describe anything you want others to know about yourself or your character \
				that isn't covered by the flavor text. This is a great place to list things like your preferences, limits, or \
				anything else you want to share!",
				"OOC Notes",
				html_decode(features["ooc_notes"]),
				MAX_FLAVOR_LEN,
				TRUE
			)
			if(!isnull(numessage))
				PlayBoop(user, BOOP_SUB_PROMPT)
				if(numessage == "")
					var/usure = alert(
						user,
						"Are you sure you want to clear your OOC notes?",
						"Character Preference",
						"Yes clear it",
						"No keep it"
					)
					if(usure != "Yes clear it")
						to_chat(user, span_warning("Okay nevermind!!"))
						return PRACT_DIALOG_CANCEL
				features["ooc_notes"] = numessage
				what_did = PRACT_DIALOG_ACCEPT_BIG
				to_chat(user, span_green("You have set your OOC notes!"))
			else
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Change one of your parts (horns, tails, etc)
		if(PREFCMD_CHANGE_PART)
			what_did = ChangePart(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the current slot
		if(PREFCMD_CHANGE_SLOT)
			what_did = ChangeSlot(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the current TBS
		if(PREFCMD_CHANGE_TBS)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_tbs = input(
				user,
				"Are you a top, bottom, or switch? (or none of the above)",
				"Character Preference"
			) as null|anything in TBS_LIST
			if(new_tbs)
				tbs = new_tbs
				to_chat(user, span_green("You are a [new_tbs]!"))
				what_did = PRACT_DIALOG_ACCEPT
			else
				to_chat(user, span_warning("Okay nevermind[prob(1)? ", bottom" : ""]!!"))
				what_did = PRACT_DIALOG_CANCEL
		// Apply some kind of color to somewhere
		if(PREFCMD_COLOR_CHANGE)
			what_did = ChangeColor(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Use runechat color in the chat log
		if(PREFCMD_COLOR_CHAT_LOG)
			TOGGLE_VAR(color_chat_log)
			what_did = PRACT_TOGGLE(color_chat_log)
		// Copy a color from somewhere
		if(PREFCMD_COLOR_COPY)
			what_did = CopyColor(user, href_list)
		// Delete a color from somewhere
		if(PREFCMD_COLOR_DEL)
			what_did = DeleteColor(user, href_list)
		// Paste a color to somewhere
		if(PREFCMD_COLOR_PASTE)
			what_did = PasteColor(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not the combo HUD uses lighting (i dont know what this does)
		if(PREFCMD_COMBOHUD_LIGHTING)
			TOGGLE_BITFIELD(toggles, COMBOHUD_LIGHTING)
			what_did = PRACT_TOGGLE(toggles & COMBOHUD_LIGHTING)
		// Change how much if at all the screen shakes when you take damage
		if(PREFCMD_DAMAGESCREENSHAKE_TOGGLE)
			switch(damagescreenshake)
				if(0)
					damagescreenshake = 1
				if(1)
					damagescreenshake = 2
				if(2)
					damagescreenshake = 0
				else
					damagescreenshake = 1
			what_did = PRACT_TOGGLE(damagescreenshake)
		// Edit the current eye type
		if(PREFCMD_EYE_TYPE)
			what_did = ChangeEyeType(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the style of facial hair you have
		if(PREFCMD_FACIAL_HAIR_STYLE)
			what_did = ChangeFacialHairStyle(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you have a fuzzy body
		if(PREFCMD_FUZZY)
			TOGGLE_VAR(fuzzy)
			what_did = PRACT_TOGGLE(fuzzy)
		// Toggle whether or not you can see peoples genitals when you look at them (the player, not the genitals)
		if(PREFCMD_GENITAL_EXAMINE)
			TOGGLE_BITFIELD(cit_toggles, GENITAL_EXAMINE)
			what_did = PRACT_TOGGLE(cit_toggles & GENITAL_EXAMINE)
		// Toggle whether or not you can see ghost accessories
		if(PREFCMD_GHOST_ACCS)
			var/new_ghost_accs = alert(
				user,
				"Do you want your ghost to show full accessories where possible, \
				hide accessories but still use the directional sprites where possible, \
				or also ignore the directions and stick to the default sprites?",
				"Boob Yeah",
				GHOST_ACCS_FULL_NAME,
				GHOST_ACCS_DIR_NAME,
				GHOST_ACCS_NONE_NAME
			)
			switch(new_ghost_accs)
				if(GHOST_ACCS_FULL_NAME)
					ghost_accs = GHOST_ACCS_FULL
				if(GHOST_ACCS_DIR_NAME)
					ghost_accs = GHOST_ACCS_DIR
				if(GHOST_ACCS_NONE_NAME)
					ghost_accs = GHOST_ACCS_NONE
				else
					ghost_accs = GHOST_ACCS_FULL
			what_did = PRACT_DIALOG_ACCEPT
		// Toggle whether or not you can hear people with your ghost ears
		if(PREFCMD_GHOST_EARS)
			TOGGLE_BITFIELD(chat_toggles, CHAT_GHOSTEARS)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_GHOSTEARS)
		// Change the form of your ghost
		if(PREFCMD_GHOST_FORM)
			if(!unlock_content)
				what_did = PRACT_DIALOG_DENIED
				to_chat(user, span_warning("You need to support BYOND to change your ghost form! It's a good thing to do!"))
			else
				var/new_form = input(
					user,
					"Choose your ghostly form!",
					"Thanks for supporting BYOND",
					ghost_form,
				) as null|anything in GLOB.ghost_forms
				if(isnull(new_form))
					to_chat(user, span_warning("Okay nevermind!!"))
					what_did = PRACT_DIALOG_CANCEL
				else
					ghost_form = new_form
					what_did = PRACT_DIALOG_ACCEPT
		// Change how your ghost orbits
		if(PREFCMD_GHOST_ORBIT)
			if(!unlock_content)
				what_did = PRACT_DIALOG_DENIED
				to_chat(user, span_warning("You need to support BYOND to change your ghostly orbit! It's a good thing to do!"))
			else
				var/new_orbit = input(
					user,
					"Choose your ghostly orbit!",
					"Thanks for supporting BYOND",
					ghost_orbit,
				) as null|anything in GLOB.ghost_orbits
				if(isnull(new_orbit))
					to_chat(user, span_warning("Okay nevermind!!"))
					what_did = PRACT_DIALOG_CANCEL
				else
					ghost_orbit = new_orbit
					what_did = PRACT_DIALOG_ACCEPT
		// Change how you see other ghosts
		if(PREFCMD_GHOST_OTHERS)
			var/new_ghost_others = alert(
				user,
				"Do you want the ghosts of others to show up as their own setting, \
				as their default sprites, or always as the default white ghost?",
				"Boob Yeah",
				GHOST_OTHERS_THEIR_SETTING_NAME,
				GHOST_OTHERS_DEFAULT_SPRITE_NAME,
				GHOST_OTHERS_SIMPLE_NAME
			)
			switch(new_ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING_NAME)
					ghost_others = GHOST_OTHERS_THEIR_SETTING
				if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
					ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
				if(GHOST_OTHERS_SIMPLE_NAME)
					ghost_others = GHOST_OTHERS_SIMPLE
				else
					ghost_others = GHOST_OTHERS_THEIR_SETTING
			what_did = PRACT_DIALOG_ACCEPT
		// Toggle whether or not you can see PDAs as a ghost
		if(PREFCMD_GHOST_PDA)
			TOGGLE_BITFIELD(chat_toggles, CHAT_GHOSTPDA)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_GHOSTPDA)
		// Toggle whether or not you can hear the radio as a ghost
		if(PREFCMD_GHOST_RADIO)
			TOGGLE_BITFIELD(chat_toggles, CHAT_GHOSTRADIO)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_GHOSTRADIO)
		// Toggle whether or not you can see actions as a ghost
		if(PREFCMD_GHOST_SIGHT)
			TOGGLE_BITFIELD(chat_toggles, CHAT_GHOSTSIGHT)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_GHOSTSIGHT)
		// Toggle whether or not you can hear whispers as a ghost
		if(PREFCMD_GHOST_WHISPERS)
			TOGGLE_BITFIELD(chat_toggles, CHAT_GHOSTWHISPER)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_GHOSTWHISPER)
		// Toggle whether or not you can see the gun cursor
		if(PREFCMD_GUNCURSOR_TOGGLE)
			TOGGLE_BITFIELD(cb_toggles, AIM_CURSOR_ON)
			what_did = PRACT_TOGGLE(cb_toggles & AIM_CURSOR_ON)
		// Change the first gradient of your hair
		if(PREFCMD_HAIR_GRADIENT_1)
			what_did = ChangeHairGradient(user, href_list, 1)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the second gradient of your hair
		if(PREFCMD_HAIR_GRADIENT_2)
			what_did = ChangeHairGradient(user, href_list, 2)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the style of your hair
		if(PREFCMD_HAIR_STYLE_1)
			what_did = ChangeHairStyle(user, href_list, 1)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the second style of your hair
		if(PREFCMD_HAIR_STYLE_2)
			what_did = ChangeHairStyle(user, href_list, 2)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you see smileys in the health bar
		if(PREFCMD_HEALTH_SMILEYS)
			TOGGLE_VAR(show_health_smilies)
			what_did = PRACT_TOGGLE(show_health_smilies)
		// Toggle if a genital is hidden by clothes and or by undies
		if(PREFCMD_HIDE_GENITAL)
			what_did = ToggleGenitalHide(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you can see the hotkey help
		if(PREFCMD_HOTKEY_HELP)
			TOGGLE_VAR(keybind_hotkey_helpmode)
			what_did = PRACT_TOGGLE(keybind_hotkey_helpmode)
		// Toggle hotkey mode!
		if(PREFCMD_HOTKEYS)
			TOGGLE_VAR(hotkeys)
			user.client.ensure_keys_set(src)
			what_did = PRACT_TOGGLE(hotkeys)
		// Toggle whether or not the HUD flashes whenever it feels like it
		if(PREFCMD_HUD_TOGGLE_FLASH)
			TOGGLE_VAR(hud_toggle_flash)
			what_did = PRACT_TOGGLE(hud_toggle_flash)
		// Toggle whether or not you can hear people spam the hunting horn
		if(PREFCMD_HUNTINGHORN)
			TOGGLE_BITFIELD(toggles, SOUND_HUNTINGHORN)
			what_did = PRACT_TOGGLE(toggles & SOUND_HUNTINGHORN)
		// Toggle whether or not you see income updates
		if(PREFCMD_INCOME_UPDATES)
			TOGGLE_BITFIELD(chat_toggles, CHAT_BANKCARD)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_BANKCARD)
		// Change which key turns on the loser bar
		if(PREFCMD_INPUT_MODE_HOTKEY)
			if(input_mode_hotkey == "Tab")
				input_mode_hotkey = "Ctrl+Tab"
			else
				input_mode_hotkey = "Tab"
			parent.change_input_toggle_key(input_mode_hotkey, send_chat = TRUE)
			what_did = PRACT_TOGGLE(input_mode_hotkey == "Tab")
		// The game wants to record a keypress!
		if(PREFCMD_KEYBINDING_CAPTURE)
			CaptureKeybinding(user, href_list)
		// Actually record the keypress
		if(PREFCMD_KEYBINDING_SET)
			what_did = KeybindingSet(user, href_list)
		// Toggle whether or not you can see the category of a keybinding
		if(PREFCMD_KEYBINDING_CATEGORY_TOGGLE)
			what_did = ToggleKeybindingCategory(user, href_list)
		// Change the legs of your character
		if(PREFCMD_LEGS)
			what_did = ChangeLegs(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the category of your loadout
		if(PREFCMD_LOADOUT_CATEGORY)
			what_did = ChangeLoadoutCategory(user, href_list)
		// Change the description of your loadout
		if(PREFCMD_LOADOUT_REDESC)
			what_did = ChangeLoadoutDescription(user, href_list)
		// Change the name of your loadout
		if(PREFCMD_LOADOUT_RENAME)
			what_did = ChangeLoadoutName(user, href_list)
		// Reset your loadout
		if(PREFCMD_LOADOUT_RESET)
			what_did = ResetLoadout(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Ask for something to set the search to
		if(PREFCMD_LOADOUT_SEARCH)
			what_did = EnterSearchTerm(user, href_list)
		// Clear the search term for your loadout
		if(PREFCMD_LOADOUT_SEARCH_CLEAR)
			what_did = ClearLoadoutSearch(user, href_list)
		// Change the subcategory of your loadout
		if(PREFCMD_LOADOUT_SUBCATEGORY)
			what_did = ChangeLoadoutSubcategory(user, href_list)
		// (De)select something for your loadout!
		if(PREFCMD_LOADOUT_TOGGLE)
			what_did = ToggleLoadoutItem(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle if you can hear the lobby music
		if(PREFCMD_LOBBY_MUSIC)
			TOGGLE_BITFIELD(toggles, SOUND_LOBBY)
			what_did = PRACT_TOGGLE(toggles & SOUND_LOBBY)
		// Add a marking to your character
		if(PREFCMD_MARKING_ADD)
			what_did = AddMarking(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Edit a marking on your character
		if(PREFCMD_MARKING_EDIT)
			what_did = EditMarking(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Move a marking down on your character
		if(PREFCMD_MARKING_MOVE_DOWN)
			what_did = ShiftMarking(user, href_list, "down")
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Move a marking up on your character
		if(PREFCMD_MARKING_MOVE_UP)
			what_did = ShiftMarking(user, href_list, "up")
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Move to the next marking on your character
		if(PREFCMD_MARKING_NEXT)
			href_list[PREFDAT_GO_NEXT] = TRUE
			what_did = EditMarking(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Move to the previous marking on your character
		if(PREFCMD_MARKING_PREV)
			href_list[PREFDAT_GO_PREV] = TRUE
			what_did = EditMarking(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Remove a marking from your character
		if(PREFCMD_MARKING_REMOVE)
			what_did = RemoveMarking(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle the master vore switch
		if(PREFCMD_MASTER_VORE_TOGGLE)
			TOGGLE_VAR(master_vore_toggle)
			what_did = PRACT_TOGGLE(master_vore_toggle)
		// Change the maximum length of a runechat message
		if(PREFCMD_MAX_CHAT_LENGTH)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/desiredlength = input(
				user, 
				"Runechat is a system that shows big blocks of text on screen whenever something speaks or emotes. \
				When one is shown, how many characters maximum should it be? \
				(Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))",
				"Character Preference",
				max_chat_length
			) as null|num
			if(isnull(desiredlength))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)
				to_chat(user, span_green("You have set the maximum runechat length to [max_chat_length]!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the maximum height of a PFP
		if(PREFCMD_MAX_PFP_HEIGHT)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newhight = input(
				user,
				"When you examine other players, a profile image is typically shown. \
				These images can be quite big, so they are scaled down to a maximum height. \
				How many pixels tall should profile examine images be when you see them?",
				"Character Preference",
				see_pfp_max_hight
			) as null|num
			if(isnull(newhight))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				see_pfp_max_hight = newhight
				to_chat(user, span_green("You have set the maximum profile image height to [see_pfp_max_hight]!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the maximum width percent of a PFP
		if(PREFCMD_MAX_PFP_WIDTH)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newhight = input(
				user,
				"When you examine other players, a profile image is typically shown. \
				These images can be quite big, so they are scaled down to a maximum width. \
				This width is measured as a percentage of the chat window. \
				How many percent wide should profile examine images be when you see them?",
				"Character Preference",
				see_pfp_max_widht
			) as null|num
			if(isnull(newhight))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				see_pfp_max_widht = newhight
				to_chat(user, span_green("You have set the maximum profile image width percent to [see_pfp_max_widht]!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the type of meat you are
		if(PREFCMD_MEAT_TYPE)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newmeat = input(
				user,
				"What kind of meat are you?",
				"Character Preference",
				features["meat_type"]
			) as null|anything in GLOB.meat_types
			if(isnull(newmeat))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				features["meat_type"] = newmeat
				to_chat(user, span_green("You are [features["meat_type"]] meat!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the MIDI that plays when you die
		if(PREFCMD_MIDIS)
			TOGGLE_BITFIELD(toggles, SOUND_MIDI)
			what_did = PRACT_TOGGLE(toggles & SOUND_MIDI)
		// Toggle whether or not you see mismatched markings
		if(PREFCMD_MISMATCHED_MARKINGS)
			TOGGLE_VAR(show_mismatched_markings)
			what_did = PRACT_TOGGLE(show_mismatched_markings)
		// Modify a limb
		if(PREFCMD_MODIFY_LIMB)
			what_did = ModifyLimbMod(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Remove a limb modification
		if(PREFCMD_REMOVE_LIMB)
			what_did = RemoveLimbMod(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you can see offscreen runechats
		if(PREFCMD_OFFSCREEN)
			TOGGLE_VAR(see_fancy_offscreen_runechat)
			what_did = PRACT_TOGGLE(see_fancy_offscreen_runechat)
		// Change whether or not the genital is always show, never show, or show when unclothered
		if(PREFCMD_OVERRIDE_GENITAL)
			what_did = OverrideGenital(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the kind of PDA you have
		if(PREFCMD_PDA_KIND)
			what_did = ChangePDAKind(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the ringtone of your PDA
		if(PREFCMD_PDA_RINGTONE)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_ringtone = stripped_input(
				user,
				"When someone sends a message to your DataPal, it'll say something! \
				What would you like it to say?",
				"Character Preference",
				pda_ringmessage,
				30
			)
			if(isnull(new_ringtone))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else if(trim(new_ringtone) == "")
				pda_ringmessage = initial(pda_ringmessage)
			to_chat(user, span_green("You have set your DataPal ringtone to [pda_ringmessage]!"))
			what_did = PRACT_DIALOG_ACCEPT
		// Change the whitelist for the PHUD
		if(PREFCMD_PHUD_WHITELIST)
			what_did = ChangePHUDWhitelist(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change your default X pixel offset
		if(PREFCMD_PIXEL_X)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newx = input(
				user,
				"You can have your character be, by default, offset to the left or right by a certain number of pixels. \
				How many pixels would you like to offset your character? \
				Positive numbers move your character to the right, negative numbers move your character to the left. \
				(Valid range is [PIXELSHIFT_MIN] to [PIXELSHIFT_MAX] )",
				"Character Preference",
				custom_pixel_x
			) as null|num
			if(isnull(newx))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				custom_pixel_x = round(clamp(newx, PIXELSHIFT_MIN, PIXELSHIFT_MAX), 1)
				to_chat(user, span_green("You have set your default left/right pixel offset to [custom_pixel_x]!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change your default Y pixel offset
		if(PREFCMD_PIXEL_Y)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newy = input(
				user,
				"You can have your character be, by default, offset up or down by a certain number of pixels. \
				How many pixels would you like to offset your character? \
				Positive numbers move your character up, negative numbers move your character down. \
				(Valid range is [PIXELSHIFT_MIN] to [PIXELSHIFT_MAX] )",
				"Character Preference",
				custom_pixel_y
			) as null|num
			if(isnull(newy))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				custom_pixel_y = round(clamp(newy, PIXELSHIFT_MIN, PIXELSHIFT_MAX), 1)
				to_chat(user, span_green("You have set your default up/down pixel offset to [custom_pixel_y]!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Toggle whether or not you can see pull requests
		if(PREFCMD_PULL_REQUESTS)
			TOGGLE_BITFIELD(chat_toggles, CHAT_PULLR)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_PULLR)
		// Toggle whether or not you can hear radio blurbles
		if(PREFCMD_RADIO_BLURBLES)
			TOGGLE_BITFIELD(chat_toggles, CHAT_HEAR_RADIOBLURBLES)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_HEAR_RADIOBLURBLES)
		// Toggle whether or not you can hear radio static
		if(PREFCMD_RADIO_STATIC)
			TOGGLE_BITFIELD(chat_toggles, CHAT_HEAR_RADIOSTATIC)
			what_did = PRACT_TOGGLE(chat_toggles & CHAT_HEAR_RADIOSTATIC)
		// Toggle whether or not you gots rainbow blood
		if(PREFCMD_RAINBOW_BLOOD)
			if(features["blood_color"] != "rainbow")
				features["blood_color"] = "rainbow"
				to_chat(user, span_green("You have rainbow blood!"))
				what_did = PRACT_TOGGLE(TRUE)
			else
				features["blood_color"] = "FFFFFF"
				to_chat(user, span_green("You have normal blood!"))
				what_did = PRACT_TOGGLE(FALSE)
		// Save your preferences
		if(PREFCMD_SAVE)
			if(!save_preferences())
				alert(
					user,
					"OH NO! Something went wrong while saving your preferences! \
					Something seriously wrong happened, maybe! Please, close the game and \
					contact a staff member to help you out! Error code: THAT ONE DJ PONY'S BUTT",
					"Character Preference",
					"Okay",
					"Oh no!"
				)
			else if(!save_character())
				alert(
					user,
					"OH NO! Something went wrong while saving your character! \
					Something seriously wrong happened, maybe! Please, close the game and \
					contact a staff member to help you out! Error code: THE PONY WITH THE WIERD EYES' BUTT",
					"Character Preference",
					"Okay",
					"Oh no!"
				)
			else
				to_chat(user, span_green("SAVE OK!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the scale of your character
		if(PREFCMD_SCALE)
			what_did = ChangeScale(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you get permascars
		if(PREFCMD_SCARS)
			TOGGLE_VAR(persistent_scars)
			what_did = PRACT_TOGGLE(persistent_scars)
		// Clear all your permascars
		if(PREFCMD_SCARS_CLEAR)
			scars_list["1"] = ""
			scars_list["2"] = ""
			scars_list["3"] = ""
			scars_list["4"] = ""
			scars_list["5"] = ""
			to_chat(user, span_notice("You have cleared all of your permanent scars!"))
			what_did = PRACT_DIALOG_ACCEPT
		// Toggle whether or not you can see runechat from non-mobs
		if(PREFCMD_SEE_CHAT_NON_MOB)
			TOGGLE_VAR(see_chat_non_mob)
			what_did = PRACT_TOGGLE(see_chat_non_mob)
		// Toggle whether or not you can see certain genitals
		if(PREFCMD_SEE_GENITAL)
			what_did = ToggleGenitalCanSee(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you can see RC emotes
		if(PREFCMD_SEE_RC_EMOTES)
			TOGGLE_VAR(see_rc_emotes)
			what_did = PRACT_TOGGLE(see_rc_emotes)
		// Change the subsubcategory of the prefs menu
		if(PREFCMD_SET_SUBSUBTAB)
			what_did = SetSubSubTab(user, href_list)
		// Change the subcategory of the prefs menu
		if(PREFCMD_SET_SUBTAB)
			what_did = SetSubTab(user, href_list)
		// Change the category of the prefs menu
		if(PREFCMD_SET_TAB)
			what_did = SetMainTab(user, href_list)
		// Shift the genital
		if(PREFCMD_SHIFT_GENITAL)
			what_did = ShiftGenital(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Show this many characters in the character list
		if(PREFCMD_SHOW_THIS_MANY_CHARS)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/newchars = input(
				user,
				"How many character slots do you want to be able to see? This will just \
				hide the rest, they'll still be there when you change this back later. \
				(1-[max_save_slots])",
				"Character Preference",
				show_this_many
			) as null|num
			if(isnull(newchars))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				show_this_many = clamp(newchars, 1, max_save_slots)
				to_chat(user, span_green("You will now see [show_this_many] character slots!"))
				what_did = PRACT_DIALOG_ACCEPT
		// Change the skin tone of your character
		if(PREFCMD_SKIN_TONE)
			what_did = ChangeSkinTone(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Copy a character slot to your clopboard uwu princess plotlestia
		if(PREFCMD_SLOT_COPY)
			what_did = CopySlot(user, href_list)
		// Delete a character slot
		if(PREFCMD_SLOT_DELETE)
			what_did = DeleteSlot(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Paste a character slot from your clopboard uwu princess poona
		if(PREFCMD_SLOT_PASTE)
			what_did = PasteSlot(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change your socks!
		if(PREFCMD_SOCKS)
			what_did = ChangeSocks(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Set if your socks are over your clothes or something
		if(PREFCMD_SOCKS_OVERCLOTHES)
			socks_overclothes++
			if(socks_overclothes > UNDERWEAR_OVER_EVERYTHING)
				socks_overclothes = UNDERWEAR_UNDER_CLOTHES
			what_did = PRACT_TOGGLE(TRUE)
			do_vis_update = TRUE
		// Change the species of your character
		if(PREFCMD_SPECIES)
			what_did = ChangeSpecies(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the name of your species
		if(PREFCMD_SPECIES_NAME)
			var/spename = input(
				user,
				"What is your character's species called?",
				"Character Preference",
				custom_species
			) as null|text
			if(isnull(spename))
				to_chat(user, span_warning("Okay nevermind!!"))
			spename = reject_bad_name(spename)
			if(spename)
				custom_species = spename
				to_chat(user, span_green("Your species is now called [custom_species]!"))
			else
				custom_species = null
				to_chat(user, span_green("Your species name is the default!"))
			what_did = PRACT_DIALOG_ACCEPT
		// Split the admin tabs
		if(PREFCMD_SPLIT_ADMIN_TABS)
			TOGGLE_BITFIELD(toggles, SPLIT_ADMIN_TABS)
			what_did = PRACT_TOGGLE(toggles & SPLIT_ADMIN_TABS)
		// Toggle the sprint buffer
		if(PREFCMD_SPRINTBUFFER)
			TOGGLE_BITFIELD(toggles, SOUND_SPRINTBUFFER)
			what_did = PRACT_TOGGLE(toggles & SOUND_SPRINTBUFFER)
		// Change the stat of ur character
		if(PREFCMD_STAT_CHANGE)
			what_did = ChangeStats(user, href_list)
		// Change the taste of your character
		if(PREFCMD_TASTE)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/new_taste = input(
				user,
				"What does your character taste like?",
				"Character Preference",
				features["taste"]
			) as null|text
			if(isnull(new_taste))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			new_taste = reject_bad_name(new_taste)
			if(new_taste)
				features["taste"] = new_taste
				to_chat(user, span_green("Your character tastes like [features["taste"]]!"))
			else
				features["taste"] = "something"
				to_chat(user, span_green("Your character tastes like something!"))
			what_did = PRACT_DIALOG_ACCEPT
		// Toggle the tetris storage
		if(PREFCMD_TETRIS_STORAGE_TOGGLE)
			TOGGLE_VAR(no_tetris_storage)
			what_did = PRACT_TOGGLE_INV(no_tetris_storage)
		// Toggle the fancy TGUI
		if(PREFCMD_TGUI_FANCY)
			TOGGLE_VAR(tgui_fancy)
			what_did = PRACT_TOGGLE(tgui_fancy)
		// Toggle the lock on the TGUI
		if(PREFCMD_TGUI_LOCK)
			TOGGLE_VAR(tgui_lock)
			what_did = PRACT_TOGGLE(tgui_lock)
		// Toggle whether or not you have a certain genital
		if(PREFCMD_TOGGLE_GENITAL)
			what_did = ToggleGenital(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle whether or not you can see the character list
		if(PREFCMD_TOGGLE_SHOW_CHARACTER_LIST)
			TOGGLE_VAR(charlist_hidden)
			what_did = PRACT_TOGGLE(charlist_hidden)
		// Change the style of the UI
		if(PREFCMD_UI_STYLE)
			PlayBoop(user, BOOP_MENU_OPEN)
			var/pickedui = input(
				user,
				"What kind of UI would you like?",
				"Character Preference",
				UI_style
			) as null|anything in GLOB.available_ui_styles
			if(isnull(pickedui))
				to_chat(user, span_warning("Okay nevermind!!"))
				what_did = PRACT_DIALOG_CANCEL
			else
				UI_style = pickedui
				if(parent && parent.mob && parent.mob.hud_used)
					parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
			what_did = PRACT_DIALOG_ACCEPT
		// Change the undershirt of your character
		if(PREFCMD_UNDERSHIRT)
			what_did = ChangeUndershirt(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the undershirt of your character
		if(PREFCMD_UNDERSHIRT_OVERCLOTHES)
			undershirt_overclothes++
			if(undershirt_overclothes > UNDERWEAR_OVER_EVERYTHING)
				undershirt_overclothes = UNDERWEAR_UNDER_CLOTHES
			what_did = PRACT_TOGGLE(TRUE)
			do_vis_update = TRUE
		// Change the underwear of your character
		if(PREFCMD_UNDERWEAR)
			what_did = ChangeUnderwear(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Change the underwear of your character
		if(PREFCMD_UNDERWEAR_OVERCLOTHES)
			undies_overclothes++
			if(undies_overclothes > UNDERWEAR_OVER_EVERYTHING)
				undies_overclothes = UNDERWEAR_UNDER_CLOTHES
			what_did = PRACT_TOGGLE(TRUE)
			do_vis_update = TRUE
		// Undo the last thing you did
		if(PREFCMD_UNDO)
			load_preferences()
			load_character()
			to_chat(user, span_green("You have undone your changes!"))
			what_did = PRACT_DIALOG_ACCEPT
		// Change the whether you can hear sounds and runechats on floors above or below you
		// if(PREFCMD_UPPERLOWERFLOOR)
		// 	TOGGLE_VAR(upperlowerfloor)
		// 	what_did = PRACT_TOGGLE(upperlowerfloor)
		// 	do_vis_update = TRUE
		// Open the VChat window
		if(PREFCMD_VCHAT)
			PlayBoop(user, BOOP_MENU_OPEN)
			SSchat.HornyPreferences(user)
			what_did = PRACT_DIALOG_ACCEPT
		// Toggle widescreen mode
		if(PREFCMD_WIDESCREEN_TOGGLE)
			TOGGLE_VAR(widescreenpref)
			user.client.change_view(CONFIG_GET(string/default_view))
			what_did = PRACT_TOGGLE(widescreenpref)
		// Change the width of your character
		if(PREFCMD_WIDTH)
			what_did = ChangeWidth(user, href_list)
			if(WasAccept(what_did))
				do_vis_update = TRUE
		// Toggle Winflash!
		if(PREFCMD_WINFLASH)
			TOGGLE_VAR(windowflashing)
			what_did = PRACT_TOGGLE(windowflashing)

	var/boob
	switch(what_did) // play some sounds!
		if(PRACT_DIALOG_ACCEPT)
			boob = BOOP_ACCEPT
		if(PRACT_DIALOG_ACCEPT_BIG)
			boob = BOOP_ACCEPT_BIG
		if(PRACT_DIALOG_ACCEPT_SMOL)
			boob = BOOP_ACCEPT_SMOL
		if(PRACT_DIALOG_CANCEL)
			boob = BOOP_CANCEL
		if(PRACT_DIALOG_DENIED)
			boob = BOOP_DENIED
		if(PRACT_DIALOG_ERROR)
			boob = BOOP_ERROR
	if(boob)
		PlayBoop(user, boob)
	// post stuff do
	ShowChoices(user, do_vis_update)

/// Try to let the player add a limb modification to their character
/datum/preferences/proc/AddLimbMod(mob/user, list/href_list)
	var/list/moddable_limbs = LOADOUT_ALLOWED_LIMB_TARGETS
	for(var/limb in modified_limbs)
		moddable_limbs -= limb
	if(LAZYLEN(moddable_limbs) <= 0)
		to_chat(user, span_warning("All of your limbs are already modified!"))
		return PRACT_DIALOG_DENIED
	PlayBoop(user, BOOP_MENU_OPEN)
	// make the moddable limbs have actual names
	var/limb_names = list()
	for(var/limb_key in moddable_limbs)
		var/thename = GLOB.main_body_parts2words[limb_key]
		thename = capitalize_all(thename)
		limb_names[thename] = limb_key
	
	var/which_limb = input(
		user,
		"Which limb would you like to modify?",
		"Character Preference"
	) as null|anything in limb_names
	if(!which_limb)
		return PRACT_DIALOG_CANCEL
	PlayBoop(user, BOOP_SUB_PROMPT)
	var/mod_type = input(
		user,
		"What would you like to do with your [which_limb]?",
		"Character Preference"
	) as null|anything in LOADOUT_LIMBS
	if(!mod_type)
		return PRACT_DIALOG_CANCEL
	switch(mod_type)
		if(LOADOUT_LIMB_PROSTHETIC)
			PlayBoop(user, BOOP_SUB_PROMPT)
			return AddProsthetic(user, which_limb, mod_type)
		if(LOADOUT_LIMB_AMPUTATED)
			modified_limbs[which_limb] = list(mod_type)
			to_chat(user, span_green("You have amputated your [which_limb]!"))
			return PRACT_DIALOG_ACCEPT
		if(LOADOUT_LIMB_NORMAL)
			modified_limbs -= which_limb
			to_chat(user, span_green("You have restored your [which_limb]!"))
			return PRACT_DIALOG_ACCEPT
	return PRACT_DIALOG_CANCEL

/// Try to let the player add a prosthetic to their character
/datum/preferences/proc/AddProsthetic(mob/user, which_limb, mod_type)
	var/prosthetic_type = input(
		user,
		"Choose the type of prosthetic for your [which_limb]",
		"Character Preference"
	) as null|anything in (list("prosthetic") + GLOB.prosthetic_limb_types)
	if(!prosthetic_type)
		return PRACT_DIALOG_CANCEL
	// var/prosthetic_count = 0
	// for(var/modified_limb in modified_limbs)
	// 	if(modified_limbs[modified_limb][1] == LOADOUT_LIMB_PROSTHETIC && modified_limb != which_limb)
	// 		prosthetic_count += 1
	// if(prosthetic_count > MAXIMUM_LOADOUT_PROSTHETICS)
	// 	to_chat(user, span_danger("You can only have up to two prosthetic limbs!"))
	// 	return PRACT_DIALOG_DENIED
	// else
	//save the actual prosthetic data
	modified_limbs[which_limb] = list(mod_type, prosthetic_type)
	to_chat(user, span_green("You have added a prosthetic [which_limb]!"))
	return PRACT_DIALOG_ACCEPT

/// Modify a limb
/datum/preferences/proc/ModifyLimbMod(mob/user, list/href_list)
	var/list/modified_limbs = features["modified_limbs"]
	if(LAZYLEN(modified_limbs) <= 0)
		to_chat(user, span_warning("You have no modified limbs to change!"))
		return PRACT_DIALOG_DENIED
	PlayBoop(user, BOOP_MENU_OPEN)
	var/which = href_list[PREFDAT_MODIFY_LIMB_MOD]
	var/list/modded_limb = modified_limbs[which]
	if(!modded_limb)
		to_chat(user, span_warning("That limb isn't modified!"))
		return PRACT_DIALOG_DENIED
	if(modded_limb[1] == LOADOUT_LIMB_AMPUTATED)
		to_chat(user, span_warning("There isn't much to modify about an amputated limb! Try removing it (which is to say, restore it) instead!"))
		return PRACT_DIALOG_DENIED
	return AddLimbMod(user, href_list) // it'll remove it for us

/// Remove a limb modification
/datum/preferences/proc/RemoveLimbMod(mob/user, list/href_list)
	var/list/modified_limbs = features["modified_limbs"]
	if(LAZYLEN(modified_limbs) <= 0)
		to_chat(user, span_warning("You have no modified limbs to remove!"))
		return PRACT_DIALOG_DENIED
	PlayBoop(user, BOOP_MENU_OPEN)
	var/which = href_list[PREFDAT_REMOVE_LIMB_MOD]
	var/list/modded_limb = modified_limbs[which]
	if(!modded_limb)
		to_chat(user, span_warning("That limb isn't modified!"))
		return PRACT_DIALOG_DENIED
	modified_limbs -= which
	to_chat(user, span_green("Your [which] is back to normal!"))
	return PRACT_DIALOG_ACCEPT

/// Change the alt prefix of the user
/datum/preferences/proc/ChangeAltPrefix(mob/user, list/href_list)
	if(!LAZYLEN(pref_species.alt_prefixes))
		alt_appearance = "Default"
		to_chat(user, span_warning("You have no alternate appearances to choose from!"))
		return PRACT_DIALOG_DENIED
	var/pickfrom = list("Default" = "")
	pickfrom |= pref_species.alt_prefixes
	PlayBoop(user, BOOP_MENU_OPEN)
	var/result = input(
		user,
		"Select an alternate species appearance! Or press cancel to clear it.",
		"Character Preference"
	) as null|anything in pickfrom
	if(isnull(result) || result == "")
		alt_appearance = "Default"
		to_chat(user, span_green("You have cleared your alternate appearance!"))
		return PRACT_DIALOG_ACCEPT
	alt_appearance = result
	to_chat(user, span_green("You have set your alternate appearance to [result]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the backpack kind of the user
/datum/preferences/proc/ChangeBackpackKind(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/backbag = input(
		user,
		"Choose the kind of backpack you'd like to use!",
		"Character Preference"
	) as null|anything in GLOB.backbaglist
	if(isnull(backbag))
		return PRACT_DIALOG_CANCEL
	to_chat(user, span_green("You have set your backpack to [backbag]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the shape of the user's genitals
/datum/preferences/proc/ChangeGenitalShape(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/haspart = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[haspart]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: FLUTTERSHY'S BUTT"))
		return PRACT_DIALOG_ERROR
	if(!CHECK_BITFIELD(GD.genital_flags, GENITAL_CAN_RESHAPE))
		to_chat(user, span_warning("[GD.name] can't be reshaped! :("))
		return PRACT_DIALOG_DENIED
	var/list/shape_list = GD.shapelist
	if(!LAZYLEN(shape_list))
		to_chat(user, span_warning("This genital is set to be reshapable, but there arent any shapes! something went wrong :( error code: RARITY'S BUTT"))
		return PRACT_DIALOG_ERROR
	var/new_shape = input(
		user,
		"How would you like your [GD.name] to look?",
		"Character Preference"
	) as null|anything in shape_list
	if(isnull(new_shape))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	// save the new shape
	features[GD.shape_key] = new_shape
	to_chat(user, span_green("Congratulations! Your [GD.name] looks like \a [new_shape] now!"))
	return PRACT_DIALOG_ACCEPT

/// Change the size of the user's genitals
/datum/preferences/proc/ChangeGenitalSize(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/haspart = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[haspart]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: RAINBOW DASH'S BUTT"))
		return PRACT_DIALOG_ERROR
	if(!CHECK_BITFIELD(GD.genital_flags, GENITAL_CAN_RESIZE))
		to_chat(user, span_warning("[GD.name] can't be resized! :("))
		return PRACT_DIALOG_DENIED
	// now this can be either a number range or a list (thanks boobs)
	var/size_list = GD.sizelist
	var/new_size
	if(LAZYLEN(size_list))
		new_size = input(
			user,
			"How big would you like your [GD.name] to be? (in [GD.size_units])",
			"Character Preference"
		) as null|anything in size_list
	else if(GD.size_min && GD.size_max)
		new_size = input(
			user,
			"How big would you like your [GD.name] to be? ([GD.size_min] - [GD.size_max] [GD.size_units])",
			"Character Preference"
		) as null|num
		if(new_size)
			new_size = clamp(new_size, GD.size_min, GD.size_max)
	if(isnull(new_size))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	// save the new size
	features[GD.size_key] = new_size
	to_chat(user, span_green("Congratulations! Your [GD.name] is now \a [GD.SizeString(new_size)]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the slot!
/datum/preferences/proc/ChangeSlot(mob/user, list/href_list)
	var/new_slot = numberfy(href_list[PREFDAT_SLOT])
	if(new_slot == default_slot)
		return PRACT_DIALOG_CANCEL
	var/haz_character = load_character(new_slot)
	if(!haz_character)
		initialize_preferences()
		random_character()
		real_name = random_unique_name(gender)
		save_character()
		to_chat(user, span_green("Welcome to life, [real_name]!"))
	if(isnewplayer(parent.mob))
		var/mob/dead/new_player/player_mob = parent.mob
		player_mob.new_player_panel()
	return PRACT_DIALOG_ACCEPT

/// Change a part of the user
/datum/preferences/proc/ChangePart(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/partkind = href_list[PREFDAT_PARTKIND]
	var/list/optionslist
	var/list/blank_others
	var/blank_with
	var/specialy
	var/kindname
	/// now for everyone's favorite: look up tables!
	switch(partkind)
		if(BPART_DECO_WINGS)
			optionslist = GLOB.deco_wings_list
			kindname = "decorative wings"
		if(BPART_DERG_BELLY)
			optionslist = GLOB.derg_belly_list
			kindname = "dragon belly style"
		if(BPART_DERG_BODY)
			optionslist = GLOB.derg_body_list
			kindname = "dragon body style"
		if(BPART_DERG_EARS)
			optionslist = GLOB.derg_ear_list
			kindname = "dragon ears"
		if(BPART_DERG_EYES)
			optionslist = GLOB.derg_eye_list
			kindname = "dragon eyes"
		if(BPART_DERG_HORNS)
			optionslist = GLOB.derg_horn_list
			kindname = "dragon horns"
		if(BPART_DERG_MANE)
			optionslist = GLOB.derg_mane_list
			kindname = "dragon mane"
		if(BPART_EARS)
			optionslist = GLOB.ears_list
			kindname = "ears"
			specialy = TRUE
		if(BPART_FRILLS)
			optionslist = GLOB.frills_list
			kindname = "frills"
		if(BPART_HORNS)
			optionslist = GLOB.horns_list
			kindname = "horns"
		if(BPART_INSECT_FLUFF)
			optionslist = GLOB.insect_fluffs_list
			kindname = "bug fluff"
		if(BPART_INSECT_MARKINGS)
			optionslist = GLOB.insect_markings_list
			kindname = "bug markings"
		if(BPART_INSECT_WINGS)
			optionslist = GLOB.insect_wings_list
			kindname = "bug wings"
		if(BPART_IPC_ANTENNA)
			optionslist = GLOB.ipc_antennas_list
			kindname = "robot antenna"
			specialy = TRUE
		if(BPART_IPC_SCREEN)
			optionslist = GLOB.ipc_screens_list
			kindname = "robot screen"
		if(BPART_MAM_EARS)
			optionslist = GLOB.mam_ears_list
			kindname = "furry ears"
			specialy = TRUE
		if(BPART_MAM_SNOUTS)
			optionslist = GLOB.mam_snouts_list
			kindname = "furry snouts"
			specialy = TRUE
			blank_others = list("snout")
			blank_with = "None"
		if(BPART_MAM_TAIL)
			optionslist = GLOB.mam_tails_list
			kindname = "furry tails"
			specialy = TRUE
			blank_others = list("taur", "tail_human", "tail_lizard", "xenotail")
			blank_with = "None"
		if(BPART_SNOUT)
			optionslist = GLOB.snouts_list
			kindname = "snouts"
			specialy = TRUE
			blank_others = list("mam_snouts")
			blank_with = "None"
		if(BPART_SPINES)
			optionslist = GLOB.spines_list
			kindname = "spines"
		if(BPART_TAIL_HUMAN)
			optionslist = GLOB.tails_list_human
			kindname = "human tails"
			specialy = TRUE
			blank_others = list("taur", "tail_lizard", "mam_tail", "xenotail")
			blank_with = "None"
		if(BPART_TAIL_LIZARD)
			optionslist = GLOB.tails_list_lizard
			kindname = "lizard tails"
			blank_others = list("taur", "tail_human", "mam_tail", "xenotail")
			blank_with = "None"
		if(BPART_TAUR)
			optionslist = GLOB.taur_list
			kindname = "tauric body"
			specialy = TRUE
			blank_others = list("mam_tail", "xenotail", "tail_human", "tail_lizard")
			blank_with = "None"
		if(BPART_WINGS)
			optionslist = GLOB.wings_list
			kindname = "wings"
		if(BPART_XENODORSAL)
			optionslist = GLOB.xeno_dorsal_list
			kindname = "alien dorsal"
		if(BPART_XENOHEAD)
			optionslist = GLOB.xeno_head_list
			kindname = "alien head"
		if(BPART_XENOTAIL)
			optionslist = GLOB.xeno_tail_list
			kindname = "alien tail"
			specialy = TRUE
			blank_others = list("mam_tail", "taur", "tail_human", "tail_lizard")
			blank_with = "None"
	// now we have the options list, let's get the user to pick one
	// just kidding, we need to do special stuff to special stuff first
	if(specialy)
		var/list/newlist = list()
		for(var/path in optionslist)
			var/datum/sprite_accessory/instance = optionslist[path]
			if(istype(instance, /datum/sprite_accessory))
				var/datum/sprite_accessory/S = instance
				if(!(S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
					newlist[path] = S.name
		optionslist = newlist
	if(LAZYLEN(optionslist) <= 0)
		to_chat(user, span_warning("There don't seem to be any options for [kindname]! Huh."))
		return PRACT_DIALOG_DENIED
	// now we can actually get the user to pick one
	// just kidding, we need to handle the previous and next buttons first
	var/first_try = ShiftAdjustment(user, optionslist, features[partkind], href_list)
	if(first_try)
		features[partkind] = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_thing = input(
		user,
		"Choose your character's [kindname]!",
		"Character Preference"
	) as null|anything in optionslist
	if(isnull(new_thing))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	features[partkind] = new_thing
	if(blank_others)
		for(var/other in blank_others)
			features[other] = blank_with
	to_chat(user, span_green("You have set your [kindname] to [new_thing]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the color of something on the user
/datum/preferences/proc/ChangeColor(mob/user, list/href_list = list())
	PlayBoop(user, BOOP_MENU_OPEN)
	// this proc is a bit more complicated than the others
	// first, get us a color, we'll figure out where it goes later
	var/new_color = input(
		user,
		"Choose a color!",
		"Character Preference"
	) as null|color
	// easy part's done, now we need to--
	if(isnull(new_color))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	// --figure out where it goes
	// first, check if the color is for a marking or gear item
	if(href_list[PREFDAT_IS_MARKING])
		// find the marking by its uid
		var/muid = href_list[PREFDAT_MARKING_UID]
		for(var/list/mark in features["mam_body_markings"])
			if(LAZYLEN(mark) < MARKING_LIST_LENGTH)
				mark = SanitizeMarking(mark)
			if(mark[MARKING_UID] == muid)
				var/slott = numberfy(href_list[PREFDAT_MARKING_SLOT])
				mark[MARKING_COLOR_LIST][slott] = new_color
				to_chat(user, span_green("You have set the color of your marking to [new_color]!"))
				return PRACT_DIALOG_ACCEPT
		to_chat(user, span_warning("Couldn't find the marking you wanted to color! Something went wrong :( error code: PRINCESS LUNA'S BUTT"))
		return PRACT_DIALOG_ERROR
	// if it's not a marking, maybe it's a gear item
	if(href_list[PREFDAT_IS_GEAR])
		var/load_slot = numberfy(href_list[PREFDAT_LOADOUT_SLOT])
		var/geartype = href_list[PREFDAT_GEAR_TYPE] // who lives in a pineapple under the sea
		var/list/loadoutgear = has_loadout_gear(load_slot, geartype)
		loadoutgear[LOADOUT_CUSTOM_COLOR] = new_color
		to_chat(user, span_green("You have set the color of your [geartype] to [new_color]!"))
		return PRACT_DIALOG_ACCEPT
	// The easy part is done, and now we know its probably a pref color feature thing, so let's find out which one
	if(href_list[PREFDAT_COLKEY_IS_FEATURE])
		var/colkey = href_list[PREFDAT_COLOR_KEY]
		features[colkey] = new_color
		to_chat(user, span_green("You have set the color of your [colkey] to [new_color]!"))
		return PRACT_DIALOG_ACCEPT
	// Or maybe its some kind of hard variable, which complicates things (for future coders, not me =3)
	if(href_list[PREFDAT_COLKEY_IS_VAR])
		var/colkey = href_list[PREFDAT_COLOR_KEY]
		if(!(colkey in vars))
			to_chat(user, span_warning("Couldn't find the variable you wanted to color! Something went wrong :( error code: PRINCESS CELESTIA'S BUTT"))
			return PRACT_DIALOG_ERROR
		vars[colkey] = new_color // warning, it doesnt actually know if this var is a color or not, so make sure you know what you're doing
		to_chat(user, span_green("You have set the color of your [colkey] to [new_color]!"))
		return PRACT_DIALOG_ACCEPT
	// if we got here, something went wrong
	to_chat(user, span_warning("Couldn't find the color you wanted to change! Something went wrong :( error code: PINKIE PIE'S BUTT"))
	return PRACT_DIALOG_ERROR

/// Let the player copy a color from somewhere
/datum/preferences/proc/CopyColor(mob/user, list/href_list)
	// considerably less upsettingly guntcitory than the other color proc
	//   Who loves his brainwashing and always wants more? |
	var/thecolor = href_list[PREFDAT_COLOR_HEX] // <-------/
	if(!is_color(thecolor))
		to_chat(user, span_warning("That's not a valid color!"))
		return PRACT_DIALOG_DENIED
	color_history -= thecolor
	color_history.Insert(1, thecolor)
	current_color = thecolor
	CleanupColorHistory()
	if(!href_list[PREFDAT_SUPPRESS_MESSAGE])
		to_chat(user, span_green("You have copied the color [thecolor]!"))
	return PRACT_DIALOG_ACCEPT

/// Let the player delete a color from somewhere
/datum/preferences/proc/DeleteColor(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/thecolor = href_list[PREFDAT_COLOR_HEX]
	if(!is_color(thecolor))
		to_chat(user, span_warning("That's not a valid color!"))
		return PRACT_DIALOG_DENIED
	color_history -= thecolor
	CleanupColorHistory()
	to_chat(user, span_green("You have removed the color [thecolor]!"))
	return PRACT_DIALOG_ACCEPT

/// Let the player paste a color to somewhere
/datum/preferences/proc/PasteColor(mob/user, list/href_list)
	if(!is_color(current_color))
		to_chat(user, span_warning("You haven't copied a color yet!"))
		return PRACT_DIALOG_DENIED
	// now heres the guntic part
	href_list[PREFDAT_COLOR_HEX] = current_color
	href_list[PREFDAT_SUPPRESS_MESSAGE] = TRUE
	. = ChangeColor(user, href_list)
	if(. == PRACT_DIALOG_ACCEPT)
		CopyColor(user, href_list) // move it to the top of the list, just like the real world

/datum/preferences/proc/CleanupColorHistory()
	if(!islist(color_history))
		color_history = list()
	if(!LAZYLEN(color_history))
		return
	color_history.len = min(5, color_history.len)

/// Let the player change the type of eyes they have
/datum/preferences/proc/ChangeEyeType(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.eye_types, eye_type, href_list)
	if(first_try)
		eye_type = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_eye_type = input(
		user,
		"What's your character's eyes look like?",
		"Character Preference"
	) as null|anything in GLOB.eye_types
	if(isnull(new_eye_type))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	eye_type = new_eye_type
	to_chat(user, span_green("You have set your eye type to [new_eye_type]!"))
	return PRACT_DIALOG_ACCEPT

/// Let the player change the style of facial hair they have
/datum/preferences/proc/ChangeFacialHairStyle(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.facial_hair_styles_list, facial_hair_style, href_list)
	if(first_try)
		facial_hair_style = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_facial_hair_style = input(
		user,
		"How does your character's facial hair look?",
		"Character Preference"
	) as null|anything in GLOB.facial_hair_styles_list
	if(isnull(new_facial_hair_style))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	facial_hair_style = new_facial_hair_style
	to_chat(user, span_green("You have set your facial hair style to [new_facial_hair_style]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the gradient of the user's hair, either the first or second
/datum/preferences/proc/ChangeHairGradient(mob/user, list/href_list, which)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/hair = which == 1 ? "grad_style" : "grad_style_2"
	var/first_try = ShiftAdjustment(user, GLOB.hair_gradients, features[hair], href_list)
	if(first_try)
		features[hair] = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_gradient = input(
		user,
		"How does the [which ? "first" : "second"] gradient style of your character's hair look?",
		"Character Preference"
	) as null|anything in GLOB.hair_gradients
	if(isnull(new_gradient))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	features[hair] = new_gradient
	to_chat(user, span_green("You have set the [which ? "first" : "second"] gradient style of your hair to [new_gradient]!"))
	return PRACT_DIALOG_ACCEPT

/// Change the style of the user's hair, either the first or second
/// the first is a var, and the second is a f&*king feature
/datum/preferences/proc/ChangeHairStyle(mob/user, list/href_list, which)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try
	if(which == 1)
		first_try = ShiftAdjustment(user, GLOB.hair_styles_list, hair_style, href_list)
		if(first_try)
			hair_style = first_try
			return PRACT_DIALOG_ACCEPT_SMOL
	else if(which == 2)
		first_try = ShiftAdjustment(user, GLOB.hair_styles_list, features["hair_style_2"], href_list)
		if(first_try)
			features["hair_style_2"] = first_try
			return PRACT_DIALOG_ACCEPT_SMOL
	var/new_hair_style = input(
		user,
		"How does the [which ? "first" : "second"] style of your character's hair look?",
		"Character Preference"
	) as null|anything in GLOB.hair_styles_list
	if(isnull(new_hair_style))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	if(which == 1)
		hair_style = new_hair_style
	else if(which == 2)
		features["hair_style_2"] = new_hair_style
	to_chat(user, span_green("You have set the [which ? "first" : "second"] style of your hair to [new_hair_style]!"))
	return PRACT_DIALOG_ACCEPT

/// Change which genitals you wont see
/datum/preferences/proc/ToggleGenitalCanSee(mob/user, list/href_list)
	var/which = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[which]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: APPLEJACK'S BUTT"))
		return PRACT_DIALOG_ERROR
	TOGGLE_BITFIELD(features["genital_hide"], GD.hide_flag)
	var/seesee = CHECK_BITFIELD(features["genital_hide"], GD.hide_flag) ? "no longer see" : "now be able to see"
	to_chat(user, span_green("You will [seesee] others' [GD.name]!"))
	return PRACT_TOGGLE_INV(CHECK_BITFIELD(features["genital_hide"], GD.hide_flag))

/// Let the player capture a keypress for a keybinding
/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key, independent = FALSE, special = FALSE)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];[independent?"independent=1;":""][special?"special=1;":""]clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/// Actually set the keybinding
/datum/preferences/proc/KeybindingSet(mob/user, list/href_list)
	var/kb_name = href_list["keybinding"]
	if(!kb_name)
		user << browse(null, "window=capturekeypress")
		ShowChoices(user)
		return PRACT_DIALOG_CANCEL
	var/independent = href_list["independent"]
	var/clear_key = text2num(href_list["clear_key"])
	var/old_key = href_list["old_key"]
	if(clear_key)
		if(independent)
			modless_key_bindings -= old_key
		else
			if(key_bindings[old_key])
				key_bindings[old_key] -= kb_name
				LAZYADD(key_bindings["Unbound"], kb_name)
				if(!length(key_bindings[old_key]))
					key_bindings -= old_key
		user << browse(null, "window=capturekeypress")
		if(href_list["special"])		// special keys need a full reset
			user.client.ensure_keys_set(src)
		save_preferences()
		ShowChoices(user)
		return PRACT_DIALOG_ACCEPT

	var/new_key = uppertext(href_list["key"])
	var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
	var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
	var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
	var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
	// var/key_code = text2num(href_list["key_code"])
	if(GLOB._kbMap[new_key])
		new_key = GLOB._kbMap[new_key]
	var/full_key
	switch(new_key)
		if("Alt")
			full_key = "[new_key][CtrlMod][ShiftMod]"
		if("Ctrl")
			full_key = "[AltMod][new_key][ShiftMod]"
		if("Shift")
			full_key = "[AltMod][CtrlMod][new_key]"
		else
			full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
	if(independent)
		modless_key_bindings -= old_key
		modless_key_bindings[full_key] = kb_name
	else
		if(key_bindings[old_key])
			key_bindings[old_key] -= kb_name
			if(!length(key_bindings[old_key]))
				key_bindings -= old_key
		key_bindings[full_key] += list(kb_name)
		key_bindings[full_key] = sortList(key_bindings[full_key])
	if(href_list["special"])		// special keys need a full reset
		user.client.ensure_keys_set(src)
	user << browse(null, "window=capturekeypress")
	return PRACT_DIALOG_ACCEPT

/// Toggle the category of a keybinding
/datum/preferences/proc/ToggleKeybindingCategory(mob/user, list/href_list)
	var/cat = href_list[PREFDAT_CATEGORY]
	if(!cat)
		return PRACT_DIALOG_CANCEL
	if(!islist(keybind_cat_open))
		keybind_cat_open = list()
	keybind_cat_open[cat] = keybind_cat_open[cat] ? FALSE : TRUE
	return PRACT_DIALOG_ACCEPT

/// Change your legs
/datum/preferences/proc/ChangeLegs(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.legs_list, features["legs"], href_list)
	if(first_try)
		features["legs"] = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_legs = input(
		user,
		"Choose your character's legs!",
		"Character Preference"
	) as null|anything in GLOB.legs_list
	if(isnull(new_legs))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	features["legs"] = new_legs
	to_chat(user, span_green("You have set your legs to [new_legs]!"))
	return PRACT_DIALOG_ACCEPT

/// Change your loadout category!
/datum/preferences/proc/ChangeLoadoutCategory(mob/user, list/href_list)
	var/cat = html_decode(href_list[PREFDAT_LOADOUT_CATEGORY])
	if(!cat)
		return PRACT_DIALOG_CANCEL
	ClearLoadoutSearch(user, href_list)
	gear_category = cat
	if(cat != GEAR_CAT_ALL_EQUIPPED)
		gear_subcategory = GLOB.loadout_categories[cat][1]
	return PRACT_DIALOG_ACCEPT

/// Change your loadout subcategory!
/datum/preferences/proc/ChangeLoadoutSubcategory(mob/user, list/href_list)
	var/subcat = html_decode(href_list[PREFDAT_LOADOUT_SUBCATEGORY])
	if(!subcat)
		return PRACT_DIALOG_CANCEL
	ClearLoadoutSearch(user, href_list)
	gear_subcategory = subcat
	return PRACT_DIALOG_ACCEPT

/// Change the description of a loadout thing!
/datum/preferences/proc/ChangeLoadoutDescription(mob/user, list/href_list)
	var/list/usergear = GetLoadoutList(user, href_list)
	if(!usergear)
		return PRACT_DIALOG_CANCEL
	var/new_description = stripped_multiline_input_or_reflect(
		user,
		"What should this thing's description be? (max 500 characters)",
		"Loadout Description",
		usergear[LOADOUT_CUSTOM_DESCRIPTION] || "",
		500
	)
	if(isnull(new_description))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	if(trim(new_description) == "")
		var/usure = alert(
			user,
			"Are you sure you want to clear this item's description?",
			"Clear Description?",
			"Yes, clear it",
			"No, leave it",
		)
		if(usure != "Yes, clear it")
			to_chat(user, span_warning("Okay nevermind!!"))
			return PRACT_DIALOG_CANCEL
		usergear[LOADOUT_CUSTOM_DESCRIPTION] = null
		return PRACT_DIALOG_ACCEPT
	else
		usergear[LOADOUT_CUSTOM_DESCRIPTION] = new_description
		to_chat(user, span_green("You have set the description of your [usergear[LOADOUT_CUSTOM_NAME]] to [new_description]!"))
		return PRACT_DIALOG_ACCEPT
	
/// Change the name of a loadout thing!
/datum/preferences/proc/ChangeLoadoutName(mob/user, list/href_list)
	var/list/usergear = GetLoadoutList(user, href_list)
	if(!usergear)
		return PRACT_DIALOG_CANCEL
	var/new_name = stripped_input(
		user,
		"What should this thing's name be? (max [MAX_NAME_LEN] characters)",
		"Loadout Name",
		usergear[LOADOUT_CUSTOM_NAME] || "",
		MAX_NAME_LEN,
	)
	if(isnull(new_name))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	if(trim(new_name) == "")
		var/usure = alert(
			user,
			"Are you sure you want to clear this item's name?",
			"Clear Name?",
			"Yes, clear it",
			"No, leave it",
		)
		if(usure != "Yes, clear it")
			to_chat(user, span_warning("Okay nevermind!!"))
			return PRACT_DIALOG_CANCEL
		usergear[LOADOUT_CUSTOM_NAME] = null
		return PRACT_DIALOG_ACCEPT
	else
		usergear[LOADOUT_CUSTOM_NAME] = new_name
		to_chat(user, span_green("You have set the name of your [usergear[LOADOUT_CUSTOM_NAME]] to [new_name]!"))
		return PRACT_DIALOG_ACCEPT

/// Reset your loadout!
/datum/preferences/proc/ResetLoadout(mob/user, list/href_list)
	var/usure = alert(
		user,
		"Are you sure you want to reset your loadout?",
		"Reset Loadout?",
		"Yes, reset it",
		"No, leave it",
	)
	if(usure != "Yes, reset it")
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	loadout_data["SAVE_[loadout_slot]"] = list()
	to_chat(user, span_green("You have reset your loadout!"))
	return PRACT_DIALOG_ACCEPT

/// Ask for a search term for the loadout
/datum/preferences/proc/EnterSearchTerm(mob/user, list/href_list)
	var/search = input(
		user,
		"What would you like to search for?",
		"Character Preference"
	) as null|text
	if(isnull(search))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	SetLoadoutSearch(user, search)
	loadout_search = search
	return PRACT_DIALOG_ACCEPT

/// Set the search term for the loadout
/datum/preferences/proc/SetLoadoutSearch(mob/user, search_term)
	if(!search_term)
		ClearLoadoutSearch(user)
		return PRACT_DIALOG_CANCEL
	loadout_search = search_term
	return PRACT_DIALOG_ACCEPT

/// Clear the search term for the loadout
/datum/preferences/proc/ClearLoadoutSearch(mob/user, list/href_list)
	loadout_search = null
	return PRACT_DIALOG_ACCEPT

/// Toggle having something in your loadout!
/datum/preferences/proc/ToggleLoadoutItem(mob/user, list/href_list)
	var/gearname = html_decode(href_list[PREFDAT_LOADOUT_GEAR_NAME])
	var/datum/gear/G = GLOB.flat_loadout_items[gearname]
	if(!G)
		return PRACT_DIALOG_ERROR
	var/loadout_slot = numberfy(href_list[PREFDAT_LOADOUT_SLOT])
	var/has_it = has_loadout_gear(loadout_slot, "[G.type]")
	if(has_it)
		RemoveGearFromLoadout(loadout_slot, "[G.type]")
		to_chat(user, span_green("You have removed the [G.name] from your loadout!"))
		return PRACT_TOGGLE(FALSE)
	else
		if(!CanAffordLoadoutItem(user, G))
			to_chat(user, span_danger("You can't afford that item!"))
			return PRACT_DIALOG_DENIED
		if(!HasSlotForLoadoutItem(user, G))
			to_chat(user, span_danger("You can only have a total of [MAX_FREE_PER_CAT] things from this category!"))
			return PRACT_DIALOG_DENIED
		if(G.donoritem && !G.donator_ckey_check(user.ckey))
			to_chat(user, span_danger("Sorry, this item is special for a certain person! You probably shouldnt be seeing this, so, error code: PRINCESS CADANCE'S BUTT"))
			return PRACT_DIALOG_ERROR
		AddGearToLoadout(loadout_slot, G)
		to_chat(user, span_green("You have added the [G.name] to your loadout!"))
		return PRACT_TOGGLE(TRUE)

// Add a marking to the user! MAM MARKINGS ONLY!!!!!
/datum/preferences/proc/AddMarking(mob/user, list/href_list)
	var/which_part = input(
		user,
		"Where will this marking go?",
		"Character Preference"
	) as null|anything in list("Head", "Chest", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "All")
	if(isnull(which_part))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	var/list/lame_markings = GLOB.mam_body_markings_list
	var/list/cool_markings = GetAppropriateMamMarkings(user, lame_markings, which_part)
	if(!LAZYLEN(cool_markings))
		to_chat(user, span_warning("There don't seem to be any markings for that part! Huh."))
		return PRACT_DIALOG_DENIED
	var/new_marking = input(
		user,
		"What marking will you add?",
		"Character Preference"
	) as null|anything in cool_markings
	if(isnull(new_marking))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	var/list/locations = list()
	if(which_part != "All")
		locations = list(which_part)
	else
		locations = list("Head", "Chest", "Left Arm", "Right Arm", "Left Leg", "Right Leg")
	for(var/spot in locations)
		var/list/newmarking = list()
		newmarking.len = MARKING_LIST_LENGTH
		newmarking[MARKING_LIMB_INDEX_NUM] = text2num(GLOB.bodypart_values[spot])
		newmarking[MARKING_NAME] = new_marking
		newmarking[MARKING_COLOR_LIST] = GetDefaultMarkingColors()
		newmarking[MARKING_UID] = GenerateMarkingUID()
		features["mam_body_markings"] += list(newmarking)
	to_chat(user, span_green("You have added the [new_marking] to your character!"))
	return PRACT_DIALOG_ACCEPT

// change a marking from one style to another! MAM MARKINGS ONLY!!!!!
/datum/preferences/proc/EditMarking(mob/user, list/href_list)
	var/muid = href_list[PREFDAT_MARKING_UID]
	if(!muid)
		return PRACT_DIALOG_CANCEL
	var/list/mark = GetMarkingByUID(user, muid)
	if(!mark)
		to_chat(user, span_warning("Couldn't find the marking you wanted to edit! Something went wrong :( error code: MINUETTE'S BUTT"))
		return PRACT_DIALOG_ERROR
	var/place = text2num(mark[MARKING_LIMB_INDEX_NUM])
	var/which_part = GLOB.bodypart_names[place]
	var/list/lame_markings = GLOB.mam_body_markings_list
	var/list/cool_markings = GetAppropriateMamMarkings(user, lame_markings, which_part)
	if(!LAZYLEN(cool_markings))
		to_chat(user, span_warning("There don't seem to be any markings for that part! Huh."))
		return PRACT_DIALOG_DENIED
	var/first_try = ShiftAdjustment(user, cool_markings, mark[MARKING_NAME], href_list)
	if(first_try)
		mark[MARKING_NAME] = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_marking = input(
		user,
		"What marking will you change it to?",
		"Character Preference"
	) as null|anything in cool_markings
	if(isnull(new_marking))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	mark[MARKING_NAME] = new_marking
	to_chat(user, span_green("You have changed the marking to [new_marking]!"))
	return PRACT_DIALOG_ACCEPT

// remove a marking from the user! MAM MARKINGS ONLY!!!!!
/datum/preferences/proc/RemoveMarking(mob/user, list/href_list)
	var/muid = href_list[PREFDAT_MARKING_UID]
	if(!muid)
		return PRACT_DIALOG_CANCEL
	var/mark = GetMarkingByUID(user, muid)
	if(!mark)
		to_chat(user, span_warning("Couldn't find the marking you wanted to remove! Something went wrong :( error code: LYRA'S BUTT"))
		return PRACT_DIALOG_ERROR
	features["mam_body_markings"] -= list(mark)
	to_chat(user, span_green("You have removed the marking!"))
	return PRACT_DIALOG_ACCEPT

// Change the ordering of a marking in the list
/datum/preferences/proc/ShiftMarking(mob/user, list/href_list, whichdir)
	var/muid = href_list[PREFDAT_MARKING_UID]
	if(!muid)
		return PRACT_DIALOG_CANCEL
	var/mark = GetMarkingByUID(user, muid)
	if(!mark)
		to_chat(user, span_warning("Couldn't find the marking you wanted to move! Something went wrong :( error code: RARITY'S BUTT"))
		return PRACT_DIALOG_ERROR
	var/list/mymarkings = features["mam_body_markings"]
	var/wheredex = mymarkings.Find(mark)
	if(wheredex == LAZYLEN(mymarkings) && whichdir == "down")
		to_chat(user, span_warning("That marking is already at the bottom of the list!"))
		return PRACT_DIALOG_DENIED
	if(wheredex == 1 && whichdir == "up")
		to_chat(user, span_warning("That marking is already at the top of the list!"))
		return PRACT_DIALOG_DENIED
	var/swapdex = whichdir == "up" ? wheredex - 1 : wheredex + 1
	mymarkings.Swap(wheredex, swapdex)
	to_chat(user, span_green("You have moved the marking [whichdir]!"))
	return PRACT_DIALOG_ACCEPT

// OverrideGenital
/datum/preferences/proc/OverrideGenital(mob/user, list/href_list)
	var/which = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[which]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: APPLEJACK'S BUTT"))
		return PRACT_DIALOG_ERROR
	var/list/options = list(
		"Always Visible" = GENITAL_ALWAYS_VISIBLE,
		"Always Hidden" = GENITAL_ALWAYS_HIDDEN,
		"Check Coverage" = 0
	)
	var/overkey = GD.override_key
	var/newvis = input(
		user,
		"Set a visibility override! If set, this part will always be visible/hidden, regardless of how covered it is.",
		"Character Preference",
		options
	) as null|anything in options
	if(isnull(newvis))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	var/it_to_bit = options[newvis]
	DISABLE_BITFIELD(features[overkey], GENITAL_ALWAYS_HIDDEN | GENITAL_ALWAYS_VISIBLE)
	ENABLE_BITFIELD(features[overkey], it_to_bit)
	to_chat(user, span_green("You have set the visibility of your [GD.name] to [newvis]!"))
	return PRACT_DIALOG_ACCEPT

// Change the PDA skin!
/datum/preferences/proc/ChangePDAKind(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/picked_pda = input(
		user,
		"What kind of DataPal do you want? \
		You can change this in-game by ctrl-shift-clicking the DataPal ingame!",
		"Character Preference",
		pda_skin
	) as null|anything in GLOB.pda_skins
	if(isnull(picked_pda))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	pda_skin = picked_pda
	to_chat(user, span_green("You have set your DataPal to [picked_pda]!"))
	return PRACT_DIALOG_ACCEPT

// Change the p-hud whtielist
/datum/preferences/proc/ChangePHUDWhitelist(mob/user, list/href_list, savetoo)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/new_genital_whitelist = stripped_multiline_input_or_reflect(
		user, 
		"Which people are you okay with seeing their genitals when exposed? If a humanlike mob has a name containing \
		any of the following, if their genitals are showing, you will be able to see them, regardless of your \
		content settings. Partial names are accepted, case is not important, please no punctuation (except ','). \
		Separate your entries with a comma!",
		"Genital Whitelist",
		genital_whitelist)
	if(isnull(new_genital_whitelist))
		to_chat(user, "Never mind!!")
		return PRACT_DIALOG_CANCEL
	if(trim(new_genital_whitelist) == "" && trim(genital_whitelist) != "")
		var/whoa = alert(user, "Are you sure you want to clear your genital whitelist?", "Clear Genital Whitelist", "Yes", "No")
		if(whoa == "No")
			to_chat(user, "Never mind!!")
			return PRACT_DIALOG_CANCEL
	genital_whitelist = new_genital_whitelist
	to_chat(user, span_notice("Updated your genital whitelist! It should kick in soon!"))
	if(savetoo)
		save_preferences()
	return PRACT_DIALOG_ACCEPT

// Change your size
/datum/preferences/proc/ChangeScale(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/min = CONFIG_GET(number/body_size_min)
	var/max = CONFIG_GET(number/body_size_max)
	var/donger = CONFIG_GET(number/threshold_body_size_slowdown)
	var/new_size = input(
		user,
		"How big is your character? (from [min*100]% to [max*100]%)\n\
		Just a heads up, this might make your character look a little distorted!\
		[donger > min ? " Also, if you go below [donger*100]%, you'll have a slower movement speed!" : ""]",
		"Character Preference",
		features["body_size"]*100
	) as null|num
	if(isnull(new_size))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	new_size = clamp(new_size * 0.01, min, max)
	if((new_size + 0.01) < donger)
		var/dorfy = alert(
			user,
			"Your character is smaller than the threshold of [donger*100]%. \
			This will make them move slower. Do you want to keep this size?",
			"Speed Penalty Alert",
			"Yes",
			"Move it to the threshold",
			"No"
		)
		if(dorfy == "Move it to the threshold")
			new_size = donger
		if(dorfy == "No" || !dorfy)
			to_chat(user, span_warning("Okay nevermind!!"))
			return PRACT_DIALOG_CANCEL
	features["body_size"] = new_size
	to_chat(user, span_green("You have set your size to [new_size*100]%!"))
	return PRACT_DIALOG_ACCEPT

// Change your width
/datum/preferences/proc/ChangeWidth(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/min = CONFIG_GET(number/body_width_min)
	var/max = CONFIG_GET(number/body_width_max)
	var/new_width = input(
		user,
		"How wide is your character? (from [min*100]% to [max*100]%)",
		"Character Preference",
		features["body_width"]*100
	) as null|num
	if(isnull(new_width))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	new_width = clamp(new_width * 0.01, min, max)
	features["body_width"] = new_width
	to_chat(user, span_green("You have set your width to [new_width*100]%!"))
	return PRACT_DIALOG_ACCEPT

// Change your ToggleGenitalHide
/datum/preferences/proc/ToggleGenitalHide(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/which = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[which]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: OCTAVIA'S BUTT"))
		return PRACT_DIALOG_ERROR
	var/bittu = features[GD.vis_flags_key]
	if(href_list[PREFDAT_HIDDEN_BY] == "undies")
		TOGGLE_BITFIELD(bittu, GENITAL_RESPECT_UNDERWEAR)
	if(href_list[PREFDAT_HIDDEN_BY] == "clothing")
		TOGGLE_BITFIELD(bittu, GENITAL_RESPECT_CLOTHING)
	features[GD.vis_flags_key] = bittu
	return PRACT_TOGGLE(CHECK_BITFIELD(bittu, GENITAL_RESPECT_UNDERWEAR | GENITAL_RESPECT_CLOTHING))

// Set the Sub Sub tab
/datum/preferences/proc/SetSubSubTab(mob/user, list/href_list)
	var/tab = html_decode(href_list[PREFDAT_SUBSUBTAB])
	if(!tab)
		return PRACT_DIALOG_CANCEL
	current_sub_subtab = tab
	return PRACT_DIALOG_ACCEPT

// Set the Sub tab
/datum/preferences/proc/SetSubTab(mob/user, list/href_list)
	var/tab = html_decode(href_list[PREFDAT_SUBTAB])
	if(!tab)
		return PRACT_DIALOG_CANCEL
	current_subtab = tab
	return PRACT_DIALOG_ACCEPT

// Set the Main tab
/datum/preferences/proc/SetMainTab(mob/user, list/href_list)
	var/tab = html_decode(href_list[PREFDAT_TAB])
	if(!tab)
		return PRACT_DIALOG_CANCEL
	current_tab = tab
	return PRACT_DIALOG_ACCEPT

// Shift Genital
/datum/preferences/proc/ShiftGenital(mob/user, list/href_list, whichdir)
	var/list/corklist = features["genital_order"]
	var/wheredex = corklist.Find(href_list[PREFDAT_GENITAL_HAS])
	if(wheredex == LAZYLEN(corklist) && whichdir == "down")
		to_chat(user, span_warning("That genital is already at the bottom of the list!"))
		return PRACT_DIALOG_DENIED
	if(wheredex == 1 && whichdir == "up")
		to_chat(user, span_warning("That genital is already at the top of the list!"))
		return PRACT_DIALOG_DENIED
	var/swapdex = whichdir == "up" ? wheredex - 1 : wheredex + 1
	corklist.Swap(wheredex, swapdex)
	return PRACT_DIALOG_ACCEPT

// Change your skin tone!
/datum/preferences/proc/ChangeSkinTone(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/list/choices = GLOB.skin_tones - GLOB.nonstandard_skin_tones
	if(CONFIG_GET(flag/allow_custom_skintones))
		choices += "custom"
	var/new_s_tone = input(
		user,
		"What color is your character's skin? (You can also choose a custom color!) (I recommend playing a furry tho!)",
		"Character Preference"
	) as null|anything in choices
	if(isnull(new_s_tone))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	if(new_s_tone == "custom")
		var/default = use_custom_skin_tone ? skin_tone : null
		var/custom_tone = input(
			user,
			"What color is your custom skin tone?",
			"Character Preference",
			default
		) as color|null
		if(isnull(custom_tone))
			to_chat(user, span_warning("Okay nevermind!!"))
			return PRACT_DIALOG_CANCEL
		use_custom_skin_tone = TRUE
		skin_tone = custom_tone
	else
		use_custom_skin_tone = FALSE
		skin_tone = new_s_tone
	to_chat(user, span_green("You have set your skin tone to [new_s_tone]!"))
	return PRACT_DIALOG_ACCEPT

// Delete your character!
/datum/preferences/proc/DeleteSlot(mob/user, list/href_list)
	if(!user)
		return PRACT_DIALOG_CANCEL
	lockdown = TRUE
	/// stage one, ask if they are sure, and detail the fact that this will delete the character forever
	/// with no chance of retrieval
	var/stage1text = "You have clicked the button that will delete [real_name]. If you go through with this, [real_name] will \
		be deleted, forever. There are no backups available, and no way to retrieve [real_name] once deleted. All of your \
		flavor texts, quirks, and preferences associated with [real_name] will be lost, permanently and forever. The only things that will \
		remain of [real_name] are things you have written down or screenshotted. Are you sure you want to delete [real_name]?"
	var/choose = alert(user, stage1text, "Character Deletion", "Yes, Delete This Character Forever", "NO WAIT I CHANGED Your MIND")
	if(choose != "Yes, Delete This Character Forever")
		lockdown = FALSE
		to_chat(user, span_green("Your character remains safe and sound."))
		return PRACT_DIALOG_CANCEL
	/// stage two, ask if they are really sure, and ask if they'd like to go back and save their flavor text or keep a screenshot of their prefs
	/// a chance to back out, but also a chance to save some stuff
	var/stage2text = "Are you absolutely sure you want to delete [real_name]? Have you saved their flavor text, OOC notes, or any other \
		information you want to keep? You might also want to take a screenshot of [real_name]'s preferences, just in case you want to \
		recreate them later. Again, there are no backups of [real_name] stored on the server or anywhere else, and there is no possible way \
		to undo this or retrieve any data relating to [real_name]. Once deleted, [real_name] is *gone* for *good*. \
		Are you sure you want to delete [real_name]?"
	var/choose2 = alert(user, stage2text, "Character Deletion", "Yes, Delete This Character Forever", "NO WAIT I CHANGED Your MIND")
	if(choose2 != "Yes, Delete This Character Forever")
		lockdown = FALSE
		to_chat(user, span_green("Your character remains safe and sound."))
		return PRACT_DIALOG_CANCEL
	/// stage three, have them type in the name of the character to confirm they really want to delete it
	var/confirmtext = "To confirm that you really want to delete [real_name], type in their name exactly as it appears in the text box below. \
		Please be careful, as this is your last chance to back out of deleting [real_name]. Again, just to be clear, the file structure \
		that we use with BYOND to save your individual characters does not allow for any feasible method of backing up or restoring \
		deleted characters. Once you delete [real_name], they are gone forever. Please confirm that you want to delete [real_name] by typing \
		their name in the box below."
	var/confirm = input(user, confirmtext, "Character Deletion") as text|null
	if(confirm != real_name)
		lockdown = FALSE
		to_chat(user, span_green("Your character remains safe and sound."))
		return PRACT_DIALOG_CANCEL
	/// stage four, actually delete the character
	log_game("[parent.ckey] has deleted [real_name] via the preferences menu. [real_name] is gone, forever. RIP.")
	to_chat(user, span_danger("So be it. Deleting [real_name]..."))
	delete_character(default_slot, real_name)
	to_chat(user, span_danger("Character deletion complete. They are gone, forever."))
	lockdown = FALSE
	return PRACT_DIALOG_ACCEPT

// Paste a character!
/datum/preferences/proc/PasteSlot(mob/user, list/href_list)
	if(!user)
		return PRACT_DIALOG_CANCEL
	if(copyslot == default_slot)
		to_chat(user, span_danger("You can't paste a character to itself, it just wouldn't work!"))
		return PRACT_DIALOG_CANCEL
	var/tobsure = alert(
		user,
		"Just to be clear, this will copy everything from [copyname] in slot [copyslot] to \
		[real_name], the currently selected character in slot [copyslot]. Everything on THIS \
		character ([real_name]) will be totally, utterly, completely lost and deleted forever, \
		and in its place will be everything from [copyname]. Are you sure you want to do this?",
		"Character Paste",
		"Yes, Paste [copyname] to [real_name]",
		"NO WAIT I CHANGED MY MIND",
	)
	if(tobsure != "Yes, Paste [copyname] to [real_name]")
		to_chat(user, span_green("Nevermind!! Your character remains safe and sound."))
		return PRACT_DIALOG_CANCEL
	var/sure2 = input(
		user,
		"Just in case you kinda sorta fat-fingered the last prompt, please type 'Chiara is wide' \
		in the box below to confirm that you really want to paste [copyname] to [real_name] and \
		utterly delete [real_name] forever and ever. No quotes, please!",
		"Character Paste, part II",
	) as text|null
	if(sure2 != "Chiara is wide")
		to_chat(user, span_green("Nevermind!! Your character remains safe and sound."))
		return PRACT_DIALOG_CANCEL
	load_character(copyslot, TRUE)
	save_character()
	to_chat(user, span_notice("Character pasted successfully!"))
	return PRACT_DIALOG_ACCEPT

// Change your socks!
/datum/preferences/proc/ChangeSocks(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.socks_list, socks, href_list)
	if(first_try)
		socks = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_socks = input(
		user,
		"What kind of socks does your character wear?",
		"Character Preference"
	) as null|anything in GLOB.socks_list
	if(isnull(new_socks))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	socks = new_socks
	to_chat(user, span_green("Your character is now wearing [new_socks]!"))
	return PRACT_DIALOG_ACCEPT

// Change your species!
/datum/preferences/proc/ChangeSpecies(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/newspecies = input(
		user,
		"What species is your character?",
		"Character Preference"
	) as null|anything in GLOB.roundstart_race_names
	if(isnull(newspecies))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	var/newtype = GLOB.species_list[GLOB.roundstart_race_names[newspecies]]
	pref_species = new newtype()
	custom_species = null
	if(!parent.can_have_part("mam_body_markings"))
		features["mam_body_markings"] = list()
	else if(features["mam_body_markings"] == "None")
		features["mam_body_markings"] = list()
	if(parent.can_have_part("tail_lizard"))
		features["tail_lizard"] = "Smooth"
	if(pref_species.id == "felinid")
		features["mam_tail"] = "Cat"
		features["mam_ears"] = "Cat"
	eye_type = pref_species.eye_type
	to_chat(user, span_green("Your character is now a [newspecies]!"))
	return PRACT_DIALOG_ACCEPT

// Change your stats!
/datum/preferences/proc/ChangeStats(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/totalcurrentpoints = special_s + special_p + special_e + special_c + special_i + special_a + special_l
	var/totalmaxpoints = 40
	var/max_per_stat = 10
	var/min_per_stat = 1
	var/statvarname = href_list[PREFDAT_STAT]
	var/stat_current_value = vars["[statvarname]"] // hue
	totalcurrentpoints -= stat_current_value
	var/points_to_spend = totalmaxpoints - totalcurrentpoints
	var/points_to_spend_on_stat = min(points_to_spend, max_per_stat)
	var/newpoints = input(
		user,
		"How many points should this stat be? (Can be between [min_per_stat] and [points_to_spend_on_stat], inclusive!)",
		"Character Preference",
		stat_current_value
	) as null|num
	if(isnull(newpoints))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	newpoints = clamp(newpoints, min_per_stat, points_to_spend_on_stat)
	vars["[statvarname]"] = newpoints
	to_chat(user, span_green("You have set that stat to [newpoints]!"))
	return PRACT_DIALOG_ACCEPT

// Toggle whether or not you have a certain genital
/datum/preferences/proc/ToggleGenital(mob/user, list/href_list)
	var/which = href_list[PREFDAT_GENITAL_HAS]
	var/datum/genital_data/GD = GLOB.genital_data_system[which]
	if(!GD)
		to_chat(user, span_warning("That's not a valid genital! something went wrong :( error code: KENZIE HOWZER'S BUTT"))
		return PRACT_DIALOG_ERROR
	features[GD.has_key] = features[GD.has_key] ? FALSE : TRUE
	if(features[GD.has_key])
		to_chat(user, span_green("Congratulations! You now have a [GD.name]!"))
	else
		to_chat(user, span_green("Congratulations! You have removed your [GD.name]!"))
	return PRACT_TOGGLE(features[GD.has_key])

// Change your underwear!
/datum/preferences/proc/ChangeUnderwear(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.underwear_list, underwear, href_list)
	if(first_try)
		underwear = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_underwear = input(
		user,
		"What kind of underwear / pants / bottomwear does your character wear?",
		"Character Preference"
	) as null|anything in GLOB.underwear_list
	if(isnull(new_underwear))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	underwear = new_underwear
	to_chat(user, span_green("Your character is now wearing [new_underwear]!"))
	return PRACT_DIALOG_ACCEPT

// Change your unershirt
/datum/preferences/proc/ChangeUndershirt(mob/user, list/href_list)
	PlayBoop(user, BOOP_MENU_OPEN)
	var/first_try = ShiftAdjustment(user, GLOB.undershirt_list, undershirt, href_list)
	if(first_try)
		undershirt = first_try
		return PRACT_DIALOG_ACCEPT_SMOL
	var/new_undershirt = input(
		user,
		"What kind of undershirt / shirt / topwear does your character wear?",
		"Character Preference"
	) as null|anything in GLOB.undershirt_list
	if(isnull(new_undershirt))
		to_chat(user, span_warning("Okay nevermind!!"))
		return PRACT_DIALOG_CANCEL
	undershirt = new_undershirt
	to_chat(user, span_green("Your character is now wearing [new_undershirt]!"))
	return PRACT_DIALOG_ACCEPT

// Get a marking by its UID
/datum/preferences/proc/GetMarkingByUID(mob/user, muid)
	if(!muid)
		return
	for(var/list/mark in features["mam_body_markings"])
		if(LAZYLEN(mark) < MARKING_LIST_LENGTH)
			mark = SanitizeMarking(mark)
		if(mark[MARKING_UID] == muid)
			return mark

// Get the markings that are appropriate for the user's selected limb
/datum/preferences/proc/GetAppropriateMamMarkings(mob/user, list/marking_list, selected_limb)
	if(!LAZYLEN(marking_list))
		return
	if(!user || !selected_limb)
		return
	var/list/cooler_markings = list()
	for(var/path in marking_list)
		var/datum/sprite_accessory/S = marking_list[path]
		if(!istype(S))
			continue
		if(istype(S, /datum/sprite_accessory/mam_body_markings))
			var/datum/sprite_accessory/mam_body_markings/marking = S
			if(selected_limb != "All")
				if(!(selected_limb in marking.covered_limbs))
					continue
		if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
			cooler_markings[S.name] = path
	return cooler_markings

// Get the default colors for a marking
/datum/preferences/proc/GetDefaultMarkingColors()
	return list(features["mcolor"], features["mcolor2"], features["mcolor3"]) // close enough

// Was accept?
/datum/preferences/proc/WasAccept(did)
	if(did == PRACT_DIALOG_ACCEPT)
		return TRUE
	if(did == PRACT_DIALOG_ACCEPT_SMOL)
		return TRUE
	return FALSE

// Play a boob!
/datum/preferences/proc/PlayBoop(mob/user, boop)
	if(!user || !boop)
		return
	var/boopsound
	switch(boop)
		if(BOOP_ACCEPT)
			boopsound = 'sound/effects/prefsmenu/accept.ogg'
		if(BOOP_ACCEPT_BIG)
			boopsound = 'sound/effects/prefsmenu/accept_big.ogg'
		if(BOOP_ACCEPT_SMOL)
			boopsound = 'sound/effects/prefsmenu/accept_smol.ogg'
		if(BOOP_CANCEL)
			boopsound = 'sound/effects/prefsmenu/cancel.ogg'
		if(BOOP_DENIED)
			boopsound = 'sound/effects/prefsmenu/denied.ogg'
		if(BOOP_ERROR)
			boopsound = 'sound/effects/prefsmenu/error.ogg'
		if(BOOP_BIG_MENU_OPEN)
			boopsound = 'sound/effects/prefsmenu/menu_open_big.ogg'
		if(BOOP_MENU_OPEN)
			boopsound = 'sound/effects/prefsmenu/menu_open.ogg'
		if(BOOP_SUB_PROMPT)
			boopsound = 'sound/effects/prefsmenu/sub_prompt.ogg'
	if(boopsound)
		user.playsound_local(user, boopsound)

// Can the user afford the item?
/datum/preferences/proc/CanAffordLoadoutItem(mob/user, datum/gear/G)
	if(!G.cost)
		return TRUE
	if(G.cost > gear_points)
		return FALSE
	return TRUE

// Add an item to the user's loadout
/datum/preferences/proc/AddGearToLoadout(loadout_slot, datum/gear/G)
	var/new_loadout_data = list()
	new_loadout_data[LOADOUT_ITEM] = "[G.type]"
	new_loadout_data[LOADOUT_COLOR] = "FFFFFF"
	new_loadout_data[LOADOUT_CUSTOM_NAME] = ""
	new_loadout_data[LOADOUT_CUSTOM_DESCRIPTION] = ""
	new_loadout_data[LOADOUT_CUSTOM_COLOR] = "FFFFFF"
	new_loadout_data[LOADOUT_UID] = GenerateMarkingUID()
	if(!islist(loadout_data["SAVE_[loadout_slot]"]))
		loadout_data["SAVE_[loadout_slot]"] = list()
	loadout_data["SAVE_[loadout_slot]"] += list(new_loadout_data)
	return TRUE

// Does the user have a slot for the item?
/datum/preferences/proc/HasSlotForLoadoutItem(mob/user, datum/gear/G)
	if(G.cost)
		return TRUE
	var/numfound = 0
	for(var/i in loadout_data["SAVE_[loadout_slot]"])
		var/loadie = i[LOADOUT_ITEM]
		var/datum/gear/testgear = text2path(loadie)
		if(initial(testgear.cost) > 0) // oh right, these are uninitialized, mb
			continue // non-free items are self limiting
		if(initial(testgear.category) != G.category)
			continue
		numfound++
	return numfound < MAX_FREE_PER_CAT

/datum/preferences/proc/RemoveGearFromLoadout(save_slot, gear_type)
	var/find_gear = has_loadout_gear(save_slot, gear_type)
	if(find_gear)
		loadout_data["SAVE_[save_slot]"] -= list(find_gear)


/datum/preferences/proc/CopySlot(mob/user, list/href_list)
	copyslot = default_slot
	copyname = real_name
	to_chat(user, span_notice("Copied [real_name] to the clipboard."))
	return PRACT_DIALOG_ACCEPT

/// Shift the options list for a part change
/datum/preferences/proc/ShiftAdjustment(mob/user, list/optionslist, current, list/href_list)
	if(!LAZYLEN(optionslist) || !LAZYLEN(href_list) || !current)
		return
	if(!href_list[PREFDAT_GO_PREV] && !href_list[PREFDAT_GO_NEXT])
		return
	. = PRACT_DIALOG_ERROR
	var/which = href_list[PREFDAT_GO_PREV] ? "prev" : "next"
	var/newoption
	if(which == "prev")
		newoption = next_list_item(current, optionslist)
	else
		newoption = previous_list_item(current, optionslist)
	if(!newoption)
		to_chat(user, span_warning("Something went wrong! Error code: TWILIGHT SPARKLE'S BUTT"))
		return
	return newoption

/// Gets the loadout list for the user
/datum/preferences/proc/GetLoadoutList(mob/user, list/href_list)
	var/name = html_decode(href_list[PREFDAT_LOADOUT_GEAR_NAME])
	var/datum/gear/G = GLOB.loadout_items[gear_category][gear_subcategory][name]
	if(!G)
		return
	var/loadout_slot = numberfy(href_list[PREFDAT_LOADOUT_SLOT])
	var/usergear = has_loadout_gear(loadout_slot, "[G.type]")
	if(!usergear)
		return
	return usergear

/// Makes GenerateMarkingUID
/datum/preferences/proc/GenerateMarkingUID()
	return "MARKING_[rand(1000000, 9999999)]_[rand(1000000, 9999999)]_[rand(1000000, 9999999)]_[rand(1000000, 9999999)]"



