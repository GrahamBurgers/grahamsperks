function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
    if entity_thats_responsible == EntityGetRootEntity(GetUpdatedEntityID()) and damage > 0 then damage = 0 end
    return damage, critical_hit_chance
end