/datum/antagonist/heretic
	name = "Heretic"
	roundend_category = "Heretics"
	antagpanel_category = "Heretic"
	antag_moodlet = /datum/mood_event/heretics
	job_rank = ROLE_HERETIC
	antag_hud_type = ANTAG_HUD_HERETIC
	antag_hud_name = "heretic"
	threat = 10
	var/give_equipment = TRUE
	var/list/researched_knowledge = list()
	var/total_sacrifices = 0
	var/ascended = FALSE

/datum/antagonist/heretic/admin_add(datum/mind/new_owner,mob/admin)
	give_equipment = TRUE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has heresized [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has heresized [key_name(new_owner)].")

/datum/antagonist/heretic/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ecult_op.ogg', 100, FALSE, pressure_affected = FALSE)//subject to change
	to_chat(owner, "<span class='boldannounce'>You are the Heretic!</span><br>\
	<B>The old ones gave you these tasks to fulfill:</B>")
	owner.announce_objectives()
	to_chat(owner, "<span class='cult'>The book whispers, the forbidden knowledge walks once again!<br>\
	Your book allows you to research abilities, but be careful, you cannot undo what has been done.<br>\
	You gain charges by either collecting influences or sacrificing people tracked by the living heart<br> \
	You can find a basic guide at : https://tgstation13.org/wiki/Heresy_101 </span>")

/datum/antagonist/heretic/on_gain()
	var/mob/living/current = owner.current
//	owner.teach_crafting_recipe(/datum/crafting_recipe/heretic/codex)
	if(ishuman(current))
		forge_primary_objectives()
		gain_knowledge(/datum/eldritch_knowledge/spell/basic)
		gain_knowledge(/datum/eldritch_knowledge/living_heart)
		gain_knowledge(/datum/eldritch_knowledge/codex_cicatrix)
		gain_knowledge(/datum/eldritch_knowledge/eldritch_blade)
	current.log_message("has been converted to the cult of the forgotten ones!", LOG_ATTACK, color="#960000")
	GLOB.reality_smash_track.AddMind(owner)
	START_PROCESSING(SSprocessing,src)
	if(give_equipment)
		equip_cultist()
	return ..()

/datum/antagonist/heretic/on_removal()

	for(var/X in researched_knowledge)
		var/datum/eldritch_knowledge/EK = researched_knowledge[X]
		EK.on_lose(owner.current)

	if(!silent)
		to_chat(owner.current, span_userdanger("My mind begins to flare as the otherwordly knowledge escapes your grasp!"))
		owner.current.log_message("has renounced the cult of the old ones!", LOG_ATTACK, color="#960000")
	GLOB.reality_smash_track.RemoveMind(owner)
	STOP_PROCESSING(SSprocessing,src)

	return ..()


/datum/antagonist/heretic/proc/equip_cultist()
	var/mob/living/carbon/H = owner.current
	if(!istype(H))
		return
	. += ecult_give_item(/obj/item/forbidden_book, H)
	. += ecult_give_item(/obj/item/living_heart, H)

/datum/antagonist/heretic/proc/ecult_give_item(obj/item/item_path, mob/living/carbon/human/H)
	var/list/slots = list(
		"backpack" = SLOT_IN_BACKPACK,
		"left pocket" = SLOT_L_STORE,
		"right pocket" = SLOT_R_STORE
	)

	var/T = new item_path(H)
	var/item_name = initial(item_path.name)
	var/where = H.equip_in_one_of_slots(T, slots)
	if(!where)
		to_chat(H, span_userdanger("Unfortunately, you weren't able to get a [item_name]. This is very bad and you should adminhelp immediately (press F1)."))
		return FALSE
	else
		to_chat(H, span_danger("I have a [item_name] in your [where]."))
		if(where == "backpack")
			SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)
		return TRUE

/datum/antagonist/heretic/process()

	for(var/X in researched_knowledge)
		var/datum/eldritch_knowledge/EK = researched_knowledge[X]
		EK.on_life(owner.current)

/datum/antagonist/heretic/proc/forge_primary_objectives()
	var/list/assasination = list()
	var/list/protection = list()
	for(var/i in 1 to 2)
		var/pck = pick("assasinate","protect")
		switch(pck)
			if("assasinate")
				var/datum/objective/assassinate/A = new
				A.owner = owner
				var/list/owners = A.get_owners()
				A.find_target(owners,protection)
				assasination += A.target
				objectives += A
			if("protect")
				var/datum/objective/protect/P = new
				P.owner = owner
				var/list/owners = P.get_owners()
				P.find_target(owners,assasination)
				protection += P.target
				objectives += P

	var/datum/objective/sacrifice_ecult/SE = new
	SE.owner = owner
	SE.update_explanation_text()
	objectives += SE

/datum/antagonist/heretic/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	if(mob_override)
		current = mob_override
	add_antag_hud(antag_hud_type, antag_hud_name, current)
	handle_clown_mutation(current, mob_override ? null : "Knowledge described in the book allowed you to overcome your clownish nature, allowing you to use complex items effectively.")
	current.faction |= "heretics"

/datum/antagonist/heretic/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	if(mob_override)
		current = mob_override
	remove_antag_hud(antag_hud_type, current)
	handle_clown_mutation(current, removing = FALSE)
	current.faction -= "heretics"

/datum/antagonist/heretic/get_admin_commands()
	. = ..()
	.["Equip"] = CALLBACK(src,PROC_REF(equip_cultist))

/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()

	var/cultiewin = TRUE

	parts += printplayer(owner)
	parts += "<b>Sacrifices Made:</b> [total_sacrifices]"

	if(length(objectives))
		var/count = 1
		for(var/o in objectives)
			var/datum/objective/objective = o
			if(objective.check_completion())
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</b></span>"
			else
				parts += "<b>Objective #[count]</b>: [objective.explanation_text] <span class='redtext'>Fail.</span>"
				cultiewin = FALSE
			count++
	if(ascended)
		parts += "<span class='greentext big'>HERETIC HAS ASCENDED!</span>"
	else
		if(cultiewin)
			parts += span_greentext("The heretic was successful!")
		else
			parts += span_redtext("The heretic has failed.")

	parts += "<b>Knowledge Researched:</b> "

	var/list/knowledge_message = list()
	var/list/knowledge = get_all_knowledge()
	for(var/X in knowledge)
		var/datum/eldritch_knowledge/EK = knowledge[X]
		knowledge_message += "[EK.name]"
	parts += knowledge_message.Join(", ")

	return parts.Join("<br>")
////////////////
// Knowledge //
////////////////

/datum/antagonist/heretic/proc/gain_knowledge(datum/eldritch_knowledge/EK)
	if(get_knowledge(EK))
		return FALSE
	var/datum/eldritch_knowledge/initialized_knowledge = new EK
	researched_knowledge[initialized_knowledge.type] = initialized_knowledge
	initialized_knowledge.on_gain(owner.current)
	return TRUE

/datum/antagonist/heretic/proc/get_researchable_knowledge()
	var/list/researchable_knowledge = list()
	var/list/banned_knowledge = list()
	for(var/X in researched_knowledge)
		var/datum/eldritch_knowledge/EK = researched_knowledge[X]
		researchable_knowledge |= EK.next_knowledge
		banned_knowledge |= EK.banned_knowledge
		banned_knowledge |= EK.type
	researchable_knowledge -= banned_knowledge
	return researchable_knowledge

/datum/antagonist/heretic/proc/get_knowledge(wanted)
	return researched_knowledge[wanted]

/datum/antagonist/heretic/proc/get_all_knowledge()
	return researched_knowledge

/datum/antagonist/heretic/threat()
	. = ..()
	for(var/X in researched_knowledge)
		var/datum/eldritch_knowledge/EK = researched_knowledge[X]
		. += EK.cost
	if(ascended)
		. += 20

////////////////
// Objectives //
////////////////

/datum/objective/sacrifice_ecult
	name = "sacrifice"

/datum/objective/sacrifice_ecult/update_explanation_text()
	. = ..()
	target_amount = rand(2,4)
	explanation_text = "Sacrifice at least [target_amount] people."

/datum/objective/sacrifice_ecult/check_completion()
	if(!owner)
		return FALSE
	var/datum/antagonist/heretic/cultie = owner.has_antag_datum(/datum/antagonist/heretic)
	if(!cultie)
		return FALSE
	return cultie.total_sacrifices >= target_amount
