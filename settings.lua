---@diagnostic disable: undefined-global
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
    "graham_progress_lukki",     -- lukki mount
    "graham_progress_immunity",  -- immunity aura
    "graham_minimimic_killed",   -- mini perk spells
    "graham_bloodymimic_killed", -- magic skin
    "graham_progress_deathquest",
    -- burger
    "graham_progress_appeased",
    -- chest rains
    "graham_progress_bloody_chest_rain",
    "graham_progress_mini_chest_rain",
    "graham_progress_lost_chest_rain",
    "graham_progress_tech_chest_rain",
    "graham_progress_immunity_chest_rain",
    -- wand exchange
    "graham_progress_candyheart_exchange",
    "graham_progress_coffee_exchange",
    "graham_progress_experimental_exchange",
    "graham_progress_gluestick_exchange",
    "graham_progress_petworm_exchange",
    "graham_progress_rotting_exchange",
}

local currentLang = ModSettingGet("grahamsperks.Language") or 1
local translations = { -- default to English
    {"Settings reminder", "Should this mod pester you about its settings?"},
    {"Pacifist chest replacement", "Should the pacifist chest always be replaced with a Mini Treasure Chest?"},
    {"Add new enemies", "Should the mod add new enemies?\nThis excludes mimics, which are always enabled.\nNote: Having enemies disabled will make it impossible to get 100%\nenemy progress unless you've already killed the enemies previously.\n(Sorry, technical limitations and such.)"},
    {"Add new starting items", "Should you be able to start with new spells or potions at the start of a run?"},
    {"Bloody Bonus message", "Should the Bloody Bonus perk tell you how many kills you have left?", "On every kill", "Every 5 kills", "No, never"},
    {"Lucky Day message", "Should Lucky Day inform you when you dodged an attack?", "Yes, show percentage", "Yes", "No, never"},
    {"Force birthday materials", "Should Copium and Birthday Magic show up, even if it's not 11/11?"},
    {"Aggressive material spreading", "Should Creepy Polymorphine and Dried Fungus spread through air?"},
    {"Reset all progress", "[Reset All]", "Click here to reset all progress for this mod. This cannot be undone!"},
    {"Unlock all progress", "[Unlock All]", "Click here to unlock all progress for this mod. This cannot be undone!"},
    {"[True]", "[False]", "[Locked]", "You can't use this while in a run.", "Confused or want more info? Check out the mod's wiki page at noita.wiki.gg/Mods!"},
    {"Language", "What language do you want to play Graham's Things in?\nRestart the game after changing this setting."},
    {"Hide breadcrumbs", "Should Breadcrumbs from the perk be invisible?\nThis is just cosmetic. Enable this if the perk is causing too much visual clutter."},
    {"Spell weight multiplier", "Increase or decrease the spawn frequency of spells from Graham's Things.\nValues higher than 100% will make them appear more often.\nValues lower than 100% will make them appear less often.", "100%", "120%", "150%", "200%", "80%", "50%", "10%"},
}

if currentLang == 2 then -- Chinese translations here
    translations = {
        {"设置提醒", "这个模组是否应该在开始游戏时提示你进行模组设置？"},
        {"和平主义者宝箱替换", "和平主义宝箱是否始终替换为迷你宝箱？"},
        {"添加新敌人", "该模组是否应该添加新的敌人？\n这个设置不包括模仿者，因为模仿者始终处于启用状态。\n注意：禁用敌人将无法解锁100%图鉴，敌人的进展只展示\n你之前已经杀死过的敌人。\n（抱歉，这是因为技术上的限制。）"},
        {"添加新的初始内容", "应该在新游戏开始时使用全新的法术和魔药吗？"},
        {"血腥奖励提示", "血腥奖励天赋应该提示你还需要杀死多少敌人吗？", "每次击杀敌人时提示", "每5次击杀敌人时提示", "永不提示"},
        {"幸运日提示", "当你规避攻击时幸运日天赋是否应该显示消息？", "提示，并显示概率百分比", "显示消息", "永不提示"},
        {"老兵节材料", "即使不是11/11时,安慰剂和生日魔法是否应该出现？"},
        {"侵蚀性材料扩散", "恐怖变形气体和蘑菇粉尘会通过空气传播吗？"},
        {"重置所有进度", "[重置全部]", "单击此处重置此模组的所有进度。 这不能撤消！"},
        {"解锁所有进度", "[解锁全部]", "单击此处解锁此模组的所有进度。 这不能撤消！"},
        {"[是]", "[否]", "[锁定]", "你不能在进行游戏时修改这个选项。", "感到困惑或想了解更多信息？ 查看该模组的wiki页面：noita.wiki.gg/Mods！"},
        {"语言", "你想用什么语言玩Graham's Things？\n更改此设置后需要重新启动游戏才能生效。"},
        {"隐藏面包屑", "面包屑天赋产生的面包屑应该隐形吗？\n这只是装饰性的。如果面包屑天赋导致画面过于混乱，请启用此功能。"},
        {"法术生成权重", "增加或降低Graham's Things法术的生成频率。\n大于100%会增加此mod所属法术的生成频率\n小于100%则会降低法术的生成频率", "100%", "120%", "150%", "200%", "80%", "50%", "10%"},
    }
elseif currentLang == 3 then -- Russian translations here
    translations = {
        {"Напоминание о настройках", "Должен ли этот мод донимать вас своими настройками?"},
        {"Замена сундука пацифиста", "Должен ли сундук пацифиста всегда заменяться на мини-сундук с сокровищами?"},
        {"Добавить новых врагов", "Должен ли мод добавлять новых врагов?\n Это исключает мимику, которая всегда включена.\nПримечание: отключение врагов сделает невозможным получение 100%\n вражеского прогресса, если вы уже не убили врагов ранее.\n (Извините, технические ограничения и тому подобное.)"},
        {"Добавить новые стартовые предметы", "Должны ли вы иметь возможность начинать \nс новыми заклинаниями или зельями в начале игры?"},
        {"Сообщение о кровавом бонусе", "Должен ли перк \"Кровавый бонус\" сообщать вам, сколько убийств у вас осталось?", "При каждом убийстве", "Каждые 5 убийств", "Нет, никогда"},
        {"Сообщение о Дне удачи", "Должен ли День удачи сообщать вам, когда вы уклонились от атаки?", "Да, показывать процент", "Да", "Нет, никогда"},
        {"Принудительные материалы дня рождения", "Должны ли появляться Копиум и Магия дня рождения, даже если сегодня не 11/11?"},
        {"Агрессивное распространение материалов", "Должны ли Жуткий полиморфин и Сушеный гриб распространяться по воздуху?"},
        {"Сбросить весь прогресс", "[Сбросить все]", "Нажмите здесь, чтобы сбросить \nвесь прогресс для этого мода. Этого нельзя отменить!"},
        {"Разблокировать весь прогресс", "[Разблокировать все]", "Нажмите здесь, чтобы разблокировать \nвесь прогресс для этого мода. Это нельзя отменить!"},
        {"[Да]", "[Нет]", "[Заблокировано]", "Вы не можете использовать это во время бега.", "Запутались или хотите больше информации?\nЗагляните на вики-страницу мода по адресу noita.wiki.gg/Mods!"},
        {"Язык", "На каком языке вы хотите играть в \"Вещи Грэма\"?\n Перезапустите игру после изменения этой настройки."},
        {"Скрывать хлебные крошки", "Должны ли хлебные крошки от перка быть невидимыми?\n Это просто косметический параметр. \nВключите эту настройку, если перк создает слишком много визуальных помех."},
        {"Множитель количества заклинаний", "Увеличивает или уменьшает частоту спавна заклинаний из Graham's Things.\nЗначение больше 100% будет заставлять их появляться чаще.\nЗначение меньше 100% будет заставлять их появляться реже.", "100%", "120%", "150%", "200%", "80%", "50%", "10%"},
    }
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
            GuiText(gui, 0, 0, translations[11][5])
        end
    },
}

local settings = {
    {
        id      = "Language",
        name    = translations[12][1],
        desc    = translations[12][2],
        type    = "enum",
        values  = {
            [1] = "English",
            [2] = "中文 (Chinese)",
            [3] = "Русский (Russian)"
        },
        default = 1,
    },
    --[[
    {
        id      = "SettingsReminder",
        name    = translations[1][1],
        desc    = translations[1][2],
        type    = "boolean",
        default = true,
    },
    ]]--
    {
        id      = "PacifistChest",
        name    = translations[2][1],
        desc    = translations[2][2],
        type    = "boolean",
        default = true,
    },
    {
        id      = "Enemies",
        name    = translations[3][1],
        desc    = translations[3][2],
        type    = "boolean",
        default = true,
    },
    {
        id      = "StartingItems",
        name    = translations[4][1],
        desc    = translations[4][2],
        type    = "boolean",
        default = true,
    },
    {
        id      = "SpellWeightMultiplier",
        name    = translations[14][1],
        desc    = translations[14][2],
        type    = "enum",
        values  = {
            [1] = translations[14][3],
            [2] = translations[14][4],
            [3] = translations[14][5],
            [4] = translations[14][6],
            [5] = translations[14][7],
            [6] = translations[14][8],
            [7] = translations[14][9],
        },
        default = 1,
    },
    {
        id      = "BloodyBonus",
        name    = translations[5][1],
        desc    = translations[5][2],
        type    = "enum",
        values  = {
            [1] = translations[5][3],
            [2] = translations[5][4],
            [3] = translations[5][5],
        },
        default = 2,
    },
    {
        id      = "LuckyDay",
        name    = translations[6][1],
        desc    = translations[6][2],
        type    = "enum",
        values  = {
            [1] = translations[6][3],
            [2] = translations[6][4],
            [3] = translations[6][5],
        },
        default = 1,
    },
    {
        id      = "Breadcrumbs",
        name    = translations[13][1],
        desc    = translations[13][2],
        type    = "boolean",
        default = false,
    },
    {
        id      = "Birthday",
        name    = translations[7][1],
        desc    = translations[7][2],
        type    = "boolean",
        default = false,
    },
    {
        id      = "Creepy",
        name    = translations[8][1],
        desc    = translations[8][2],
        type    = "boolean",
        default = false,
    },
    {
        id   = "Reset",
        name = translations[9][1],
        txt  = translations[9][2],
        desc = translations[9][3],
        type = "custom",
        lock = true,
        func = function(lmb, rmb)
            if lmb then
                RemoveFlagPersistent("graham_used_unlock_all")
                for i = 1, #progress do
                    RemoveFlagPersistent(progress[i])
                end
            end
        end
    },
    {
        id   = "Unlock",
        name = translations[10][1],
        txt  = translations[10][2],
        desc = translations[10][3],
        type = "custom",
        lock = true,
        func = function(lmb, rmb)
            if lmb then
                AddFlagPersistent("graham_used_unlock_all")
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
                    local lmb, rmb = GuiButton(gui2, im_id, (longest + 2) - length, 0, old and translations[11][1] or translations[11][2])
                    GuiTooltip(gui2, setting.ui_description, "")
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
                    GuiTooltip(gui2, setting.ui_description, "")
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
                    if curr_setting.lock and not in_main_menu2 then
                        GuiColorSetForNextWidget(gui2, 0.6, 0.4, 0.4, 0.8)
                        GuiText(gui2, (longest + 2) - length, 0, translations[11][3] )
                        GuiTooltip(gui2, setting.ui_name, translations[11][4])
                    else
                        local lmb, rmb = GuiButton(gui2, im_id, (longest + 2) - length, 0, curr_setting.txt)
                        curr_setting.func(lmb, rmb)
                        GuiTooltip(gui2, setting.ui_name, setting.ui_description)
                    end
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
