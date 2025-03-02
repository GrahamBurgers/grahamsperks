local entity_id = GetUpdatedEntityID()
local COUNT = 9
local x, y = EntityGetTransform( entity_id )
dofile_once("data/scripts/lib/utilities.lua")

local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" )
	if shooter and shooter ~= 0 then
		for i = 1, COUNT - 1 do
			local shot = shoot_projectile_from_projectile( entity_id, "mods/grahamsperks/files/entities/connection_trail_dot.xml", x, y, 0, 0)
			local proj = EntityGetFirstComponent(shot, "ProjectileComponent")
			if proj then
				ComponentSetValue2(proj, "on_death_emit_particle_count", entity_id)
				ComponentSetValue2(proj, "bounce_energy", i) -- store identifier
			end
		end
	end
end