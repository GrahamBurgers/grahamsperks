dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local comp = get_variable_storage_component(entity_id, "graham_chest_type")
local chest = ComponentGetValue2(comp, "value_string")
if chest == "none" then return end

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

-- double payouts; you deserve it
local count = Random(2,6)

for i=1,count do
	EntityLoad( chest, pos_x + Random( -360, 360 ), pos_y - 300 )
end

GameScreenshake( 30 )
