local me = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(me, "ProjectileComponent") or 0
local caster = ComponentGetValue2(proj, "mWhoShot")
if caster ~= nil then
    local x, y = EntityGetTransform(me)
    local velocity = EntityGetFirstComponentIncludingDisabled(caster, "CharacterDataComponent") or 0
    if velocity ~= 0 then
        ComponentSetValue2(velocity, "mVelocity", 0, 0)
    end
    EntityApplyTransform(caster, x, y)
end