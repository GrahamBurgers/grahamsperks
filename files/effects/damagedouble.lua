function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
    if damage > 0 then
        damage = damage * 0.25
    end
    return damage, crit_chance
end