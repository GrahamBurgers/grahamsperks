dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local projectiles = EntityGetInRadiusWithTag( x, y, 192, "projectile" ) or {}
for i = 1, #projectiles do
	local comps = EntityGetComponent(projectiles[i], "ProjectileComponent") or {}
	for j = 1, #comps do
		ComponentSetValue2(comps[j], "penetrate_world", true)
		ComponentSetValue2(comps[j], "penetrate_world_velocity_coeff", 0.4)
	end
end