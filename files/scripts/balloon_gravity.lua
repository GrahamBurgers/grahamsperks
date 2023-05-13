local entity_id = GetUpdatedEntityID()
local suc = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
local inv = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialInventoryComponent" )
if inv ~= nil and suc ~= nil then
    local counts = ComponentGetValue2( inv, "count_per_material_type" )
    local capacity = ComponentGetValue2( suc, "barrel_size")
    local fullness = 0
    for i=1, #counts do
        fullness = fullness + counts[i]
    end
    local ratio = fullness/capacity
    local x, y = EntityGetTransform(entity_id)
    PhysicsApplyForceOnArea(
        function(entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular)
            return body_x, body_y, 0, (ratio * (-body_mass * 1.2))*9.5, 0 -- forcePosX,forcePosY,forceX,forceY,forceAngular
        end, 0, x, y, x, y
    )
end