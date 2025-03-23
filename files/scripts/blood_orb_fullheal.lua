local item_pickup_old = item_pickup

function item_pickup( entity_item, entity_who_picked, name )
    local eyes = EntityGetWithTag("graham_bloodorb")
    local dmg, temp, particles
    for i = 1, #eyes do
        dmg = EntityGetFirstComponentIncludingDisabled(eyes[i], "DamageModelComponent")
        if dmg ~= nil then
            temp = ComponentGetValue2(dmg, "max_hp")
            -- Buff max hp by 10% (cap at 5000)
            temp = temp * 1.1
            if temp > 200 then temp = 200 end
            ComponentSetValue2(dmg, "max_hp", temp)
            
            if ComponentGetValue2(dmg, "hp") < temp then
                particles = EntityLoad("data/entities/particles/heal_effect.xml")
                EntityAddChild(eyes[i], particles)
            end
            ComponentSetValue2(dmg, "hp", temp)
        end

        temp = EntityGetFirstComponentIncludingDisabled(eyes[i], "SpriteComponent")
        if temp ~= nil then
            local image_file = "mods/grahamsperks/files/entities/eye/eye1.png"
			if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
				image_file = "mods/grahamsperks/files/entities/eye/eye1_robotic.png"
			end
            ComponentSetValue2(temp, "image_file", image_file)
            EntityRefreshSprite(eyes[i], temp)
        end

        EntitySetComponentIsEnabled(eyes[i], EntityGetFirstComponentIncludingDisabled(eyes[i], "HitboxComponent") or 0, true)
        EntitySetComponentIsEnabled(eyes[i], EntityGetFirstComponentIncludingDisabled(eyes[i], "ParticleEmitterComponent") or 0, true)
        EntitySetComponentIsEnabled(eyes[i], EntityGetFirstComponentIncludingDisabled(eyes[i], "DamageModelComponent") or 0, true)
        EntitySetComponentIsEnabled(eyes[i], EntityGetFirstComponentIncludingDisabled(eyes[i], "GenomeDataComponent") or 0, true)
    end

    local robots = GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0" )
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    local options = {"tank.xml", "tank_rocket.xml", "tank_super.xml", "toasterbot.xml"}
    for i = 1, robots do
        SetRandomSeed(entity_item + x, y + i)
        EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x, y)
    end

    -- remove the foams hurt
    local children = EntityGetAllChildren(entity_who_picked, "foam_armor") or {}
    for i = 1, #children do
        local var = EntityGetComponent(children[i], "VariableStorageComponent", "foam_armor_ouch") or {}
        local ui = EntityGetFirstComponent(children[i], "UIIconComponent")
        for j = 1, #var do
            ComponentSetValue2(var[j], "value_float", 0)
            if ui then ComponentSetValue2(ui, "description", GameTextGet("$graham_statusdesc_foam")) end
        end
    end

    item_pickup_old( entity_item, entity_who_picked, name )
end