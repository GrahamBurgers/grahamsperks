local me = GetUpdatedEntityID()
local healthcomp = EntityGetFirstComponentIncludingDisabled(me, "DamageModelComponent")
if healthcomp ~= nil then
    local hp = ComponentGetValue2(healthcomp, "hp")
    local max_hp = ComponentGetValue2(healthcomp, "max_hp")
    if hp < max_hp and hp > 0 then
        hp = hp + max_hp / 200

		if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
			-- Doubled regen + altered sprites
			hp = hp + max_hp / 200
		end
        if hp > max_hp then hp = max_hp end
        ComponentSetValue2(healthcomp, "hp", hp)

        -- SPRITE LOGIC
        local spritecomp = EntityGetFirstComponentIncludingDisabled(me, "SpriteComponent")
		if spritecomp ~= nil then
			local current_sprite = ComponentGetValue2(spritecomp, "image_file")
			local to_switch

			local hitbox = EntityGetFirstComponentIncludingDisabled(me, "HitboxComponent")
			local particles = EntityGetFirstComponentIncludingDisabled(me, "ParticleEmitterComponent")
			EntitySetComponentIsEnabled(me, hitbox, true)
			EntitySetComponentIsEnabled(me, particles, true)

			if hp > max_hp * 0.75 then
				to_switch = "eye1"
			elseif hp > max_hp * 0.50 then
				to_switch = "eye2"
			elseif hp > max_hp * 0.25 then
				to_switch = "eye3"
			elseif hp > 0 then
				to_switch = "eye4"
			else
				to_switch = "eye5"
				EntitySetComponentIsEnabled(me, hitbox, false)
				EntitySetComponentIsEnabled(me, particles, false)
			end

			if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
				to_switch = to_switch .. "_robotic"
			end

			if current_sprite ~= "mods/grahamsperks/files/entities/eye/" .. to_switch .. ".png" then
				-- Hack to make the sprite update faster; remove and readd the component
				-- I'm sure this will cause no problems whatsoever
				EntityRemoveComponent(me, spritecomp)
				EntityAddComponent2(me, "SpriteComponent", {
					image_file="mods/grahamsperks/files/entities/eye/" .. to_switch .. ".png",
					offset_x=8,
					offset_y=8,
					z_index=-2,
				})
			end
        end
    end
end