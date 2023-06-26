/mob/living/simple_animal/hostile/retaliate/deathclaw
	name = "deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws."
	icon = 'icons/fallout/mobs/monsters/deathclaw.dmi'
	icon_state = "deathclaw"
	icon_living = "deathclaw"
	icon_dead = "deathclaw_dead"
	icon_gib = "deathclaw_gib"
	mob_armor = ARMOR_VALUE_DEATHCLAW_COMMON
	maxHealth = 250
	health = 250
	reach = 2
	speed = 1
	obj_damage = 200
	melee_damage_lower = 30
	melee_damage_upper = 40
	footstep_type = FOOTSTEP_MOB_HEAVY
	move_to_delay = 2.4 //hahahahahahahaaaaa
	gender = MALE
	a_intent = INTENT_HARM //So we can not move past them.
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	robust_searching = TRUE
	speak = list("ROAR!","Rawr!","GRRAAGH!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 10
	taunt_chance = 25
	tastes = list("a bad time" = 5, "dirt" = 1)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	var/color_mad = "#ffc5c5"
	see_in_dark = 8
	decompose = FALSE
	wound_bonus = 0 //This might be a TERRIBLE idea
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 4,
							/obj/item/stack/sheet/animalhide/deathclaw = 2,
							/obj/item/stack/sheet/bone = 4)
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "hits"
	attack_verb_simple = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("neutral")
	gold_core_spawnable = HOSTILE_SPAWN
	//var/charging = FALSE
	move_resist = MOVE_FORCE_OVERPOWERING
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	emote_taunt_sound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = 'sound/f13npc/deathclaw/death.ogg'
	low_health_threshold = 0.5
	variation_list = list(
		MOB_RETREAT_DISTANCE_LIST(0, 0, 0, 3, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(65),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(30),
	)
	despawns_when_lonely = FALSE

/mob/living/simple_animal/hostile/retaliate/deathclaw/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/retaliate/deathclaw/playable
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = FALSE

/// Override this with what should happen when going from high health to low health
/mob/living/simple_animal/hostile/retaliate/deathclaw/make_low_health()
	visible_message(span_danger("[src] lets out a vicious roar!!!"))
	playsound(src, 'sound/f13npc/deathclaw/aggro2.ogg', 100, 1, SOUND_DISTANCE(20))
	color = color_mad
	reach += 1
	speed *= 0.8
	obj_damage += 200
	melee_damage_lower *= 1.5
	melee_damage_upper *= 1.4
	see_in_dark += 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	wound_bonus += 25
	bare_wound_bonus += 50
	sound_pitch = -50
	alternate_attack_prob = 75
	is_low_health = TRUE

/// Override this with what should happen when going from low health to high health
/mob/living/simple_animal/hostile/deathclaw/retaliate/make_high_health()
	visible_message(span_danger("[src] calms down."))
	color = initial(color)
	reach = initial(reach)
	speed = initial(speed)
	obj_damage = initial(obj_damage)
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	see_in_dark = initial(see_in_dark)
	environment_smash = initial(environment_smash)
	wound_bonus = initial(wound_bonus)
	bare_wound_bonus = initial(bare_wound_bonus)
	alternate_attack_prob = initial(alternate_attack_prob)
	is_low_health = FALSE

/mob/living/simple_animal/hostile/deathclaw/retaliate/AlternateAttackingTarget(atom/the_target)
	if(!ismovable(the_target))
		return
	var/atom/movable/throwee = the_target
	if(throwee.anchored)
		return
	var/atom/throw_target = get_ranged_target_turf(throwee, get_dir(src, the_target), rand(2,10), 4)
	throwee.safe_throw_at(throw_target, 10, 1, src, TRUE)
	playsound(get_turf(throwee), 'sound/effects/Flesh_Break_1.ogg')

/mob/living/simple_animal/hostile/retaliate/deathclaw/Move()
	if(is_low_health && health > 0)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/Bump(atom/A)
	if(is_low_health)
		if((isturf(A) || isobj(A)) && A.density)
			A.ex_act(EXPLODE_HEAVY)
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			if(stat || health <= 0)
				playsound(get_turf(src), 'sound/effects/Flesh_Break_2.ogg', 100, 1, ignore_walls = TRUE)
				visible_message(span_danger("[src] smashes into \the [A] and explodes in a violent spray of gore![prob(25) ? " Holy shit!" : ""]"))
				gib()
				return
		DestroySurroundings()
	..()

// Mother death claw - egglaying
/mob/living/simple_animal/hostile/retaliate/deathclaw/mother
	name = "mother deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws. This one is an BIG mother."
	gender = FEMALE
	mob_armor = ARMOR_VALUE_DEATHCLAW_MOTHER
	maxHealth = 300
	health = 300
	stat_attack = CONSCIOUS
	melee_damage_lower = 25
	melee_damage_upper = 55
	footstep_type = FOOTSTEP_MOB_HEAVY
	color = rgb(95,104,94)
	color_mad = rgb(113, 105, 100)
	var/egg_type = /obj/item/reagent_containers/food/snacks/f13/deathclawegg
	var/food_type = /obj/item/reagent_containers/food/snacks/meat/slab
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/list/feedMessages = list("It rips the meat from your grasp.","It glares at you as it swallows the meat whole.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 6,
							/obj/item/stack/sheet/animalhide/deathclaw = 3)

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++deathclaw_mother_count

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/Destroy()
	--deathclaw_mother_count
	return ..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem claws
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, span_warning("[name] doesn't seem hungry!"))
	else
		..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message(span_alertalien("[src] [pick(layMessage)]"))
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = rand(-6,6)
		E.pixel_y = rand(-6,6)
		if(eggsFertile)
			if(deathclaw_mother_count < MAX_MOTHERCLAWS && prob(25))
				START_PROCESSING(SSobj, E)

/obj/item/reagent_containers/food/snacks/f13/deathclawegg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/f13/deathclawegg/process()
	if(isturf(loc))
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			visible_message("[src] hatches with a quiet cracking sound, swelling to full size.")
			/mob/living/simple_animal/hostile/retaliate/deathclaw/mother(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)
  
