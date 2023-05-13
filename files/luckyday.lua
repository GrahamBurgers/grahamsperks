function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )

	local player = GetUpdatedEntityID() 
	
	local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
	local health = 0
	if( damagemodels ~= nil ) then
		for i,v in ipairs(damagemodels) do
			health = tonumber( ComponentGetValue2( v, "hp" ) )
			break
		end
	end
	
    local new_damage = damage
	SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
	
	-- to make the math easier
	health = health * 25
	damage = damage * 25

if damage < 2 then return new_damage, crit_chance end
	local difference = (damage * 0.5) / health
	local cutoff = math.max(1, (100 * math.min(0.75, difference)))
	if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then cutoff = cutoff + 10 end

	local rand = Random(1,100)
	
	if cutoff >= rand then
		new_damage = 0
		
		EntityLoad( "mods/grahamsperks/files/entities/lucky.xml", x, y )
		if EntityHasTag(player, "player_unit") then
			if ModSettingGet("grahamsperks.luckyday") == "yes" then
				GamePrint(GameTextGetTranslatedOrNot("$graham_lucky") .. " (" .. tostring(math.ceil(cutoff)) .. "%)")
			elseif ModSettingGet("grahamsperks.luckyday") == "no" then
				GamePrint("$graham_lucky")
			end
		end
	end
    return new_damage, crit_chance
end