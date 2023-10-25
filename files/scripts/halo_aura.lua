local owner = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(owner)
local entities = EntityGetInRadiusWithTag(x, y, 115, "mortal")
local x2, y2, eid
for i = 1, #entities do
    if entities[i] ~= owner and EntityGetHerdRelation( owner, entities[i] ) <= 60 then
        x2, y2 = EntityGetTransform(entities[i])
        if math.sqrt((x2 - x)^2 + (y2 - y)^2) > 95 then
            LoadGameEffectEntityTo(entities[i], "mods/grahamsperks/files/effects/movement_slower_head.xml")
        end
    end
end