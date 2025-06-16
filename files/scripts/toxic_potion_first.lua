-- first tick should never hurt entities
local proj = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent")
if proj then ComponentSetValue2(proj, "collide_with_entities", true) end
local gae = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "GameAreaEffectComponent")
if gae then EntitySetComponentIsEnabled(GetUpdatedEntityID(), gae, true) end