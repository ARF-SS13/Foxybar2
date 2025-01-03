/* 
 * File:   genital_data.dm
 * Author: Cogwerks The Fox
 * Date:   2019-12-10
 * License: WWW.PLAYAPOCALYPSE.COM
 * 
 * I shoudla known after the 500th define for all genitals that I needed to remember my golden rule
 * 'Anything a fuuckhuge list can do, a datum does better'
 */

/datum/genital_data
	var/name
	var/has_key
	var/shape_key
	var/size_key
	var/color_key
	var/phud_key
	var/vis_flags_key
	var/override_key
	var/hide_flag
	var/genital_flags
	var/list/sizelist
	var/list/shapelist
	var/taurable
	var/size_min
	var/size_max
	var/size_name
	var/size_units

/datum/genital_data/New(obj/item/organ/genital/nad)
	shapelist = nad.GetShapeList()
	sizelist = nad.GetSizeList()
	taurable = nad.CanTaur()
	size_min = nad.GetMinSize()
	size_max = nad.GetMaxSize()
	size_name = nad.GetSizeKind()
	has_key = nad.associated_has
	shape_key = nad.shape_key
	size_key = nad.size_key
	color_key = nad.color_key
	phud_key = nad.pornhud_slot
	vis_flags_key = nad.vis_flags_key
	override_key = nad.override_key
	hide_flag = nad.hide_flag
	name = nad.name
	genital_flags = nad.genital_flags
	size_units = nad.size_units

/datum/genital_data/proc/SizeString(size)
	var/out = size_name
	out = replacetext(out, "<SIZE>", "[capitalize(size)]")
	if(isnum(size) && size > 1)
		out = replacetext(out, "<S>", "s")
		out = replacetext(out, "<ES>", "es")
	else
		out = replacetext(out, "<S>", "")
		out = replacetext(out, "<ES>", "")
	return out










