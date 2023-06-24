dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)
    print(tostring(new_value))
end

local progress = {
    "graham_progress_hunger",    -- demise
    "graham_progress_sheep",     -- sheepification
    "graham_progress_robot",     -- technical prowess
    "graham_progress_lucky",     -- lucky day
    "graham_progress_tech",      -- materialist
    "graham_progress_immunity",  -- immmunity aura
    "graham_minimimic_killed",   -- mini perk spells
    "graham_bloodymimic_killed", -- magic skin
}

function reset_all_data()
    RemoveFlagPersistent("graham_progress_hunger")      -- demise
    RemoveFlagPersistent("graham_progress_sheep")       -- sheepification
    RemoveFlagPersistent("graham_progress_robot")       -- technical prowess
    RemoveFlagPersistent("graham_progress_lucky")       -- lucky day
    RemoveFlagPersistent("graham_progress_tech")        -- materialist
    RemoveFlagPersistent("graham_progress_lukki")       -- lukki mount
    RemoveFlagPersistent("graham_progress_immunity")    -- immmunity aura
    RemoveFlagPersistent("graham_minimimic_killed")     -- mini perk spells
    RemoveFlagPersistent("graham_bloodymimic_killed")   -- magic skin
end

function unlock_all_data()
    AddFlagPersistent("graham_progress_hunger")      -- demise
    AddFlagPersistent("graham_progress_sheep")       -- sheepification
    AddFlagPersistent("graham_progress_robot")       -- technical prowess
    AddFlagPersistent("graham_progress_lucky")       -- lucky day
    AddFlagPersistent("graham_progress_tech")        -- materialist
    AddFlagPersistent("graham_progress_lukki")       -- lukki mount
    AddFlagPersistent("graham_progress_immunity")    -- immmunity aura
    AddFlagPersistent("graham_minimimic_killed")     -- mini perk spells
    AddFlagPersistent("graham_bloodymimic_killed")   -- magic skin
end

local mod_id = "grahamsperks" -- This should match the name of your mod's folder.
local longest = 0
local initialized = false     -- COPI: Prevent re-initialization. Used for padding settings and stuff.
mod_settings_version = 1      -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings =
{   -- DO NOT ADD TO THIS UNLESS YOU KNOW WHAT YOU'RE DOING. SETTINGS GO BELOW IN THE LOCAL settings TABLE
    {
        id = "info",
        not_setting = true,
        ui_fn = function(mod_id2, gui, in_main_menu, im_id, setting)
            GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 0.8)
            GuiText(gui, 0, 0, [[Confused or want more info? Check out the mod's wiki page at noita.wiki.gg/Mods!]])
        end
    },
    {
        id = "DEBUG_reset",
        not_setting = true,
        ui_fn = function(mod_id2, gui, in_main_menu, im_id, setting)
            local lmb, rmb = GuiButton(gui, im_id, 0, 0, "[DEBUG: RE-INIT] (TODO:REMOVETHIS)")
            if lmb then -- Skip first two
                for i=3,#mod_settings do
                    -- Wipe settings and uninit
                    mod_settings[i]=nil
                    initialized = false
                end
            end
        end
    },
}

local settings = {
    {
        id      = "SettingsReminder",
        name    = "Settings Reminder",
        desc    = "Should this mod pester you about its settings?",
        type    = "boolean",
        default = true,
    },
    {
        id      = "PacifistChest",
        name    = "Pacifist Chest Replacement",
        desc    = "Should the pacifist chest always be replaced with a Mini Treasure Chest?",
        type    = "boolean",
        default = true,
    },
    {
        id      = "Spells",
        name    = "Add new spells",
        desc    = "Should the mod add new spells? \n(Disabling WILL break some things!)",
        type    = "boolean",
        default = true,
    },
    {
        id      = "Perks",
        name    = "Add New Perks",
        desc    = "Should the mod add new perks? \n(Disabling WILL break some things!)",
        type    = "boolean",
        default = true,
    },
    {
        id      = "BloodyBonus",
        name    = "Bloody Bonus Message",
        desc    = "Should Bloody Bonus tell you how many kills you have left?",
        type    = "enum",
        values  = {
            [1] = "On every kill",
            [2] = "Every 5 kills",
            [3] = "Never",
        },
        default = 2,
    },
    --[[
    {
        id      = "LifeLottery",
        name    = "Life Lottery Alt GFX",
        desc    = "Should Life Lottery spawn with a random appearance?",
        type    = "boolean",
        default = true,
    },
    ]] --
    {
        id      = "LuckyClover",
        name    = "Lucky Clover GTCs",
        desc    = "Should Lucky Clover increase the chances of finding a Great Chest?",
        type    = "boolean",
        default = false,
    },
    {
        id      = "LuckyDay",
        name    = "Lucky Day Message",
        desc    = "Should Lucky Day inform you when you dodged an attack?",
        type    = "enum",
        values  = {
            [1] = "Yes, show percentage",
            [2] = "Yes",
            [3] = "No, never",
        },
        default = 1,
    },
    {
        id      = "Birthday",
        name    = "Force Birthday Materials",
        desc    = "Should Copium and Birthday Magic show up, even if it's not 11/11?",
        type    = "boolean",
        default = false,
    },
    {
        id      = "Creepy",
        name    = "Aggressive Material Spreading",
        desc    = "Should Creepy Polymorphine and Dried Fungus spread through air?",
        type    = "boolean",
        default = false,
    },
    {
        id   = "Reset",
        name = "Reset Progress",
        txt  = "[Reset All]",
        desc = "Should Creepy Polymorphine and Dried Fungus spread through air?",
        type = "custom",
        func = function(lmb, rmb)
            if lmb then
                for i = 1, #progress do
                    RemoveFlagPersistent(progress[i])
                end
            end
        end
    },
    {
        id   = "Unlock",
        name = "Unlock Progress",
        txt  = "[Unlock All]",
        desc = "Should Creepy Polymorphine and Dried Fungus spread through air?",
        type = "custom",
        func = function(lmb, rmb)
            if lmb then
                for i = 1, #progress do
                    AddFlagPersistent(progress[i])
                end
            end
        end
    },
}





















-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id) -- This can be used to migrate some settings between mod versions.
    mod_settings_update(mod_id, mod_settings, init_scope)
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui(gui, in_main_menu)
    if not initialized then
        local len = #mod_settings
        for i = 1, #settings do
            local curr_setting = settings[i]
            local length = GuiGetTextDimensions(gui, curr_setting.name)
            longest = math.max(longest, length)
            print("grahamsperks." .. curr_setting.id)
            mod_settings[len + i] = {
                ---@diagnostic disable-next-line: undefined-global
                scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
                id = "grahamsperks." .. curr_setting.id,
                ui_name = curr_setting.name,
                ui_description = curr_setting.desc,
                default_value = curr_setting.default,
            }
            local typeof = curr_setting.type
            if typeof=="boolean" then
                mod_settings[len + i].ui_fn = function(mod_id2, gui2, in_main_menu2, im_id, setting)
                    GuiLayoutBeginHorizontal(gui2, 0, 0)
                    GuiColorSetForNextWidget(gui2, 0.6, 0.6, 0.6, 0.8)
                    GuiText(gui2, 0, 0, setting.ui_name .. ": ")
                    local old = ModSettingGet(setting.id)
                    if old == nil then old = setting.default_value end
                    local lmb, rmb = GuiButton(gui2, im_id, (longest + 2) - length, 0, old and "[True ]" or "[False]")
                    GuiTooltip(gui, setting.ui_name, setting.ui_description)
                    if lmb then
                        ModSettingSet(setting.id, not old)
                    elseif rmb then
                        ModSettingSet(setting.id, setting.default_value)
                    end
                    GuiLayoutEnd(gui2)
                end
            elseif typeof=="enum" then
                mod_settings[len + i].ui_fn = function(mod_id2, gui2, in_main_menu2, im_id, setting)
                    GuiLayoutBeginHorizontal(gui2, 0, 0)
                    GuiColorSetForNextWidget(gui2, 0.6, 0.6, 0.6, 0.8)
                    GuiText(gui2, 0, 0, setting.ui_name .. ": ")
                    local old = ModSettingGet(setting.id)
                    if old == nil then old = setting.default_value end
                    local lmb, rmb = GuiButton(gui2, im_id, (longest + 2) - length, 0, table.concat{"[",curr_setting.values[old],"]"})
                    GuiTooltip(gui, setting.ui_name, setting.ui_description)
                    if lmb then
                        ModSettingSet(setting.id, (old%#curr_setting.values)+1)
                    elseif rmb then
                        ModSettingSet(setting.id, setting.default_value)
                    end
                    GuiLayoutEnd(gui2)
                end
            elseif typeof=="custom" then
                mod_settings[len + i].ui_fn = function(mod_id2, gui2, in_main_menu2, im_id, setting)
                    GuiLayoutBeginHorizontal(gui2, 0, 0)
                    GuiColorSetForNextWidget(gui2, 0.6, 0.6, 0.6, 0.8)
                    GuiText(gui2, 0, 0, setting.ui_name .. ": ")
                    local lmb, rmb = GuiButton(gui2, im_id, (longest + 2) - length, 0, curr_setting.txt)
                    GuiTooltip(gui, setting.ui_name, setting.ui_description)
                    curr_setting.func(lmb, rmb)
                    GuiLayoutEnd(gui2)
                end
            end


        end
        initialized = true
    end
    ---@diagnostic disable-next-line: lowercase-global
    screen_width, screen_height = GuiGetScreenDimensions(gui)
    ---@diagnostic disable-next-line: undefined-global
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
