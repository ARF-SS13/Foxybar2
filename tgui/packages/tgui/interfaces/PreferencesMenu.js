/* eslint-disable react/jsx-pascal-case */
// 80 characters is not big enough for my yiff yiff
/* eslint-disable max-len */
import { useBackend, useLocalState } from '../backend';
import { toFixed } from 'common/math';
import { multiline } from 'common/string';
import {
  AnimatedNumber,
  Box,
  Button,
  Divider,
  Dropdown,
  Flex,
  Fragment,
  Icon,
  Input,
  Knob,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
  Table,
  TextArea,
  ToggleBox,
  Tooltip,
} from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

const bigbutton_min_width = "200px";
const LR_SettingNameWidth = "100px";
const ColorBoxWidth = "100px";

export const PreferencesMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    real_name = "Rex Bingus",
  } = data;
  return (
    <Window
      width={900}
      height={600}
      title={`Preferences - ${real_name}`}
      theme="greenenu"
      resizable>
      <Window.Content
        style={{
          "background": "linear-gradient(180deg, #2F4F4F, #1F3A3A)",
        }}>
        <Stack fill>
          <Stack.Item>
            <Stack fill vertical>
              <Stack.Item>
                <CharacterSelect />
              </Stack.Item>
              <Stack.Item>
                <TabBlocks />
              </Stack.Item>
              <Stack.Item grow shrink> {/* grow shrink my beloved, you have saved so many of my garbo layouts */}
                <Section fill scrollable>
                  <MainWindow />
                </Section>
              </Stack.Item>
              <Stack.Item>
                <SaveLoadHorny />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <CharacterPreview />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// This is the character select menu! Its an array of buttons that you can click
// to select a character!
const CharacterSelect = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    characters = [],
    current_slot = 0,
  } = data;

  return (
    <Section
      title="Who are you today?"
      fill>
      <Flex
        wrap="wrap"
        justify="center">
        {characters.map((character, index) => (
          <Flex.Item
            key={index}
            min_width={bigbutton_min_width}>
            <CharacterButton
              key={index}
              character={character}
              index={index}
              current_slot={current_slot} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

// This is the character button! It's a button that you can click to select a
// character! It's a button!
const CharacterButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    character,
    index,
    current_slot,
  } = props;
  const charname = character ? character.name : `Character ${index + 1}`;
  const is_current = (index + 1) === current_slot;

  return (
    <Button
      selected={is_current}
      nowrap
      content={charname}
      onClick={() => act('PREFCMD_CHANGE_SLOT',
        { 'PREFDAT_SLOT': index + 1 })} />
  );
};

// This is the tab blocks! They're a set of buttons that you can click to
// select a tab! They're buttons!
const TabBlocks = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    category_tabs_line1 = [],
    category_tabs_line2 = [],
    current_category = "",
    subcategory_tabs = [],
    current_subcategory = "",
    subsubcategory_tabs = [],
    current_subsubcategory = "",
    tab2words = {}, // diccionario de tab a palabras para mostrar en el boton de tab (ej: "tab1": "Tab 1")
  } = data;

  return (
    <Section fill>
      <Stack fill vertical> {/* Container for all the category groups */}
        <Stack.Item> {/* Top level category tabs */}
          <Stack fill>
            <Stack.Item> {/* First line of category tabs */}
              <Stack fill>
                {category_tabs_line1.map((category, index) => (
                  <Stack.Item
                    key={index}
                    grow>
                    <TabButton
                      key={index}
                      tab={category}
                      tablevel={1}
                      current_tab={current_category}
                      words={tab2words[category] || category} />
                  </Stack.Item>
                ))}
              </Stack>
            </Stack.Item>
            <Stack.Item> {/* Second line of category tabs */}
              <Stack fill>
                {category_tabs_line2.map((category, index) => (
                  <Stack.Item
                    key={index}
                    grow>
                    <TabButton
                      key={index}
                      tab={category}
                      current_tab={current_category}
                      words={tab2words[category] || category} />
                  </Stack.Item>
                ))}
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        {subcategory_tabs.length > 0 && (/* Subcategory tabs */
          <Stack.Item>
            <Stack fill>
              {subcategory_tabs.map((category, index) => (
                <Stack.Item
                  key={index}
                  grow>
                  <TabButton
                    key={index}
                    tab={category}
                    current_tab={current_subcategory}
                    words={tab2words[category] || category} />
                </Stack.Item>
              ))}
            </Stack>
          </Stack.Item>
        ) || null}
        {subsubcategory_tabs.length > 0 && (/* Subsubcategory tabs */
          <Stack.Item>
            <Stack fill>
              {subsubcategory_tabs.map((category, index) => (
                <Stack.Item
                  key={index}
                  grow>
                  <TabButton
                    key={index}
                    tab={category}
                    current_tab={current_subsubcategory}
                    words={tab2words[category] || category} />
                </Stack.Item>
              ))}
            </Stack>
          </Stack.Item>
        ) || null}
      </Stack>
    </Section>
  );
};

// This is the tab button! It's a button that you can click to select a tab! It's
// a button!
const TabButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    tab = "",
    current_tab = "",
    words = "",
  } = props;
  const is_current = tab === current_tab;

  return (
    <Button
      selected={is_current}
      content={words}
      onClick={() => act('PREFCMD_SET_TAB',
        { 'PREFDAT_TAB': tab })} />
  );
};

// This is the main window! It's a window that contains the main content of the
// preferences menu! Its a clever switch statement that renders different
// components based on the current tab, subtab, or subsubtab!
const MainWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    selected_tab = "",
  } = data;
  // the subsubcategories are part undies and layering, and part binguses
  // this checks if the current subsubcategory contains "has_" in the name
  if (current_subsubcategory && current_subsubcategory.includes("has_")) {
    return (
      <HasBingus />
    );
  }
  // now a huge switchcase!
  switch (selected_tab) {
    case "PPT_CHARCTER_PROPERTIES":
    case "PPT_CHARCTER_PROPERTIES_INFO":
      return (
        <CharacterInfo />
      );
    case "PPT_CHARCTER_PROPERTIES_VOICE":
      return (
        <CharacterVoice />
      );
    case "PPT_CHARCTER_PROPERTIES_MISC":
      return (
        <CharacterMisc />
      );
    case "PPT_CHARCTER_APPEARANCE":
    case "PPT_CHARCTER_APPEARANCE_MISC":
      return (
        <CharacterAppearanceMisc />
      );
    case "PPT_CHARCTER_APPEARANCE_HAIR_EYES":
      return (
        <CharacterHairEyes />
      );
    case "PPT_CHARCTER_APPEARANCE_PARTS":
      return (
        <CharacterParts />
      );
    case "PPT_CHARCTER_APPEARANCE_MARKINGS":
      return (
        <CharacterMarkings />
      );
    case "PPT_CHARCTER_APPEARANCE_UNDERLYING":
    case "PPT_CHARCTER_APPEARANCE_UNDERLYING_UNDIES":
      return (
        <CharacterUndies />
      );
    case "PPT_CHARCTER_APPEARANCE_UNDERLYING_LAYERING":
      return (
        <CharacterLayering />
      );
    case "PPT_LOADOUT":
      return (
        <CharacterLoadout />
      );
    case "PPT_GAME_PREFERENCES":
    case "PPT_GAME_PREFERENCES_GENERAL":
      return (
        <GamePreferencesGeneral />
      );
    case "PPT_GAME_PREFERENCES_UI":
      return (
        <GamePreferencesUI />
      );
    case "PPT_GAME_PREFERENCES_CHAT":
      return (
        <GamePreferencesChat />
      );
    case "PPT_GAME_PREFERENCES_RUNECHAT":
      return (
        <GamePreferencesRunechat />
      );
    case "PPT_GAME_PREFERENCES_GHOST":
      return (
        <GamePreferencesGhost />
      );
    case "PPT_GAME_PREFERENCES_AUDIO":
      return (
        <GamePreferencesAudio />
      );
    case "PPT_GAME_PREFERENCES_ADMIN":
      return (
        <GamePreferencesAdmin />
      );
    case "PPT_GAME_PREFERENCES_CONTENT":
      return (
        <GamePreferencesContent />
      );
    case "PPT_KEYBINDINGS":
      return (
        <Keybindings />
      );
    default:
      return (
        <NoticeBox>
          Grumble grumble, something went wrong.
        </NoticeBox>
      );
  }
};

// This is the character info! It's a form that you can fill out to set your
// character's name, gunder, and other properties!
// its a split form, with the left side being the form and the right side being
// flavor text and such, kinda like a passport
const CharacterInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = "",
    age = 21,
    gender = "meef",
    tbs = "I am a top!",
    kiss = "I kiss passionately!",
    flavor_text = "Cool description goes here!",
    ooc_text = "OOC info goes here!",
    profile_pic_link = "www.ohno.dwingus",
  } = data;

  return (
    <Section fill>
      <Stack fill> {/* Leftright split */}
        <Stack.Item basis="50%"> {/* Left side */}
          <Section fill>
            <Stack fill vertical>
              <Stack.Item> {/* Profile picture */}
                <Box
                  width="100%"
                  height="100px"
                  backgroundSize="cover"
                  backgroundImage={`url(${profile_pic_link})`} />
              </Stack.Item>
              <Stack.Item> {/* Name */}
                <LR_SettingNameValuePair
                  name="Name:"
                  value={name}
                  command="PREFCMD_CHANGE_NAME" />
              </Stack.Item>
              <Stack.Item> {/* Age and gunder */}
                <Stack fill>
                  <Stack.Item>
                    <LR_SettingNameValuePair
                      name="Age:"
                      value={age}
                      command="PREFCMD_CHANGE_AGE" />
                  </Stack.Item>
                  <Stack.Item>
                    <LR_SettingNameValuePair
                      name="Sex:"
                      value={gender}
                      command="PREFCMD_CHANGE_GENDER" />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item> {/* Top, bottom, switch */}
                <Stack fill>
                  <Stack.Item>
                    <LR_SettingNameValuePair
                      name="Top/Bottom/Switch:"
                      value={tbs}
                      command="PREFCMD_CHANGE_TBS" />
                  </Stack.Item>
                  <Stack.Item>
                    <LR_SettingNameValuePair
                      name="Kissing Style:"
                      value={kiss}
                      command="PREFCMD_CHANGE_KISS" />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
        <Stack.Item basis="50%"> {/* Right side */}
          <Section fill>
            <Stack fill vertical>
              <Stack.Item basis="50%"> {/* Flavor text */}
                <UD_SettingNameValuePair
                  name="Flavor Text:"
                  value={flavor_text}
                  command="PREFCMD_CHANGE_FT" />
              </Stack.Item>
              <Stack.Item basis="50%"> {/* OOC info */}
                <UD_SettingNameValuePair
                  name="OOC Info:"
                  value={ooc_text}
                  command="PREFCMD_CHANGE_OOC" />
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This is the character voice! It's a form that you can fill out to set your
// character's blurbles and such!
const CharacterVoice = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    typing_indicator_sound = "beep 1",
    typing_indicator_sound_play = "when_horny",
    typing_indicator_variance = "A little bit",
    typing_indicator_speed = "Normal",
    typing_indicator_volume = "Normal",
    typing_indicator_pitch = "Normal",
    typing_indicator_max_words_spoken = 5,
    runechat_color = "FFFFFF",
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="50%">
              <LR_SettingNameValuePair
                name="Blurble Sound:"
                value={typing_indicator_sound}
                command="PREFCMD_CHANGE_TYPING_SOUND" />
            </Stack.Item>
            <Stack.Item basis="50%">
              <LR_SettingNameValuePair
                name="You'll hear it when:"
                value={typing_indicator_sound_play}
                command="PREFCMD_CHANGE_TYPING_SOUND_PLAY" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              <UD_SettingNameValuePair
                name="Speed"
                value={typing_indicator_speed}
                command="PREFCMD_CHANGE_TYPING_SPEED" />
            </Stack.Item>
            <Stack.Item>
              <UD_SettingNameValuePair
                name="Volume"
                value={typing_indicator_volume}
                command="PREFCMD_CHANGE_TYPING_VOLUME" />
            </Stack.Item>
            <Stack.Item>
              <UD_SettingNameValuePair
                name="Pitch"
                value={typing_indicator_pitch}
                command="PREFCMD_CHANGE_TYPING_PITCH" />
            </Stack.Item>
            <Stack.Item>
              <UD_SettingNameValuePair
                name="Variance"
                value={typing_indicator_variance}
                command="PREFCMD_CHANGE_TYPING_VARIANCE" />
            </Stack.Item>
            <Stack.Item>
              <UD_SettingNameValuePair
                name="Max Words Spoken"
                value={typing_indicator_max_words_spoken}
                command="PREFCMD_CHANGE_TYPING_MAX_WORDS" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <LR_SettingNameValuePair
            name="Runechat Color:"
            value={
              <ColorBox
                color_value={runechat_color}
                no_button
                color_index="runechat_color"
                colkey_is_feature />
            } />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This is the character misc! It stuff like your bank account, your
// quirks, your stats,and some other stuff!
const CharacterMisc = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    quester_uid = "123456",
    money_string = "0 fennecs",
    pda_skin = "default",
    pda_ringmessage = "I'm horny!",
    pda_color = "FFFFFF",
    backbag = "default",
    persistent_scars = true,
    quirks = [], // full of objects
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Account ID (Do not share!)"
                value={quester_uid}
                no_button />
            </Stack.Item>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Current Balance"
                value={money_string}
                no_button />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="PDA Skin"
                value={pda_skin}
                command="PREFCMD_PDA_KIND" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="PDA Ringmessage"
                value={pda_ringmessage}
                command="PREFCMD_PDA_RINGTONE" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <LR_SettingNameValuePair
                name="PDA Color"
                no_button
                value={
                  <ColorBox
                    color_value={pda_color}
                    color_index="pda_color"
                    colkey_is_var />
                } />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Backpack"
                value={backbag}
                command="PREFCMD_BACKPACK_KIND" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Persistent Scars"
                value={persistent_scars ? "Enabled" : "Disabled"}
                command="PREFCMD_SCARS" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Clear Scars"
                value="Clear"
                command="PREFCMD_SCARS_CLEAR" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <UD_SettingNameValuePair
            name="Stats (Affects Rolls)"
            no_button
            value={<SpecialStats />} />
        </Stack.Item>
        <Stack.Item>
          <UD_SettingNameValuePair
            name="Quirks"
            no_button
            value={<Quirks />} />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This is the special stats! It's a set of buttons that you can click to
// change your character's special stats! It's buttons!
const SpecialStats = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    special_s = 10,
    special_p = 10,
    special_e = 10,
    special_c = 10,
    special_i = 10,
    special_a = 10,
    special_l = 10,
    special_totals = "70 / 40",
  } = data;

  return (
    <Stack fill>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Strength"
          value={special_s}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'strength' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Perception"
          value={special_p}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'perception' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Endurance"
          value={special_e}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'endurance' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Charisma"
          value={special_c}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'charisma' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Intelligence"
          value={special_i}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'intelligence' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Agility"
          value={special_a}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'agility' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Luck"
          value={special_l}
          command="PREFCMD_STAT_CHANGE"
          command_data={{ 'PREFDAT_STAT': 'luck' }} />
      </Stack.Item>
      <Stack.Item>
        <UD_SettingNameValuePair
          name="Totals"
          value={special_totals}
          no_button />
      </Stack.Item>
    </Stack>
  );
};

// This is the quirks! It's just a flextable that displays your character's
// quirks! It's a flextable!
const Quirks = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    quirks = [],
  } = data;

  return (
    <Flex
      wrap="wrap">
      {quirks.map((quirk, index) => (
        <Flex.Item
          key={index}
          basis="25%">
          <Box
            className={quirk.class}>
            {quirk.name}
          </Box>
        </Flex.Item>
      ))}
    </Flex>
  );
};

// This is the character appearance for misc! It's a form that you can fill out
// to set your character's appearance!
const CharacterAppearanceMisc = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    species_name = "Bingus",
    species_custom_name = "Bingus",

    show_body_model = false,
    body_model = "Feminine",

    show_body_sprite = false,
    body_sprite = "default",

    show_alt_appearance = false,
    alt_appearance = "default",

    blood_color = "FF0000",
    blood_rainbow = false,
    meat_type = "default",
    taste = "default",
    body_scale = 1,
    body_width = 1,
    fuzzysharp = "Fuzzy",
    pixel_x = 0,
    pixel_y = 0,
    legs = "Digitigrade",
    show_skin_tone = false,
    skin_tone = "default",
  } = data;

  const show_modelspriteappearance_row = show_body_model || show_body_sprite || show_alt_appearance;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Species"
                value={species_name}
                command="PREFCMD_SPECIES" />
            </Stack.Item>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Name of Species"
                value={species_custom_name}
                command="PREFCMD_SPECIES_NAME" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        {show_modelspriteappearance_row && (
          <Stack.Item>
            <Stack fill>
              {show_body_model && (
                <Stack.Item grow>
                  <UD_SettingNameValuePair
                    name="Body Model"
                    value={body_model}
                    command="PREFCMD_BODY_MODEL" />
                </Stack.Item>
              )}
              {show_body_sprite && (
                <Stack.Item grow>
                  <UD_SettingNameValuePair
                    name="Body Sprite"
                    value={body_sprite}
                    command="PREFCMD_BODY_SPRITE" />
                </Stack.Item>
              )}
              {show_alt_appearance && (
                <Stack.Item grow>
                  <UD_SettingNameValuePair
                    name="Alt Appearance"
                    value={alt_appearance}
                    command="PREFCMD_ALT_PREFIX" />
                </Stack.Item>
              )}
            </Stack>
          </Stack.Item>
        )}
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="50%">
              <LR_SettingNameValuePair
                name="Blood Color"
                no_button
                value={
                  <ColorBox
                    color_value={blood_color === "rainbow" ? "FF0000" : blood_color}
                    color_index="blood_color"
                    colkey_is_feature />
                } />
            </Stack.Item>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Blood Rainbow"
                value={blood_rainbow ? "Enabled" : "Disabled"}
                command="PREFCMD_RAINBOW_BLOOD" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Meat Type"
                value={meat_type}
                command="PREFCMD_MEAT_TYPE" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Taste"
                value={taste}
                command="PREFCMD_TASTE" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Legs"
                value={legs}
                command="PREFCMD_LEGS" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Body Scale"
                value={body_scale}
                command="PREFCMD_SCALE" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Body Width"
                value={body_width}
                command="PREFCMD_WIDTH" />
            </Stack.Item>
            <Stack.Item basis="33%">
              <UD_SettingNameValuePair
                name="Fuzzy/Sharp"
                value={fuzzysharp}
                command="PREFCMD_FUZZY" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Offset &udarr;"
                value={pixel_y}
                command="PREFCMD_PIXEL_Y" />
            </Stack.Item>
            <Stack.Item basis="50%">
              <UD_SettingNameValuePair
                name="Offset &rarr;"
                value={pixel_x}
                command="PREFCMD_PIXEL_X" />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        {show_skin_tone && (
          <Stack.Item>
            <Stack fill>
              <Stack.Item basis="100%">
                <UD_SettingNameValuePair
                  name="Skin Tone"
                  value={skin_tone}
                  command="PREFCMD_SKIN_TONE" />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        ) || null}
      </Stack>
    </Section>
  );
};

// This is the character hair and eyes! It's a form that you can fill out to
// set your character's hair and eyes!
const CharacterHairEyes = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    eye_type,
    eye_over_hair,
    left_eye_color = "000000",
    right_eye_color = "000000",
    hair_1_style = "Bald",
    hair_1_color = "000000",
    gradient_1_style = "None",
    gradient_1_color = "000000",
    hair_2_style = "None",
    hair_2_color = "000000",
    gradient_2_style = "None",
    gradient_2_color = "000000",
    facial_hair_style = "None",
    facial_hair_color = "000000",
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item> {/* Eyes */}
          <Stack fill vertical>
            <Stack.Item>
              <Box
                className="UD_SettingName">
                Eyes
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="25%">
                  <UD_SettingNameValuePair
                    name="Eye Type"
                    no_button
                    value={
                      <PrevNextSetting
                        current={eye_type}
                        command="PREFCMD_EYE_TYPE" />
                    } />
                </Stack.Item>
                <Stack.Item basis="25%">
                  <LR_SettingNameValuePair
                    name="Left Eye Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={left_eye_color}
                        color_index="left_eye_color"
                        colkey_is_var />
                    } />
                </Stack.Item>
                <Stack.Item basis="25%">
                  <LR_SettingNameValuePair
                    name="Right Eye Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={right_eye_color}
                        color_index="right_eye_color"
                        colkey_is_var />
                    } />
                </Stack.Item>
                <Stack.Item basis="25%">
                  <UD_SettingNameValuePair
                    name="Eye Over Hair"
                    value={eye_over_hair ? "Enabled" : "Disabled"}
                    command="PREFCMD_EYE_OVER_HAIR" />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Hair */}
          <Stack fill vertical>
            <Stack.Item>
              <Box
                className="UD_SettingName">
                Hairea 1
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="50%">
                  <UD_SettingNameValuePair
                    name="Style"
                    no_button
                    value={
                      <PrevNextSetting
                        current={hair_1_style}
                        command="PREFCMD_HAIR_STYLE_1" />
                    } />
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LR_SettingNameValuePair
                    name="Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={hair_1_color}
                        color_index="hair_color"
                        colkey_is_var />
                    } />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="50%">
                  <UD_SettingNameValuePair
                    name="Gradient Style"
                    no_button
                    value={
                      <PrevNextSetting
                        current={gradient_1_style}
                        command="PREFCMD_HAIR_GRADIENT_1" />
                    } />
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LR_SettingNameValuePair
                    name="Gradient Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={gradient_1_color}
                        color_index="hair_gradient_color_1"
                        colkey_is_feature />
                    } />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Hair 2 */}
          <Stack fill vertical>
            <Stack.Item>
              <Box
                className="UD_SettingName">
                Hairea 2
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="50%">
                  <UD_SettingNameValuePair
                    name="Style"
                    no_button
                    value={
                      <PrevNextSetting
                        current={hair_2_style}
                        command="PREFCMD_HAIR_STYLE_2" />
                    } />
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LR_SettingNameValuePair
                    name="Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={hair_2_color}
                        color_index="hair_color_2"
                        colkey_is_feature />
                    } />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="50%">
                  <UD_SettingNameValuePair
                    name="Gradient Style"
                    no_button
                    value={
                      <PrevNextSetting
                        current={gradient_2_style}
                        command="PREFCMD_HAIR_GRADIENT_2" />
                    } />
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LR_SettingNameValuePair
                    name="Gradient Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={gradient_2_color}
                        color_index="grad_color_2"
                        colkey_is_feature />
                    } />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack fill vertical>
            <Stack.Item>
              <Box
                className="UD_SettingName">
                Facial Hair
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item basis="50%">
                  <UD_SettingNameValuePair
                    name="Style"
                    no_button
                    value={
                      <PrevNextSetting
                        current={facial_hair_style}
                        command="PREFCMD_FACIAL_HAIR_STYLE" />
                    } />
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LR_SettingNameValuePair
                    name="Color"
                    no_button
                    value={
                      <ColorBox
                        color_value={facial_hair_color}
                        color_index="facial_hair_color"
                        colkey_is_feature />
                    } />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This, here, are the character parts. IT is a list of options to change
// things like your ears, tail, and other parts!
const CharacterParts = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    all_parts = [], // giant hell list
    all_limb_mods = [], // slghtly less
  } = data;

  // format of all_parts:
  // [
  //   {
  //     "displayname": "Ears",
  //     "featurekey": "ears",
  //     "currentshape": "None",
  //     "color1": "000000",
  //     "color1_key": "ears_color_primary",
  //     "color2": "000000",
  //     "color2_key": "ears_color_secondary",
  //     "color2_show": false,
  //     "color3": "000000",
  //     "color3_key": "ears_color_tertiary",
  //     "color3_show": false,
  //   }, ... boob yeah
  // ],
  // format of all_limb_mods:
  // [
  //   {
  //     "pros_or_amp": "Pros",
  //     "style": "None",
  //     "area": "None",
  //   }, ... boob yeah
  // ],

  return (
    <Section fill>
      <Stack fill vertical>
        {all_parts.map((part, index) => (
          <Stack.Item key={index}>
            <LovelyPart part={part} />
          </Stack.Item>
        ))}
        <Divider />
        {all_limb_mods.map((mod, index) => (
          <Stack.Item key={index}>
            <ModdedLimb mod={mod} />
          </Stack.Item>
        ))}
        <Stack.Item>
          <Button
            icon="plus"
            content="Add Limb Mod"
            onClick={() => act('PREFCMD_ADD_LIMB')} />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This is the character markings! It's a form that you can fill out to set
// your character's markings!
const CharacterMarkings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    can_have_markings = false,
    markings = [],
  } = data;
  // format of markings:
  // [
  //   {
  //     "displayname": "Marking 1",
  //     "location": "1",
  //     "location_display": "Head",
  //     "uid": "123456"
  //     "color1": "000000",
  //     "color2": "000000",
  //     "color2_show": false,
  //     "color3": "000000",
  //     "color3_show": false,
  //   }, ... boob yeah

  if (!can_have_markings) {
    return (
      <NoticeBox>
        Oh no, you cant have any cool markings! Dang, that sure sucks.
        Furries get them though, just saying.
      </NoticeBox>
    );
  }

  return (
    <Section fill>
      <Stack fill vertical>
        {markings.map((marking, index) => (
          <Stack.Item key={index}>
            <CuteMarking marking={marking} />
          </Stack.Item>
        ))}
        <Stack.Item>
          <Button
            icon="plus"
            content="Add Marking"
            onClick={() => act('PREFCMD_ADD_MARKING')} />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// This is a marking! It's a set of buttons that you can click to change the
// shape and color of the marking! Also has buttons to move it up or down the
// list, and to remove it! It's buttons!
const CuteMarking = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    marking = {},
  } = props;
  const {
    displayname = "",
    location_display = "",
    color1 = "000000",
    color1_key = "",
    color2 = "000000",
    color2_key = "",
    color2_show = false,
    color3 = "000000",
    color3_key = "",
    color3_show = false,
  } = marking;

  return (
    <Stack fill>




































// This is a part, something like ears or a tail! Its a set of buttons that
// you can click to change the shape and color of the part! It's buttons!
const LovelyPart = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    part = {},
  } = props;
  const {
    displayname = "",
    featurekey = "",
    currentshape = "None",
    color1 = "000000",
    color1_key = "",
    color2 = "000000",
    color2_key = "",
    color2_show = false,
    color3 = "000000",
    color3_key = "",
    color3_show = false,
  } = part;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <LR_SettingNameValuePair
          name={displayname}
          value={
            <PrevNextSetting
              current={currentshape}
              command="PREFCMD_CHANGE_PART"
              command_data={{ 'PREFDAT_PARTKIND': featurekey }} />
          } />
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item basis="33%">
            <ColorBox
              color_value={color1}
              color_index={color1_key}
              colkey_is_feature />
          </Stack.Item>
          {color2_show && (
            <Stack.Item basis="33%">
              <ColorBox
                color_value={color2}
                color_index={color2_key}
                colkey_is_feature />
            </Stack.Item>
          )}
          {color3_show && (
            <Stack.Item basis="33%">
              <ColorBox
                color_value={color3}
                color_index={color3_key}
                colkey_is_feature />
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

// This is a limb mod, something like a prosthetic or an amputation! It's a
// lot simpler, just a button to change the style of the mod, or remove it!
const ModdedLimb = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mod = {},
  } = props;
  const {
    pros_or_amp = "",
    style = "None",
    area = "None",
  } = mod;

  return (
    <Stack fill>
      <Stack.Item>
        <Button
          icon="trash"
          onClick={() => act('PREFCMD_REMOVE_LIMB',
            { 'PREFDAT_REMOVE_LIMB_MOD': area })} />
      <Stack.Item>
        <UD_SettingNameValuePair
          name={`${pros_or_amp} ${area}`}
          value={style}
          command="PREFCMD_MODIFY_LIMB"
          command_data={{ 'PREFDAT_MODIFY_LIMB_MOD': area }} />
      </Stack.Item>
    </Stack>
  );
};






























// This is a setting that has a previous and next button!
const PrevNextSetting = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current = "",
    command = "",
  } = props;

  return (
    <Stack fill>
      <Stack.Item shrink> {/* Previous */}
        <Button
          icon="arrow-left"
          onClick={() => act(command, { 'PREFDAT_GO_PREV': 1 })} />
      </Stack.Item>
      <Stack.Item shrink> {/* Next */}
        <Button
          icon="arrow-right"
          onClick={() => act(command, { 'PREFDAT_GO_NEXT': 1 })} />
      </Stack.Item>
      <Stack.Item grow> {/* Current */}
        <Button
          content={current}
          onClick={() => act(command)} />
      </Stack.Item>
    </Stack>
  );
};


// This is a simple split box with a name and a value, and a button to change
// the value! Can accept a command, and an object with key-value pairs to send
// to the backend! Can also be set to not have the value be a button, instead
// just a value to look at and admire!
const LR_SettingNameValuePair = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = "",
    value = "",
    command = "",
    command_data = {},
    no_button = false,
  } = props;

  return (
    <Stack fill>
      <Stack.Item basis={LR_SettingNameWidth}> {/* Name */}
        <Box className="LR_SettingName">
          {name}
        </Box>
      </Stack.Item>
      <Stack.Item grow> {/* Value */}
        {no_button && (
          <Box className="LR_SettingValueInfo">
            {value}
          </Box>
        ) || (
          <Button
            className="LR_SettingValueButton"
            content={value}
            onClick={() => act(command, command_data)} />
        )}
      </Stack.Item>
    </Stack>
  );
};

// This is a simple horizongallly split box with a name and a value,
// and a button to change the value! Can accept a command, and an object
// with key-value pairs to send to the backend! Can also be set to not have
// the value be a button, instead just a value to look at and admire!
const UD_SettingNameValuePair = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = "",
    value = "",
    command = "",
    command_data = {},
    no_button = false,
  } = props;

  return (
    <Stack fill vertical>
      <Stack.Item> {/* Name */}
        <Box
          className="UD_SettingName">
          {name}
        </Box>
      </Stack.Item>
      <Stack.Item grow> {/* Value */}
        {no_button && (
          <Box className="UD_SettingValueInfo">
            {value}
          </Box>
        ) || (
          <Button
            className="UD_SettingValueButton"
            content={value}
            onClick={() => act(command, command_data)} />
        )}
      </Stack.Item>
    </Stack>
  );
};

// ColorBox is a box that displays a color! It can be clicked to change the
// color! Contains a few elements:
// - A box that displays the color, and the hex value of the color (is a button, usually)
// - A button to copy the hex value to the clipboard
// - A button to paste the hex value from the clipboard
// - An X button if the color is a historical one
const ColorBox = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    color_value = "#FFFFFF",
    color_index = "", // used by default to say which color to change
    gear_index = null, // tells the backend which gear to change the color of (overrides color_index)
    marking_index = null, // tells the backend which marking to change the color of (overrides color_index)
    colkey_is_var = false, // tells the backend that the color key is a variable
    colkey_is_feature = false, // tells the backend that the color key is a feature
    historical = false,
  } = props;
  // make the text color either black or white depending on the background color
  const text_color = parseInt(color_value.replace("#", ""), 16) > 0xffffff / 2 ? "black" : "white";

  return (
    <Stack fill>
      <Stack.Item>
        {historical && (
          <Box
            className="ColorBox"
            style={{
              "background": "#" + color_value,
              "color": text_color,
            }}>
            {color_value}
          </Box>
        ) || (
          <Button
            className="ColorBox"
            style={{
              "background": "#" + color_value,
              "color": text_color,
            }}
            content={color_value}
            onClick={() => act('PREFCMD_COLOR_CHANGE',
              { 'PREFDAT_COLOR_HEX': color_value,
                'PREFDAT_COLOR_KEY': color_index,
                'PREFDAT_COLKEY_GEAR': gear_index,
                'PREFDAT_COLKEY_MARKING': marking_index,
                'PREFDAT_COLKEY_IS_COLOR': colkey_is_var,
                'PREFDAT_COLKEY_IS_FEATURE': colkey_is_feature,
              })} />
        )}
      </Stack.Item>
      <Stack.Item shrink>
        <Button
          icon="copy"
          onClick={() => act('PREFCMD_COLOR_COPY',
            { 'PREFDAT_COLOR_HEX': color_value })} />
        <Button
          icon="paste"
          onClick={() => act('PREFCMD_COLOR_PASTE',
            { 'PREFDAT_COLOR_HEX': color_value })} />
        {historical && (
          <Button
            icon="times"
            onClick={() => act('PREFCMD_COLOR_DELETE',
              { 'PREFDAT_COLOR_HEX': color_value })} />
        )}
      </Stack.Item>
    </Stack>
  );
};











