//Beam
/obj/effect/ebeam/chain
	name = "lightning chain"
	layer = LYING_MOB_LAYER

/mob/living/simple_animal/hostile/guardian/beam
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "shocks"
	attack_verb_simple = "shock"
	melee_damage_type = BURN
	attack_sound = 'sound/machines/defib_zap.ogg'
	damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, CLONE = 0.7, STAMINA = 0, OXY = 0.7)
	playstyle_string = "<span class='holoparasite'>As a <b>lightning</b> type, you have 30% damage reduction, apply lightning chains to targets on attack and have a lightning chain to your summoner. Lightning chains will shock anyone near them.</span>"
	magic_fluff_string = span_holoparasite("..And draw the Tesla, a shocking, lethal source of power.")
	tech_fluff_string = span_holoparasite("Boot sequence complete. Lightning modules active. Holoparasite swarm online.")
	carp_fluff_string = span_holoparasite("CARP CARP CARP! Caught one! It's a lightning carp! Everyone else goes zap zap.")
	var/datum/beam/summonerchain
	var/list/enemychains = list()
	var/successfulshocks = 0

/mob/living/simple_animal/hostile/guardian/beam/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(. && isliving(my_target) && my_target != src && my_target != summoner)
		cleardeletedchains()
		for(var/chain in enemychains)
			var/datum/beam/B = chain
			if(B.target == my_target)
				return //oh this guy already HAS a chain, let's not chain again
		if(enemychains.len > 2)
			var/datum/beam/C = pick(enemychains)
			qdel(C)
			enemychains -= C
		enemychains += Beam(my_target, "lightning[rand(1,12)]", time=70, maxdistance=13, beam_type=/obj/effect/ebeam/chain)

/mob/living/simple_animal/hostile/guardian/beam/Destroy()
	removechains()
	return ..()

/mob/living/simple_animal/hostile/guardian/beam/Manifest()
	. = ..()
	if(.)
		if(summoner)
			summonerchain = Beam(summoner, "lightning[rand(1,12)]", time=INFINITY, maxdistance=INFINITY, beam_type=/obj/effect/ebeam/chain)
		while(loc != summoner)
			if(successfulshocks > 5)
				successfulshocks = 0
			if(shockallchains())
				successfulshocks++
			sleep(3)

/mob/living/simple_animal/hostile/guardian/beam/Recall()
	. = ..()
	if(.)
		removechains()

/mob/living/simple_animal/hostile/guardian/beam/proc/cleardeletedchains()
	if(summonerchain && QDELETED(summonerchain))
		summonerchain = null
	if(enemychains.len)
		for(var/chain in enemychains)
			var/datum/cd = chain
			if(!chain || QDELETED(cd))
				enemychains -= chain

/mob/living/simple_animal/hostile/guardian/beam/proc/shockallchains()
	. = 0
	cleardeletedchains()
	if(summoner)
		if(!summonerchain)
			summonerchain = Beam(summoner, "lightning[rand(1,12)]", time=INFINITY, maxdistance=INFINITY, beam_type=/obj/effect/ebeam/chain)
		. += chainshock(summonerchain)
	if(enemychains.len)
		for(var/chain in enemychains)
			. += chainshock(chain)

/mob/living/simple_animal/hostile/guardian/beam/proc/removechains()
	if(summonerchain)
		qdel(summonerchain)
		summonerchain = null
	if(enemychains.len)
		for(var/chain in enemychains)
			qdel(chain)
		enemychains = list()

/mob/living/simple_animal/hostile/guardian/beam/proc/chainshock(datum/beam/B)
	. = 0
	var/list/turfs = list()
	for(var/E in B.elements)
		var/obj/effect/ebeam/chainpart = E
		if(chainpart && chainpart.x && chainpart.y && chainpart.z)
			var/turf/T = get_turf_pixel(chainpart)
			turfs |= T
			if(T != get_turf(B.origin) && T != get_turf(B.target))
				for(var/turf/TU in circlerange(T, 1))
					turfs |= TU
	for(var/turf in turfs)
		var/turf/T = turf
		for(var/mob/living/L in T)
			if(L.stat != DEAD && L != src && L != summoner)
				if(hasmatchingsummoner(L)) //if the summoner matches don't hurt them
					continue
				if(successfulshocks > 4)
					if(iscarbon(L))
						var/mob/living/carbon/C = L
						if(ishuman(C))
							var/mob/living/carbon/human/H = C
							H.electrocution_animation(20)
						C.jitteriness += 1000
						C.do_jitter_animation(jitteriness)
						C.stuttering += 1
						spawn(20)
							if(C)
								C.jitteriness = max(C.jitteriness - 990, 10)
					L.visible_message(
						span_danger("[L] was shocked by the lightning chain!"), \
						span_userdanger("I am shocked by the lightning chain!"), \
						span_italic("I hear a heavy electrical crack.") \
					)
				L.adjustFireLoss(1.2) //adds up very rapidly
				. = 1
