function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
	
	local new_damage = damage

	local player = EntityGetParent(GetUpdatedEntityID())

	local damagemodel = EntityGetFirstComponent( player, "DamageModelComponent" )
	if( damagemodel ~= nil ) then
		local hp = tonumber( ComponentGetValue2( damagemodel, "hp" ) )
        local max_hp = tonumber( ComponentGetValue2( damagemodel, "max_hp"))
		new_damage = new_damage * (1 + (hp / max_hp) * -0.5)
	end

	return new_damage, crit_chance
end