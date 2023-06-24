dofile_once("mods/grahamsperks/files/scripts/midas_gold.lua")

local me = GetUpdatedEntityID()
if GameHasFlagRun("graham_gold_all_enemies") then
    obliterate(me)
    return
end
local name = EntityGetName(me)
local comps = EntityGetComponent(EntityGetWithTag("graham_midas_curse")[1], "VariableStorageComponent")
if comps ~= nil then
    for i = 1, #comps do
        if ComponentGetValue2(comps[i], "value_string") == name then
            -- hopefully this works
            obliterate(me)
            break
        end
    end
end

EntityAddTag(me, "graham_midas_curseable")