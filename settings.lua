dofile("data/scripts/lib/mod_settings.lua") 

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

function reset_all_data()
RemoveFlagPersistent("graham_progress_hunger") -- demise
RemoveFlagPersistent("graham_progress_sheep") -- sheepification
RemoveFlagPersistent("graham_progress_robot") -- technical prowess
RemoveFlagPersistent("graham_progress_lucky") -- lucky day
RemoveFlagPersistent("graham_progress_tech") -- materialist
RemoveFlagPersistent("graham_progress_immunity") -- immmunity aura
RemoveFlagPersistent("graham_minimimic_killed") -- mini perk spells
RemoveFlagPersistent("graham_bloodymimic_killed") -- magic skin
end

function unlock_all_data()
AddFlagPersistent("graham_progress_hunger")
AddFlagPersistent("graham_progress_sheep")
AddFlagPersistent("graham_progress_robot")
AddFlagPersistent("graham_progress_lucky")
AddFlagPersistent("graham_progress_tech")
AddFlagPersistent("graham_progress_immunity")
AddFlagPersistent("graham_minimimic_killed")
AddFlagPersistent("graham_bloodymimic_killed")
end

local mod_id = "grahamsperks" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings = 
{
	{
		id = "_",
		ui_name = "(Confused or want more info? Check out the mod's wiki page at noita.wiki.gg/Mods!)",
		not_setting = true,
	},
	{
		id = "_",
		ui_name = " ",
		not_setting = true,
	},
	{
	id = "message143",
	ui_name = "!! Settings reminder",
	ui_description = "Should this mod pester you about its settings?",
	value_default = "yes",
	values = { {"yes","Yes"}, {"no","No"}},
	scope = MOD_SETTING_SCOPE_RUNTIME,
	change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
	},
	{
	id = "pacifist",
	ui_name = "Pacifist chest replacement",
	ui_description = "Should the pacifist chest always be replaced with a Mini Treasure Chest?",
	value_default = "yes",
	values = { {"yes","Yes"}, {"no","No"}},
	scope = MOD_SETTING_SCOPE_RUNTIME,
	change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
	},
	{
	id = "spells",
	ui_name = "Add new spells",
	ui_description = "Should the mod add new spells? (Disabling WILL break some things!)",
	value_default = "yes",
	values = { {"yes","Yes"}, {"no","No"}},
	scope = MOD_SETTING_SCOPE_NEW_GAME,
	change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
	},
	{
	category_id = "graham_perks",
	ui_name = "Perks",
	ui_description = "Settings for this mod's perks",
	settings = {
		{
		id = "perks",
		ui_name = "Add new perks",
		ui_description = "Should the mod add new perks? (Disabling WILL break some things!)",
		value_default = "yes",
		values = { {"yes","Yes"}, {"no","No"}},
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		{
		id = "bloodybonus",
		ui_name = "Bloody Bonus message",
		ui_description = "Should Bloody Bonus tell you how many kills you have left?",
		value_default = "milestone",
		values = { {"all","On every kill"}, {"milestone","Every 5 kills"}, {"none","Never"} },
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		{
		--[[
		id = "lifelottery",
		ui_name = "Life Lottery alternate costumes",
		ui_description = "Should Life Lottery spawn with a random costume?",
		value_default = "yes",
		values = { {"yes","Yes"}, {"no","No"}},
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		]]--
		{
		id = "luckyclover",
		ui_name = "Lucky Clover great chests",
		ui_description = "Should Lucky Clover increase the chances of finding a Great Chest?",
		value_default = "no",
		values = { {"yes","Yes"}, {"no","No"}},
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		{
		id = "luckyday",
		ui_name = "Lucky Day message",
		ui_description = "Should Lucky Day inform you when you dodged an attack?",
		value_default = "yes",
		values = { {"yes","Yes, show percentage"}, {"no","Yes"}, {"none","No, not at all"}},
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
	},
	},
	{
	category_id = "graham_materials",
	ui_name = "Materials",
	ui_description = "Settings for this mod's materials",
	settings = {
		{
		id = "birthday",
		ui_name = "Force birthday materials",
		ui_description = "Should Copium and Birthday Magic show up, even if it's not 11/11?",
		value_default = "no",
		values = { {"yes","Yes"}, {"no","No"}},
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		{
		id = "creepy",
		ui_name = "Aggressive material spreading",
		ui_description = "Should Creepy Polymorphine and Dried Fungus spread through air?",
		value_default = "yes",
		values = { {"yes","Yes"}, {"no","No"}},
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		change_fn = mod_setting_change_callback, -- Called when the user interact with the settings widget.
		},
		{
		id = "blank",
		ui_name = " ",
		not_setting = true,
		},
		{
		id = "all",
		ui_name = "Unlock all",
		ui_description = "Click to unlock all of this mod's unlocks.\nThis doesn't affect anything but this mod!",
		scope = MOD_SETTING_SCOPE_RUNTIME,
		values = { {"a",""}, {"b",""}},
		value_default = "a",
		change_fn = unlock_all_data, -- Called when the user interact with the settings widget.
		},
		{
		id = "reset",
		ui_name = "Relock all",
		ui_description = "Click to reset all of this mod's unlocks and saved data.\nThis doesn't affect anything but this mod!",
		scope = MOD_SETTING_SCOPE_RUNTIME,
		values = { {"a",""}, {"b",""}},
		value_default = "a",
		change_fn = reset_all_data, -- Called when the user interact with the settings widget.
		},
	},
	},
}

-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end