local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n");
    end
    local new_translations = ModTextFileGetContent( "mods/grahamsperks/files/translations.csv" );
    translations = translations .. new_translations;
    ModTextFileSetContent( "data/translations/common.csv", translations );
end

dofile_once("mods/grahamsperks/lib/polytools_init.lua").init("mods/grahamsperks/lib")
dofile("mods/grahamsperks/lib/polytools.lua")
dofile_once("mods/grahamsperks/lib/polytools_init.lua").init("mods/grahamsperks/lib")

ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials.xml")
ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials_reactions.xml")
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_append.lua" )

	-- Extra mod compatibility
if ModIsEnabled("more-stuff") then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_morestuff.xml")
end

if ModIsEnabled("anvil_of_destiny") then
  ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/grahamsperks/files/scripts/aod_compat.lua")
end

if ModSettingGet("grahamsperks.spells") == "yes" then
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/grahamsperks/files/spells/actions.lua")
end

if ModSettingGet("grahamsperks.creepy") == "yes" then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_creepy.xml")
end

local path = ""
local content = ""
local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()
SetRandomSeed(second, minute)
local lifelottery = Random(1, 6)
if ModSettingGet("grahamsperks.lifelottery") == "yes" then
	if (lifelottery == 5) then
		path = "mods/grahamsperks/files/perks/perk_list.lua"
		content = ModTextFileGetContent(path)
		content = content:gsub("spoopyboi2.png", "mine.png")
		content = content:gsub("spoopyboi.png", "mine2.png")
		ModTextFileSetContent(path, content)
	elseif (lifelottery == 6) then
		path = "mods/grahamsperks/files/perks/perk_list.lua"
		content = ModTextFileGetContent(path)
		content = content:gsub("spoopyboi2.png", "threehamburgers.png")
		content = content:gsub("spoopyboi.png", "threehamburgers.png")
		ModTextFileSetContent(path, content)
	end
end

if ModSettingGet("grahamsperks.perks") == "yes" then
	ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/grahamsperks/files/perks/perk_list.lua")
end

ModLuaFileAppend( "data/scripts/items/heart.lua", "mods/grahamsperks/files/healthyheart.lua" )
ModLuaFileAppend( "data/scripts/items/heart_better.lua", "mods/grahamsperks/files/healthyheart_better.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/grahamsperks/files/effects/status_effects.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/grahamsperks/files/bloodybonus_check.lua" )
ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/grahamsperks/files/add_oneoffs.lua" )
ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/grahamsperks/files/biome_scripts_append.lua" )
ModLuaFileAppend( "data/scripts/biomes/temple_altar.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/biomes/boss_arena.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/grahamsperks/files/scripts/gun_extra_effects.lua")
ModLuaFileAppend( "data/scripts/buildings/forge_item_convert.lua", "mods/grahamsperks/files/scripts/anvil_append.lua")
ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/grahamsperks/files/scripts/perk_append_test.lua")
ModLuaFileAppend( "data/scripts/items/heart_fullhp.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")
ModLuaFileAppend( "data/scripts/items/heart_fullhp_temple.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")

local biome_path = "data/biome/_pixel_scenes.xml"
if ModIsEnabled("noitavania") then biome_path = "mods/noitavania/data/biome/_pixel_scenes.xml" end
local content = ModTextFileGetContent(biome_path)
content = content:gsub("<mBufferedPixelScenes>", [[<mBufferedPixelScenes>
  <PixelScene pos_x="-2379" pos_y="6646" just_load_an_entity="mods/grahamsperks/files/entities/books/cookbook.xml" />
  <PixelScene pos_x="9953" pos_y="-1167" just_load_an_entity="mods/grahamsperks/files/entities/books/polybook.xml" />
  <PixelScene pos_x="-3811" pos_y="10113" just_load_an_entity="mods/grahamsperks/files/entities/books/lonelybook.xml" />
  <PixelScene pos_x="-16268" pos_y="-7093" just_load_an_entity="mods/grahamsperks/files/entities/books/timebook.xml" />
  <PixelScene pos_x="-1933" pos_y="-59" just_load_an_entity="mods/grahamsperks/files/entities/books/anvilbook.xml" />
  <PixelScene pos_x="4379" pos_y="895" just_load_an_entity="mods/grahamsperks/files/pickups/chest_bloody.xml" />
  <PixelScene pos_x="-12340" pos_y="420" just_load_an_entity="mods/grahamsperks/files/pickups/chest_bloody.xml" />
  <PixelScene pos_x="-3367" pos_y="3346" just_load_an_entity="mods/grahamsperks/files/pickups/chest_bloody.xml" />
  <PixelScene pos_x="2945" pos_y="12316" just_load_an_entity="mods/grahamsperks/files/pickups/chest_bloody.xml" />
  <PixelScene pos_x="11480" pos_y="-4864" just_load_an_entity="mods/grahamsperks/files/wands/candyheart.xml" />
  <PixelScene pos_x="10050" pos_y="-736" just_load_an_entity="mods/grahamsperks/files/wands/rotting.xml" />
  <PixelScene pos_x="16090" pos_y="10000" just_load_an_entity="mods/grahamsperks/files/wands/coffee.xml" />
  <PixelScene pos_x="2520" pos_y="7440" just_load_an_entity="mods/grahamsperks/files/wands/petworm.xml" />
  <PixelScene pos_x="4135" pos_y="12964" just_load_an_entity="mods/grahamsperks/files/wands/gluestick.xml" />
  <PixelScene pos_x="16161" pos_y="3333" just_load_an_entity="mods/grahamsperks/files/wands/experimental.xml" />
  <PixelScene pos_x="1487" pos_y="6085" just_load_an_entity="mods/grahamsperks/files/entities/books/unlockbook.xml" />
  <PixelScene pos_x="3435" pos_y="936" just_load_an_entity="mods/grahamsperks/files/pickups/vial.xml" />
  <PixelScene pos_x="-2111" pos_y="2722" just_load_an_entity="mods/grahamsperks/files/pickups/balloon.xml" />
  <PixelScene pos_x="-1908" pos_y="-56" just_load_an_entity="mods/grahamsperks/files/pixelscenes/text.xml" />
  <PixelScene pos_x="-1864" pos_y="-53" just_load_an_entity="data/entities/items/pickup/moon.xml" />
  <PixelScene pos_x="2372" pos_y="530" just_load_an_entity="mods/grahamsperks/files/pixelscenes/hands.xml" />
  <PixelScene pos_x="2382" pos_y="550" just_load_an_entity="mods/grahamsperks/files/entities/goldblood.xml" />
  <PixelScene pos_x="-2221" pos_y="2564" just_load_an_entity="mods/grahamsperks/files/pixelscenes/hellblood.xml" />
  <PixelScene pos_x="-2490" pos_y="6480" just_load_an_entity="mods/grahamsperks/files/pixelscenes/transmutatium.xml" />
  <PixelScene pos_x="3921" pos_y="3100" just_load_an_entity="mods/grahamsperks/files/entities/forge_item_check.xml" />
  <PixelScene pos_x="3951" pos_y="3140" just_load_an_entity="mods/grahamsperks/files/pixelscenes/hand.xml" />
  <PixelScene pos_x="-14638" pos_y="13031" just_load_an_entity="mods/grahamsperks/files/entities/forge_item_check.xml" />
  <PixelScene pos_x="-14608" pos_y="13071" just_load_an_entity="mods/grahamsperks/files/pixelscenes/hand.xml" />
  <PixelScene pos_x="4573" pos_y="528" just_load_an_entity="mods/grahamsperks/files/pixelscenes/eye.xml" />
  <PixelScene pos_x="2000" pos_y="1735" just_load_an_entity="mods/grahamsperks/files/pixelscenes/closedeye.xml" />
  <PixelScene pos_x="2319" pos_y="1868" just_load_an_entity="mods/grahamsperks/files/entities/eyechecker.xml" />
  <PixelScene pos_x="-5302" pos_y="575" just_load_an_entity="mods/grahamsperks/files/pixelscenes/materials.xml" />
  <PixelScene pos_x="-6760" pos_y="7424" just_load_an_entity="mods/grahamsperks/files/pixelscenes/yinyang.xml" />
  <PixelScene pos_x="-6693" pos_y="7515" just_load_an_entity="mods/grahamsperks/files/entities/halo_checker.xml" />
  <PixelScene pos_x="4074" pos_y="12889" just_load_an_entity="mods/grahamsperks/files/pixelscenes/credits.xml" />
  <PixelScene pos_x="11537" pos_y="9956" just_load_an_entity="mods/grahamsperks/files/pixelscenes/water.xml" />
  <PixelScene pos_x="11537" pos_y="9986" just_load_an_entity="mods/grahamsperks/files/pickups/chest_immunity.xml" />
  <PixelScene pos_x="-317" pos_y="-1673" just_load_an_entity="mods/grahamsperks/files/pixelscenes/island.xml" />
  <PixelScene pos_x="-278" pos_y="-1580" just_load_an_entity="mods/grahamsperks/files/entities/fireplace_worse.xml" />
  <PixelScene pos_x="-46" pos_y="-1550" just_load_an_entity="mods/grahamsperks/files/entities/books/cozybook.xml" />
  <PixelScene pos_x="4046" pos_y="12977" just_load_an_entity="mods/grahamsperks/files/pixelscenes/secret.xml" />
  <PixelScene pos_x="4532" pos_y="13081" just_load_an_entity="mods/grahamsperks/files/entities/perk_spawners/map_spawner.xml" />
  <PixelScene pos_x="785" pos_y="-1231" just_load_an_entity="mods/grahamsperks/files/entities/perk_spawners/map2_spawner.xml" />
  <PixelScene pos_x="15090" pos_y="-3333" just_load_an_entity="mods/grahamsperks/files/entities/perk_spawners/ll_spawner.xml" />
  <PixelScene pos_x="16382" pos_y="-1991" just_load_an_entity="mods/grahamsperks/files/pixelscenes/snake.xml" />
  <PixelScene pos_x="14241" pos_y="16284" just_load_an_entity="mods/grahamsperks/files/entities/forge_item_check.xml" />
  <PixelScene pos_x="4692" pos_y="652" just_load_an_entity="mods/grahamsperks/files/entities/tear_secret.xml" />
  <PixelScene pos_x="14271" pos_y="16324" just_load_an_entity="mods/grahamsperks/files/pixelscenes/hand.xml" />
  <PixelScene pos_x="-16295" pos_y="-7140" just_load_an_entity="mods/grahamsperks/files/pixelscenes/home.xml" />
  <PixelScene pos_x="-16238" pos_y="-6987" just_load_an_entity="data/entities/props/furniture_bed.xml" />
  <PixelScene pos_x="-16116" pos_y="-7004" just_load_an_entity="data/entities/props/furniture_wood_table.xml" />
  <PixelScene pos_x="-16016" pos_y="-7068" just_load_an_entity="mods/grahamsperks/files/pickups/chest_lost.xml" />
  <PixelScene pos_x="-16117" pos_y="-7015" just_load_an_entity="mods/grahamsperks/files/pickups/chest_mini.xml" />
  <PixelScene pos_x="-16038" pos_y="-7010" just_load_an_entity="mods/grahamsperks/files/entities/fireplace_worse.xml" />
  <PixelScene pos_x="7412" pos_y="6175" just_load_an_entity="mods/grahamsperks/files/pixelscenes/heart.xml" />
]])
ModTextFileSetContent(biome_path, content)

dofile_once("data/scripts/perks/perk.lua")

-- prepare for the taggening (to make my life easier)
local path = ""
local content = ""

-- make charm on toxic work with toxic material spell
path = "data/entities/misc/hitfx_toxic_charm.xml"
content = ModTextFileGetContent(path)
content = content:gsub("condition_status", "condition_effect")
ModTextFileSetContent(path, content)

-- add tag to all-seeing eye
path = "data/entities/projectiles/deck/xray.xml"
content = ModTextFileGetContent(path)
content = content:gsub("tags=\"projectile_player\"", "tags=\"projectile_player,graham_ase\"")
ModTextFileSetContent(path, content)

-- add tag to kuu
path = "data/entities/items/pickup/moon.xml"
content = ModTextFileGetContent(path)
content = content:gsub("tags=\"hittable,teleportable_NOT,item_pickup,moon_energy\"", "tags=\"hittable,teleportable_NOT,item_pickup,moon_energy,forgeable,bloodmoon_forgeable\"")
ModTextFileSetContent(path, content)

-- add tag to evil eye
path = "data/entities/items/pickup/evil_eye.xml"
content = ModTextFileGetContent(path)
content = content:gsub("tags=\"hittable,teleportable_NOT,item_physics,item_pickup,evil_eye\"", "tags=\"hittable,teleportable_NOT,item_physics,item_pickup,evil_eye,forgeable,cybereye_forgeable\"")
ModTextFileSetContent(path, content)

-- put barrel in starting wands
path = "data/scripts/gun/procedural/starting_bomb_wand.lua"
content = ModTextFileGetContent(path)
content = content:gsub("\"GRENADE\"", "\"GRENADE\",\"GRAHAM_BARREL\"")
ModTextFileSetContent(path, content)

-- noita together perk compat
if ModIsEnabled("noita_together") then
	path = "data/scripts/gun/procedural/starting_bomb_wand.lua"
	content = ModTextFileGetContent(path)
	content = content:gsub("EXTRA_MONEY=true,", "EXTRA_MONEY=true,GRAHAM_HEALTHY_HEARTS=true,GRAHAM_LUCKY_CLOVER=true,GRAHAM_CAMPFIRE=true,")
	ModTextFileSetContent(path, content)
end

-- Golden starting wands
-- Stole this code from copi (thanks copi)
if HasFlagPersistent("graham_death_hp_boost") then
	path = "data/items_gfx/bomb_wand.xml"
	content = ModTextFileGetContent(path)
	content = content:gsub("data/items_gfx/bomb_wand.png", "mods/grahamsperks/files/wands/bomb_wand.png")
	ModTextFileSetContent(path, content)
end

if HasFlagPersistent("graham_death_hp_boost") then
	path = "data/items_gfx/handgun.xml"
	content = ModTextFileGetContent(path)
	content = content:gsub("data/items_gfx/handgun.png", "mods/grahamsperks/files/wands/handgun.png")
	ModTextFileSetContent(path, content)
end

function OnPlayerSpawned(player_entity)
	
	GlobalsSetValue( "GRAHAM_TOGGLE", "null" )
	GlobalsSetValue( "GRAHAM_TOGGLE2", "null" )

	local message = ModSettingGet("grahamsperks.message2")
	if message == "yes" then
	GamePrint("Check the mod settings menu for Graham's Things - new settings were added!")
	end
	
	if GameHasFlagRun("spawned_lifelottery") == false then
		GlobalsSetValue( "GRAHAM_ONEOFFS", "0" )
		GameAddFlagRun("spawned_lifelottery")
		
		local player = EntityGetWithTag( "player_unit" )[1]
		local x, y = EntityGetTransform(player)
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/unlockchecker.xml", x, y )
		EntityAddChild( player, entity_id )
			
		if HasFlagPersistent("graham_death_hp_boost") then
			RemoveFlagPersistent("graham_death_hp_boost")

			local player = EntityGetWithTag("player_unit")[1]
			if player ~= nil then
				local x, y = EntityGetTransform(player)
				EntityLoad("mods/grahamsperks/files/pickups/heart_healthy.xml", x, y)
				EntityLoad("mods/grahamsperks/files/pickups/heart_healthy.xml", x, y)
				EntityLoad("data/entities/_debug/random_perk.xml", x, y - 20)
			end
		end
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	SetRandomSeed(100, 100)
	local year, month, day = GameGetDateAndTimeLocal()
	if ( month == 11 ) and ( day == 11 ) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
	elseif (Random(1, 100) == 1) or ModSettingGet("grahamsperks.birthday") == "yes" then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
	end
	
	SetRandomSeed(10, 10)
	if (Random(1, 30) == 1) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_secret.lua" )
	end

	-- nolla loves their absurdly rare events, so why don't I have a few of my own?
	SetRandomSeed(1000, 1000)
	if (Random(1, 1000) == 1) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_hunger.lua" )
	end

end

-- CUSTOM GENOME FOR THE PLAYER WHEN ROBOTS ARE FRIENDLY
-- Code below is by Horscht and Keith, thanks so much!

function split_string(inputstr, sep)
  sep = sep or "%s"
  local t= {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local content = ModTextFileGetContent("data/genome_relations.csv")

--The function works like this: genome_name is the name of your new genome/faction, 
--default_relation_ab is the relation with all the horizontal genomes which relations weren't specified in the table, 
--default_relation_ba is the relation with all the vertical genomes which relations weren't specified in the table, 
--self relation is the genome's relation with itself, 
--relations is a table which directly specifies the value of the genome relation with.

function add_new_genome(content, genome_name, default_relation_ab, default_relation_ba, self_relation, relations)
  local lines = split_string(content, "\r\n")
  local output = ""
  local genome_order = {}
  for i, line in ipairs(lines) do
    if i == 1 then
      output = output .. line .. "," .. genome_name .. "\r\n"
    else
      local herd = line:match("([%w_-]+),")
      output = output .. line .. ","..(relations[herd] or default_relation_ba).."\r\n"
      table.insert(genome_order, herd)
    end
  end
  
  local line = genome_name
  for i, v in ipairs(genome_order) do
    line = line .. "," .. (relations[v] or default_relation_ab)
  end
  output = output .. line .. "," .. self_relation

  return output
end

content = add_new_genome(content, "player_robotic", 0, 0, 100, {
  player = 100,
  robot = 100,
  healer = 40,
  ghost = 20,
  mage = 20,
  orcs = 2
})

ModTextFileSetContent("data/genome_relations.csv", content)