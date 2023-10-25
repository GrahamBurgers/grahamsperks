dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity( entity_id )
local x,y = EntityGetTransform( player_id )

local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "wizard_orb_id" )
if ( comp ~= nil ) then
	local id = ComponentGetValue2( comp, "value_int" )
	
	local varsto = EntityGetFirstComponent(player_id, "VariableStorageComponent", "graham_blood_orbs")
	local count = 1
	if varsto ~= nil then
		count = ComponentGetValue2(varsto, "value_int")
	end

	local circle = math.pi * 2
	local inc = circle / count
	
	local dir = inc * id + GameGetFrameNum() * 0.01
	
	local nx = x + math.cos( dir ) * 20
	local ny = y - math.sin( dir ) * 20
	
	EntitySetTransform( entity_id, nx, ny )
end