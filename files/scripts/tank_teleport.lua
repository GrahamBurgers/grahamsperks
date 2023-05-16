local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "player_unit"))
if x2 ~= nil and y2 ~= nil then
    local distance = math.abs( x - x2 ) + math.abs( y - y2)
    if distance > 400 then
        EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(me, x2, y2)
    end
end