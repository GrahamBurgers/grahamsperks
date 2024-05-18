local setting = ModSettingGet("grahamsperks.Breadcrumbs") or false
local sprite = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent")
if sprite == nil then return end
if setting ~= true then
    EntitySetComponentIsEnabled(GetUpdatedEntityID(), sprite, true)
else
    EntitySetComponentIsEnabled(GetUpdatedEntityID(), sprite, false)
end