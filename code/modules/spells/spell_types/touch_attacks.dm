/obj/effect/proc_holder/spell/targeted/touch
	var/hand_path = /obj/item/melee/touch_attack
	var/obj/item/melee/touch_attack/attached_hand = null
	var/drawmessage = "I channel the power of the spell to your hand."
	var/dropmessage = "I draw the power out of your hand."
	invocation_type = "none" //you scream on connecting, not summoning
	include_user = 1
	range = -1

/obj/effect/proc_holder/spell/targeted/touch/proc/remove_hand(recharge = FALSE)
	QDEL_NULL(attached_hand)
	if(recharge)
		charge_counter = charge_max

/obj/effect/proc_holder/spell/targeted/touch/proc/on_hand_destroy(obj/item/melee/touch_attack/hand)
	if(hand != attached_hand)
		CRASH("Incorrect touch spell hand.")
	//Start recharging.
	attached_hand = null
	recharging = TRUE
	action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/targeted/touch/cast(list/targets,mob/user = usr)
	if(!QDELETED(attached_hand))
		remove_hand(TRUE)
		to_chat(user, span_notice("[dropmessage]"))
		return

	for(var/mob/living/carbon/C in targets)
		if(!attached_hand)
			if(ChargeHand(C))
				recharging = FALSE
				return

/obj/effect/proc_holder/spell/targeted/touch/charge_check(mob/user,silent = FALSE)
	if(!QDELETED(attached_hand)) //Charge doesn't matter when putting the hand away.
		return TRUE
	else
		return ..()

/obj/effect/proc_holder/spell/targeted/touch/proc/ChargeHand(mob/living/carbon/user)
	attached_hand = new hand_path(src)
	attached_hand.attached_spell = src
	if(!user.put_in_hands(attached_hand))
		remove_hand(TRUE)
		to_chat(user, span_warning("My hands are full!"))
		return FALSE
	to_chat(user, span_notice("[drawmessage]"))
	return TRUE


/obj/effect/proc_holder/spell/targeted/touch/disintegrate
	name = "Disintegrate"
	desc = "This spell charges your hand with vile energy that can be used to violently explode victims."
	hand_path = /obj/item/melee/touch_attack/disintegrate

	school = "evocation"
	charge_max = 600
	cooldown_min = 200 //100 deciseconds reduction per rank

	action_icon_state = "gib"

/obj/effect/proc_holder/spell/targeted/touch/flesh_to_stone
	name = "Flesh to Stone"
	desc = "This spell charges your hand with the power to turn victims into inert statues for a long period of time."
	hand_path = /obj/item/melee/touch_attack/fleshtostone

	school = "transmutation"
	charge_max = 600
	cooldown_min = 200 //100 deciseconds reduction per rank

	action_icon_state = "statue"
	sound = 'sound/magic/fleshtostone.ogg'

/obj/effect/proc_holder/spell/targeted/touch/nuclear_fist
	name = "Nuclear Fist"
	desc = "This spell channels raw manliness, allowing you punch your enemies across the galaxy, causing them to detonate violently if hitting any other living being midflight. Does not work while laying down."
	hand_path = /obj/item/melee/touch_attack/nuclearfist

	school = "evocation"
	charge_max = 100
	clothes_req = NONE
	cooldown_min = 20

	action_icon_state = "nuclearfist"
