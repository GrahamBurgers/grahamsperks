dofile_once("mods/grahamsperks/files/scripts/midas_gold.lua")

local entity = EntityGetWithTag("graham_midas_curse")[1]
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local enemy = EntityGetInRadiusWithTag(x, y, 20, "enemy")[1] or 0
if enemy ~= 0 and not EntityHasTag(enemy, "miniboss") and not EntityHasTag(enemy, "boss") then
    local name = EntityGetName(enemy)
    EntityAddComponent2(entity, "VariableStorageComponent", {
        name = "graham_midas_curse",
        value_string = name,
    })
    -- hopefully this works
    obliterate(me)
end