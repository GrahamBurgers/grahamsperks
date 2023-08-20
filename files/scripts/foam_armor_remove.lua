local owner = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponent(owner, "DamageModelComponent")
if comp == nil then return end
local hp = ComponentGetValue2(comp, "hp")
EntityInflictDamage(owner, 0.8, "DAMAGE_CURSE", "$graham_name_foamarmor", "NORMAL", 0, 0)
ComponentSetValue2(comp, "hp", hp - 0.8)