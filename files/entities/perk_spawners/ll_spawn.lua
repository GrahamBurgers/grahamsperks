dofile_once("data/scripts/perks/perk.lua")

local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
perk_spawn(x, y, "GRAHAM_LIFE_LOTTERY", true)
EntityKill(me)