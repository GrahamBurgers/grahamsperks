dofile_once("data/scripts/perks/perk.lua")

local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
if HasFlagPersistent("fury_secret_funny") then
    perk_spawn(x, y - 30, "GRAHAM_EXTRA_SLOTS", true)
else
    if HasFlagPersistent("graham_deathquest_03") then
        local pid = perk_spawn(x, y, "GRAHAM_EXTRA_SLOTS", true)
        EntityRemoveTag(pid, "perk")
        EntityAddComponent(pid, "LuaComponent", {
            script_item_picked_up="mods/grahamsperks/files/scripts/deathquest_finish.lua"
        })
    end
end
EntityKill(me)