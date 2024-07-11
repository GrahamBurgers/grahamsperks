local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
dofile_once("data/scripts/lib/utilities.lua")

local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" )

	if shooter ~= 0 and shooter ~= nil then
		local x2, y2 = EntityGetTransform( shooter )
		if x2 ~= nil then
			local dir_x = x2 - x
			local dir_y = y2 - y
			local distance = math.floor(math.sqrt(dir_x * dir_x + dir_y * dir_y) / 10)
			if distance > 15 then distance = 15 end
			local curx = x
			local cury = y
			local count = 0

			while count < distance do
				curx = curx + (dir_x / distance)
				cury = cury + (dir_y / distance)
				shoot_projectile_from_projectile( entity_id, "mods/grahamsperks/files/entities/connection_trail.xml", curx, cury, 0, 0)
				-- EntityLoad("mods/grahamsperks/files/entities/connection_trail.xml", curx, cury)
				count = count + 1
			end
		end

	else
	end

end