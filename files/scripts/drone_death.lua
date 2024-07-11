local me = GetUpdatedEntityID()
local hpcomp = EntityGetFirstComponent(me, "DamageModelComponent")
if hpcomp ~= nil then
    local hp = ComponentGetValue2(hpcomp, "hp")
    local item = EntityGetFirstComponent(me, "ItemComponent")
    if item then
        ComponentSetValue2(item, "uses_remaining", math.floor((hp * 25) + 0.5))
    end
    if hp <= 0 then
        local homingcomp = EntityGetFirstComponent(me, "HomingComponent") or 0
        if ComponentGetValue2(homingcomp, "target_tag") == "player_unit" then
            ComponentSetValue2(homingcomp, "target_tag", "enemy")
            ComponentSetValue2(homingcomp, "homing_targeting_coeff", 130)
            ComponentSetValue2(homingcomp, "homing_velocity_multiplier", 0.6)
            ComponentSetValue2(homingcomp, "detect_distance", 70)
            ComponentSetValue2(homingcomp, "target_who_shot", false)
            local comps = EntityGetAllComponents(me) or {}
            for i = 1, #comps do
                if ComponentHasTag(comps[i], "disable_on_death") then
                    EntityRemoveComponent(me, comps[i])
                elseif ComponentHasTag(comps[i], "lurker_data") then
                    ComponentAddTag( comps[i], "enabled_in_world")
                    ComponentAddTag( comps[i], "enabled_in_hand")
                end
            end
            EntitySetComponentsWithTagEnabled(me, "lurker_data", true)
            local physicsai = EntityGetFirstComponent(me, "PhysicsAIComponent") or 0
            ComponentSetValue2(physicsai, "force_coeff", 1)
            ComponentSetValue2(physicsai, "force_max", 1)
            local ai = EntityGetFirstComponent(me, "AnimalAIComponent")
            if ai then
                ComponentSetValue2(ai, "attack_ranged_enabled", false)
            end
        else
            local x, y = EntityGetTransform(me)
            if #EntityGetInRadiusWithTag(x, y, 8, "enemy") > 0 then
                ComponentSetValue2(hpcomp, "kill_now", true)
                local proj = EntityGetFirstComponent(me, "ProjectileComponent")
                if proj then ComponentSetValue2(proj, "on_death_explode", true) end
                local name = EntityGetName(me)
                if name == "$graham_attackdrone" then
                    EntityLoad("mods/grahamsperks/files/spells/wood.xml", x, y)
                elseif name == "$graham_supportdrone" then
                    EntityLoad("mods/grahamsperks/files/spells/circle_sweet.xml", x, y)
                elseif name == "$graham_shielddrone" then
                    EntityLoad("data/entities/projectiles/deck/shield_field.xml", x, y)
                end
            end
        end
    end
end

-- 4/10/2024: idle effects
-- 7/10/2024: what did I mean by this?