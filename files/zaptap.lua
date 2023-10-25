dofile_once("data/scripts/lib/utilities.lua")

function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )

local new_damage = damage
local player = GetUpdatedEntityID()
-- thank you dextercd for helping with this. jank scripts be jank
local my = GetUpdatedComponentID()

if player ~= ent_thats_responsible and EntityGetName(ent_thats_responsible) ~= "lap2_chaser" then

local x, y = EntityGetTransform(player)
local x2, y2 = EntityGetTransform(ent_thats_responsible)
	if x ~= nil and y ~= nil and x2 ~= nil and y2 ~= nil then
		-- thanks to Evaisa for helping me debug this
		local dir_x = x - x2
		local dir_y = y - y2
		local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
		
		local var_comp = get_variable_storage_component(player, "zap_tap_radius")
		local radius = ComponentGetValue2(var_comp, "value_int")

		if distance < radius then
			new_damage = 0
			local dmg = 1
			if GameHasFlagRun("PERK_PICKED_ELECTRICITY") then dmg = dmg * 2 end
			if GameHasFlagRun("PERK_PICKED_GLASS_CANNON") then dmg = dmg * 5 end

			if GameHasFlagRun("PERK_PICKED_TRICK_BLOOD_MONEY") or GameHasFlagRun("PERK_PICKED_EXTRA_MONEY_TRICK_KILL") then
				EntityInflictDamage( ent_thats_responsible, dmg, "DAMAGE_ELECTRICITY", "Zap Tap", "DISINTEGRATED", 0, 0)
			else
				EntityInflictDamage( ent_thats_responsible, dmg, "DAMAGE_ELECTRICITY", "Zap Tap", "DISINTEGRATED", 0, 0, player)
			end

			EntityInflictDamage( player, damage / 4, "DAMAGE_ELECTRICITY", "Zap Tap", "DISINTEGRATED", 0, 0, player)

			-- cooldown
			if ComponentGetValue2(my, "script_damage_about_to_be_received") ~= "nil" then
				ComponentSetValue2(my, "script_damage_about_to_be_received", "nil")
				ComponentAddTag(my, "readd_zaptap")
				EntityAddComponent2(player, "LuaComponent", {
					script_source_file="mods/grahamsperks/files/scripts/readd_zaptap.lua",
					execute_every_n_frame=2,
					execute_on_added=false,
					remove_after_executed=true
				})
			end
		end
	end
end

    return new_damage, crit_chance
end