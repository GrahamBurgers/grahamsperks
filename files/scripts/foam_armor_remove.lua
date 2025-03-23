local owner = EntityGetRootEntity(GetUpdatedEntityID())
local dmg = EntityGetFirstComponent(owner, "DamageModelComponent")
if not dmg then return end
local vars = EntityGetComponent(GetUpdatedEntityID(), "VariableStorageComponent", "foam_armor_ouch") or {}
for i = 1, #vars do
    local damage = ComponentGetValue2(vars[i], "value_float")
    damage = math.min(damage, ComponentGetValue2(dmg, "hp") - 0.04)
    if damage > 0 then
        EntityInflictDamage(owner, damage, "DAMAGE_CURSE", "$graham_name_foamarmor", "NORMAL", 0, 0)
    end
end