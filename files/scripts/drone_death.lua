local me = GetUpdatedEntityID()
local hpcomp = EntityGetFirstComponent(me, "DamageModelComponent")
if hpcomp ~= nil then
    local hp = ComponentGetValue2(hpcomp, "hp")
    if hp <= 0 then
        local homingcomp = EntityGetFirstComponent(me, "HomingComponent") or 0
        if ComponentGetValue2(homingcomp, "target_tag") == "player_unit" then
            ComponentSetValue2(homingcomp, "target_tag", "enemy")
            ComponentSetValue2(homingcomp, "homing_targeting_coeff", 130)
            ComponentSetValue2(homingcomp, "homing_velocity_multiplier", 0.6)
            ComponentSetValue2(homingcomp, "detect_distance", 50)
            ComponentSetValue2(homingcomp, "target_who_shot", false)
            local comps = EntityGetAllComponents(me) or {}
            for i = 1, #comps do
                if ComponentHasTag(comps[i], "disable_on_death") then
                    EntityRemoveComponent(me, comps[i])
                end
            end
            local physicsai = EntityGetFirstComponent(me, "PhysicsAIComponent") or 0
            ComponentSetValue2(physicsai, "force_coeff", 1)
            ComponentSetValue2(physicsai, "force_max", 1)
        else
            local x, y = EntityGetTransform(me)
            if #EntityGetInRadiusWithTag(x, y, 8, "enemy") > 0 then
                ComponentSetValue2(hpcomp, "kill_now", true)
            end
        end
    end
end