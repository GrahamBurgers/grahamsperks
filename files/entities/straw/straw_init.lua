local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent") or 0
local straws = 11
SetRandomSeed(GameGetFrameNum(), comp)
ComponentSetValue2(comp, "image_file", "mods/grahamsperks/files/entities/straw/straw_" .. Random(1, straws) .. ".png")
EntitySetComponentIsEnabled(GetUpdatedEntityID(), comp, true)