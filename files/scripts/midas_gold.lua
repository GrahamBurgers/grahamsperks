function obliterate(enemy)
    local sprites = EntityGetComponent(enemy, "SpriteComponent") or 0
    if type(sprites) ~= "number" then
        if #sprites > 1 then
            for j = 1, #sprites do
                if j > 1 then
                    EntityRemoveComponent(enemy, sprites[j])
                    GamePrint("removed sprite")
                end
            end
        end
    end

    EntityConvertToMaterial(enemy, "templebrick_golden_static")
    EntityKill(enemy)
    local x, y = EntityGetTransform(enemy)
    local chest = EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
    EntityRemoveComponent(chest, EntityGetFirstComponentIncludingDisabled(chest, "AudioComponent") or 0)
end