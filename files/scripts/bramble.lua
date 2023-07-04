-- hax but it actually works somehow
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local bramble = EntityGetClosestWithTag(x, y, "graham_bramball")
local comp = EntityGetFirstComponent(bramble, "ProjectileComponent")
if comp ~= nil then
    local comp2 = EntityGetFirstComponent(me, "ProjectileComponent") or 0
    if comp2 == 0 then return end
    ComponentSetValue2(comp2, "mWhoShot", ComponentGetValue2(comp, "mWhoShot"))
    -- inherit lifetime modifiers
    local var = EntityGetFirstComponent(bramble, "VariableStorageComponent") or 0
    ComponentSetValue2(comp2, "lifetime", ComponentGetValue2(var, "value_int") + 160)
end