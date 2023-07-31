local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local radius = ComponentObjectGetValue2(comp, "config_explosion", "explosion_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius, "prey")
for i = 1, #enemies do
    if enemies[i] ~= GetUpdatedEntityID() then
        local eid = EntityLoad( "data/entities/misc/effect_movement_slower_ui.xml" )
        EntityAddChild( enemies[i], eid )
    end
end