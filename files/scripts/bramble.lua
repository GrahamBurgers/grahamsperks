-- hax but it actually works somehow
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local bramble = EntityGetInRadiusWithTag(x, y, 8, "graham_bramball")
if not bramble then return end
local comp = EntityGetFirstComponent(bramble[1], "ProjectileComponent")
local comp2 = EntityGetFirstComponent(me, "ProjectileComponent")
local var = EntityGetFirstComponent(bramble[1], "VariableStorageComponent")
if comp and comp2 and var then
    ComponentSetValue2(comp2, "mWhoShot", ComponentGetValue2(comp, "mWhoShot"))
    -- inherit lifetime modifiers
    ComponentSetValue2(comp2, "lifetime", ComponentGetValue2(var, "value_int") * 1.5)
    -- inherit damage
    local dmg = (ComponentGetValue2(comp, "damage") / 2) + ComponentObjectGetValue2(comp, "damage_by_type", "slice")
    ComponentObjectSetValue2(comp2, "damage_by_type", "slice", dmg)
end