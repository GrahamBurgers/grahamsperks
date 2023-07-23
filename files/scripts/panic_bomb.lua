local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "ProjectileComponent") or 0
if comp == 0 then return end
local whoshot = ComponentGetValue2(comp, "mWhoShot") or 0

local particles = EntityGetFirstComponent(me, "ParticleEmitterComponent") or 0
if ComponentGetValue2(comp, "on_death_explode") ~= true or ComponentGetValue2(comp, "on_lifetime_out_explode") ~= true then
    ComponentSetValue2(particles, "is_emitting", false)
    return
end
local x, y = EntityGetTransform(me)
local x2, y2 = EntityGetTransform(whoshot)

local radius = ComponentObjectGetValue2(comp, "config_explosion", "explosion_radius")
ComponentSetValue2(particles, "area_circle_radius", radius, radius)
if whoshot == 0 or x2 == nil or y2 == nil then
    -- if we can't find who shot it, turn the particle emitter green and don't shrink it
    ComponentSetValue2(particles, "emitted_material_name", "radioactive_liquid")
    ComponentSetValue2(comp, "lifetime", 180)
    EntityRemoveComponent(me, GetUpdatedComponentID())
    return
end

local distance = math.sqrt((x2 - x)^2 + (y2 - y)^2)
if distance > radius + 2 then
    -- panic!
    ComponentSetValue2(comp, "lifetime", 0)
end

ComponentObjectSetValue2(comp, "config_explosion", "explosion_radius", math.max(10, radius - 0.15))
ComponentSetValue2(particles, "count_min", radius * 0.75)
ComponentSetValue2(particles, "count_max", radius * 0.75)

local sizes = {"008", "012", "016", "032", "064", "128",}
for i = 1, #sizes do
    if radius < tonumber(sizes[i]) then
        ComponentObjectSetValue2(comp, "config_explosion", "explosion_sprite", "data/particles/explosion_" .. sizes[i] .. ".xml")
        return
    end
end