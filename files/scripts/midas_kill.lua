dofile_once("mods/grahamsperks/files/scripts/midas_gold.lua")

local me = GetUpdatedEntityID()
local name = EntityGetName(me)
local comps = EntityGetComponent(EntityGetWithTag("graham_midas_curse")[1], "VariableStorageComponent")
if comps ~= nil then
    for i = 1, #comps do
        if ComponentGetValue2(comps[i], "value_string") == name then
            -- hopefully this works
            obliterate(me)
        end
    end
end