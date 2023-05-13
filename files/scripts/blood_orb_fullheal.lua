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
            EntityRemoveComponent(eyes[i], temp)

            local image_file = "mods/grahamsperks/files/entities/eye/eye1.png"
			if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
				image_file = "mods/grahamsperks/files/entities/eye/eye1_robotic.png"
			end
            EntityAddComponent2(eyes[i], "SpriteComponent", {
                image_file=image_file,
                offset_x=8,
                offset_y=8,
                z_index=-2,
            })
        end

        local hitbox = EntityGetFirstComponentIncludingDisabled(eyes[i], "HitboxComponent")
        EntitySetComponentIsEnabled(eyes[i], hitbox, true)
        local particles = EntityGetFirstComponentIncludingDisabled(eyes[i], "ParticleEmitterComponent")
        EntitySetComponentIsEnabled(eyes[i], particles, true)
        local damagecomp = EntityGetFirstComponentIncludingDisabled(eyes[i], "DamageModelComponent")
        EntitySetComponentIsEnabled(eyes[i], damagecomp, true)
        local genome = EntityGetFirstComponentIncludingDisabled(eyes[i], "GenomeDataComponent")
        EntitySetComponentIsEnabled(eyes[i], genome, true)
    end

    item_pickup_old( entity_item, entity_who_picked, name )
end