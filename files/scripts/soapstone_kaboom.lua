local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

-- oh no, this script might be slightly weird if the user has 2 or more suns within 56 pixels of one another!!!
local sun = EntityGetInRadiusWithTag(x, y, 56, "seed_d")[1] or nil

if sun ~= nil then
    x, y = EntityGetTransform(sun)
    EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
    GameScreenshake( 30, x, y )
    local players = EntityGetWithTag("player_unit")
    for j = 1, #players do
        local effect = EntityLoad("mods/grahamsperks/files/effects/clean.xml", x, y)
        EntityAddChild(players[j], effect)
    end
    EntityKill(entity_id)
end