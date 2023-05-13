dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local test = EntityGetInRadiusWithTag( x, y, 50, "evil_eye" )
local found = false

for i,v in ipairs( test ) do
	local c = EntityGetComponent( v, "LightComponent" )
	
	if ( c ~= nil ) then
		found = true
		break
	end
end

if ( found == true ) then
    EntityKill(GetUpdatedEntityID())
    ConvertMaterialOnAreaInstantly( x - 100, y - 100, 200, 200,  CellFactory_GetType("water_static"),  CellFactory_GetType("graham_ascendum"), 0, 0)
	EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y - 70)
end