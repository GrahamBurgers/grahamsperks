dofile_once("data/scripts/lib/utilities.lua")
local x, y = EntityGetTransform(GetUpdatedEntityID())
SetRandomSeed(x + GetUpdatedEntityID() + 3294, y + GameGetFrameNum() + 340)
for i = 1, Random(1, 3) do
    SetRandomSeed(x + GetUpdatedEntityID() + i, y + GameGetFrameNum() + 340)
    local eid = shoot_projectile( GetUpdatedEntityID(), "mods/grahamsperks/files/spells/hail.xml", x + Randomf(30, -30), y + 15, Randomf(25, -25), Randomf(80, 120), false )
end