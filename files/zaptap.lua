dofile_once("data/scripts/lib/utilities.lua")

function damage_about_to_be_received( damage, x, y, ent_thats_responsible, critical_hit_chance)
	local player = GetUpdatedEntityID()
	-- thank you dextercd for helping with this. jank scripts be jank
	-- edit: the part that dexter helped with has since been removed, but I still am grateful for the effort

	if player ~= ent_thats_responsible and not EntityHasTag(ent_thats_responsible, "lap2_chaser") and damage > 0 then
		-- is entity a projectile?
		local proj = EntityGetFirstComponent(ent_thats_responsible, "ProjectileComponent")
		if proj then
			local whoshot = ComponentGetValue2(proj, "mWhoShot")
			if whoshot == ent_thats_responsible then -- panic?
				return damage, critical_hit_chance
			end
			if whoshot ~= nil and whoshot ~= 0 then ent_thats_responsible = whoshot end
		end
		local x2, y2 = EntityGetTransform(ent_thats_responsible)
		if x ~= nil and y ~= nil and x2 ~= nil and y2 ~= nil then
			-- thanks to Evaisa for helping me debug this
			local dir_x = x - x2
			local dir_y = y - y2
			local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)

			local var_comp = get_variable_storage_component(player, "zap_tap_radius") or 0
			local radius = ComponentGetValue2(var_comp, "value_int") or 18
			local frame = ComponentGetValue2(var_comp, "value_float")

			if distance < radius and frame < GameGetFrameNum() then
				ComponentSetValue2(var_comp, "value_float", GameGetFrameNum() + 30)
				local dmg = 1
				damage = 0
				if GameHasFlagRun("PERK_PICKED_ELECTRICITY") then dmg = dmg * 2 end
				if GameHasFlagRun("PERK_PICKED_GLASS_CANNON") then dmg = dmg * 5 end

				if GameHasFlagRun("PERK_PICKED_TRICK_BLOOD_MONEY") or GameHasFlagRun("PERK_PICKED_EXTRA_MONEY_TRICK_KILL") then
					EntityInflictDamage( ent_thats_responsible, dmg, "DAMAGE_ELECTRICITY", "$perkname_graham_zaptap", "DISINTEGRATED", 0, 0)
				else
					EntityInflictDamage( ent_thats_responsible, dmg, "DAMAGE_ELECTRICITY", "$perkname_graham_zaptap", "DISINTEGRATED", 0, 0, player)
				end

				if GameGetGameEffectCount(player, "STUN_PROTECTION_ELECTRICITY") + GameGetGameEffectCount(player, "PROTECTION_ELECTRICITY") <= 0 then
					local effect_id, entity_id = GetGameEffectLoadTo(player, "ELECTROCUTION", false)
					ComponentSetValue2(effect_id, "frames", 20)
				end
			end
		end
	end
	return damage, critical_hit_chance
end