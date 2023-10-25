local emitters = EntityGetComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or {}
for i = 1, #emitters do
    if ComponentGetValue2(emitters[i], "emit_cosmetic_particles") then
        EntityRemoveComponent(GetUpdatedEntityID(), emitters[i])
    end
end
local sprites = EntityGetComponent(GetUpdatedEntityID(), "SpriteComponent") or {}
for i = 1, #sprites do
    EntityRemoveComponent(GetUpdatedEntityID(), sprites[i])
end
local unnecessary = EntityGetComponent(GetUpdatedEntityID(), "SpriteParticleEmitterComponent") or {}
for i = 1, #unnecessary do
    EntityRemoveComponent(GetUpdatedEntityID(), unnecessary[i])
end