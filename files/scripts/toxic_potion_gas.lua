local particles = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
local min, radius = ComponentGetValue2(particles, "area_circle_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius * 1, "mortal")

local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local whoshot = ComponentGetValue2(comp, "mWhoShot")
for i = 1, #enemies do
    if enemies[i] ~= whoshot and GameGetGameEffectCount(enemies[i], "PROTECTION_RADIOACTIVITY") == 0 then
        EntityInflictDamage(enemies[i], radius * 0.008, "DAMAGE_RADIOACTIVE", "$damage_radioactivity", "NORMAL", 0, 0, whoshot)
    end
end