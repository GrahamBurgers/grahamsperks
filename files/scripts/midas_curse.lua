dofile_once("mods/grahamsperks/files/scripts/midas_gold.lua")

local entity = EntityGetWithTag("graham_midas_curse")[1]
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local enemy = EntityGetInRadiusWithTag(x, y, 20, "graham_midas_curseable")[1] or 0
if enemy ~= 0 then
    local name = EntityGetName(enemy)
    EntityAddComponent2(entity, "VariableStorageComponent", {
        name = "graham_midas_curse",
        value_string = name,
    })
    -- hopefully this works
    obliterate(enemy)
    -- pretend like this is a holy mountain collapse
    GameTriggerMusicFadeOutAndDequeueAll( 2.0 )
    EntityLoad("data/entities/misc/workshop_collapse.xml", x, y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/temple_collapse", x, y )
    EntityLoad("data/entities/projectiles/deck/crumbling_earth.xml", x - 100, y)
    EntityLoad("data/entities/projectiles/deck/crumbling_earth.xml", x + 100, y)
    EntityKill(me)
end