local entity_id = EntityGetRootEntity(GetUpdatedEntityID())
local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if proj then
	ComponentSetValue2(proj, "die_on_low_velocity", false)
end
local vel = EntityGetFirstComponent(entity_id, "VelocityComponent")
if vel then
	ComponentSetValue2(vel, "gravity_x", 0)
	ComponentSetValue2(vel, "gravity_y", 0)
end