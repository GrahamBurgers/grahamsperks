-- timeout bar functionality
-- technically this should work with any entities with a lifetimecomponent and a tagged spritecomponent
local sprite = EntityGetFirstComponent(GetUpdatedEntityID(), "SpriteComponent", "timed_health_slider")
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "LifetimeComponent")
if sprite == nil or comp == nil then return end
local endframe = ComponentGetValue2(comp, "kill_frame")
local startframe = ComponentGetValue2(comp, "creation_frame")
local percentage = (GameGetFrameNum() - startframe) / (endframe - startframe)
ComponentSetValue2(sprite, "special_scale_x", 1 - percentage)