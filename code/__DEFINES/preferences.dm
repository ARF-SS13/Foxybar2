
//Preference toggles
#define SOUND_ADMINHELP			(1<<0)
#define SOUND_MIDI				(1<<1)
#define SOUND_AMBIENCE			(1<<2)
#define SOUND_LOBBY				(1<<3)
#define MEMBER_PUBLIC			(1<<4)
#define INTENT_STYLE			(1<<5)
#define MIDROUND_ANTAG			(1<<6)
#define SOUND_INSTRUMENTS		(1<<7)
#define SOUND_SHIP_AMBIENCE		(1<<8)
#define SOUND_PRAYERS			(1<<9)
#define ANNOUNCE_LOGIN			(1<<10)
#define SOUND_ANNOUNCEMENTS		(1<<11)
#define DISABLE_DEATHRATTLE		(1<<12)
#define DISABLE_ARRIVALRATTLE	(1<<13)
#define COMBOHUD_LIGHTING		(1<<14)
#define SOUND_SI				(1<<15)
#define SPLIT_ADMIN_TABS 		(1<<16)
#define VERB_CONSENT			(1<<17)
#define HEAR_LEWD_VERB_SOUNDS		(1<<18)
#define HEAR_LEWD_VERB_WORDS		(1<<19)
#define SOUND_HUNTINGHORN		(1<<20)
#define SOUND_SPRINTBUFFER		(1<<21)

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|MEMBER_PUBLIC|INTENT_STYLE|MIDROUND_ANTAG|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS|SOUND_SI|VERB_CONSENT|HEAR_LEWD_VERB_WORDS|SOUND_HUNTINGHORN|SOUND_SPRINTBUFFER)

//Chat toggles
#define CHAT_OOC			(1<<0)
#define CHAT_DEAD			(1<<1)
#define CHAT_GHOSTEARS		(1<<2)
#define CHAT_GHOSTSIGHT		(1<<3)
#define CHAT_PRAYER			(1<<4)
#define CHAT_RADIO			(1<<5)
#define CHAT_PULLR			(1<<6)
#define CHAT_GHOSTWHISPER	(1<<7)
#define CHAT_GHOSTPDA		(1<<8)
#define CHAT_GHOSTRADIO 	(1<<9)
#define CHAT_LOOC			(1<<10)
#define CHAT_BANKCARD		(1<<11)
#define CHAT_REMOTE_LOOC	(1<<12)
#define CHAT_AOOC			(1<<13)
#define CHAT_NEWBIE			(1<<14)
#define CHAT_HEAR_RADIOBLURBLES			(1<<15)
#define CHAT_HEAR_RADIOSTATIC			(1<<16)
#define CHAT_SEE_COOLCHAT			(1<<17)

#define TOGGLES_DEFAULT_CHAT (CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_PULLR|CHAT_GHOSTWHISPER|CHAT_GHOSTPDA|CHAT_GHOSTRADIO|CHAT_LOOC|CHAT_BANKCARD|CHAT_REMOTE_LOOC|CHAT_AOOC|CHAT_NEWBIE|CHAT_HEAR_RADIOBLURBLES|CHAT_HEAR_RADIOSTATIC|CHAT_SEE_COOLCHAT)

#define PARALLAX_INSANE -1 //for show offs
#define PARALLAX_HIGH    0 //default.
#define PARALLAX_MED     1
#define PARALLAX_LOW     2
#define PARALLAX_DISABLE 3 //this option must be the highest number

#define PARALLAX_DELAY_DEFAULT world.tick_lag
#define PARALLAX_DELAY_MED     1
#define PARALLAX_DELAY_LOW     2

#define SEC_DEPT_NONE "None"
#define SEC_DEPT_RANDOM "Random"
#define SEC_DEPT_ENGINEERING "Engineering"
#define SEC_DEPT_MEDICAL "Medical"
#define SEC_DEPT_SCIENCE "Science"
#define SEC_DEPT_SUPPLY "Supply"

// Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING			"Living"
#define EXP_TYPE_CREW			"Crew"
#define EXP_TYPE_COMMAND		"Command"
#define EXP_TYPE_ENGINEERING	"Engineering"
#define EXP_TYPE_MEDICAL		"Medical"
#define EXP_TYPE_SCIENCE		"Science"
#define EXP_TYPE_SUPPLY			"Supply"
#define EXP_TYPE_SECURITY		"Security"
#define EXP_TYPE_SILICON		"Silicon"
#define EXP_TYPE_SERVICE		"Service"
#define EXP_TYPE_ANTAG			"Antag"
#define EXP_TYPE_SPECIAL		"Special"
#define EXP_TYPE_GHOST			"Ghost"
//#define EXP_TYPE_BIKER			"Ashdown Overlook"
#define EXP_TYPE_ADMIN			"Admin"
//f13 stuff
#define EXP_TYPE_FALLOUT		"Fallout"
#define EXP_TYPE_VAULT			"Vault"
#define EXP_TYPE_BROTHERHOOD	"Southern BoS Outcasts"
#define EXP_TYPE_NCR			"Ncr"
#define EXP_TYPE_OASIS "Oasis"
#define EXP_TYPE_LEGION			"Legion"
#define EXP_TYPE_WASTELAND		"Wasteland"
#define EXP_TYPE_ENCLAVE		"Enclave"
#define EXP_TYPE_NCRCOMMAND     "NCRCommand"
#define EXP_TYPE_RANGER         "Ranger"
#define EXP_TYPE_SCRIBE         "Scribe"
#define EXP_TYPE_DECANUS        "Decanus"
#define EXP_TYPE_TRIBAL			"Tribal"
#define EXP_TYPE_FOLLOWERS		"New Boston Clinic"
#define EXP_TYPE_OUTLAW			"Outlaw"
#define EXP_TYPE_KHAN			"Great Khans"
#define EXP_TYPE_CLUB			"Heavens Night"
//Flags in the players table in the db
#define DB_FLAG_EXEMPT 							(1<<0)
#define DB_FLAG_AGE_CONFIRMATION_INCOMPLETE		(1<<1)
#define DB_FLAG_AGE_CONFIRMATION_COMPLETE		(1<<2)

#define DEFAULT_CYBORG_NAME "Default Cyborg Name"

//Job preferences levels
#define JP_LOW 1
#define JP_MEDIUM 2
#define JP_HIGH 3

//Chaos levels for dynamic voting
#define CHAOS_NONE "None (Extended)"
#define CHAOS_LOW "Low"
#define CHAOS_MED "Medium"
#define CHAOS_HIGH "High"
#define CHAOS_MAX "Maximum"

#define TBS_TOP "I am a top!"
#define TBS_BOTTOM "I am a bottom!"
#define TBS_SHOES "I am a switch!"
#define TBS_NONE "I am none of these!"
#define TBS_DEFAULT TBS_NONE
#define TBS_LIST list(TBS_TOP, TBS_BOTTOM, TBS_SHOES, TBS_NONE)

#define KISS_BOYS "I am a boykisser!"
#define KISS_GIRLS "I am a girlkisser!"
#define KISS_ANY "I'll kiss anybody!"
#define KISS_NONE "I don't kiss!"
#define KISS_DEFAULT KISS_NONE
#define KISS_LIST list(KISS_BOYS,KISS_GIRLS,KISS_ANY,KISS_NONE)

GLOBAL_LIST_INIT(undie_position_strings, list("Under Clothes", "Over Clothes", "Over Suit", "Over EVERYTHING"))
#define UNDERWEAR_UNDER_CLOTHES 0
#define UNDERWEAR_OVER_UNIFORM 1
#define UNDERWEAR_OVER_SUIT 2
#define UNDERWEAR_OVER_EVERYTHING 3

//CB Toggles
#define AIM_CURSOR_ON (1<<0)

/// Changelog entries
#define PMC_OOC_NOTES_UPDATE "update_ur_ooc" // Player Master Changelog
#define PMC_QUIRK_OVERHAUL_2K23 "updated_ur_quirks" // Player Master Changelog
#define PMC_DAN_MESSED_UP_WHO_STUFF "whoops" // Player Master Changelog
#define PMC_PORNHUD_WHITELIST_RELOCATION "ur_nads_are_here_now" // Player Master Changelog
#define PMC_UNBREAK_FAVORITE_PLAPS "/datum/interaction/bang/datum/interaction/funch" // Player Master Changelog
#define PMC_FENNY_FINISHED_124_QUESTS "and_killed_the_server" // Player Master Changelog
#define PMC_MY_PDA_FLIES_IN_FULL_COLOR "nekooooooooo" // Player Master Changelog
#define PMC_MOMMYCHAT_IS_COOL "ill be your mommy tonight uwu" // Player Master Changelog

/// The master Preferences Changelog to check the player's prefs against.
/// includes a list of actions that need to be taken to update the player's prefs.
#define PREFERENCES_MASTER_CHANGELOG list(\
	PMC_OOC_NOTES_UPDATE, \
	PMC_QUIRK_OVERHAUL_2K23,\
	PMC_DAN_MESSED_UP_WHO_STUFF,\
	PMC_FENNY_FINISHED_124_QUESTS,\
	PMC_MY_PDA_FLIES_IN_FULL_COLOR,\
	PMC_MOMMYCHAT_IS_COOL,\
)

#define PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF "lookingatyouwiretap" // Player Master Changelog
#define PMR_DAN_MESSED_UP_CHATPREFS "chatprefs" // Player Master Changelog
#define PMR_ADDED_RADIO_BLURBLES "CHAT_HEAR_RADIOBLURBLES" // Player Master Changelog
#define PMR_ADDED_RADIO_STATIC "PMR_ADDED_RADIO_STATIC" // Player Master Changelog
#define PMR_ADDED_COOLCHAT "fill-me-to-the-brimcon" // Player Master Changelog
#define PMR_RUNECHAT_LENGTHENING "long_long_maaaaaaaaaaaaan" // Player Master Changelog
#define PMR_REMOVE_CORK_STRING "yes_it_was_funny_once" // Player Master Changelog

/// The master Preferences Changelog to check the player's prefs against.
/// includes a list of actions that need to be taken to update the player's prefs.
#define PREFERENCES_MASTER_REVISIONLIST list(\
	PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF,\
	PMR_ADDED_RADIO_STATIC,\
	PMR_ADDED_RADIO_BLURBLES,\
	PMR_DAN_MESSED_UP_CHATPREFS,\
	PMR_ADDED_COOLCHAT,\
	PMR_RUNECHAT_LENGTHENING,\
	PMR_REMOVE_CORK_STRING,\
)

#define PREFCMD_ACTION_BUTTONS              "PREFCMD_ACTION_BUTTONS"
#define PREFCMD_ADD_LIMB                    "PREFCMD_ADD_LIMB"
#define PREFCMD_ADMINHELP                   "PREFCMD_ADMINHELP"
#define PREFCMD_ALLOW_BEING_FED_PREY        "PREFCMD_ALLOW_BEING_FED_PREY"
#define PREFCMD_ALLOW_BEING_PREY            "PREFCMD_ALLOW_BEING_PREY"
#define PREFCMD_ALLOW_DEATH_MESSAGES        "PREFCMD_ALLOW_DEATH_MESSAGES"
#define PREFCMD_ALLOW_DIGESTION_DAMAGE      "PREFCMD_ALLOW_DIGESTION_DAMAGE"
#define PREFCMD_ALLOW_DIGESTION_DEATH       "PREFCMD_ALLOW_DIGESTION_DEATH"
#define PREFCMD_ALLOW_DIGESTION_SOUNDS      "PREFCMD_ALLOW_DIGESTION_SOUNDS"
#define PREFCMD_ALLOW_EATING_SOUNDS         "PREFCMD_ALLOW_EATING_SOUNDS"
#define PREFCMD_ALLOW_TRASH_MESSAGES        "PREFCMD_ALLOW_TRASH_MESSAGES"
#define PREFCMD_ALLOW_VORE_MESSAGES         "PREFCMD_ALLOW_VORE_MESSAGES"
#define PREFCMD_ALT_PREFIX                  "PREFCMD_ALT_PREFIX"
#define PREFCMD_AMBIENTOCCLUSION            "PREFCMD_AMBIENTOCCLUSION"
#define PREFCMD_ANNOUNCE_LOGIN              "PREFCMD_ANNOUNCE_LOGIN"
#define PREFCMD_AROUSABLE                   "PREFCMD_AROUSABLE"
#define PREFCMD_AUTO_FIT_VIEWPORT           "PREFCMD_AUTO_FIT_VIEWPORT"
#define PREFCMD_AUTO_OOC                    "PREFCMD_AUTO_OOC"
#define PREFCMD_AUTO_WAG                    "PREFCMD_AUTO_WAG"
#define PREFCMD_AUTOSTAND_TOGGLE            "PREFCMD_AUTOSTAND_TOGGLE"
#define PREFCMD_BACKPACK_KIND               "PREFCMD_BACKPACK_KIND"
#define PREFCMD_BLURBLE_MAX_WORDS           "PREFCMD_BLURBLE_MAX_WORDS"
#define PREFCMD_BLURBLE_PITCH               "PREFCMD_BLURBLE_PITCH"
#define PREFCMD_BLURBLE_SOUND               "PREFCMD_BLURBLE_SOUND"
#define PREFCMD_BLURBLE_SPEED               "PREFCMD_BLURBLE_SPEED"
#define PREFCMD_BLURBLE_TRIGGER             "PREFCMD_BLURBLE_TRIGGER"
#define PREFCMD_BLURBLE_VARY                "PREFCMD_BLURBLE_VARY"
#define PREFCMD_BLURBLE_VOLUME              "PREFCMD_BLURBLE_VOLUME"
#define PREFCMD_BODY_MODEL                  "PREFCMD_BODY_MODEL"
#define PREFCMD_BODY_SPRITE                 "PREFCMD_BODY_SPRITE"
#define PREFCMD_BUTT_SLAP                   "PREFCMD_BUTT_SLAP"
#define PREFCMD_BYOND_PUBLICITY             "PREFCMD_BYOND_PUBLICITY"
#define PREFCMD_CHANGE_AGE                  "PREFCMD_CHANGE_AGE"
#define PREFCMD_CHANGE_FLAVOR_TEXT          "PREFCMD_CHANGE_FLAVOR_TEXT"
#define PREFCMD_CHANGE_GENDER               "PREFCMD_CHANGE_GENDER"
#define PREFCMD_CHANGE_GENITAL_SHAPE        "PREFCMD_CHANGE_GENITAL_SHAPE"
#define PREFCMD_CHANGE_GENITAL_SIZE         "PREFCMD_CHANGE_GENITAL_SIZE"
#define PREFCMD_CHANGE_KISSER               "PREFCMD_CHANGE_KISSER"
#define PREFCMD_CHANGE_NAME                 "PREFCMD_CHANGE_NAME"
#define PREFCMD_CHANGE_OOC_NOTES            "PREFCMD_CHANGE_OOC_NOTES"
#define PREFCMD_CHANGE_PART                 "PREFCMD_CHANGE_PART"
#define PREFCMD_CHANGE_SLOT                 "PREFCMD_CHANGE_SLOT"
#define PREFCMD_CHANGE_TBS                  "PREFCMD_CHANGE_TBS"
#define PREFCMD_CHAT_ON_MAP                 "PREFCMD_CHAT_ON_MAP"
#define PREFCMD_CHAT_WIDTH                  "PREFCMD_CHAT_WIDTH"
#define PREFCMD_CLIENTFPS                   "PREFCMD_CLIENTFPS"
#define PREFCMD_COLOR_CHANGE                "PREFCMD_COLOR_CHANGE"
#define PREFCMD_COLOR_CHAT_LOG              "PREFCMD_COLOR_CHAT_LOG"
#define PREFCMD_COLOR_COPY                  "PREFCMD_COLOR_COPY"
#define PREFCMD_COLOR_DEL                   "PREFCMD_COLOR_DEL"
#define PREFCMD_COLOR_PASTE                 "PREFCMD_COLOR_PASTE"
#define PREFCMD_COMBOHUD_LIGHTING           "PREFCMD_COMBOHUD_LIGHTING"
#define PREFCMD_DAMAGESCREENSHAKE_TOGGLE    "PREFCMD_DAMAGESCREENSHAKE_TOGGLE"
#define PREFCMD_EYE_TYPE                    "PREFCMD_EYE_TYPE"
#define PREFCMD_FACIAL_HAIR_STYLE           "PREFCMD_FACIAL_HAIR_STYLE"
#define PREFCMD_FUZZY                       "PREFCMD_FUZZY"
#define PREFCMD_GENITAL_EXAMINE             "PREFCMD_GENITAL_EXAMINE"
#define PREFCMD_GHOST_ACCS                  "PREFCMD_GHOST_ACCS"
#define PREFCMD_GHOST_EARS                  "PREFCMD_GHOST_EARS"
#define PREFCMD_GHOST_FORM                  "PREFCMD_GHOST_FORM"
#define PREFCMD_GHOST_ORBIT                 "PREFCMD_GHOST_ORBIT"
#define PREFCMD_GHOST_OTHERS                "PREFCMD_GHOST_OTHERS"
#define PREFCMD_GHOST_PDA                   "PREFCMD_GHOST_PDA"
#define PREFCMD_GHOST_RADIO                 "PREFCMD_GHOST_RADIO"
#define PREFCMD_GHOST_SIGHT                 "PREFCMD_GHOST_SIGHT"
#define PREFCMD_GHOST_WHISPERS              "PREFCMD_GHOST_WHISPERS"
#define PREFCMD_GUNCURSOR_TOGGLE            "PREFCMD_GUNCURSOR_TOGGLE"
#define PREFCMD_HAIR_GRADIENT_1             "PREFCMD_HAIR_GRADIENT_1"
#define PREFCMD_HAIR_GRADIENT_2             "PREFCMD_HAIR_GRADIENT_2"
#define PREFCMD_HAIR_STYLE_1                "PREFCMD_HAIR_STYLE_1"
#define PREFCMD_HAIR_STYLE_2                "PREFCMD_HAIR_STYLE_2"
#define PREFCMD_HEALTH_SMILEYS              "PREFCMD_HEALTH_SMILEYS"
#define PREFCMD_HIDE_GENITAL                "PREFCMD_HIDE_GENITAL"
#define PREFCMD_HOTKEY_HELP                 "PREFCMD_HOTKEY_HELP"
#define PREFCMD_HOTKEYS                     "PREFCMD_HOTKEYS"
#define PREFCMD_HUD_TOGGLE_FLASH            "PREFCMD_HUD_TOGGLE_FLASH"
#define PREFCMD_HUNTINGHORN                 "PREFCMD_HUNTINGHORN"
#define PREFCMD_INCOME_UPDATES              "PREFCMD_INCOME_UPDATES"
#define PREFCMD_INPUT_MODE_HOTKEY           "PREFCMD_INPUT_MODE_HOTKEY"
#define PREFCMD_KEYBINDING_CAPTURE          "keybindings_set"
#define PREFCMD_KEYBINDING_CATEGORY_TOGGLE  "PREFCMD_KEYBINDING_CATEGORY_TOGGLE"
#define PREFCMD_KEYBINDING_SET              "PREFCMD_KEYBINDING_SET"
#define PREFCMD_LEGS                        "PREFCMD_LEGS"
#define PREFCMD_LOADOUT_CATEGORY            "PREFCMD_LOADOUT_CATEGORY"
#define PREFCMD_LOADOUT_REDESC              "PREFCMD_LOADOUT_REDESC"
#define PREFCMD_LOADOUT_RENAME              "PREFCMD_LOADOUT_RENAME"
#define PREFCMD_LOADOUT_RESET               "PREFCMD_LOADOUT_RESET"
#define PREFCMD_LOADOUT_SEARCH              "PREFCMD_LOADOUT_SEARCH"
#define PREFCMD_LOADOUT_SEARCH_CLEAR        "PREFCMD_LOADOUT_SEARCH_CLEAR"
#define PREFCMD_LOADOUT_SUBCATEGORY         "PREFCMD_LOADOUT_SUBCATEGORY"
#define PREFCMD_LOADOUT_TOGGLE              "PREFCMD_LOADOUT_TOGGLE"
#define PREFCMD_LOBBY_MUSIC                 "PREFCMD_LOBBY_MUSIC"
#define PREFCMD_MARKING_ADD                 "PREFCMD_MARKING_ADD"
#define PREFCMD_MARKING_EDIT                "PREFCMD_MARKING_EDIT"
#define PREFCMD_MARKING_MOVE_DOWN           "PREFCMD_MARKING_MOVE_DOWN"
#define PREFCMD_MARKING_MOVE_UP             "PREFCMD_MARKING_MOVE_UP"
#define PREFCMD_MARKING_NEXT                "PREFCMD_MARKING_NEXT"
#define PREFCMD_MARKING_PREV                "PREFCMD_MARKING_PREV"
#define PREFCMD_MARKING_REMOVE              "PREFCMD_MARKING_REMOVE"
#define PREFCMD_MASTER_VORE_TOGGLE          "PREFCMD_MASTER_VORE_TOGGLE"
#define PREFCMD_MAX_CHAT_LENGTH             "PREFCMD_MAX_CHAT_LENGTH"
#define PREFCMD_MAX_PFP_HEIGHT              "PREFCMD_MAX_PFP_HEIGHT"
#define PREFCMD_MAX_PFP_WIDTH               "PREFCMD_MAX_PFP_WIDTH"
#define PREFCMD_MEAT_TYPE                   "PREFCMD_MEAT_TYPE"
#define PREFCMD_MIDIS                       "PREFCMD_MIDIS"
#define PREFCMD_MISMATCHED_MARKINGS         "PREFCMD_MISMATCHED_MARKINGS"
#define PREFCMD_MODIFY_LIMB                 "PREFCMD_MODIFY_LIMB"
#define PREFCMD_OFFSCREEN                   "PREFCMD_OFFSCREEN"
#define PREFCMD_OVERRIDE_GENITAL            "PREFCMD_OVERRIDE_GENITAL"
#define PREFCMD_PDA_KIND                    "PREFCMD_PDA_KIND"
#define PREFCMD_PDA_RINGTONE                "PREFCMD_PDA_RINGTONE"
#define PREFCMD_PHUD_WHITELIST              "PREFCMD_PHUD_WHITELIST"
#define PREFCMD_PIXEL_X                     "PREFCMD_PIXEL_X"
#define PREFCMD_PIXEL_Y                     "PREFCMD_PIXEL_Y"
#define PREFCMD_PULL_REQUESTS               "PREFCMD_PULL_REQUESTS"
#define PREFCMD_RADIO_BLURBLES              "PREFCMD_RADIO_BLURBLES"
#define PREFCMD_RADIO_STATIC                "PREFCMD_RADIO_STATIC"
#define PREFCMD_RAINBOW_BLOOD               "PREFCMD_RAINBOW_BLOOD"
#define PREFCMD_REMOVE_LIMB                 "PREFCMD_REMOVE_LIMB"
#define PREFCMD_SAVE                        "PREFCMD_SAVE"
#define PREFCMD_SCALE                       "PREFCMD_SCALE"
#define PREFCMD_SCARS                       "PREFCMD_SCARS"
#define PREFCMD_SCARS_CLEAR                 "PREFCMD_SCARS_CLEAR"
#define PREFCMD_SCREENSHAKE_TOGGLE          "PREFCMD_SCREENSHAKE_TOGGLE"
#define PREFCMD_SEE_CHAT_NON_MOB            "PREFCMD_SEE_CHAT_NON_MOB"
#define PREFCMD_SEE_GENITAL                 "PREFCMD_SEE_GENITAL"
#define PREFCMD_SEE_RC_EMOTES               "PREFCMD_SEE_RC_EMOTES"
#define PREFCMD_SET_SUBSUBTAB               "PREFCMD_SET_SUBSUBTAB"
#define PREFCMD_SET_SUBTAB                  "PREFCMD_SET_SUBTAB"
#define PREFCMD_SET_TAB                     "PREFCMD_SET_TAB"
#define PREFCMD_SHIFT_GENITAL               "PREFCMD_SHIFT_GENITAL"
#define PREFCMD_SHOW_THIS_MANY_CHARS        "PREFCMD_SHOW_THIS_MANY_CHARS"
#define PREFCMD_SKIN_TONE                   "PREFCMD_SKIN_TONE"
#define PREFCMD_SLOT_COPY                    "PREFCMD_SLOT_COPY"
#define PREFCMD_SLOT_DELETE                      "PREFCMD_SLOT_DELETE"
#define PREFCMD_SLOT_PASTE                   "PREFCMD_SLOT_PASTE"
#define PREFCMD_SOCKS                       "PREFCMD_SOCKS"
#define PREFCMD_SOCKS_OVERCLOTHES           "PREFCMD_SOCKS_OVERCLOTHES"
#define PREFCMD_SPECIES                     "PREFCMD_SPECIES"
#define PREFCMD_SPECIES_NAME                "PREFCMD_SPECIES_NAME"
#define PREFCMD_SPLIT_ADMIN_TABS            "PREFCMD_SPLIT_ADMIN_TABS"
#define PREFCMD_SPRINTBUFFER                "PREFCMD_SPRINTBUFFER"
#define PREFCMD_STAT_CHANGE                 "PREFCMD_STAT_CHANGE"
#define PREFCMD_TASTE                       "PREFCMD_TASTE"
#define PREFCMD_TETRIS_STORAGE_TOGGLE       "PREFCMD_TETRIS_STORAGE_TOGGLE"
#define PREFCMD_TGUI_FANCY                  "PREFCMD_TGUI_FANCY"
#define PREFCMD_TGUI_LOCK                   "PREFCMD_TGUI_LOCK"
#define PREFCMD_TOGGLE_GENITAL              "PREFCMD_TOGGLE_GENITAL"
#define PREFCMD_TOGGLE_SHOW_CHARACTER_LIST  "PREFCMD_TOGGLE_SHOW_CHARACTER_LIST"
#define PREFCMD_UI_STYLE                    "PREFCMD_UI_STYLE"
#define PREFCMD_UNDERSHIRT                  "PREFCMD_UNDERSHIRT"
#define PREFCMD_UNDERSHIRT_OVERCLOTHES      "PREFCMD_UNDERSHIRT_OVERCLOTHES"
#define PREFCMD_UNDERWEAR                   "PREFCMD_UNDERWEAR"
#define PREFCMD_UNDERWEAR_OVERCLOTHES       "PREFCMD_UNDERWEAR_OVERCLOTHES"
#define PREFCMD_UNDO                        "PREFCMD_UNDO"
#define PREFCMD_UPPERLOWERFLOOR             "PREFCMD_UPPERLOWERFLOOR"
#define PREFCMD_VCHAT                       "PREFCMD_VCHAT"
#define PREFCMD_WIDESCREEN_TOGGLE           "PREFCMD_WIDESCREEN_TOGGLE"
#define PREFCMD_WIDTH                       "PREFCMD_WIDTH"
#define PREFCMD_WINFLASH                    "PREFCMD_WINFLASH"

#define PREFDAT_CATEGORY              "PREFDAT_CATEGORY"
#define PREFDAT_COLOR_HEX             "PREFDAT_COLOR_HEX"
#define PREFDAT_COLKEY_IS_COLOR       "PREFDAT_COLKEY_IS_COLOR"
#define PREFDAT_COLKEY_IS_FEATURE     "PREFDAT_COLKEY_IS_FEATURE"
#define PREFDAT_COLKEY_IS_VAR         "PREFDAT_COLKEY_IS_VAR"
#define PREFDAT_COLOR_KEY             "PREFDAT_COLOR_KEY"
#define PREFDAT_GEAR_PATH             "PREFDAT_GEAR_PATH"
#define PREFDAT_GEAR_TYPE             "PREFDAT_GEAR_TYPE"
#define PREFDAT_LOADOUT_GEAR_NAME     "PREFDAT_LOADOUT_GEAR_NAME"
#define PREFDAT_GENITAL_HAS           "PREFDAT_GENITAL_HAS"
#define PREFDAT_GO_NEXT               "PREFDAT_GO_NEXT"
#define PREFDAT_GO_PREV               "PREFDAT_GO_PREV"
#define PREFDAT_HIDDEN_BY             "PREFDAT_HIDDEN_BY"
#define PREFDAT_INDEPENDENT           "PREFDAT_INDEPENDENT"
#define PREFDAT_INDEX_IS_MARKING_UID  "PREFDAT_INDEX_IS_MARKING_UID"
#define PREFDAT_IS_GEAR               "PREFDAT_IS_GEAR"
#define PREFDAT_IS_MARKING            "PREFDAT_IS_MARKING"
#define PREFDAT_KEYBINDING            "PREFDAT_KEYBINDING"
#define PREFDAT_LOADOUT_CATEGORY      "PREFDAT_LOADOUT_CATEGORY"
#define PREFDAT_LOADOUT_SEARCH        "PREFDAT_LOADOUT_SEARCH"
#define PREFDAT_LOADOUT_SLOT          "PREFDAT_LOADOUT_SLOT"
#define PREFDAT_LOADOUT_SUBCATEGORY   "PREFDAT_LOADOUT_SUBCATEGORY"
#define PREFDAT_MARKING_ACTION        "PREFDAT_MARKING_ACTION"
#define PREFDAT_MARKING_SLOT          "PREFDAT_MARKING_SLOT"
#define PREFDAT_MARKING_UID           "PREFDAT_MARKING_UID"
#define PREFDAT_MODIFY_LIMB_MOD       "PREFDAT_MODIFY_LIMB_MOD"
#define PREFDAT_OLD_KEY               "PREFDAT_OLD_KEY"
#define PREFDAT_PARTKIND              "PREFDAT_PARTKIND"
#define PREFDAT_REMOVE_LIMB_MOD       "PREFDAT_REMOVE_LIMB_MOD"
#define PREFDAT_SLOT                  "PREFDAT_SLOT"
#define PREFDAT_SUBSUBTAB             "PREFDAT_SUBSUBTAB"
#define PREFDAT_SUBTAB                "PREFDAT_SUBTAB"
#define PREFDAT_SUPPRESS_MESSAGE      "PREFDAT_SUPPRESS_MESSAGE"
#define PREFDAT_STAT                  "PREFDAT_STAT"
#define PREFDAT_TAB                   "PREFDAT_TAB"
#define PREFDAT_TOGGLE_HIDE_UNDIES    "PREFDAT_TOGGLE_HIDE_UNDIES"

#define STAT_STRENGTH      "special_s"
#define STAT_PERCEPTION    "special_p"
#define STAT_ENDURANCE     "special_e"
#define STAT_CHARISMA      "special_c"
#define STAT_INTELLIGENCE  "special_i"
#define STAT_AGILITY       "special_a"
#define STAT_LUCK          "special_l"

// supported parts
#define BPART_DECO_WINGS       "deco_wings"
#define BPART_DERG_BELLY       "derg_belly"
#define BPART_DERG_BODY        "derg_body"
#define BPART_DERG_EARS        "derg_ears"
#define BPART_DERG_EYES        "derg_eyes"
#define BPART_DERG_HORNS       "derg_horns"
#define BPART_DERG_MANE        "derg_mane"
#define BPART_EARS             "ears"
#define BPART_FRILLS           "frills"
#define BPART_HORNS            "horns"
#define BPART_HORNS_COLOR      "horns_color"
#define BPART_INSECT_FLUFF     "insect_fluff"
#define BPART_INSECT_MARKINGS  "insect_markings"
#define BPART_INSECT_WINGS     "insect_wings"
#define BPART_IPC_ANTENNA      "ipc_antenna"
#define BPART_IPC_SCREEN       "ipc_screen"
#define BPART_MAM_EARS         "mam_ears"
#define BPART_MAM_SNOUTS       "mam_snouts"
#define BPART_MAM_TAIL         "mam_tail"
#define BPART_SNOUT            "snout"
#define BPART_SPINES           "spines"
#define BPART_TAIL_HUMAN       "tail_human"
#define BPART_TAIL_LIZARD      "tail_lizard"
#define BPART_TAUR             "taur"
#define BPART_WINGS            "wings"
#define BPART_WINGS_COLOR      "wings_color"
#define BPART_XENODORSAL       "xenodorsal"
#define BPART_XENOHEAD         "xenohead"
#define BPART_XENOTAIL         "xenotail"

#define PRACT_DIALOG_ACCEPT         "PRACT_DIALOG_ACCEPT"
#define PRACT_DIALOG_ACCEPT_BIG     "PRACT_DIALOG_ACCEPT_BIG"
#define PRACT_DIALOG_ACCEPT_SMOL    "PRACT_DIALOG_ACCEPT_SMOL"
#define PRACT_DIALOG_CANCEL         "PRACT_DIALOG_CANCEL"
#define PRACT_DIALOG_DENIED         "PRACT_DIALOG_DENIED"
#define PRACT_DIALOG_ERROR          "PRACT_DIALOG_ERROR"
#define PRACT_DIALOG_FAILED         "PRACT_DIALOG_FAILED"
#define PRACT_TOGGLE(something)     ((something) ? PRACT_DIALOG_ACCEPT : PRACT_DIALOG_DENIED)
#define PRACT_TOGGLE_INV(something) ((something) ? PRACT_DIALOG_DENIED : PRACT_DIALOG_ACCEPT)

#define BOOP_BIG_MENU_OPEN "BOOP_BIG_MENU_OPEN"
#define BOOP_MENU_OPEN     "BOOP_MENU_OPEN"
#define BOOP_SUB_PROMPT    "BOOP_SUB_PROMPT"
#define BOOP_ACCEPT        "BOOP_ACCEPT"
#define BOOP_ACCEPT_BIG    "BOOP_ACCEPT_BIG"
#define BOOP_ACCEPT_SMOL   "BOOP_ACCEPT_SMOL"
#define BOOP_CANCEL        "BOOP_CANCEL"
#define BOOP_DENIED        "BOOP_DENIED"
#define BOOP_ERROR         "BOOP_ERROR"
#define BOOP_FAILED        "BOOP_FAILED"




