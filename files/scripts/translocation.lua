dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local projectiles = EntityGetInRadiusWithTag( x, y, 32, "projectile" )
SetRandomSeed( x, y - GameGetFrameNum() )
local who_shot_me = nil
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
	who_shot_me = ComponentGetValue2( comp, "mWhoShot" )
end)
local comp = EntityGetFirstComponent(entity_id, "ParticleEmitterComponent")
local lifetime = EntityGetFirstComponent(entity_id, "LifetimeComponent")
if not lifetime or not comp then return end
local left = ComponentGetValue2(lifetime, "kill_frame") - GameGetFrameNum()
ComponentSetValue2(comp, "area_circle_radius", left / 257.142857, left / 257.142857)
ComponentSetValue2(comp, "count_min", left / 60)
ComponentSetValue2(comp, "count_max", left / 60)

for i,projectile_id in ipairs(projectiles) do
	if projectile_id ~= entity_id then
		local px, py = EntityGetTransform( projectile_id )
		local vel_x, vel_y = 0,0
		local who_shot = 0
		
		edit_component( projectile_id, "VelocityComponent", function(comp,vars)
			vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
			
			--ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
		end)
		
		edit_component( projectile_id, "ProjectileComponent", function(comp,vars)
			who_shot = ComponentGetValue2( comp, "mWhoShot" ) 
		end)
		
		-- print( tostring( who_shot ) .. ", " .. tostring( entity_id ) )
		
		if ( who_shot ~= who_shot_me ) then
			local spd = math.sqrt( vel_y ^ 2 + vel_x ^ 2 )
			
			if ( spd < 1000 ) then
				local dir = 0 - math.atan2( vel_y, vel_x )
				local dir2 = 0 - math.atan2( py - y, px - x )
				
				local mirror = dir + math.pi * 0.5
				local final = mirror + ( mirror - dir2 )
				
				EntityLoad( "data/entities/particles/teleportation_source.xml", px, py )
				px = x + math.cos( final ) * 34
				py = y - math.sin( final ) * 34
				EntityLoad( "data/entities/particles/teleportation_target.xml", px, py )
				
				EntitySetTransform( projectile_id, px, py )
				GamePlaySound("data/audio/Desktop/misc.bank", "game_effect/teleport/tick", px, py)

				-- subtract 3 seconds of lifetime for each projectile successfully phased
				-- I hope this can't cause any funky infinite lifetime shenanigans
				ComponentSetValue2(lifetime, "kill_frame", ComponentGetValue2(lifetime, "kill_frame") - 180)
			end
		end
	end
end