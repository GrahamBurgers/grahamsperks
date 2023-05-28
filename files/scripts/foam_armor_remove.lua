local owner = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponent(owner, "DamageModelComponent") or 0
EntityInflictDamage(owner, 0.8, DAMAGE_CURSE, "$graham_name_foamarmor", DISINTEGRATED, 0, 0)
ComponentSetValue2(comp, "hp", ComponentGetValue2(comp, "hp") - 0.8)
ComponentSetValue2(comp, "max_hp", ComponentGetValue2(comp, "max_hp") - 0.8)