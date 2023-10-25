dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- abort if conversion already in progress
if #EntityGetInRadiusWithTag(pos_x, pos_y, 10, "graham_item_convert") > 0 then return end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 40, "grahams_things")) do
	-- make sure item is not carried in inventory or wand
	local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
	local picked = false
	if comp ~= nil then
		picked = ComponentGetValue2(comp, "has_been_picked_by_player")
	end
	if EntityGetRootEntity(id) == id and picked then
		-- start conversion
		EntityLoad("mods/grahamsperks/files/entities/forge_item_convert.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", pos_x, pos_y )
		return
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 40, "graham_runestone")) do
	-- make sure item is not carried in inventory or wand
	local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
	local picked = false
	if comp ~= nil then
		picked = ComponentGetValue2(comp, "has_been_picked_by_player")
	end
	if EntityGetRootEntity(id) == id and picked then
		-- start conversion
		EntityLoad("mods/grahamsperks/files/entities/forge_item_convert.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", pos_x, pos_y )
		return
	end
end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 40, "wand")) do
	-- make sure item is not carried in inventory or wand
	local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
	local picked = false
	if comp ~= nil then
		picked = ComponentGetValue2(comp, "has_been_picked_by_player")
	end
	if EntityGetRootEntity(id) == id and picked then
		-- start conversion
		EntityLoad("mods/grahamsperks/files/entities/forge_item_convert.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", pos_x, pos_y )
		return
	end
end