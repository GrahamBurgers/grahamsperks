dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunAction( entity_id, "GRAHAM_TOGGLER" )
AddGunAction( entity_id, "GRAHAM_TOGGLE_RED" )
AddGunAction( entity_id, "LIGHT_BULLET" )
AddGunAction( entity_id, "GRAHAM_TOGGLE_BLUE" )
AddGunAction( entity_id, "SPITTER" )