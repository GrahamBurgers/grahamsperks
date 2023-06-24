dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- convert items
local converted2 = false

local function EntityGetInRadiusWithName(x, y, radius, name)
	local list = EntityGetInRadius(x, y, radius)
	local new_list = {}
	for i = 1, #list do
		if EntityGetName(list[i]) == name then
			table.insert(new_list, list[i])
		end
	end
	return new_list
end

for _,id in pairs(EntityGetInRadiusWithName(pos_x, pos_y, 70, "$graham_magmacore_name")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id then
		local x,y = EntityGetTransform(id)
		EntityLoad("mods/grahamsperks/files/pickups/burg.xml", x, y - 5)
		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(id)
		converted2 = true
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "cybereye_forgeable")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id then
		local x,y = EntityGetTransform(id)
		EntityLoad("mods/grahamsperks/files/pickups/cybereye.xml", x, y - 5)
		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(id)
		converted2 = true
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "bloodmoon_forgeable")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id then
		local x,y = EntityGetTransform(id)
		EntityLoad("mods/grahamsperks/files/pickups/bloodmoon.xml", x, y - 5)
		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(id)
		converted2 = true
	end
end

for _,id in pairs(EntityGetInRadiusWithName(pos_x, pos_y, 70, "$graham_unlockbook_name")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id then
		local x,y = EntityGetTransform(id)
		EntityLoad("mods/grahamsperks/files/entities/books/reforgebook.xml", x, y - 5)
		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(id)
		converted2 = true
	end
end

if converted2 then
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_01", true, pos_x, pos_y )
end