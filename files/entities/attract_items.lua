dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity( entity_id )
local wand_id = find_the_wand_held( player_id )
local x
local y

if ( wand_id ~= nil ) and ( wand_id ~= NULL_ENTITY ) then
    x,y = EntityGetTransform( wand_id )
else return end

local items = EntityGetWithTag( "gold_nugget" )
local distance_full = tonumber( GlobalsGetValue( "PERK_ATTRACT_ITEMS_RANGE", "72" ) )
local power = math.min( distance_full / 16, 10 )

if ( #items > 0 ) then
	for i,item_id in ipairs(items) do	
		local px, py = EntityGetTransform( item_id )
		
		local distance = math.abs( x - px ) + math.abs( y - py )
		
		if ( distance < distance_full * 1.25 ) then
			distance = math.sqrt( ( x - px ) ^ 2 + ( y - py ) ^ 2 )
			direction = 0 - math.atan2( ( y - py ), ( x - px ) )
	
			if ( distance < distance_full ) then
				local physicscomponents = EntityGetComponent( item_id, "PhysicsBodyComponent" )
				
				if ( physicscomponents ~= nil ) then
					local vel_x = math.cos( direction ) * power
					local vel_y = 0 - math.sin( direction ) * power
					
					PhysicsApplyForce( item_id, vel_x, vel_y )
				end
			end
		end
	end
end