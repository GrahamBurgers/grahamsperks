
function shot(projectile)
    local me = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "minitank_hp")
    local sprite = EntityGetFirstComponentIncludingDisabled(me, "SpriteComponent", "timed_health_slider")
    local proj = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
    if (not sprite) or (not comp) or (not proj) then return end

    local value = ComponentGetValue2(comp, "value_float") - (ComponentGetValue2(proj, "damage") * 4) + 0.03
    local max = ComponentGetValue2(comp, "value_int")
    ComponentSetValue2(comp, "value_float", value)
    if value < 0 then
        EntityKill(me)
    else
        -- timeout bar functionality
        -- technically this should work with any entities with a lifetimecomponent and a tagged spritecomponent
        ComponentSetValue2(sprite, "special_scale_x", value / max)
    end
end