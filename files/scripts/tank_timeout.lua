local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "LifetimeComponent")
local sprite = EntityGetFirstComponent(GetUpdatedEntityID(), "SpriteComponent", "timed_health_slider")
if sprite == nil or comp == nil then return end

if BiomeMapGetName(x, y) == "$biome_holymountain" or BiomeMapGetName(x, y) == "$biome_boss_arena" then
    ComponentSetValue2(comp, "kill_frame", ComponentGetValue2(comp, "kill_frame") + 1)
    ComponentSetValue2(comp, "creation_frame", ComponentGetValue2(comp, "creation_frame") + 1)
end

-- timeout bar functionality
-- technically this should work with any entities with a lifetimecomponent and a tagged spritecomponent
local endframe = ComponentGetValue2(comp, "kill_frame")
local startframe = ComponentGetValue2(comp, "creation_frame")
local percentage = (GameGetFrameNum() - startframe) / (endframe - startframe)
ComponentSetValue2(sprite, "special_scale_x", 1 - percentage)