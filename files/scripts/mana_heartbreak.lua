local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(me, "AbilityComponent")
if comp ~= nil then
    ComponentSetValue2(comp, "mana_max", ComponentGetValue2(comp, "mana_max") + 1)
end