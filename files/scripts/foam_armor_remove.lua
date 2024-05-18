local owner = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponent(owner, "DamageModelComponent")
local var = EntityGetFirstComponent(GetUpdatedEntityID(), "VariableStorageComponent")
if var then
    local damage = ComponentGetValue2(var, "value_float")
    EntityInflictDamage(owner, -damage, "DAMAGE_CURSE", "$graham_name_foamarmor", "NORMAL", 0, 0)
end