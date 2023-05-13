dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunActionPermanent( entity_id, "GRAHAM_ROT" )
AddGunActionPermanent( entity_id, "NECROMANCY" )
AddGunAction( entity_id, "SPITTER_TIMER" )
AddGunAction( entity_id, "GRAHAM_WOOD" )