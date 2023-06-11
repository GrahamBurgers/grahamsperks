local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
EntityLoad("mods/grahamsperks/files/entities/statue_image.xml", x + 20, y - 10)

if GameGetFrameNum() % 20 == 0 then
    dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")
end