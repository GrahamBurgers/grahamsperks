local translations = ModTextFileGetContent( "data/translations/common.csv" );
local new_translations
if translations ~= nil then
	while translations:find("\r\n\r\n") do
		translations = translations:gsub("\r\n\r\n","\r\n");
	end
	new_translations = ModTextFileGetContent( "mods/grahamsperks/files/translations.csv" );
	translations = translations .. new_translations;
	new_translations = ModTextFileGetContent( "mods/grahamsperks/files/translations_1.5.csv" );
	translations = translations .. new_translations;
	ModTextFileSetContent( "data/translations/common.csv", translations );
end

ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials.xml")
ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials_reactions.xml")
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_append.lua" )
ModLuaFileAppend( "data/scripts/items/potion_aggressive.lua", "mods/grahamsperks/files/materials/potion_aggressive.lua" )

	-- Extra mod compatibility
if ModIsEnabled("more-stuff") then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_morestuff.xml")
end
if ModIsEnabled("anvil_of_destiny") then
  ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/grahamsperks/files/scripts/aod_compat.lua")
end

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/grahamsperks/files/spells/actions.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/grahamsperks/files/perks/perk_list.lua")

if ModSettingGet("grahamsperks.Creepy") ~= false then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_creepy.xml")
end

ModLuaFileAppend( "data/scripts/items/heart.lua", "mods/grahamsperks/files/healthyheart.lua" )
ModLuaFileAppend( "data/scripts/items/heart_evil.lua", "mods/grahamsperks/files/healthyheart.lua" )
ModLuaFileAppend( "data/scripts/items/heart_better.lua", "mods/grahamsperks/files/healthyheart_better.lua" )
ModLuaFileAppend( "data/scripts/items/spell_refresh.lua", "mods/grahamsperks/files/scripts/spell_refresh_append.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/grahamsperks/files/effects/status_effects.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/grahamsperks/files/bloodybonus_check.lua" )
ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/grahamsperks/files/add_oneoffs.lua" )
ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/grahamsperks/files/biome_scripts_append.lua" )
ModLuaFileAppend( "data/scripts/biomes/temple_altar.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/biomes/boss_arena.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/buildings/forge_item_convert.lua", "mods/grahamsperks/files/scripts/anvil_append.lua")
ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/grahamsperks/files/scripts/perk_append_test.lua")
ModLuaFileAppend( "data/scripts/items/heart_fullhp.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")
ModLuaFileAppend( "data/scripts/items/heart_fullhp_temple.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")
ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/grahamsperks/files/scripts/fungal_shift_append.lua")

if ModSettingGet("grahamsperks.Enemies") ~= false then
	-- enemies
	local enemies = {"coalmine_alt", "excavationsite", "snowcave", "snowcastle", "sandcave"}
	for i = 1, #enemies do
		ModLuaFileAppend( "data/scripts/biomes/" .. enemies[i] .. ".lua", "mods/grahamsperks/files/scripts/enemies_" .. enemies[i] .. ".lua" )
	end
	PolymorphTableAddEntity( "data/entities/animals/graham_miner_gasser.xml", false )
end

local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	for i = 1, #table do
		string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		if table[i][4] == true then
			-- make things show up in first 2 parallel worlds
			-- hopefully this won't cause too much lag when starting a run
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + 35840 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - 35840 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + 71680 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - 71680 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end

add_scene({
	{-2379, 6646, "mods/grahamsperks/files/entities/books/cookbook.xml", true},
	{9953, -1167, "mods/grahamsperks/files/entities/books/polybook.xml", true},
	{-3811, 10113, "mods/grahamsperks/files/entities/books/lonelybook.xml", true},
	{-16268, -7093, "mods/grahamsperks/files/entities/books/timebook.xml", true},
	{-1933, -59, "mods/grahamsperks/files/entities/books/anvilbook.xml"},
	{4379, 895, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{-12340, 420, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{-3367, 3346, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{2945, 12316, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{12336, -4642, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{-1707, -742, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{9654, 9186, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{3372, 1876, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{-4324, 3968, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{4413, 13087, "mods/grahamsperks/files/pickups/chest_tech.xml"},
	{11480, -4864, "mods/grahamsperks/files/wands/candyheart.xml", true},
	{10050, -736, "mods/grahamsperks/files/wands/rotting.xml", true},
	{16090, 10000, "mods/grahamsperks/files/wands/coffee.xml", true},
	{2520, 7440, "mods/grahamsperks/files/wands/petworm.xml", true},
	{4135, 12964, "mods/grahamsperks/files/wands/gluestick.xml", true},
	{16161, 3333, "mods/grahamsperks/files/wands/experimental.xml", true},
	{1487, 6085, "mods/grahamsperks/files/entities/books/unlockbook.xml", true},
	{3435, 936, "mods/grahamsperks/files/pickups/vial.xml", true},
	{-2111, 2722, "mods/grahamsperks/files/pickups/balloon.xml", true},
	{-1908, -56, "mods/grahamsperks/files/pixelscenes/text.xml"},
	{-1864, -53, "data/entities/items/pickup/moon.xml"},
	{2372, 530, "mods/grahamsperks/files/pixelscenes/hands.xml", true},
	{2382, 550, "mods/grahamsperks/files/entities/goldblood.xml", true},
	{-2221, 2564, "mods/grahamsperks/files/pixelscenes/hellblood.xml", true},
	{-2490, 6480, "mods/grahamsperks/files/pixelscenes/transmutatium.xml", true},
	{3921, 3100, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
	{3951, 3140, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
	{-14638, 13031, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
	{-14608, 13071, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
	{2318, 1870, "mods/grahamsperks/files/entities/eyechecker.xml", true},
	{4573, 528, "mods/grahamsperks/files/pixelscenes/eye.xml", true},
	{2000, 1735, "mods/grahamsperks/files/pixelscenes/closedeye.xml", true},
	{-5302, 575, "mods/grahamsperks/files/pixelscenes/materials.xml"},
	{-6760, 7424, "mods/grahamsperks/files/pixelscenes/yinyang.xml", true},
	{-6693, 7515, "mods/grahamsperks/files/entities/halo_checker.xml", true},
	{11537, 9956, "mods/grahamsperks/files/pixelscenes/water.xml"},
	{11537, 9986, "mods/grahamsperks/files/pickups/chest_immunity.xml"},
	{-317, -1673, "mods/grahamsperks/files/pixelscenes/island.xml"},
	{-278, -1580, "mods/grahamsperks/files/entities/fireplace_worse.xml"},
	{-46, -1550, "mods/grahamsperks/files/entities/books/cozybook.xml"},
	{4046, 12977, "mods/grahamsperks/files/pixelscenes/secret.xml", true},
	{4532, 13081, "mods/grahamsperks/files/entities/perk_spawners/map_spawner.xml"},
	{785, -1231, "mods/grahamsperks/files/entities/perk_spawners/map2_spawner.xml"},
	{15090, -3333, "mods/grahamsperks/files/entities/perk_spawners/ll_spawner.xml"},
	{3546, 13100, "mods/grahamsperks/files/entities/perk_spawners/slots_spawner.xml"},
	{14241, 16284, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
	{4692, 652, "mods/grahamsperks/files/entities/tear_secret.xml", true},
	{14271, 16324, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
	{-16295, -7140, "mods/grahamsperks/files/pixelscenes/home.xml"},
	{-16238, -6987, "data/entities/props/furniture_bed.xml"},
	{-16116, -7004, "data/entities/props/furniture_wood_table.xml"},
	{-16016, -7068, "mods/grahamsperks/files/pickups/chest_lost.xml"},
	{-16117, -7015, "mods/grahamsperks/files/pickups/chest_mini.xml"},
	{-16038, -7010, "mods/grahamsperks/files/entities/fireplace_worse.xml"},
	{7412, 6175, "mods/grahamsperks/files/pixelscenes/heart.xml", true},
	{12055, 2700, "mods/grahamsperks/files/pixelscenes/wealth.xml"},
	{12055, 2730, "mods/grahamsperks/files/entities/midas_curse.xml"},
	{1800, 6600, "mods/grahamsperks/files/pixelscenes/egg.xml", true},
	{1800, 6600, "mods/grahamsperks/files/pickups/egg.xml", true},
	{1800, 6600, "mods/grahamsperks/files/entities/books/eggbook.xml", true},
	{-11695, 600, "mods/grahamsperks/files/pixelscenes/stargazer.xml", true},
	{0, 100000, "mods/grahamsperks/files/pixelscenes/cat.xml", true},
	{0, -100000, "mods/grahamsperks/files/pixelscenes/cat2.xml", true},
	{3331, 1616, "mods/grahamsperks/files/entities/progress/progress.xml", true},
})

dofile_once("data/scripts/perks/perk.lua")

local patches = {
    {
        path    = "data/entities/misc/hitfx_toxic_charm.xml",
        from    = "condition_status",
        to      = "condition_effect",
    },
    {
        path    = "data/entities/projectiles/deck/xray.xml",
        from    = "tags=\"projectile_player\"",
        to      = "tags=\"projectile_player,graham_ase\"",
    },
    {
        path    = "data/entities/items/pickup/moon.xml",
        from    = "tags=\"hittable,",
        to      = "tags=\"hittable,forgeable,bloodmoon_forgeable,",
    },
    {
        path    = "data/entities/items/pickup/evil_eye.xml",
        from    = "tags=\"hittable,",
        to      = "tags=\"hittable,forgeable,cybereye_forgeable,",
    },
	{
        path    = "data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent 
				_enabled="1" 
				execute_every_n_frame="240"
				script_source_file="mods/grahamsperks/files/scripts/altar_append.lua" 
			>
			</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/entities/base_humanoid.xml",
        from    = "<GameStatsComponent />",
        to      = [[
			<GameStatsComponent />
			<LuaComponent
			execute_on_added="0"
			execute_every_n_frame="2"
			remove_after_executed="1"
			script_source_file="mods/grahamsperks/files/scripts/midas_kill.lua"
			></LuaComponent>
		]],
    },
	{
        path    = "data/entities/items/books/base_book.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent
			execute_on_added="1"
			execute_every_n_frame="-1"
			remove_after_executed="1"
			script_source_file="mods/grahamsperks/files/scripts/book.lua"
			></LuaComponent>
			</Entity>
		]],
    },
}

if ModSettingGet("grahamsperks.StartingItems") ~= false then
	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/grahamsperks/files/scripts/potion_starting_append.lua")
	table.insert(patches, {
		path    = "data/scripts/gun/procedural/starting_wand.lua",
        from    = "\"SPITTER\"",
        to      = "\"SPITTER\",\"GRAHAM_GLOW_DART\",\"GRAHAM_BRAMBALL\"",
	})
	table.insert(patches, {
        path    = "data/scripts/gun/procedural/starting_bomb_wand.lua",
        from    = "\"GRENADE\"",
        to      = "\"GRENADE\",\"GRAHAM_BARREL\"",
	})
end

if ModIsEnabled("noita-together") then
	table.insert(patches, {
        path    = "mods/noita-together/files/scripts/perks.lua",
        from    = "EXTRA_MONEY=true,",
        to      = "EXTRA_MONEY=true,GRAHAM_HEALTHY_HEARTS=true,GRAHAM_LUCKY_CLOVER=true,GRAHAM_CAMPFIRE=true,GRAHAM_REFRESHER=true,GRAHAM_EXTRA_SLOTS=true,",
	})
end

if HasFlagPersistent("graham_death_hp_boost") then
	table.insert(patches, {
        path    = "data/items_gfx/bomb_wand.xml",
        from    = "data/items_gfx/bomb_wand.png",
        to      = "mods/grahamsperks/files/wands/bomb_wand.png",
    })
	table.insert(patches, {
        path    = "data/items_gfx/handgun.xml",
        from    = "data/items_gfx/handgun.png",
        to      = "mods/grahamsperks/files/wands/handgun.png",
    })
end

for i=1, #patches do
    local patch = patches[i]
    local content = ModTextFileGetContent(patch.path)
    content = content:gsub(patch.from, patch.to)
    ModTextFileSetContent(patch.path, content)
end

function OnPlayerSpawned(player)
	local x, y = EntityGetTransform(player)
	
	GlobalsSetValue( "GRAHAM_TOGGLE", "null" )
	GlobalsSetValue( "GRAHAM_TOGGLE2", "null" )

	if ModSettingGet("grahamsperks.SettingsReminder") then
	    GamePrint("$graham_settings_check")
	end
	
	if GameHasFlagRun("spawned_lifelottery") == false then
		GlobalsSetValue( "GRAHAM_ONEOFFS", "0" )
		GameAddFlagRun("spawned_lifelottery")
			
		if HasFlagPersistent("graham_death_hp_boost") then
			RemoveFlagPersistent("graham_death_hp_boost")
			EntityLoad("mods/grahamsperks/files/pickups/heart_healthy.xml", x, y)
			EntityLoad("mods/grahamsperks/files/pickups/heart_healthy.xml", x, y)
			EntityLoad("data/entities/_debug/random_perk.xml", x, y - 20)
		end

		local eid = EntityCreateNew()
		EntityAddTag(eid, "graham_midas_curse")
		EntityAddChild(GameGetWorldStateEntity(), eid)

		EntityAddComponent(player, "LuaComponent", {
			script_source_file="mods/grahamsperks/files/entities/unlockcheck.lua",
			execute_every_n_frame="5",
		})

		EntityAddComponent(player, "LuaComponent", {
			script_death="mods/grahamsperks/files/scripts/death.lua",
			execute_every_n_frame="-1",
		})

		if not HasFlagPersistent("graham_death_is_ok") then
			RemoveFlagPersistent("graham_deathquest_01")
			RemoveFlagPersistent("graham_deathquest_02")
			RemoveFlagPersistent("graham_deathquest_03")
		end
		RemoveFlagPersistent("graham_death_is_ok")

		if HasFlagPersistent("graham_deathquest_03") then
			-- death quest complete
			EntityAddTag(player, "polymorphable_NOT")
			local comp = EntityGetComponent(player, "DamageModelComponent") or {}
			for i = 1, #comp do
				EntitySetComponentIsEnabled(player, comp[i], false)
			end
			comp = EntityGetComponent(player, "CharacterDataComponent") or {}
			for i = 1, #comp do
				ComponentSetValue2(comp[i], "flying_needs_recharge", false)
			end
			comp = EntityGetComponent(player, "WalletComponent") or {}
			for i = 1, #comp do
				EntityRemoveComponent(player, comp[i])
			end

			EntityAddComponent2(player, "CellEaterComponent", {
				radius=8,
				eat_probability=1,
			})

			local worldstate = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
			ComponentSetValue2(worldstate, "global_genome_relations_modifier", 200)
			ComponentSetValue2(worldstate, "intro_weather", true)
			GameAddFlagRun("graham_gold_all_enemies")

			EntityAddComponent2(player, "LuaComponent", {
				script_source_file="mods/grahamsperks/files/scripts/delete_all.lua",
				execute_every_n_frame=5,
			})
		end
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()
	SetRandomSeed(100 + hour, 100 + second)
	if ( month == 11 ) and ( day == 11 ) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
	elseif (Random(1, 100) == 1) or ModSettingGet("grahamsperks.birthday") == "yes" then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
	end
	
	SetRandomSeed(10 + minute, 10 + year)
	if (Random(1, 30) == 1) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_secret.lua" )
	end
end