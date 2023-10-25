local player = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(player)
SetRandomSeed(player + x, y + GameGetFrameNum())
if Random(1, 3) == 1 then
    GamePlayAnimation(player, "hurt", 2)
    local eid = EntityLoad("mods/grahamsperks/files/entities/flummoxium.xml", x, y)
    EntityAddChild(player, eid)
end