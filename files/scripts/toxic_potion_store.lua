local comps = EntityGetComponent(GetUpdatedEntityID(), "ProjectileComponent") or {}
if #comps < 1 then return end
local multiplier = 30
local size = 0
local damagetypes = {"projectile", "electricity", "explosion", "fire", "melee", "slice", "slice", "ice", "physics_hit", "radioactive", "poison", "overeating", "curse"}
for i = 1, #comps do
    for j = 1, #damagetypes do
        size = size + ComponentObjectGetValue2( comps[i], "damage_by_type", damagetypes[j] ) * multiplier
        ComponentObjectSetValue2( comps[i], "damage_by_type", damagetypes[j], 0 )
    end
    size = size + ComponentGetValue2(comps[i], "damage") * multiplier
    ComponentSetValue2(comps[i], "damage", 0)
    ComponentSetValue2(comps[i], "penetrate_world", false)
    ComponentSetValue2(comps[i], "penetrate_entities", false)
    ComponentSetValue2(comps[i], "collide_with_entities", true)
end

EntityAddComponent2(GetUpdatedEntityID(), "VariableStorageComponent", {
    _tags="graham_toxic_potion",
    name="graham_toxic_potion",
    value_int=size
})