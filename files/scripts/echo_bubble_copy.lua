local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "ProjectileComponent") or 0
local caster = ComponentGetValue2(comp, "mWhoShot")
if caster ~= nil and caster ~= 0 then
    local x, y = EntityGetTransform(caster)
    EntityApplyTransform(me, x, y - 2)
end