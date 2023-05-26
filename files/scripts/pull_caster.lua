local me = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(me, "ProjectileComponent") or 0
local caster = ComponentGetValue2(proj, "mWhoShot")
if caster ~= nil then
    local x, y = EntityGetTransform(me)
    local velocity = EntityGetFirstComponentIncludingDisabled(caster, "CharacterDataComponent") or 0
    ComponentSetValue2(velocity, "mVelocity", 0, 0)
    EntityApplyTransform(caster, x, y)

    local xs, ys = PhysicsGetComponentVelocity(me, EntityGetFirstComponent(me, "PhysicsBodyComponent") or 0)
    local speed = (xs^2+ys^2)^0.5
    ComponentObjectSetValue2(proj, "damage_by_type", "physics_hit", speed / 20)
    if speed < 1.5 then
        EntityKill(me)
    end
end