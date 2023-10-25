dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- convert items
local converted2 = false

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "magmastone")) do
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

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "book_reforgeable")) do
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