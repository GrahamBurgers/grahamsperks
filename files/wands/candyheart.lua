dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunActionPermanent( entity_id, "GRAHAM_MANAHEART" )
AddGunActionPermanent( entity_id, "COLOUR_RAINBOW" )
AddGunAction( entity_id, "GRAHAM_CIRCLE_SWEET" )
AddGunAction( entity_id, "GRAHAM_MIST_SWEET" )