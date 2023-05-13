dofile_once("data/scripts/lib/utilities.lua")

function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )

local new_damage = damage
local player = GetUpdatedEntityID() 

if player ~= ent_thats_responsible and EntityGetName(ent_thats_responsible) ~= "lap2_chaser" then

	local x, y = EntityGetTransform(player)
	local x2, y2 = EntityGetTransform(ent_thats_responsible)

	local frame = tostring(GameGetFrameNum())
	local var_comp = get_variable_storage_component(player, "zap_tap_last_frame_executed")
	local lastframe = ComponentGetValue2(var_comp, "value_string")
	if lastframe == nil then lastframe = 0 end
	--[[
	GamePrint(frame)
	GamePrint(lastframe)
	GamePrint(tostring(frame ~= lastframe))

	okay, so this lastframe thing is definitively working, but it still crashes the game.
	i'm out of ideas for what to do with this
	]]--

	if frame ~= lastframe then
		if x ~= nil and y ~= nil and x2 ~= nil and y2 ~= nil then
			-- thanks to Evaisa for helping me debug this
			local dir_x = x - x2
			local dir_y = y - y2
			local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)
			
			var_comp = get_variable_storage_component(player, "zap_tap_radius")
			radius = ComponentGetValue2(var_comp, "value_int")

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
			end
		end

		if var_comp ~= nil then
			ComponentSetValue2(var_comp, "value_string", frame)	
		else
			EntityAddComponent2(player, "VariableStorageComponent", {
				value_string=frame,
				name="zap_tap_last_frame_executed"
			})
		end
	end

end

    return new_damage, crit_chance
end