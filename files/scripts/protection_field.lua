dofile_once("data/scripts/lib/utilities.lua")

local distance_full = 50

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local root_entity = EntityGetRootEntity( entity_id )

-- attract projectiles
local entities = EntityGetInRadiusWithTag(x, y, distance_full, "hittable")
for _,id in ipairs(entities) do	
	local comp = EntityGetFirstComponent( id, "DamageModelComponent" )
	if ( comp ~= nil ) and (id ~= root_entity) then
		local eid = EntityLoad( "data/entities/misc/effect_protection_all_ultrashort.xml", x, y )
		EntityAddChild( id, eid )
	end
end