local comps = EntityGetComponent(GetUpdatedEntityID(), "SpriteComponent") or {}
for i = 1, #comps do
    EntityRefreshSprite(GetUpdatedEntityID(), comps[i])
end