local me = GetUpdatedEntityID()
local varsto = EntityGetFirstComponent(me, "VariableStorageComponent", "player_riding_id") or 0
local player_riding = ComponentGetValue2(varsto, "value_int") or 0
if player_riding ~= 0 then
    local x, y = EntityGetTransform(me)
    if EntityHasTag(player_riding, "player_unit") == false then
        -- panic
        local substitute = EntityGetClosestWithTag(x, y, "player_unit")
        local x2, y2 = EntityGetTransform(substitute)
        local kick = EntityGetFirstComponentIncludingDisabled(substitute, "KickComponent") or 0
        local comp = EntityGetFirstComponent(me, "InteractableComponent") or 0
        ComponentSetValue2(comp, "name", "graham_lukki_mount")
        ComponentSetValue2(comp, "ui_text", "$graham_lukki_mount")
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_mount", false)
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_dismount", true)
        ComponentSetValue2(varsto, "value_int", 0)
        if kick ~= 0 then
            ComponentSetValue2(kick, "player_kickforce", 28)
        end
        EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(me, x2, y2)
        return
    end
    local x2, y2 = EntityGetTransform(player_riding)
    local distance = math.sqrt((x2 - x)^2 + (y2 - y)^2)
    if distance < 50 then
        EntityApplyTransform(player_riding, x, y - 4)
        local chomp = EntityGetFirstComponent(player_riding, "CharacterDataComponent")
        if chomp ~= nil then
            ComponentSetValue2(chomp, "is_on_ground", true)
            ComponentSetValue2(chomp, "mFlyingTimeLeft", ComponentGetValue2(chomp, "mFlyingTimeLeft") + 3)
        end
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
        yv = yv - 0.30159 --stop falling
        local anim = EntityGetFirstComponent(me, "IKLimbsAnimatorComponent")
        if anim then
            local stand = ComponentGetValue2(anim, "mHasGroundAttachmentOnAnyLeg")
            if not stand then
                yv = yv + 1
            else
                if ComponentGetValue2(comp, "mButtonDownDown") then yv = yv + 1.2 end
                if ComponentGetValue2(comp, "mButtonDownUp") then yv = yv - 1.2 end
            end
        end
        if ComponentGetValue2(comp, "mButtonDownRight") then xv = xv + 1 end
        if ComponentGetValue2(comp, "mButtonDownLeft") then xv = xv - 1 end
        PhysicsApplyForce(me, xv * 30, yv * 60)
    end
end