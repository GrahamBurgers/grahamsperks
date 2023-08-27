function obliterate(enemy)
    if EntityHasTag(enemy, "miniboss") or EntityHasTag(enemy, "boss") or EntityHasTag(enemy, "graham_minitank") then return end
    local sprites = EntityGetComponent(enemy, "SpriteComponent") or 0
    if type(sprites) ~= "number" then
        if #sprites > 1 then
            for j = 1, #sprites do
                if j > 1 then
                    EntityRemoveComponent(enemy, sprites[j])
                end
            end
        end
    end

    EntityConvertToMaterial(enemy, "templebrick_golden_static")
    EntityKill(enemy)
end