/*****************************Survival Pod********************************/
/area/survivalpod
	name = "\improper Emergency Shelter"
	icon_state = "away"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	valid_territory = FALSE

//Survival Capsule
/obj/item/survivalcapsule
	name = "basic C.A.M.P."
	desc = "A basic C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/template_id = "shelter_alpha"
	var/datum/map_template/shelter/template
	var/used = FALSE
	var/nuke = FALSE

/obj/item/survivalcapsule/proc/get_template()
	if(template)
		return
	template = SSmapping.shelter_templates[template_id]
	if(!template)
		stack_trace("Shelter template ([template_id]) not found!")
		qdel(src)

/obj/item/survivalcapsule/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/item/survivalcapsule/examine(mob/user)
	. = ..()
	get_template()
	. += "This capsule has the [template.name] stored."
	. += template.description

/obj/item/survivalcapsule/attack_self()
	//Can't grab when capsule is New() because templates aren't loaded then
	get_template()
	if(!used)
		loc.visible_message(span_warning("\The [src] begins to shake. Stand back!"))
		used = TRUE
		sleep(50)
		var/turf/deploy_location = get_turf(src)
		if(!nuke)
			var/status = template.check_deploy(deploy_location)
			switch(status)
				if(SHELTER_DEPLOY_BAD_AREA)
					src.loc.visible_message(span_warning("\The [src] will not function in this area."))
				if(SHELTER_DEPLOY_BAD_TURFS, SHELTER_DEPLOY_ANCHORED_OBJECTS)
					var/width = template.width
					var/height = template.height
					src.loc.visible_message(span_warning("\The [src] doesn't have room to deploy! You need to clear a [width]x[height] area!"))

			if(status && status != SHELTER_DEPLOY_ALLOWED)
				used = FALSE
				return

		playsound(src, 'sound/effects/phasein.ogg', 100, 1)

		var/turf/T = deploy_location
		if(!is_mining_level(T.z)) //only report capsules away from the mining/lavaland level
			message_admins("[ADMIN_LOOKUPFLW(usr)] activated a bluespace capsule away from the mining level! [ADMIN_VERBOSEJMP(T)]")
			log_admin("[key_name(usr)] activated a bluespace capsule away from the mining level at [AREACOORD(T)]")
		template.load(deploy_location, centered = TRUE, annihilate = nuke)
		new /obj/effect/particle_effect/smoke(get_turf(src))
		qdel(src)

//Non-default pods

/obj/item/survivalcapsule/luxury
	name = "luxury bluespace shelter capsule"
	desc = "A luxury C.A.M.P. capsule packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_beta"

/obj/item/survivalcapsule/luxuryelite
	name = "luxury elite bar capsule"
	desc = "A luxury bar C.A.M.P. capsule packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_charlie"

//Pod objects

//Window
/obj/structure/window/shuttle/survival_pod
	name = "pod window"
	icon = 'icons/obj/smooth_structures/pod_window.dmi'
	icon_state = "pod_window-0"
	base_icon_state = "pod_window"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_SURVIVAL_TIANIUM_POD)
	canSmoothWith = list(SMOOTH_GROUP_SURVIVAL_TIANIUM_POD)

/obj/structure/window/shuttle/survival_pod/spawner/north
	dir = NORTH

/obj/structure/window/shuttle/survival_pod/spawner/east
	dir = EAST

/obj/structure/window/shuttle/survival_pod/spawner/west
	dir = WEST

/obj/structure/window/reinforced/survival_pod
	name = "pod window"
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "pwindow"

//Door
/obj/machinery/door/airlock/survival_pod
	name = "airlock"
	icon = 'icons/obj/doors/airlocks/survival/survival.dmi'
	overlays_file = 'icons/obj/doors/airlocks/survival/survival_overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_pod

/obj/machinery/door/airlock/survival_pod/glass
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_pod
	name = "pod airlock assembly"
	icon = 'icons/obj/doors/airlocks/survival/survival.dmi'
	base_name = "pod airlock"
	overlays_file = 'icons/obj/doors/airlocks/survival/survival_overlays.dmi'
	airlock_type = /obj/machinery/door/airlock/survival_pod
	glass_type = /obj/machinery/door/airlock/survival_pod/glass

//Windoor
/obj/machinery/door/window/survival_pod
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "windoor"
	base_state = "windoor"

//Table
/obj/structure/table/survival_pod
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "table"
	smoothing_flags = SMOOTH_CORNERS

//Sleeper
/obj/machinery/sleeper/survival_pod
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "sleeper"

/obj/machinery/sleeper/survival_pod/update_icon_state()
	return

/obj/machinery/sleeper/survival_pod/update_overlays()
	. = ..()
	if(!state_open)
		. += "sleeper_cover"

//Computer
/obj/item/gps/computer
	name = "pod computer"
	icon_state = "pod_computer"
	icon = 'icons/obj/lavaland/pod_computer.dmi'
	anchored = TRUE
	density = TRUE
	pixel_y = -32

/obj/item/gps/computer/wrench_act(mob/living/user, obj/item/I)
	if(flags_1 & NODECONSTRUCT_1)
		return TRUE

	user.visible_message(span_warning("[user] disassembles [src]."),
		span_notice("I start to disassemble [src]..."), "I hear clanking and banging noises.")
	if(I.use_tool(src, user, 20, volume=50))
		new /obj/item/gps(loc)
		qdel(src)
	return TRUE

/obj/item/gps/computer/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	attack_self(user)

//Bed
/obj/structure/bed/pod
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"

//Survival Storage Unit
/obj/machinery/smartfridge/survival_pod
	name = "survival pod storage"
	desc = "A heated storage unit."
	icon_state = "donkvendor"
	icon = 'icons/obj/lavaland/donkvendor.dmi'
	light_range = 5
	light_power = 1.2
	light_color = "#DDFFD3"
	max_n_of_items = 10
	pixel_y = -4
	flags_1 = NODECONSTRUCT_1
	var/empty = FALSE

/obj/machinery/smartfridge/survival_pod/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/machinery/smartfridge/survival_pod/Initialize(mapload)
	. = ..()
	if(empty)
		return
	for(var/i in 1 to 5)
		var/obj/item/reagent_containers/food/snacks/donkpocket/warm/W = new(src)
		load(W)
	if(prob(50))
		var/obj/item/storage/box/dice/D = new(src)
		load(D)
	else
		var/obj/item/instrument/guitar/G = new(src)
		load(G)

/obj/machinery/smartfridge/survival_pod/accept_check(obj/item/O)
	return isitem(O)

/obj/machinery/smartfridge/survival_pod/empty
	name = "dusty survival pod storage"
	desc = "A heated storage unit. This one's seen better days."
	empty = TRUE

//Fans
/obj/structure/fans
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "fans"
	name = "environmental regulation system"
	desc = "A large machine releasing a constant gust of air."
	anchored = TRUE
	density = TRUE
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 5
	CanAtmosPass = ATMOS_PASS_NO

/obj/structure/fans/deconstruct()
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	qdel(src)

/obj/structure/fans/wrench_act(mob/living/user, obj/item/I)
	if(flags_1 & NODECONSTRUCT_1)
		return TRUE

	user.visible_message(span_warning("[user] disassembles [src]."),
		span_notice("I start to disassemble [src]..."), "I hear clanking and banging noises.")
	if(I.use_tool(src, user, 20, volume=50))
		deconstruct()
	return TRUE

/obj/structure/fans/tiny
	name = "tiny fan"
	desc = "A tiny fan, releasing a thin gust of air."
	layer = ABOVE_NORMAL_TURF_LAYER
	density = FALSE
	icon_state = "fan_tiny"
	buildstackamount = 2

/obj/structure/fans/Initialize(mapload)
	. = ..()
	air_update_turf(1)

//Inivisible, indestructible fans
/obj/structure/fans/tiny/invisible
	name = "air flow blocker"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	invisibility = INVISIBILITY_ABSTRACT

//Signs
/obj/structure/sign/mining
	name = "nanotrasen mining corps sign"
	desc = "A sign of relief for weary miners, and a warning for would-be competitors to Nanotrasen's mining claims."
	icon = 'icons/turf/walls/survival_pod_walls.dmi'
	icon_state = "ntpod"
	buildable_sign = FALSE

/obj/structure/sign/mining/survival
	name = "shelter sign"
	desc = "A high visibility sign designating a safe shelter."
	icon = 'icons/turf/walls/survival_pod_walls.dmi'
	icon_state = "survival"

//Fluff
/obj/structure/tubes
	icon_state = "tubes"
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	name = "tubes"
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	density = FALSE

/obj/item/fakeartefact
	name = "expensive forgery"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	var/possible = list(/obj/item/ship_in_a_bottle,
						/obj/item/gun/energy/pulse,
						/obj/item/book/granter/martial/carp,
						/obj/item/melee/supermatter_sword,
						/obj/item/shield/changeling,
						/obj/item/lava_staff,
						/obj/item/energy_katana,
						/obj/item/hierophant_club,
						/obj/item/his_grace,
						/obj/item/gun/ballistic/automatic/l6_saw,
						/obj/item/gun/magic/staff/chaos,
						/obj/item/gun/magic/staff/spellblade,
						/obj/item/gun/magic/wand/death,
						/obj/item/gun/magic/wand/fireball,
						/obj/item/stack/telecrystal/twenty,
						/obj/item/nuke_core,
						/obj/item/phylactery,
						/obj/item/banhammer)

/obj/item/fakeartefact/Initialize()
	. = ..()
	var/obj/item/I = pick(possible)
	name = initial(I.name)
	icon = initial(I.icon)
	desc = initial(I.desc)
	icon_state = initial(I.icon_state)
	inhand_icon_state = initial(I.inhand_icon_state)

/obj/item/survivalcapsule/premium
	name = "Premium TTU C.A.M.P."
	desc = "An intermediatly priced, carpeted, C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_beta"

/obj/item/survivalcapsule/quad
	name = "Spacious TTU C.A.M.P."
	desc = "An expanded tent with four living quarters and a soda fountain C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_charlie"

/obj/item/survivalcapsule/merchant
	name = "Merchant TTU C.A.M.P."
	desc = "A partially covered merchants stall.  This one has a sleeping quarters too. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_delta"

/obj/item/survivalcapsule/party
	name = "Party TTU C.A.M.P."
	desc = "A large, spacious tent with a booze dispenser and some food. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_echo"

/obj/item/survivalcapsule/kitchen
	name = "Cook-N-Go TTU C.A.M.P."
	desc = "A rapid, ready to deploy field mess kitchen. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_foxtrot"

/obj/item/survivalcapsule/farm
	name = "Farm-N-Go TTU C.A.M.P."
	desc = "A ready to go, loaded farming plot with three brahmin, and a small living quarter. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_golf"

/obj/item/survivalcapsule/fortuneteller
	name = "Occult TTU C.A.M.P."
	desc = "A camp with three brahmin and all your supernatural needs. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_hotel"

/obj/item/survivalcapsule/blacksmith
	name = "Blacksmithery TTU C.A.M.P."
	desc = "An all-in-one smithery, with a workbench, lathe, and forge as its key components. C.A.M.P. packed and designed by the Texarkana Trade Union.  Shake it and throw it!"
	template_id = "shelter_india"

/obj/item/survivalcapsule/super_deluxe
	name = "Super Deluxe TTU C.A.M.P."
	desc = "The best of the best, no luxury witheld super-deluxe C.A.M.P. packed and designed by the Texarkana Trade Union. Dispensers, machinery, sleeping quarters, vendors, it has it all.  Shake it and throw it!"
	template_id = "shelter_juliett"

