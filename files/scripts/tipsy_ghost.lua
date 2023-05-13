dofile_once( "data/scripts/lib/utilities.lua" )

-- Setup (hope this doesn't cause too much lag)
SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
local ghost = GetUpdatedEntityID()
local x, y = EntityGetTransform(ghost)
local player = EntityGetRootEntity(ghost)
local px, py = EntityGetTransform(player)
local rand = Random(1, 1000)

if rand <= 80 then
    -- Spawn empty potion
    EntityLoad("data/entities/items/pickup/potion_empty.xml", x, y)
elseif rand <= 400 then
    -- Poop joke
    local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "destruction_target"))
    if x2 ~= nil then
        local dir_x = x - x2
        local dir_y = y - y2
        local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
        if distance < 200 then
            shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_shot.xml", x, y, dir_x * -4, dir_y * -4) 
        end
    end
elseif rand <= 600 then
    -- Clear bad stuff
    EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/clean.xml", px, py)
elseif rand <= 800 then
    -- Alcoholify nearest enemy
    local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "destruction_target"))
    if x2 ~= nil then
        local dir_x = x - x2
        local dir_y = y - y2
        local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
        if distance < 200 then
            EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/circle_tipsy.xml", x2, y2)
        end
    end
elseif rand <= 820 then
    -- Toss urine jar at nearest enemy
    local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "destruction_target"))
    if x2 ~= nil then
        local dir_x = x - x2
        local dir_y = y - y2
        local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
        if distance < 200 then
            shoot_projectile( player, "data/entities/items/pickup/jar_of_urine.xml", x, y, dir_x / -12, dir_y / -12 ) 
        end
    else
    -- Chuck ambrosia at player
        local dir_x = x - px
        local dir_y = y - py
        local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
        if distance < 200 and Random(1, 4) == 1 then
            shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/potion_ambro.xml", x, y, dir_x / -4, dir_y / -4 ) 
        end
    end
elseif rand <= 880 then
    EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/cloud_alcohol.xml", x, y)
elseif BiomeMapGetName(x, y) ~= "$biome_holymountain" then
    -- *try* not to anger the gods
    EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/tipsy_whiskey.xml", x, y)

elseif rand <= 930 then
    local nearby_enemies = EntityGetInRadiusWithTag(x, y, 200, "destruction_target")
    for i in ipairs(nearby_enemies) do
        local x2, y2 = EntityGetTransform(nearby_enemies[i])
        EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/toxic.xml", x2, y2)
    end
end