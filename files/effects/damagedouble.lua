function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
    local new_damage = damage * 0.25
    return new_damage, crit_chance
end