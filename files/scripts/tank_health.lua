local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local health = EntityGetFirstComponentIncludingDisabled(EntityGetClosestWithTag(x, y, "player_unit"), "DamageModelComponent")
local comp = EntityGetFirstComponentIncludingDisabled(me, "DamageModelComponent")
if comp ~= nil and health ~= nil then
    ComponentSetValue2(comp, "hp", ComponentGetValue2(health, "max_hp") / 2)
    ComponentSetValue2(comp, "max_hp", ComponentGetValue2(health, "max_hp") / 2)
end