local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local how_many = Random(50,75)
local vel_variation = 200
for i=1,how_many do
	GameCreateParticle("gold", pos_x, pos_y, 2, Random(-vel_variation, vel_variation), Random(-vel_variation, vel_variation), false, true)
end

EntityKill(entity_id)
