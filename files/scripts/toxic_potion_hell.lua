dofile_once("data/scripts/lib/utilities.lua")
local size = 45

local x, y = EntityGetTransform(GetUpdatedEntityID())
local eid = shoot_projectile_from_projectile( GetUpdatedEntityID(), "mods/grahamsperks/files/entities/toxic_gas_hell.xml", x, y, 0, 0)
local particles = EntityGetFirstComponent(eid, "ParticleEmitterComponent") or 0
ComponentSetValue2(particles, "area_circle_radius", 0, size)
ComponentSetValue2(particles, "count_min", size / 6)
ComponentSetValue2(particles, "count_max", size / 6)
local new = EntityGetFirstComponent(eid, "ProjectileComponent") or 0