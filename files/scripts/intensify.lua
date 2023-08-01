local me = EntityGetRootEntity(GetUpdatedEntityID())
local particles = EntityGetComponentIncludingDisabled(me, "ParticleEmitterComponent") or {}
for i = 1, #particles do
    ComponentSetValue2(particles[i], "count_min", ComponentGetValue2(particles[i], "count_min") * 2)
    ComponentSetValue2(particles[i], "count_max", ComponentGetValue2(particles[i], "count_max") * 2)
    ComponentSetValue2(particles[i], "lifetime_min", ComponentGetValue2(particles[i], "lifetime_min") * 1.5)
    ComponentSetValue2(particles[i], "lifetime_max", ComponentGetValue2(particles[i], "lifetime_max") * 1.5)
    ComponentSetValue2(particles[i], "emission_interval_min_frames", math.min(1, ComponentGetValue2(particles[i], "emission_interval_min_frames") - 2))
    ComponentSetValue2(particles[i], "emission_interval_max_frames", math.min(1, ComponentGetValue2(particles[i], "emission_interval_max_frames") - 2))
end