/obj/machinery/fan_assembly
	name = "fan assembly"
	desc = "A basic microfan assembly."
	icon = 'icons/obj/poweredfans.dmi'
	icon_state = "mfan_assembly"
	max_integrity = 150
	use_power = NO_POWER_USE
	power_channel = ENVIRON
	idle_power_usage = 0
	active_power_usage = 0
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = FALSE
	density = FALSE
	CanAtmosPass = ATMOS_PASS_YES
	stat = 1
	var/buildstacktype = /obj/item/stack/sheet/plasteel
	var/buildstackamount = 5
	/*
			1 = Wrenched in place
			2 = Welded in place
			3 = Wires attached to it, this makes it change to the full thing.
	*/

/obj/machinery/fan_assembly/attackby(obj/item/W, mob/living/user, params)
	switch(stat)
		if(1)
			// Stat 1
			if(istype(W, /obj/item/weldingtool))
				if(weld(W, user))
					to_chat(user, span_notice("I weld the fan assembly securely into place."))
					setAnchored(TRUE)
					stat = 2
					update_icon_state()
				return
		if(2)
			// Stat 2
			if(istype(W, /obj/item/stack/cable_coil))
				if(!W.tool_start_check(user, amount=2))
					to_chat(user, span_warning("I need two lengths of cable to wire the fan assembly!"))
					return
				to_chat(user, span_notice("I start to add wires to the assembly..."))
				if(W.use_tool(src, user, 30, volume=50, amount=2))
					to_chat(user, span_notice("I add wires to the fan assembly."))
					stat = 3
					var/obj/machinery/poweredfans/F = new(loc, src)
					forceMove(F)
					F.setDir(src.dir)
					return
			else if(istype(W, /obj/item/weldingtool))
				if(weld(W, user))
					to_chat(user, span_notice("I unweld the fan assembly from its place."))
					stat = 1
					update_icon_state()
					setAnchored(FALSE)
				return
	return ..()

/obj/machinery/fan_assembly/wrench_act(mob/user, obj/item/I)
	if(stat != 1)
		return FALSE
	user.visible_message(span_warning("[user] disassembles [src]."),
		span_notice("I start to disassemble [src]..."), "I hear wrenching noises.")
	if(I.use_tool(src, user, 30, volume=50))
		deconstruct()
	return TRUE

/obj/machinery/fan_assembly/proc/weld(obj/item/weldingtool/W, mob/living/user)
	if(!W.tool_start_check(user, amount=0))
		return FALSE
	switch(stat)
		if(1)
			to_chat(user, span_notice("I start to weld \the [src]..."))
		if(2)
			to_chat(user, span_notice("I start to unweld \the [src]..."))
	if(W.use_tool(src, user, 30, volume=50))
		return TRUE
	return FALSE

/obj/machinery/fan_assembly/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new buildstacktype(loc,buildstackamount)
	qdel(src)

/obj/machinery/fan_assembly/examine(mob/user)
	. = ..()
	switch(stat)
		if(1)
			to_chat(user, span_notice("The fan assembly seems to be <b>unwelded</b> and loose."))
		if(2)
			to_chat(user, span_notice("The fan assembly seems to be welded, but missing <b>wires</b>."))
		if(3)
			to_chat(user, span_notice("The outer plating is <b>wired</b> firmly in place."))

/obj/machinery/fan_assembly/update_icon_state()
	. = ..()
	switch(stat)
		if(1)
			icon_state = "mfan_assembly"
		if(2)
			icon_state = "mfan_welded"
