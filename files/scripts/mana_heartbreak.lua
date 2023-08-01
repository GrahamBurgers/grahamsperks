local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(me, "AbilityComponent")
local storage = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "mana_debt")
if storage ~= nil then
    if ComponentGetValue2(storage, "value_int") < 1 then
        EntityRemoveComponent(me, GetUpdatedComponentID())
        return
    else
        ComponentSetValue2(storage, "value_int", ComponentGetValue2(storage, "value_int") - 1)
    end
end
if comp ~= nil then
    ComponentSetValue2(comp, "mana_max", ComponentGetValue2(comp, "mana_max") + 1)
end