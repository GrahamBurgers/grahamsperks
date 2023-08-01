dofile_once("data/scripts/lib/utilities.lua")
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(GetUpdatedEntityID())
SetRandomSeed(x + me + 3294, y + GameGetFrameNum() + 340)
local comp = EntityGetFirstComponent(EntityGetParent(me), "ProjectileComponent") or 0

for i = 1, Random(1, 3) do
    SetRandomSeed(x + me + i, y + GameGetFrameNum() + 340)
    shoot_projectile( ComponentGetValue2(comp, "mWhoShot"), "mods/grahamsperks/files/spells/hail.xml", x + Randomf(30, -30), y + 15, Randomf(25, -25), Randomf(80, 120) )
end