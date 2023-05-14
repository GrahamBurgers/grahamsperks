local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local x2, y2 = EntityGetTransform(EntityGetClosestWithTag(x, y, "player_unit"))
if x2 ~= nil and y2 ~= nil then
    local dir_x = x - x2
    local dir_y = y - y2
    local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
    if distance > 300 then
        EntityLoad( "data/entities/particles/teleportation_target.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(me, x2, y2)
    end
end