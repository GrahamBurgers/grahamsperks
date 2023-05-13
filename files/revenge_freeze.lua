dofile_once( "data/scripts/lib/utilities.lua" )

function damage_received( damage, desc, entity_who_caused, is_fatal )

local entity_id    = GetUpdatedEntityID()
local x, y, angle = EntityGetTransform( entity_id )

if( damage < 0 ) then return end

if script_wait_frames( entity_id, 10 ) then return end

SetRandomSeed(x, y)

local count = 6
local current = Random(0, 360)
local speed = 320

if GameHasFlagRun("PERK_PICKED_NO_MORE_SHUFFLE") then current = 0 end

if GameHasFlagRun("PERK_PICKED_GRAHAM_HEAT_WAVE") then speed = speed * 1.5 end

if GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
	count = count * 2
	speed = speed * 0.8
end

for i=1,count do
	local vx = math.sin( current ) * speed
	local vy = math.cos( current ) * speed
	shoot_projectile( entity_id, "data/entities/projectiles/deck/freezing_gaze_beam.xml", x, y, vx, vy )
	current = current + (math.rad(360) / count)
end

end