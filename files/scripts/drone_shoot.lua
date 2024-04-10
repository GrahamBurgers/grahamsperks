function shot( projectile_entity_id )
    local me = GetUpdatedEntityID()
    local name = EntityGetName(me)
    local damages = {
        ["$graham_supportdrone"] = 1,
        ["$graham_attackdrone"] = 1.5,
        ["$graham_shielddrone"] = 3,
    }
    local dmg = damages[name]
    EntityInflictDamage(me, dmg / 25, "DAMAGE_CURSE", "$damage_curse", "NONE", 0, 0, me)
end