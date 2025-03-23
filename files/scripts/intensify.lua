local me = EntityGetRootEntity(GetUpdatedEntityID())
local particles = EntityGetComponentIncludingDisabled(me, "ParticleEmitterComponent") or {}
for i = 1, #particles do
    ComponentSetValue2(particles[i], "count_min", math.min(32, ComponentGetValue2(particles[i], "count_min") * 2))
    ComponentSetValue2(particles[i], "count_max", math.min(32, ComponentGetValue2(particles[i], "count_max") * 2))
    ComponentSetValue2(particles[i], "lifetime_min", math.min(15, ComponentGetValue2(particles[i], "lifetime_min") * 1.5))
    ComponentSetValue2(particles[i], "lifetime_max", math.min(15, ComponentGetValue2(particles[i], "lifetime_max") * 1.5))
    ComponentSetValue2(particles[i], "emission_interval_min_frames", math.min(1, ComponentGetValue2(particles[i], "emission_interval_min_frames") - 2))
    ComponentSetValue2(particles[i], "emission_interval_max_frames", math.min(1, ComponentGetValue2(particles[i], "emission_interval_max_frames") - 2))
    ComponentSetValue2(particles[i], "image_animation_emission_probability", ComponentGetValue2(particles[i], "image_animation_emission_probability") * 1.5)
end
local projcomp = EntityGetComponentIncludingDisabled(me, "ProjectileComponent") or {}
for i = 1, #projcomp do
    ComponentSetValue2(projcomp[i], "on_death_emit_particle_count", ComponentGetValue2(projcomp[i], "on_death_emit_particle_count") * 2)
    ComponentSetValue2(projcomp[i], "blood_count_multiplier", ComponentGetValue2(projcomp[i], "blood_count_multiplier") * 1.5)
    ComponentObjectSetValue2(projcomp[i], "config_explosion", "create_cell_probability", ComponentObjectGetValue2(projcomp[i], "config_explosion", "create_cell_probability") * 1.5)
end
-- doesn't even work on touch ofs since they can't be modified but whatever
local mat = EntityGetComponentIncludingDisabled(me, "MagicConvertMaterialComponent") or {}
for i = 1, #mat do
    ComponentSetValue2(mat[i], "radius", math.min(200, ComponentGetValue2(mat[i], "radius") * 1.25))
end