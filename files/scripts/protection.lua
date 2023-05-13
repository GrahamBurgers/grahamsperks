dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once( "data/scripts/game_helpers.lua" )

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity( entity_id  )
local x, y = EntityGetTransform( player_id )

local currbiome = BiomeMapGetName( x, y )
local flag = "graham_guard_" .. tostring(currbiome) .. "_visited"

if ( GameHasFlagRun( flag ) == false ) then
	local value = GlobalsGetValue( "GRAHAM_GUARD_COUNTER", "1" )
	GlobalsSetValue( "GRAHAM_GUARD_COUNTER", value + 1 )
	local entity_id = EntityLoad( "mods/grahamsperks/files/effects/guard.xml", x, y )
	EntityAddChild( player_id, entity_id )
	
	GameAddFlagRun( flag )
	if tonumber(value) < 30 then
		GamePrint( "$graham_log_guard_" .. tostring(value) )
	else
		GamePrint( "$graham_log_guard_30" )
	end
end