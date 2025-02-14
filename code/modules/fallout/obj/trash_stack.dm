/obj/item/storage/trash_stack
	name = "pile of garbage"
	desc = "A pile of garbage. Smells as good as it looks, though it may contain something useful. Or rats. Probably rats."
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "trash_1"
	anchored = TRUE
	density = FALSE
	///Is someone rifling through this trash pile?
	var/rifling = FALSE
	var/list/loot_players = list()
	var/list/lootable_trash = list()
	var/list/garbage_list = list()
/*
/obj/item/storage/trash_stack/proc/initialize_lootable_trash()
	lootable_trash = list(/obj/effect/spawner/lootdrop/f13/trash)
	/*garbage_list = list(GLOB.trash_ammo, GLOB.trash_chem, GLOB.trash_clothing, GLOB.trash_craft,
						GLOB.trash_gun, GLOB.trash_misc, GLOB.trash_money, GLOB.trash_mob,
						GLOB.trash_part, GLOB.trash_tool, GLOB.trash_attachment)
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii*/
*/
/obj/item/storage/trash_stack/Initialize()
	. = ..()
	icon_state = "trash_[rand(1,3)]"
	GLOB.trash_piles += WEAKREF(src)
//	initialize_lootable_trash()

/obj/item/storage/trash_stack/Destroy()
	GLOB.trash_piles -= WEAKREF(src)
	. = ..()

/// Called from [code/controllers/subsystem/itemspawners.dm]
/obj/item/storage/trash_stack/proc/cleanup()
	loot_players.Cut() //This culls a list safely
	for(var/obj/item/A in loc.contents)
		if(A.from_trash)
			qdel(A)

/obj/item/storage/trash_stack/attack_hand(mob/user)
	var/turf/trash_turf = get_turf(src)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("I need a ckey to search the trash! Gratz on not having a ckey, tell Lagg (a coder) about it!"))
	if(ukey in loot_players)
		to_chat(user, span_notice("I already have looted [src]."))
		return
	if(!rifling)
		playsound(get_turf(src), 'sound/f13effects/loot_trash.ogg', 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("I start picking through [src]...."))
	rifling = TRUE
	if(!do_mob(user, src, 3 SECONDS))
		rifling = FALSE
		return
	rifling = FALSE
	if(ukey in loot_players)
		to_chat(user, span_notice("I already have looted [src]."))
		return
	loot_players += ukey
	to_chat(user, span_notice("I scavenge through [src]."))
	for(var/i in 1 to rand(1,4))
		var/list/trash_passthru = list()
		var/obj/effect/spawner/lootdrop/f13/trash/pile/my_trash = new(trash_turf)
		my_trash.spawn_the_stuff(trash_passthru) // fun fact, lists are references, so this'll be populated when the proc runs (cool huh?)
		for(var/atom/movable/spawned in trash_passthru)
			if(isitem(spawned))
				var/obj/item/newitem = spawned
				newitem.from_trash = TRUE
			if(isgun(spawned))
				var/obj/item/gun/trash_gun = spawned
				var/prob_trash = 80
				for(var/tries in 1 to 3)
					if(!prob(prob_trash))
						continue
					prob_trash -= 40
					var/trash_mod_path = pick(GLOB.trash_craft) // this was trash gunmods but like they're not gonna be in loot anymore
					var/obj/item/gun_upgrade/trash_mod = new trash_mod_path
					if(SEND_SIGNAL(trash_mod, COMSIG_ITEM_ATTACK_OBJ_NOHIT, trash_gun, null))
						break
					QDEL_NULL(trash_mod)

// lov dan
/obj/item/storage/money_stack
	name = "payroll safe"
	desc = "a payroll safe. Use it every hour to recieve your pay."
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = TRUE
	density = TRUE
	var/list/paid_players = list()
	var/list/pay = list(/obj/item/stack/f13Cash/random/med)

/obj/item/storage/money_stack/ncr
	pay = list(/obj/item/stack/f13Cash/random/ncr/med)

/obj/item/storage/money_stack/legion
	pay = list(/obj/item/stack/f13Cash/random/denarius/med)

/obj/item/storage/money_stack/Initialize()
	. = ..()
	GLOB.money_piles += src

/obj/item/storage/money_stack/Destroy()
	GLOB.money_piles -= src
	. = ..()

/obj/item/storage/money_stack/attack_hand(mob/user)
	var/turf/trash_turf = get_turf(src)
	if(user?.a_intent != INTENT_HARM)
		if(user in paid_players)
			to_chat(user, span_notice("I have already taken your pay from the [src]."))
			return
		for(var/i=0, i<rand(1,2), i++)
			var/itemtype = pick(pay)
			if(itemtype)
				to_chat(user, span_notice("I get your pay from the [src]."))
				new itemtype(trash_turf)
		paid_players += user
	else
		return ..()

/obj/item/storage/trash_stack/debug_rats
	name = "pile of rats"
	desc = "a pile of rats!"
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "trash_1"

/*
/obj/item/storage/trash_stack/debug_rats/initialize_lootable_trash()
	garbage_list = list(GLOB.trash_mob) // oops all rats!
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii
*/
