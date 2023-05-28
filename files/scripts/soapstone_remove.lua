local player = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponentIncludingDisabled(player, "SpriteStainsComponent") or 0
if comp ~= 0 then
    EntitySetComponentIsEnabled(player, comp, true)
end