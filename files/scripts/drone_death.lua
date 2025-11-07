local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
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
-- 11/6/2025: WIP drone rework. Probably won't finish this
--[[
local projectiles = EntityGetInRadiusWithTag(x, y, 24, "projectile") or {}
local held = EntityGetComponent(me, "VariableStorageComponent", "held_bullets") or {}
for i = 1, #projectiles do
    local file = nil
    local projcomp = EntityGetFirstComponent(projectiles[i], "ProjectileComponent")
    local var = EntityGetComponent(projectiles[i], "VariableStorageComponent") or {}
    for j = 1, #var do
        if ComponentGetValue2(var[j], "name") == "projectile_file" then
            file = ComponentGetValue2(var[j], "value_string")
            break
        end
    end
    if file and projcomp and ComponentGetValue2(projcomp, "mWhoShot") ~= me then
        -- if we can eat a bullet, stash it and iterate all comps
        local comp = EntityAddComponent2(me, "VariableStorageComponent", {
            _tags="held_bullets",
            value_int=0,
            value_string=file
        })
        held[#held+1] = comp
        for j = 1, #held do
            ComponentSetValue2(held[j], "value_int", ComponentGetValue2(held[j], "value_int") + 1)
        end
        ComponentSetValue2(projcomp, "on_death_explode", false)
        ComponentSetValue2(projcomp, "on_lifetime_out_explode", false)
        EntityLoad("data/entities/particles/poof_yellow_tiny.xml", x, y)
    	EntityKill(projectiles[i])
    end
end

local enemy = EntityGetClosestWithTag(x, y, "enemy")
if enemy and enemy > 0 and #held > 0 then
    -- if we have bullets to spit, then shoot the oldest one first
    local x2, y2 = EntityGetTransform(enemy)
    local distance = math.sqrt((x2 - x)^2 + (y2 - y)^2)
    if distance <= 120 and not RaytracePlatforms(x, y, x2, y2) then
        local lowest = 99999
        local lowestcomp = nil
        for j = 1, #held do
            local current = ComponentGetValue2(held[j], "value_int")
            if current < lowest then
                lowest = current
                lowestcomp = held[j]
            end
        end
        if lowestcomp then
            dofile_once("data/scripts/lib/utilities.lua")
            local proj_file = ComponentGetValue2(lowestcomp, "value_string")
            local dir = math.atan((y2 - y) / (x2 - x))
            if x > x2 then dir = dir + math.pi end
            local vx, vy = math.cos(dir), math.sin(dir)

            local new = EntityLoad(proj_file, x, y )
            local projcomp = EntityGetFirstComponent(new, "ProjectileComponent")
            if projcomp then
                ComponentSetValue2(projcomp, "go_through_this_material", "graham_aluminium")
                -- respect the projectile speed for once
                SetRandomSeed(x + x2, y + y2)
                local speed = Random(ComponentGetValue2(projcomp, "speed_min"), ComponentGetValue2(projcomp, "speed_max"))
                GameShootProjectile(me, x, y, x + vx * speed, y + vy * speed, new, true)
            end

            EntityRemoveComponent(me, lowestcomp)
        end
    end
end
]]--