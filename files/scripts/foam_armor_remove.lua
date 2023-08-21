local owner = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponent(owner, "DamageModelComponent")
if comp == nil then return end
local hp = ComponentGetValue2(comp, "hp")
local damage = 0.8
if hp <= damage then
    damage = hp - 0.04
end
EntityInflictDamage(owner, damage, "DAMAGE_CURSE", "$graham_name_foamarmor", "NORMAL", 0, 0)
ComponentSetValue2(comp, "hp", hp - damage)