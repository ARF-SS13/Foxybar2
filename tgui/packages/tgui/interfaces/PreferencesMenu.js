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
  ByondUi,
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
const DEF_TEXT_COLOR = "#00FF00"; // we hackerman now

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
        <StyleBlock />
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
    current_slot = 0,
  } = data;
  const {
    character,
    index,
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
    subsubcategory_tabs_line1 = [],
    subsubcategory_tabs_genitals = [],
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
        <Loadout />
      );
    case "PPT_GAME_PREFERENCES":
      return (
        <Options />
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

// This is the character undies! It's a form that you can fill out to set your
// character's unmentionables!
const CharacterUndies = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    undies = [],
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        {undies.map((undie, index) => (
          <Stack.Item key={index}>
            <LovelyUndie undie={undie} />
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

// This is the character layering! It's a cool table that lets you rearrange
// your genitals to show them off nicely!
const CharacterLayering = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    genitals = [],
  } = data;
  // format of genitals:
  // [
  //   {
  //     "displayname": "Poon",
  //     "has_key": "has_poon",
  //     "respect_clothing": false,
  //     "respect_underwear": false,
  //     "override_coverings": "None",
  //     "see_on_others": true,
  //     "has_one": true,
  //     "uparrow": true,
  //     "downarrow": true,
  //   }, ... boob yeah
  // ],

  const nothas_class = (has) => {
    return has ? "" : "GenitalLayeringTableNothas";
  };

  return (
    <Section fill>
      <Table
        className="GenitalLayeringTable">
        <Table.Row
          className="GenitalLayeringTableHeader">
          <Table.Cell>
            Genital
          </Table.Cell>
          <Table.Cell
            style={{
              'colspan': 2,
            }}>
            Shift
          </Table.Cell>
          <Table.Cell
            style={{
              'colspan': 2,
            }}>
            Hidden by...
          </Table.Cell>
          <Table.Cell>
            Override
          </Table.Cell>
          <Table.Cell>
            See on Others
          </Table.Cell>
          <Table.Cell>
            Has
          </Table.Cell>
        </Table.Row>
        {genitals.map((genital, index) => (
          <Table.Row
            className={nothas_class(genital.has_one)}
            key={index}>
            <Table.Cell>
              {genital.displayname}
            </Table.Cell>
            <Table.Cell>
              {genital.uparrow && (
                genital.has_one && (
                  <Button
                    icon="arrow-up"
                    onClick={() => act('PREFCMD_SHIFT_GENITAL',
                      {
                        'PREFDAT_GENITAL_HAS': genital.has_key,
                        'PREFDAT_GO_PREV': true,
                      })} />
                ) || (
                  <Box
                    className="GenitalLayeringTableNothas">
                    <Icon
                      name="arrow-up" />
                  </Box>
                )
              ) || (
                <Box />
              )}
            </Table.Cell>
            <Table.Cell>
              {genital.downarrow && (
                genital.has_one && (
                  <Button
                    icon="arrow-down"
                    onClick={() => act('PREFCMD_SHIFT_GENITAL',
                      {
                        'PREFDAT_GENITAL_HAS': genital.has_key,
                        'PREFDAT_GO_NEXT': true,
                      })} />
                ) || (
                  <Box
                    className="GenitalLayeringTableNothas">
                    <Icon
                      name="arrow-down" />
                  </Box>
                )
              ) || (
                <Box />
              )}
            </Table.Cell>
            <Table.Cell>
              <Button
                content={genital.respect_clothing}
                onClick={() => act('PREFCMD_HIDE_GENITAL',
                  {
                    'PREFDAT_GENITAL_HAS': genital.has_key,
                    'PREFDAT_HIDDEN_BY': 'clothing',
                  })} />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={genital.respect_underwear}
                onClick={() => act('PREFCMD_HIDE_GENITAL',
                  {
                    'PREFDAT_GENITAL_HAS': genital.has_key,
                    'PREFDAT_HIDDEN_BY': 'underwear',
                  })} />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={genital.override_coverings}
                onClick={() => act('PREFCMD_OVERRIDE_GENITAL',
                  {
                    'PREFDAT_GENITAL_HAS': genital.has_key,
                  })} />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={genital.see_on_others}
                onClick={() => act('PREFCMD_SEE_GENITAL',
                  {
                    'PREFDAT_GENITAL_HAS': genital.has_key,
                  })} />
            </Table.Cell>
            <Table.Cell>
              <Button
                onClick={() => act('PREFCMD_TOGGLE_GENITAL',
                  {
                    'PREFDAT_GENITAL_HAS': genital.has_key,
                  })} >
                {genital.has_one
                  ? <Icon name="checkmark" />
                  : <Icon name="times" />}
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

// This is a genital, and it lets you customize that genital! It's a set of
// buttons that you can click to change the shape and color of the genital!
// its a polymorphic menu that displays any part, with the right parameters
const HasBingus = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    this_bingus = {}, // dis fockin bingus
  } = props;
  const {
    displayname = "",
    one_or_some = "one",
    has_key = "has_bingus",
    has_one = false,
    can_see = true,
    can_color1 = false,
    color1 = "000000",
    color1_key = "",
    can_shape = false,
    shape = "None",
    can_size = false,
    size = "None",
    size_unit = "decigrundles",
    respect_clothing = false,
    respect_underwear = false,
    override_coverings = "None",
    see_on_others = true,
  } = this_bingus;

  const padwidth = "150px";

  const colorblock = can_see && can_color1 ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Color"
        no_button
        value={
          <ColorBox
            color_value={color1}
            color_index={color1_key}
            colkey_is_feature />
        } />
    </Stack.Item>
  ) : null;
  const shapeblock = can_see && can_shape ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Shape"
        value={shape}
        command="PREFCMD_SHAPE_GENITAL" />
    </Stack.Item>
  ) : null;
  const sizeblock = can_see && can_size ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Size"
        value={`${size} ${size_unit}`}
        command="PREFCMD_SIZE_GENITAL" />
    </Stack.Item>
  ) : null;
  const overrideblock = can_see ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Override"
        value={override_coverings}
        command="PREFCMD_OVERRIDE_GENITAL" />
    </Stack.Item>
  ) : null;
  const respectclothingblock = can_see ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Respect Clothing"
        value={respect_clothing ? "Enabled" : "Disabled"}
        command="PREFCMD_HIDE_GENITAL"
        command_data={{ 'PREFDAT_HIDDEN_BY': 'clothing' }} />
    </Stack.Item>
  ) : null;
  const respectunderwearblock = can_see ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="Respect Underwear"
        value={respect_underwear ? "Enabled" : "Disabled"}
        command="PREFCMD_HIDE_GENITAL"
        command_data={{ 'PREFDAT_HIDDEN_BY': 'underwear' }} />
    </Stack.Item>
  ) : null;
  const seeonothersblock = can_see ? (
    <Stack.Item>
      <LR_SettingNameValuePair
        pad={padwidth}
        name="See on Others"
        value={see_on_others ? "Enabled" : "Disabled"}
        command="PREFCMD_SEE_GENITAL" />
    </Stack.Item>
  ) : null;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <Box
            className="UD_SettingName">
            {displayname}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <LR_SettingNameValuePair
            pad={padwidth}
            name={`Got ${one_or_some}`}
            value={
              has_one
                ? "Yes"
                : "No"
            }
            command="PREFCMD_TOGGLE_GENITAL"
            command_data={{ 'PREFDAT_GENITAL_HAS': has_key }} />
        </Stack.Item>
        {colorblock}
        {shapeblock}
        {sizeblock}
        {overrideblock}
        {respectclothingblock}
        {respectunderwearblock}
        {seeonothersblock}
      </Stack>
    </Section>
  );
};

// This is the loadout, and its a big one! Has a few parts:
// - The header
// -- Number of points left, a button to reset, and the search bar
// - The primary categories
// - The secondary categories
// - THe rest of the damn thing
const Loadout = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    points_left = 0,
    points_span = "",
    search = "",
    primary_categories = [],
    secondary_categories = [],
    current_category = "",
    current_subcategory = "",
    gear_list = [],
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item> {/* Header */}
          <Stack fill>
            <Stack.Item shrink>
              <Box
                className="UD_SettingName">
                You have
              </Box>
            </Stack.Item>
            <Stack.Item shrink>
              <Box
                className={`UD_SettingName ${points_span}`}>
                {points_left}
              </Box>
            </Stack.Item>
            <Stack.Item shrink>
              <Button
                icon="undo"
                content="Reset"
                onClick={() => act('PREFCMD_LOADOUT_RESET')} />
            </Stack.Item>
            <Stack.Item grow /> {/* Spacer */}
            <Stack.Item>
              <Button
                icon="times"
                onClick={() => act('PREFCMD_LOADOUT_SEARCH_CLEAR')} />
            </Stack.Item>
            <Stack.Item>
              <Input
                placeholder="Search"
                value={search}
                onChange={(e, value) => act('PREFCMD_LOADOUT_SEARCH',
                  {
                    'PREFDAT_SEARCH': value,
                  })} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Primary Categories */}
          <Stack fill>
            {primary_categories.map((category, index) => (
              <Stack.Item key={index}>
                <Button
                  content={category}
                  selected={category === current_category}
                  onClick={() => act('PREFCMD_LOADOUT_CATEGORY',
                    {
                      'PREFDAT_LOADOUT_CATEGORY': category,
                    })} />
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Secondary Categories */}
          <Stack fill>
            {secondary_categories.map((category, index) => (
              <Stack.Item key={index}>
                <Button
                  content={category}
                  selected={category === current_subcategory}
                  onClick={() => act('PREFCMD_LOADOUT_SUBCATEGORY',
                    {
                      'PREFDAT_LOADOUT_SUBCATEGORY': category,
                    })} />
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* The unholy evil death bringer of the gear list */}
          <Flex wrap="wrap">
            {gear_list.map((gear, index) => (
              <GearItem
                key={index}
                gear={gear} />
            ))}
          </Flex>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// Options and preferences, this one'll suck it.
const Options = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    headder = "Cool Options",
    options = [],
  } = data;

  // format of options:
  // [
  //   {
  //     "displayname": "Squeeze huge boobs",
  //     "displayvalue": "Only while in public",
  //     "command": "PREFCMD_SQUEEZE_BOOBS",
  //   }, ... boob yeah
  // ],

  return (
    <Section fill>
      <Flex wrap="wrap">
        {options.map((option, index) => (
          <Flex.Item
            key={index}
            basis={OPTION_WIDTH}>
            <UD_SettingNameValuePair
              name={option.displayname}
              value={option.displayvalue}
              command={option.command} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
}; // suck it

// And now, the keybindings. truly the worst of them all.
const Keybindings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    keybindings = [],
    categories = [],
    current_category = "",
  } = data;

  // format of keybindings:
  // [
  //   {
  //     displayname: "Kneed boobs",
  //     key1: "K",
  //     key2: "B",
  //     key3: "None",
  //     default: "K",
  //     independant_key: "Q"
  //   }, ... boob yeah
  // ],

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item> {/* Categories */}
          <Stack fill>
            {categories.map((category, index) => (
              <Stack.Item key={index}>
                <Button
                  content={category}
                  selected={category === current_category}
                  onClick={() => act('PREFCMD_KEYBINDING_CATEGORY',
                    {
                      'PREFDAT_KEYBINDING_CATEGORY': category,
                    })} />
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Keybindings */}
          <Table>
            <Table.Row>
              <Table.Cell>
                Action
              </Table.Cell>
              <Table.Cell>
                Key 1
              </Table.Cell>
              <Table.Cell>
                Key 2
              </Table.Cell>
              <Table.Cell>
                Key 3
              </Table.Cell>
              <Table.Cell>
                Default
              </Table.Cell>
              <Table.Cell>
                Independant Key
              </Table.Cell>
            </Table.Row>
            {keybindings.map((keybinding, index) => (
              <Table.Row key={index}>
                <Table.Cell>
                  {keybinding.displayname}
                </Table.Cell>
                <Table.Cell
                  className="Keybind1">
                  <Button
                    content={keybinding.key1}
                    onClick={() => act('PREFCMD_KEYBINDING_CAPTURE',
                      {
                        'PREFDAT_KEYBINDING_ACTION': keybinding.displayname,
                        'PREFDAT_KEYBINDING_PREV_KEY': keybinding.key1,
                      })} />
                </Table.Cell>
                <Table.Cell
                  className="Keybind2">
                  <Button
                    content={keybinding.key2}
                    onClick={() => act('PREFCMD_KEYBINDING_CAPTURE',
                      {
                        'PREFDAT_KEYBINDING_ACTION': keybinding.displayname,
                        'PREFDAT_KEYBINDING_PREV_KEY': keybinding.key2,
                      })} />
                </Table.Cell>
                <Table.Cell
                  className="Keybind3">
                  <Button
                    content={keybinding.key3}
                    onClick={() => act('PREFCMD_KEYBINDING_CAPTURE',
                      {
                        'PREFDAT_KEYBINDING_ACTION': keybinding.displayname,
                        'PREFDAT_KEYBINDING_PREV_KEY': keybinding.key3,
                      })} />
                </Table.Cell>
                <Table.Cell
                  className="KeybindDefault">
                  {keybinding.default}
                </Table.Cell>
                <Table.Cell
                  className="KeybindIndie">
                  <Button
                    content={keybinding.independant_key}
                    onClick={() => act('PREFCMD_KEYBINDING_CAPTURE',
                      {
                        'PREFDAT_KEYBINDING_ACTION': keybinding.displayname,
                        'PREFDAT_KEYBINDING_PREV_KEY': keybinding.independant_key,
                      })} />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// save, load, horny chat button!
// also has page buttons, if needed
const SaveLoadHorny = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    pages = 1,
    current_page = 1,
    page_command = "PREFCMD_PAGE",
  } = data;

  return (
    <Section fill>
      <Stack fill vertical>
        {pages > 1 && (
          <Stack.Item>
            <Stack fill>
              <Stack.Item>
                <Button
                  disabled={current_page <= 1}
                  icon="arrow-left"
                  onClick={() => act(page_command,
                    {
                      'PREFDAT_GO_PREV': true,
                    })} />
              </Stack.Item>
              <Stack.Item>
                <Button
                  disabled={current_page >= pages}
                  icon="arrow-right"
                  onClick={() => act(page_command,
                    {
                      'PREFDAT_GO_NEXT': true,
                    })} />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        ) || null}
        <Stack.Item>
          <Button
            icon="cog"
            content="Configure VisualChat"
            onClick={() => act('PREFCMD_VCHAT')} />
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="save"
            content="Save"
            onClick={() => act('PREFCMD_SAVE')} />
        </Stack.Item>
        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              <Button
                content="Undo"
                icon="undo"
                onClick={() => act('PREFCMD_UNDO')} />
            </Stack.Item>
            <Stack.Item>
              <Button
                content="Delete"
                icon="trash"
                onClick={() => act('PREFCMD_DELETE')} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// the character preview! augh how does this work
const CharacterPreview = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section fill>
      <ByondUi
        id="character_preview_map"
        type="map"
        width="100%"
        height="100%" />
    </Section>
  );
};

// This is a gear item! It has a few parts:
// - The name of the gear
// -- will have a cool diagonal slash if you can't afford it
// -- Will be selected if you gots it
// -- Will have a cool icon if the name has been edited!
// - The cost of the gear
// -- Will be red if you can't afford it, and have a cool diagonal slash
// - The description of the gear
// -- will have a cool icon if the desc has been edited!
// if you have it:
// - Button to change its name, button to change its desc, button to color it
// if you don't have it:
// - none of those
const GearItem = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gear = {},
  } = props;
  const {
    displayname = "",
    gear_path = "",
    cost = 0,
    description = "",
    has = false,
    can_afford = false,
    renamed = false,
    redesc = false,
    color = "000000",
  } = gear;

  const costcolor = can_afford ? DEF_TEXT_COLOR : "red";
  const costclass = can_afford ? "SettingValue" : "SettingValue GearItemCannotAfford";
  const nameclassA = has ? "SettingValueSelected" : "SettingValueDeselected";
  const nameclassB = can_afford ? "" : "GearItemCannotAfford";
  const nameclass = `${nameclassA} ${nameclassB}`;
  const descclassA = redesc ? "SettingValueEdited" : "SettingValue";
  const descclassB = has ? "SettingValueSelected" : "SettingValueDeselected";
  const descclass = `${descclassA} ${descclassB}`;

  return (
    <Flex.Item
      basis={GEAR_ITEM_WIDTH}>
      <Stack fill vertical>
        <Stack.Item> {/* Name and Price */}
          <Stack fill>
            <Stack.Item grow>
              <Box
                className={nameclass}>
                {displayname}
              </Box>
            </Stack.Item>
            <Stack.Item shrink>
              <Box
                className={costclass}
                color={costcolor}>
                {cost}
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Description */}
          <Box
            className={descclass}>
            {description}
          </Box>
        </Stack.Item>
        {has && (
          <Stack.Item> {/* Buttons */}
            <Stack fill>
              <Stack.Item>
                <Button
                  icon="edit"
                  content="Change Name"
                  onClick={() => act('PREFCMD_LOADOUT_RENAME',
                    {
                      'PREFDAT_GEAR_TYPE': gear_path,
                    })} />
              </Stack.Item>
              <Stack.Item>
                <Button
                  icon="edit"
                  content="Change Desc"
                  onClick={() => act('PREFCMD_LOADOUT_REDESC',
                    {
                      'PREFDAT_GEAR_TYPE': gear_path,
                    })} />
              </Stack.Item>
              <Stack.Item>
                <ColorBox
                  color_value={color}
                  gear_index={gear_path} />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        ) || null}
      </Stack>
    </Flex.Item>
  );
};

// This is underwear! It's a set of buttons that you can click to change the
// style and color of the underwear! It's buttons!
const LovelyUndie = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    undie = {},
  } = props;
  const {
    displayname = "",
    style = "None",
    color1 = "000000",
    color1_key = "",
    overclothes = "No",
    undie_command = "PREFCMD_UNDERWEAR",
    over_command = "PREFCMD_UNDERWEAR_OVERCLOTHES",
  } = undie;

  return (
    <Stack fill vertical>
      <Stack.Item> {/* Entry Name */}
        <Box
          className="UD_SettingName">
          {displayname}
        </Box>
      </Stack.Item>
      <Stack.Item> {/* Style and overclothes */}
        <Stack fill>
          <Stack.Item grow>
            <PrevNextSetting
              current={style}
              command={command} />
          </Stack.Item>
          <Stack.Item shrink>
            <LR_SettingNameValuePair
              name="Over:"
              value={undie_command}
              command={over_command} />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item> {/* Color */}
        <ColorBox
          color_value={color1}
          color_index={color1_key}
          colkey_is_var />
      </Stack.Item>
    </Stack>
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
    color1_index = 1,
    color2 = "000000",
    color2_index = 2,
    color2_show = false,
    color3 = "000000",
    color3_index = 3,
    color3_show = false,
    marking_uid = "weewee",
  } = marking;

  return (
    <Stack fill vertical>
      <Stack.Item> {/* buttons, loc, and more buttons, name */}
        <Stack fill>
          <Stack.Item shrink>
            <Button
              icon="trash"
              onClick={() => act('PREFCMD_MARKING_REMOVE',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
          <Stack.Item shrink>
            <Button
              icon="arrow-up"
              onClick={() => act('PREFCMD_MARKING_MOVE_UP',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
          <Stack.Item shrink>
            <Button
              icon="arrow-down"
              onClick={() => act('PREFCMD_MARKING_MOVE_DOWN',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
          <Stack.Item basis="150px">
            <Box
              className="UD_SettingName">
              {location_display}
            </Box>
          </Stack.Item>
          <Stack.Item shrink>
            <Button
              icon="arrow-left"
              onClick={() => act('PREFCMD_MARKING_PREV',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
          <Stack.Item shrink>
            <Button
              icon="arrow-right"
              onClick={() => act('PREFCMD_MARKING_NEXT',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              content={displayname}
              onClick={() => act('PREFCMD_MARKING_EDIT',
                { 'PREFDAT_MARKING_UID': marking_uid })} />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item> {/* colors! */}
        <Stack fill>
          <Stack.Item basis="33%">
            <ColorBox
              color_value={color1}
              color_index={color1_key}
              marking_index={marking_uid} />
          </Stack.Item>
          {color2_show && (
            <Stack.Item basis="33%">
              <ColorBox
                color_value={color2}
                color_index={color2_key}
                marking_index={marking_uid} />
            </Stack.Item>
          ) || null}
          {color3_show && (
            <Stack.Item basis="33%">
              <ColorBox
                color_value={color3}
                color_index={color3_key}
                marking_index={marking_uid} />
            </Stack.Item>
          ) || null}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

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
      </Stack.Item>
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
    pad = LR_SettingNameWidth,
  } = props;

  return (
    <Stack fill>
      <Stack.Item basis={pad}> {/* Name */}
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


// The style block! I dont know how to use sass, but I do know how to do this!
// defines a <style> block that contains all the styles for the preferences
// menu, so that it can be styled easily from ingame
const StyleBlock = (props, context) => {
  return (
    <style>
      {`
        .UD_SettingName {
          font-size: 16px;
          font-weight: bold;
          padding: 5px;
          background: #222;
          color: #FFF;
        }
        .UD_SettingValueInfo {
          font-size: 16px;
          padding: 5px;
          background: #333;
          color: #FFF;
        }
        .UD_SettingValueButton {
          font-size: 16px;
          padding: 5px;
          background: #444;
          color: #FFF;
        }
        .LR_SettingName {
          font-size: 16px;
          font-weight: bold;
          padding: 5px;
          background: #222;
          color: #FFF;
        }
        .LR_SettingValueInfo {
          font-size: 16px;
          padding: 5px;
          background: #333;
          color: #FFF;
        }
        .LR_SettingValueButton {
          font-size: 16px;
          padding: 5px;
          background: #444;
          color: #FFF;
        }
        .ColorBox {
          font-size: 16px;
          padding: 5px;
          background: #FFF;
          color: #000;
          border: 1px solid #000;
          text-align: center;
        }
        .GenitalLayeringTable {
          width: 100%;
          border-collapse: collapse;
        }
        .GenitalLayeringTableHeader {
          background: #222;
          color: #FFF;
        }
        .GenitalLayeringTableNothas {
          background: #444;
          color: #FFF;
        }
      `}
    </style>
  );
};









