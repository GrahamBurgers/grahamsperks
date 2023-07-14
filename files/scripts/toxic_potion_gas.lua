local particles = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
local min, radius = ComponentGetValue2(particles, "area_circle_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius or 0, "mortal")

local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local whoshot = ComponentGetValue2(comp, "mWhoShot") or 0
local faction
if whoshot ~= 0 then
    local genome = EntityGetFirstComponent(whoshot, "GenomeDataComponent") or 0
    faction = ComponentGetValue2(genome, "herd_id")
end

local new = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local friendlyfire = ComponentGetValue2(new, "friendly_fire")

for i = 1, #enemies do
    if GameGetGameEffectCount(enemies[i], "PROTECTION_RADIOACTIVITY") == 0 then
        -- prevent player from killing their own friendlies (hopefully)
        local genome = EntityGetFirstComponent(enemies[i], "GenomeDataComponent") or 0
        local enemyfaction = ComponentGetValue2(genome, "herd_id")
        if (faction ~= enemyfaction and enemies[i] ~= whoshot and GameGetGameEffect( enemies[i], "CHARM" ) == 0) or friendlyfire == true then
            if GameGetGameEffectCount(enemies[i], "ALLERGY_RADIOACTIVE") == 0 then
                EntityInflictDamage(enemies[i], radius * 0.006, "DAMAGE_RADIOACTIVE", "$damage_radioactivity", "NORMAL", 0, 0, whoshot)
            else
                EntityInflictDamage(enemies[i], radius * 0.012, "DAMAGE_RADIOACTIVE", "$damage_radioactivity", "NORMAL", 0, 0, whoshot)
            end
        end
    end
end