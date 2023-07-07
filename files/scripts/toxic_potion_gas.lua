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

for i = 1, #enemies do
    if enemies[i] ~= whoshot and GameGetGameEffectCount(enemies[i], "PROTECTION_RADIOACTIVITY") == 0 then
        -- prevent player from killing their own friendlies (hopefully)
        local genome = EntityGetFirstComponent(enemies[i], "GenomeDataComponent") or 0
        local enemyfaction = ComponentGetValue2(genome, "herd_id")
        if faction ~= enemyfaction then
            EntityInflictDamage(enemies[i], radius * 0.008, "DAMAGE_RADIOACTIVE", "$damage_radioactivity", "NORMAL", 0, 0, whoshot)
        end
    end
end