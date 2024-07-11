function shot( projectile_entity_id )
    local me = GetUpdatedEntityID()
    local proj1 = EntityGetFirstComponent(me, "ProjectileComponent")
    local projdamage = 0
    if proj1 then
        projdamage = ComponentGetValue2(proj1, "damage")
    end
    local proj2 = EntityGetFirstComponent(projectile_entity_id, "ProjectileComponent")
    if proj2 then
        ComponentSetValue2(proj2, "damage", ComponentGetValue2(proj2, "damage") + projdamage / 2)
        ComponentSetValue2(proj2, "go_through_this_material", "graham_aluminium") -- does this work?
    else
        projdamage = 0
    end
    EntityInflictDamage(me, 0.04 + (projdamage / 2), "DAMAGE_CURSE", "$damage_curse", "NONE", 0, 0, me)
end