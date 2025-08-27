if GameHasFlagRun("PERK_PICKED_GRAHAM_MAP") then
    dofile_once("data/scripts/perks/perk.lua")

    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    perk_spawn(x, y, "GRAHAM_MAP2", true)
    EntityKill(me)
end