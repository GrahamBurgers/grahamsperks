function shot(projectile)
    local comps = EntityGetComponent(projectile, "ProjectileComponent")
    local health = EntityGetFirstComponent(GetUpdatedEntityID(), "DamageModelComponent")
    if health == nil then return end
    local hp = ComponentGetValue2(health, "hp")
    local max_hp = ComponentGetValue2(health, "max_hp")

    GamePrint(tostring(hp/max_hp))
    GamePrint(tostring(tonumber(GlobalsGetValue( "GRAHAM_ALLIANCE_COUNT", "20" )) / 100))

    if (comps ~= nil) and hp/max_hp < (tonumber(GlobalsGetValue( "GRAHAM_ALLIANCE_COUNT", "20" )) / 100) then
        for k, v in ipairs(comps) do
            ComponentSetValue2(v, "damage_game_effect_entities", ComponentGetValue2(v, "damage_game_effect_entities") .. "mods/grahamsperks/files/entities/effect_apply_charm.xml,")
        end
    end
end