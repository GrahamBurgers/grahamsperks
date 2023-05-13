local root = GetUpdatedEntityID()
local player = EntityGetRootEntity(root)

local comp = EntityGetComponent(player, "ShotEffectComponent", "graham_accuracy_remove")[1]
EntityRemoveComponent(player, comp)
EntityKill(root)