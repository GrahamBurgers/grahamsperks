function obliterate(enemy)
    local sprites = EntityGetComponent(enemy, "SpriteComponent") or 0
    if sprites > 1 then
        for j = 1, #sprites do
            if j > 1 then
                EntityRemoveComponent(enemy, sprites[j])
                GamePrint("removed sprite")
            end
        end
    end

    EntityConvertToMaterial(enemy, "templebrick_golden_static")
    EntityKill(enemy)
    local x, y = EntityGetTransform(enemy)
    local chest = EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
    EntityRemoveComponent(chest, EntityGetFirstComponentIncludingDisabled(chest, "AudioComponent") or 0)

    local children = EntityGetAllChildren(enemy) or 0
    for i = 1, #children do
        EntityRemoveFromParent(children[i])
        EntityKill(children[i])
    end
end