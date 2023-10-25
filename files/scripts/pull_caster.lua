local me = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(me, "ProjectileComponent") or 0
local caster = ComponentGetValue2(proj, "mWhoShot")
if caster ~= nil then
    local x, y = EntityGetTransform(me)
    local x2, y2 = EntityGetTransform(caster)
    local distance = math.sqrt((x2 - x)^2 + (y2 - y)^2)
    if distance > 50 then
        EntityKill(me)
        return
    end
    local velocity = EntityGetFirstComponentIncludingDisabled(caster, "CharacterDataComponent") or 0
    if velocity ~= 0 then
        ComponentSetValue2(velocity, "mVelocity", 0, 0)
    end
    EntityApplyTransform(caster, x, y)
end