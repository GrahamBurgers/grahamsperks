-- hax but it actually works somehow
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local bramble = EntityGetClosestWithTag(x, y, "graham_bramball")
local comp = EntityGetFirstComponent(bramble, "ProjectileComponent")
if comp ~= nil then
    ComponentSetValue2(EntityGetFirstComponent(me, "ProjectileComponent") or 0, "mWhoShot", ComponentGetValue2(comp, "mWhoShot"))
end