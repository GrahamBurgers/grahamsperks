local me = GetUpdatedEntityID()
local varsto = EntityGetFirstComponent(me, "VariableStorageComponent", "player_riding_id") or 0
local player_riding = ComponentGetValue2(varsto, "value_int")
if player_riding ~= 0 then
    local x, y = EntityGetTransform(me)
    local x2, y2 = EntityGetTransform(player_riding)
    local distance = math.abs( x - x2 ) + math.abs( y - y2)
    if distance < 80 then
        EntityApplyTransform(player_riding, x, y - 4)
    else
        EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(me, x2, y2)
    end
    local velocity = EntityGetFirstComponentIncludingDisabled(player_riding, "CharacterDataComponent") or 0
    if velocity ~= 0 then
        ComponentSetValue2(velocity, "mVelocity", 0, 0)
    end

    local comp = EntityGetFirstComponent(player_riding, "ControlsComponent")
    if comp ~= nil then
        local xv, yv = PhysicsGetComponentVelocity(me, EntityGetFirstComponent(me, "PhysicsBodyComponent") or 0)
        xv = xv * -0.1
        yv = yv * -0.1
        yv = yv - 0.3 --stop falling
        if ComponentGetValue2(comp, "mButtonDownRight") then xv = xv + 1 end
        if ComponentGetValue2(comp, "mButtonDownLeft") then xv = xv - 1 end
        if ComponentGetValue2(comp, "mButtonDownDown") then yv = yv + 1 end
        if ComponentGetValue2(comp, "mButtonDownUp") then yv = yv - 1 end
        PhysicsApplyForce(me, xv * 30, yv * 60)
    end
end