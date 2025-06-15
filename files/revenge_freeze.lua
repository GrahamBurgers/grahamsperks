dofile_once( "data/scripts/lib/utilities.lua" )

function damage_received( damage, desc, entity_who_caused, is_fatal )

local entity_id    = GetUpdatedEntityID()
local x, y, angle = EntityGetTransform( entity_id )

if( damage < 0 ) then return end

if script_wait_frames( entity_id, 20 ) then return end

SetRandomSeed(x, y)

local count = 6
local current = Random(0, 360)
local speed = 550

if GameHasFlagRun("PERK_PICKED_GRAHAM_HEAT_WAVE") then speed = speed * 1.5 end

if GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
	count = count * 2
	speed = speed * 0.8
end

if ( entity_who_caused ~= nil ) and ( entity_who_caused ~= NULL_ENTITY ) then
	local ex, ey = EntityGetTransform( entity_who_caused )
	
	if ( ex ~= nil ) and ( ey ~= nil ) then
		current = 0 - math.atan2( ey - y, ex - x )
	end
end

current = current + (math.rad(360) / count) / 2
for i=1,count do
	local vx = math.sin( current ) * speed
	local vy = math.cos( current ) * speed
	shoot_projectile( entity_id, "mods/grahamsperks/files/entities/revenge_freeze_beam.xml", x, y, vx, vy )
	current = current + (math.rad(360) / count)
end

end