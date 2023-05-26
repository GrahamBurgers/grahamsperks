local x, y = EntityGetTransform(GetUpdatedEntityID())
local entities = EntityGetInRadiusWithTag(x, y, 115, "mortal")
local x2, y2, eid
for i = 1, #entities do
    x2, y2 = EntityGetTransform(entities[i])
    if (math.abs( x - x2 ) + math.abs( y - y2 )) > 95 then
        LoadGameEffectEntityTo(entities[i], "mods/grahamsperks/files/effects/movement_slower_head.xml")
    end
end