dofile_once("data/scripts/lib/utilities.lua")
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "VariableStorageComponent", "graham_toxic_potion") or 0
local proj = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local friendlyfire = ComponentGetValue2(proj, "friendly_fire")
local size = 5 -- default size if no damage is found
if comp ~= 0 then
    size = math.max(5, ComponentGetValue2(comp, "value_int"))
end

local x, y = EntityGetTransform(GetUpdatedEntityID())
local eid = shoot_projectile_from_projectile( GetUpdatedEntityID(), "mods/grahamsperks/files/entities/toxic_gas_hell.xml", x, y, 0, 0)
local particles = EntityGetComponent(eid, "ParticleEmitterComponent") or {}
for i = 1, #particles do
    if i == 1 then
        ComponentSetValue2(particles[i], "area_circle_radius", 0, size)
    else
        ComponentSetValue2(particles[i], "area_circle_radius", size, size)
    end
    ComponentSetValue2(particles[i], "count_min", size / 2)
    ComponentSetValue2(particles[i], "count_max", size / 2)
end
local new = EntityGetFirstComponentIncludingDisabled(eid, "ProjectileComponent")
if new then
    ComponentSetValue2(new, "friendly_fire", friendlyfire)
    ComponentSetValue2(new, "collide_with_shooter_frames", friendlyfire and 0 or -1)
    ComponentObjectSetValue2(new, "damage_by_type", "curse", size * 0.006)
end
local gae = EntityGetFirstComponentIncludingDisabled(eid, "GameAreaEffectComponent")
if gae then ComponentSetValue2(gae, "radius", size * 0.8) end