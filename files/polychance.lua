dofile_once("data/scripts/lib/utilities.lua")

function shot(projectile)
    local comps = EntityGetComponent(projectile, "ProjectileComponent")
    local x, y = EntityGetTransform(projectile)
    SetRandomSeed( x + projectile, y - 4530 )
    local rando = 60
    if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then rando = rando - 10 end

    if (comps ~= nil) and (Random(1, rando) == 1) then
        local velocity = EntityGetFirstComponent(projectile, "VelocityComponent")
        local xv, yv = 0, 0
        if velocity ~= nil then
            xv, yv = ComponentGetValue2(velocity, "mVelocity")
        end
        local projcomp = EntityGetFirstComponent(projectile, "ProjectileComponent")
        if projcomp ~= nil then
            local caster = ComponentGetValue2(projcomp, "mWhoShot")
            local eid = shoot_projectile_from_projectile( caster, "data/entities/projectiles/orb_poly.xml", x, y, xv, yv )
            local homing = EntityGetFirstComponent(eid, "HomingComponent")
            if homing ~= nil then
                EntityRemoveComponent(eid, homing)
            end
        end
    end
end