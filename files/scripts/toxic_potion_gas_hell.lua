local particles = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
local _, radius = ComponentGetValue2(particles, "area_circle_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius or 0, "mortal")

local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local whoshot = ComponentGetValue2(comp, "mWhoShot") or 0

local new = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local friendlyfire = ComponentGetValue2(new, "friendly_fire")

for i = 1, #enemies do
    if GameGetGameEffectCount(enemies[i], "PROTECTION_RADIOACTIVITY") == 0 then
        -- prevent player from killing their own friendlies (hopefully)
        if EntityGetHerdRelation( whoshot, enemies[i] ) <= 60 or friendlyfire == true then
            local damage = radius * 0.008
            if GameGetGameEffectCount(enemies[i], "ALLERGY_RADIOACTIVE") == 0 then
                damage = radius * 0.008
            else
                -- deal double damage
                damage = radius * 0.016
            end
            EntityInflictDamage(enemies[i], damage, "DAMAGE_CURSE", "$damage_curse", "NORMAL", 0, 0, whoshot)
        end
    end
end