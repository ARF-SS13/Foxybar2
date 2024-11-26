#define NO_MAXVOTES_CAP -1
#define EE_START 0
#define EE_WARNING_1 1
#define EE_WARNING_2 2
#define EE_WARNING_3 3
#define EE_GIRL 4
#define EE_END 5

SUBSYSTEM_DEF(autotransfer)
	name = "Autotransfer Vote"
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	wait = 1 SECONDS

	var/starttime
	var/targettime = 23.5 HOURS
	var/voteinterval
	var/maxvotes
	var/curvotes = 0
	var/allow_vote_restart = FALSE
	var/allow_vote_transfer = FALSE
	var/min_end_vote_time = INFINITY // lol

	var/easy_end = TRUE
	var/EE_stage = EE_START
	var/EE_warning_1 = (15 MINUTES)
	var/EE_warning_2 = (10 MINUTES)
	var/EE_warning_3 = (5 MINUTES)
	var/girlfailure_time = 30 // in seconds

	var/use_config = FALSE // if TRUE, use config values instead of the above - cus fuck the config

/datum/controller/subsystem/autotransfer/Initialize(timeofday)
	// hi I'm Dan and I say fuck the config
	if(use_config)
		read_config()
	return ..()

/datum/controller/subsystem/autotransfer/proc/read_config()
	var/init_vote = CONFIG_GET(number/vote_autotransfer_initial)
	if(!init_vote) //Autotransfer voting disabled.
		return
	starttime = world.time
	targettime = starttime + init_vote
	voteinterval = CONFIG_GET(number/vote_autotransfer_interval)
	maxvotes = CONFIG_GET(number/vote_autotransfer_maximum)


/datum/controller/subsystem/autotransfer/Recover()
	starttime = SSautotransfer.starttime
	voteinterval = SSautotransfer.voteinterval
	curvotes = SSautotransfer.curvotes

/datum/controller/subsystem/autotransfer/fire()
	if(world.time < targettime)
		return
	if(!easy_end)
		SSshuttle.autoEnd()
	else
		var/EE_time = targettime
		switch(EE_stage)
			if(EE_START)
				EE_stage = EE_WARNING_1
				Announce()
			if(EE_WARNING_1)
				EE_time += EE_warning_1
				if(world.time < EE_time)
					return // not time yet!
				EE_stage = EE_WARNING_2
				Announce()
			if(EE_WARNING_2)
				EE_time += (EE_warning_1 + EE_warning_2)
				if(world.time < EE_time)
					return // not time yet!
				EE_stage = EE_WARNING_3
				Announce()
			if(EE_WARNING_3)
				EE_time += (EE_warning_1 + EE_warning_2 + EE_warning_3)
				if(world.time < EE_time)
					return // not time yet!
				EE_stage = EE_GIRL
				Announce()
			if(EE_END)
				SSticker.KillGame()

/datum/controller/subsystem/autotransfer/proc/AnnounceWarning()
	var/lefttime = 0
	switch(EE_stage)
		if(EE_START)
			lefttime = (EE_warning_1 + EE_warning_2 + EE_warning_3)
		if(EE_WARNING_1)
			lefttime = (EE_warning_2 + EE_warning_3)
		if(EE_WARNING_2)
			lefttime = (EE_warning_3)
		if(EE_WARNING_3)

	var/timewords = "[DisplayTimeText(lefttime, 60)]"
	var/words = "The bar will be closing briefly for maintenance in around [timewords]. Time to wind it down!"
	priority_announce(
		"[words]",
		"Foxy Bar Maintenance",
		null,
		"Bar Announcement"
	)


















	// if(maxvotes == NO_MAXVOTES_CAP || maxvotes > curvotes)
	// 	SSvote.initiate_vote("transfer","server")
	// 	targettime = targettime + voteinterval
	// 	curvotes++
	// else

#undef NO_MAXVOTES_CAP
