/datum/species/vampire
	name = "Vampire"
	id = "vampire"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,DRINKSBLOOD,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_NOHUNGER,TRAIT_NOBREATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	mutant_bodyparts = list("mcolor" = "FFFFFF", "tail_human" = "None", "ears" = "None", "deco_wings" = "None")
	exotic_bloodtype = "U"
	use_skintones = USE_SKINTONES_GRAYSCALE_CUSTOM
	mutant_heart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	blacklisted = TRUE
	limbs_id = "human"
	skinned_type = /obj/item/stack/sheet/animalhide/human
	var/info_text = "I am a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	species_type = "undead"

/datum/species/vampire/check_roundstart_eligible()
//	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
//		return TRUE
	return FALSE

/datum/species/vampire/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	. = ..()
	to_chat(C, "[info_text]")
	if(!C.dna.skin_tone_override)
		C.skin_tone = "albino"
	C.update_body(0)
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/B = new
	C.AddSpell(B)

/datum/species/vampire/on_species_loss(mob/living/carbon/C)
	. = ..()
	if(C.mind)
		for(var/S in C.mind.spell_list)
			var/obj/effect/proc_holder/spell/S2 = S
			if(S2.type == /obj/effect/proc_holder/spell/targeted/shapeshift/bat)
				C.mind.spell_list.Remove(S2)
				qdel(S2)

/datum/species/vampire/spec_life(mob/living/carbon/human/C)
	. = ..()
	if(istype(C.loc, /obj/structure/closet/crate/coffin))
		C.heal_overall_damage(4,4)
		C.adjustToxLoss(-4)
		C.adjustOxyLoss(-4)
		C.adjustCloneLoss(-4)
		return
	C.blood_volume -= 0.75 //Will take roughly 19.5 minutes to die from standard blood volume, roughly 83 minutes to die from max blood volume.
	if(C.get_blood(FALSE) <= (BLOOD_VOLUME_SURVIVE*C.blood_ratio))
		to_chat(C, span_danger("I ran out of blood!"))
		C.dust()
	var/area/A = get_area(C)
	if(istype(A, /area/chapel))
		to_chat(C, span_danger("I don't belong here!"))
		C.adjustFireLoss(5)
		C.adjust_fire_stacks(6)
		C.IgniteMob()

/obj/item/organ/tongue/vampire
	name = "vampire tongue"
	actions_types = list(/datum/action/item_action/organ_action/vampire)
	color = "#1C1C1C"
	var/drain_cooldown = 0

#define VAMP_DRAIN_AMOUNT 50

/datum/action/item_action/organ_action/vampire
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."

/datum/action/item_action/organ_action/vampire/Trigger()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		var/obj/item/organ/tongue/vampire/V = target
		if(V.drain_cooldown >= world.time)
			to_chat(H, span_notice("I just drained blood, wait a few seconds."))
			return
		if(H.pulling && iscarbon(H.pulling))
			var/mob/living/carbon/victim = H.pulling
			if(H.get_blood(FALSE) >= BLOOD_VOLUME_MAXIMUM)
				to_chat(H, span_notice("You're already full!"))
				return
			//This checks whether or not they are wearing a garlic clove on their neck
			if(!blood_sucking_checks(victim, TRUE, FALSE))
				return
			if(victim.stat == DEAD)
				to_chat(H, span_notice("I need a living victim!"))
				return
			if(!victim.blood_volume || (victim.dna && ((NOBLOOD in victim.dna.species.species_traits) || victim.dna.species.exotic_blood)))
				to_chat(H, span_notice("[victim] doesn't have blood!"))
				return
			V.drain_cooldown = world.time + 30
			if(victim.anti_magic_check(FALSE, TRUE, FALSE, 0))
				to_chat(victim, span_warning("[H] tries to bite you, but stops before touching you!"))
				to_chat(H, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
				return
			//Here we check now for both the garlic cloves on the neck and for blood in the victims bloodstream.
			if(!blood_sucking_checks(victim, TRUE, TRUE))
				return
			if(!do_after(H, 30, target = victim))
				return
			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - H.blood_volume //How much capacity we have left to absorb blood
			var/drained_blood = min(victim.blood_volume, VAMP_DRAIN_AMOUNT, blood_volume_difference)
			to_chat(victim, span_danger("[H] is draining your blood!"))
			to_chat(H, span_notice("I drain some blood!"))
			playsound(H, 'sound/items/drink.ogg', 30, 1, -2)
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			H.blood_volume = clamp(H.blood_volume + drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			if(!victim.blood_volume)
				to_chat(H, span_warning("I finish off [victim]'s blood supply!"))

#undef VAMP_DRAIN_AMOUNT


/mob/living/carbon/get_status_tab_items()
	. = ..()
	var/obj/item/organ/heart/vampire/darkheart = getorgan(/obj/item/organ/heart/vampire)
	if(darkheart)
		. += span_notice("Current blood level: [blood_volume]/[BLOOD_VOLUME_MAXIMUM].")


/obj/item/organ/heart/vampire
	name = "vampire heart"
	actions_types = list(/datum/action/item_action/organ_action/vampire_heart)
	color = "#1C1C1C"

/datum/action/item_action/organ_action/vampire_heart
	name = "Check Blood Level"
	desc = "Check how much blood you have remaining."

/datum/action/item_action/organ_action/vampire_heart/Trigger()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		to_chat(H, span_notice("Current blood level: [H.blood_volume]/[BLOOD_VOLUME_MAXIMUM]."))

/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape a space bat."
	invocation = "Squeak!"
	charge_max = 50
	cooldown_min = 50
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
	var/ventcrawl_nude_only = TRUE
	var/transfer_name = TRUE

/obj/effect/proc_holder/spell/targeted/shapeshift/bat/Shapeshift(mob/living/caster)			//cit change
	var/obj/shapeshift_holder/H = locate() in caster
	if(H)
		to_chat(caster, span_warning("You're already shapeshifted!"))
		return

	var/mob/living/shape = new shapeshift_type(caster.loc)
	H = new(shape,src,caster)
	if(istype(H, /mob/living/simple_animal))
		var/mob/living/simple_animal/SA = H
		if((caster.get_blood(FALSE) >= (BLOOD_VOLUME_SYMPTOMS_DEBILITATING*caster.blood_ratio)) || (ventcrawl_nude_only && length(caster.get_equipped_items(include_pockets = TRUE))))
			SA.ventcrawler = FALSE
	if(transfer_name)
		H.name = caster.name


	clothes_req = NONE
	mobs_whitelist = null
	mobs_blacklist = null
