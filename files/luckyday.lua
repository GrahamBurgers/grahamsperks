dofile_once("data/scripts/lib/utilities.lua")

function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )

	local player = GetUpdatedEntityID()
	local my = GetUpdatedComponentID()
	local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
	local health = 0
	if( damagemodels ~= nil ) then
		for i,v in ipairs(damagemodels) do
			health = ComponentGetValue2( v, "hp" )
			break
		end
	end

    local new_damage = damage
	SetRandomSeed( GameGetFrameNum(), ent_thats_responsible )

	-- to make the math easier
	health = health * 25
	damage = damage * 25

	local difference = (damage * 0.5) / health
	local cutoff = math.max(1, (100 * math.min(0.75, difference)))
	if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then cutoff = cutoff + 10 end

	local rand = Random(1,100)

	if cutoff >= rand and damage >= 2 then
		new_damage = 0

		EntityLoad( "mods/grahamsperks/files/entities/lucky.xml", x, y )
		if EntityHasTag(player, "player_unit") then
            local enum = ModSettingGet("grahamsperks.LuckyDay")
			if enum == 1 then
				GamePrint(GameTextGetTranslatedOrNot("$graham_lucky") .. " (" .. tostring(math.ceil(cutoff)) .. "%)")
            elseif enum == 2 then
				GamePrint("$graham_lucky")
			end
		end

		-- cooldown
		if ComponentGetValue2(my, "script_damage_about_to_be_received") ~= "nil" then
			ComponentSetValue2(my, "script_damage_about_to_be_received", "nil")
			ComponentAddTag(my, "readd_luckyday")
			EntityAddComponent2(player, "LuaComponent", {
				script_source_file="mods/grahamsperks/files/scripts/readd_luckyday.lua",
				execute_every_n_frame=8,
				execute_on_added=false,
				remove_after_executed=true
			})
		end
	end

    return new_damage, crit_chance
end