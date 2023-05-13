function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
	
	local new_damage = damage

	local player = EntityGetParent(GetUpdatedEntityID())

	local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,v in ipairs(damagemodels) do
			local hp = tonumber( ComponentGetValue2( v, "hp" ) )
            local max_hp = tonumber( ComponentGetValue2( v, "max_hp"))
			new_damage = new_damage * ( 0.5 * (max_hp / hp) )
			break
		end
	else
	end


	return new_damage, crit_chance
end