dofile_once("data/scripts/perks/perk.lua")

if HasFlagPersistent("graham_deathquest_03") then
    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    local pid = perk_spawn(x, y, "GRAHAM_EXTRA_SLOTS")
    EntityRemoveTag(pid, "perk")
    EntityAddComponent(pid, "LuaComponent", {
        script_item_picked_up="mods/grahamsperks/files/scripts/deathquest_finish.lua"
    })
    EntityKill(me)
end