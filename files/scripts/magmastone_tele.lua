function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
    if damage < 2 then return end
    local me = GetUpdatedEntityID()
    local dmg = EntityGetFirstComponent(me, "DamageModelComponent")
    local lua = EntityGetFirstComponent(me, "LuaComponent", "magmastone_tele")
    local proj = EntityGetFirstComponent(me, "ProjectileComponent")
    local who
    if proj then who = ComponentGetValue2(proj, "mWhoShot") or 0 end
    if dmg and who > 0 and not lua then
        EntityAddComponent2(me, "LuaComponent", {
            _tags="magmastone_tele,enabled_in_world,enabled_in_hand,enabled_in_inventory",
            script_source_file="mods/grahamsperks/files/scripts/magmastone_go.lua",
        })
        EntityAddComponent2(me, "SpriteComponent", {
            _tags="magmastone_tele,enabled_in_world,enabled_in_hand,enabled_in_inventory",
            image_file="mods/grahamsperks/files/pickups/magmastone_glow.png",
            has_special_scale=true,
            emissive=true,
            offset_x=16,
            offset_y=16,
            alpha=0.5,
        })
        local x2, y2 = EntityGetTransform(who)
        GamePlaySound( "data/audio/Desktop/animals.bank", "animals/mine/beep", x2, y2)
    end
end