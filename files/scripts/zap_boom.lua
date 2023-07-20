function death()
    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    local eid = EntityLoad("data/entities/projectiles/thunderball_slow.xml", x, y)
    local comp = EntityGetFirstComponent(eid, "ProjectileComponent") or 0
    ComponentSetValue2(comp, "lifetime", 240)
end