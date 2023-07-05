dofile_once("data/scripts/lib/utilities.lua")
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "VariableStorageComponent", "graham_toxic_potion") or 0
local size = 25
if comp ~= 0 then
    size = math.max(5, ComponentGetValue2(comp, "value_int"))
end

local x, y = EntityGetTransform(GetUpdatedEntityID())
local eid = shoot_projectile_from_projectile( GetUpdatedEntityID(), "mods/grahamsperks/files/entities/toxic_gas.xml", x, y, 0, 0)
local particles = EntityGetFirstComponent(eid, "ParticleEmitterComponent") or 0
ComponentSetValue2(particles, "area_circle_radius", 0, size)
ComponentSetValue2(particles, "count_min", size / 2)
ComponentSetValue2(particles, "count_max", size / 2)