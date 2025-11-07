local me = GetUpdatedEntityID()
local varsto = EntityGetFirstComponent(me, "VariableStorageComponent", "player_riding_id") or 0
local player_riding = ComponentGetValue2(varsto, "value_int") or 0
-- UNSTUCK!
local x, y = EntityGetTransform(me)
local TRY_UNSTUCK_COUNT = 100
Unstuck_size = Unstuck_size or 0
for i = 1, TRY_UNSTUCK_COUNT do
    if RaytracePlatforms(x - 2, y - 2, x + 2, y + 2) then
        Unstuck_size = Unstuck_size + 0.2
        SetRandomSeed(Unstuck_size + GameGetFrameNum() + x, y + GameGetFrameNum() + 34029340 + i)
        local theta = math.rad(Random( 1,360 ))
        local yes
        Unstuck_x = math.cos( theta ) * Unstuck_size
        Unstuck_y = math.sin( theta ) * Unstuck_size
        yes = RaytracePlatforms(x - Unstuck_x, y - Unstuck_y, x - Unstuck_x, y - Unstuck_y)
        local hit, hx, hy = RaytracePlatforms(x, y, x + Unstuck_x, y + Unstuck_y)
        if hit and not yes then
            x = hx - Unstuck_x
            y = hy - Unstuck_y
            EntitySetTransform(me, x, y)
            EntityApplyTransform(me, x, y)
            EntityApplyTransform(player_riding, x, y - 4)
        end
    else
        Unstuck_size = 0
        break
    end
end

if player_riding ~= 0 then
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
        if Unstuck_x or Unstuck_y then
            xv = (Unstuck_x or 0) * -2
            yv = (Unstuck_y or 0) * -1
            Unstuck_x = nil
            Unstuck_y = nil
        else
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
        end
        PhysicsApplyForce(me, xv * 30, yv * 60)
    end
end