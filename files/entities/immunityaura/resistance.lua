function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
    if damage > 0 then
        return math.max(0, damage - 0.4), crit_chance
    else
        return damage, crit_chance
    end
end