-- made this into a separate script. if *only* there was a modifier that disabled luacomponents...
local me = GetUpdatedEntityID()
local xs, ys = PhysicsGetComponentVelocity(me, EntityGetFirstComponent(me, "PhysicsBodyComponent") or 0)
local speed = (xs^2+ys^2)^0.5
local proj = EntityGetFirstComponent(me, "ProjectileComponent") or 0
ComponentObjectSetValue2(proj, "damage_by_type", "physics_hit", speed / 4)
if speed < 1 then
    EntityKill(me)
end