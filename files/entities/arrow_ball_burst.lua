dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local target = EntityGetClosestWithTag(x, y, "enemy")

SetRandomSeed(x * y, entity_id)

local found, dir = false, nil
if target then
	local x2, y2 = EntityGetTransform(target)
	local distance = math.sqrt((x2 - x)^2 + (y2 - y)^2)
	local hit, _, _ = RaytracePlatforms(x, y, x2, y2)
	if (not hit) and distance < 256 then
		found = true
		dir = math.atan((y2 - y) / (x2 - x))
		if x2 < x then dir = dir + math.pi end
	end
end

local how_many = 16

for i=1,how_many do
	SetRandomSeed(x + GameGetFrameNum() + 4248950, y - 252490 + GameGetFrameNum() + i * 3297)
	local theta = Random(math.pi * 4, -math.pi * 4)
	if found and dir and Random(1, 6) < 6 then
		theta = dir + Random(-math.pi, math.pi) / 8
	end
	SetRandomSeed(x - entity_id + 4250 + i * 3429, y - 25240 + entity_id + i * 1039)
	local length = Random(350, 550)

	local vel_x = math.cos(theta) * length
	local vel_y = math.sin(theta) * length

	shoot_projectile( entity_id, "data/entities/projectiles/deck/arrow.xml", x + vel_x * 0.025, y + vel_y * 0.025, vel_x, vel_y )
end

EntityLoad( "data/entities/particles/poof_white.xml", x, y )
EntityKill( entity_id )