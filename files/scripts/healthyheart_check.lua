local me = GetUpdatedEntityID()
local sprite = EntityGetFirstComponent(me, "SpriteComponent")
if sprite then
    local current = ComponentGetValue2(sprite, "image_file")
    if current == "data/items_gfx/heart_extrahp.xml" or current == "mods/grahamsperks/files/pickups/heart_healthy_anim.xml" then
        local has = GameHasFlagRun("PERK_PICKED_GRAHAM_HEALTHY_HEARTS")
        local new = (has and "mods/grahamsperks/files/pickups/heart_healthy_anim.xml")
        or "data/items_gfx/heart_extrahp.xml"
        if new ~= current then
            ComponentSetValue2(sprite, "image_file", new)
            EntityRefreshSprite(me, sprite)
            local ui = EntityGetFirstComponent(me, "UIInfoComponent")
            if ui then
                ComponentSetValue2(ui, "name", (has and "$graham_healthyheart_name") or "$item_heart")
            end
            local item = EntityGetFirstComponent(me, "ItemComponent")
            if item then
                ComponentSetValue2(item, "item_name", (has and "$graham_healthyheart_name") or "$item_heart")
            end
        end
    end
end