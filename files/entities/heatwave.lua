local me = GetUpdatedEntityID()
local freezefield = GameHasFlagRun("PERK_PICKED_FREEZE_FIELD")
local converts = EntityGetComponent(me, "MagicConvertMaterialComponent") or {}
for i = 1, #converts do
    ComponentSetValue2(converts[i], "min_radius", freezefield and 30 or 0)
end