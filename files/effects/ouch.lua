dofile_once("data/scripts/lib/utilities.lua") 

local me = EntityGetRootEntity(GetUpdatedEntityID())
local max_hp = 0
local dmg = EntityGetFirstComponentIncludingDisabled(me, "DamageModelComponent")
if not dmg then return end

max_hp = ComponentGetValue2(dmg, "max_hp")

EntityInflictDamage(dmg, max_hp / 200, "DAMAGE_MELEE", "$graham_status_consumed", "PLAYER_RAGDOLL_CAMERA", 0, 0)
EntityInflictDamage(dmg, max_hp / 200, "DAMAGE_PROJECTILE", "$graham_status_consumed", "PLAYER_RAGDOLL_CAMERA", 0, 0)