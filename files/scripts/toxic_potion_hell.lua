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
local new = EntityGetFirstComponent(eid, "ProjectileComponent") or 0
ComponentSetValue2(new, "friendly_fire", friendlyfire)