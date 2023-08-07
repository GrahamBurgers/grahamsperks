function enabled_changed(me)
    local body = EntityGetFirstComponentIncludingDisabled(me, "PhysicsBodyComponent") or 0
    local imageshape = EntityGetFirstComponentIncludingDisabled(me, "PhysicsImageShapeComponent") or 0
    local ai = EntityGetFirstComponentIncludingDisabled(me, "PhysicsAIComponent") or 0
    if body == 0 or imageshape == 0 then return end
    ComponentSetValue2(body, "uid", ComponentGetValue2(imageshape, "body_id"))
    ComponentSetValue2(body, "uid", ComponentGetValue2(imageshape, "body_id"))
    if ai == 0 then return end
    ComponentSetValue2(ai, "mMainBodyFound", false)
end