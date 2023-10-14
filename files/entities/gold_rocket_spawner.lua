dofile_once("data/scripts/lib/utilities.lua")
local speed = 85

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

-- velocity
local vel_x,vel_y = GameGetVelocityCompVelocity(entity_id)
vel_x, vel_y = vec_normalize(vel_x, vel_y)
if vel_x == nil then return end
vel_x = vel_x * speed
vel_y = vel_y * speed

shoot_projectile_from_projectile(entity_id, "mods/grahamsperks/files/entities/gold_rocket.xml", pos_x, pos_y, vel_x, vel_y)