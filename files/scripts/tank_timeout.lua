local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "LifetimeComponent")
local ai = EntityGetFirstComponent(me, "AnimalAIComponent")
local sprite = EntityGetFirstComponent(me, "SpriteComponent", "timed_health_slider")
if (not sprite) or (not comp) or (not ai) then return end

local prev = ComponentGetValue2(ai, "mAiStatePrev")
if (prev ~= 15 and prev ~= 16) then
    ComponentSetValue2(comp, "kill_frame", ComponentGetValue2(comp, "kill_frame") + 1)
    ComponentSetValue2(comp, "creation_frame", ComponentGetValue2(comp, "creation_frame") + 1)
end

-- timeout bar functionality
-- technically this should work with any entities with a lifetimecomponent and a tagged spritecomponent
local endframe = ComponentGetValue2(comp, "kill_frame")
local startframe = ComponentGetValue2(comp, "creation_frame")
local percentage = (GameGetFrameNum() - startframe) / (endframe - startframe)
ComponentSetValue2(sprite, "special_scale_x", 1 - percentage)