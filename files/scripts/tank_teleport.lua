local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "player_unit"))
if x2 ~= nil and y2 ~= nil then
    local distance =  math.sqrt((x2 - x)^2 + (y2 - y)^2)
    if distance > 400 then
        EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(me, x2, y2)
    end
end

-- make friendly to player (so friends don't beat each other up when game is restarted)
local comp = EntityGetFirstComponentIncludingDisabled(me, "GenomeDataComponent") or 0
ComponentSetValue2(comp, "herd_id", StringToHerdId("player"))