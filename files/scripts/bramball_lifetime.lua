local proj = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "VariableStorageComponent") or 0
ComponentSetValue2(comp, "value_int", ComponentGetValue2(proj, "lifetime") + 2)