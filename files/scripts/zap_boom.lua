function death()
    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    EntityLoad("data/entities/projectiles/thunderball_slow.xml", x, y)
end