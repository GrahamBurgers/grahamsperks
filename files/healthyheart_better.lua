local grahamburger_func = item_pickup

function item_pickup( entity_item, entity_who_picked, name )

    local damagemodel = EntityGetFirstComponent( entity_who_picked, "DamageModelComponent" ) or 0
    local multiplier = tonumber( GlobalsGetValue( "HEARTS_MORE_EXTRA_HP_MULTIPLIER", "1" ) ) 
    local second_mult = GlobalsGetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", "1" )
    -- to scale with stronger hearts perk
    
    local hp = ComponentGetValue2( damagemodel, "hp" ) --current_hp with no changes
    if GameHasFlagRun( "PERK_PICKED_GRAHAM_HEALTHY_HEARTS" ) then
        hp = hp + 2 * multiplier * second_mult
        --Gets the current hp, and adds 25. (all hp and damage is later multiplied by 25) 
    end
    grahamburger_func( entity_item, entity_who_picked, name ) --Call old function so max_hp is applied
    ComponentSetValue2( damagemodel, "hp", hp ) --Set hp

    local robots = GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0" )
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    local options = {"tank.xml", "tank_rocket.xml", "tank_super.xml", "toasterbot.xml"}
    for i = 1, robots do
        SetRandomSeed(entity_item + x, y + i)
        EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x, y)
    end

    -- fully heal the most damaged wandering eye
    local eyes = EntityGetWithTag("graham_bloodorb") or {}
    if #eyes < 1 then return end
    local lowest = math.huge
    local eid, dmg = nil, nil
    local ehp = 0
    for i = 1, #eyes do
        dmg = EntityGetFirstComponentIncludingDisabled(eyes[i], "DamageModelComponent")
        if dmg ~= nil then
            ehp = ComponentGetValue2(dmg, "hp")
            if ehp < lowest then
                lowest = ehp
                eid = eyes[i]
            end
        end
    end

    if eid ~= nil and dmg ~= nil then
        dmg = EntityGetFirstComponentIncludingDisabled(eid, "DamageModelComponent") or 0
        ehp = ComponentGetValue2(dmg, "hp")
        local maxhp = ComponentGetValue2(dmg, "max_hp")
        if ehp < maxhp then
            ComponentSetValue2(dmg, "hp", maxhp)
            local particles = EntityLoad("data/entities/particles/heal_effect.xml")
            EntityAddChild(eid, particles)

            local temp = EntityGetFirstComponentIncludingDisabled(eid, "SpriteComponent")
            if temp ~= nil then
                EntityRemoveComponent(eid, temp)
    
                local image_file = "mods/grahamsperks/files/entities/eye/eye1.png"
                if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
                    image_file = "mods/grahamsperks/files/entities/eye/eye1_robotic.png"
                end
                EntityAddComponent2(eid, "SpriteComponent", {
                    image_file=image_file,
                    offset_x=8,
                    offset_y=8,
                    z_index=-2,
                })
            end
    
            EntitySetComponentIsEnabled(eid, EntityGetFirstComponentIncludingDisabled(eid, "HitboxComponent") or 0, true)
            EntitySetComponentIsEnabled(eid, EntityGetFirstComponentIncludingDisabled(eid, "ParticleEmitterComponent") or 0, true)
            EntitySetComponentIsEnabled(eid, EntityGetFirstComponentIncludingDisabled(eid, "DamageModelComponent") or 0, true)
            EntitySetComponentIsEnabled(eid, EntityGetFirstComponentIncludingDisabled(eid, "GenomeDataComponent") or 0, true)
        end
    end
end