function enabled_changed(me, is_enabled)
    local body = EntityGetFirstComponentIncludingDisabled(me, "PhysicsBodyComponent") or 0
    local imageshape = EntityGetFirstComponentIncludingDisabled(me, "PhysicsImageShapeComponent") or 0
    local ai = EntityGetFirstComponentIncludingDisabled(me, "PhysicsAIComponent") or 0
    if body == 0 or imageshape == 0 then return end
    ComponentSetValue2(body, "uid", ComponentGetValue2(imageshape, "body_id"))
    ComponentSetValue2(body, "uid", ComponentGetValue2(imageshape, "body_id"))
    if ai == 0 then return end
    ComponentSetValue2(ai, "mMainBodyFound", false)
    local gun = EntityGetFirstComponent(me, "AnimalAIComponent") or 0
    if gun == 0 then return end
    if is_enabled then
        ComponentSetValue2(gun, "attack_ranged_enabled", true)
    else
        ComponentSetValue2(gun, "attack_ranged_enabled", false)
    end
end