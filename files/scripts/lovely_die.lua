local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x, y)
if Random(1, 10) == 10 and HasFlagPersistent("graham_progress_lukki") then
    EntityKill(me)
    EntityLoad("mods/grahamsperks/files/pickups/lovely_die.xml", x, y)
end