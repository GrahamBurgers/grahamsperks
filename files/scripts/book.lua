local me = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(me)
SetRandomSeed(me + x + 1340, y + GameGetFrameNum() + 193408)
-- tell no one about this
if Random(1, 10000) == 10000 then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/bookbook.xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end
if Random(1, 1000) == 1000 and (ModTextFileGetContent( "mods/grahamsperks/files/entities/books/corrupt/.csv" ) or "") ~= "" then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/corrupt/0" .. Random(1,8) .. ".xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end