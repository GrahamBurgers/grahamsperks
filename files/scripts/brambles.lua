local x, y = EntityGetTransform(GetUpdatedEntityID())
local entities = EntityGetInRadiusWithTag(x, y, 12, "enemy")
for i = 1, #entities do
    if not EntityHasTag(entities[i], "glue_NOT") then
        EntityInflictDamage(entities[i], 0.003,  "DAMAGE_SLICE", "$graham_name_bramball", "DISINTEGRATED", 0, 0)
        EntityApplyTransform(entities[i], x, y)
    end
end