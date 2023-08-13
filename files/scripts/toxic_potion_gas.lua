local particles = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
local _, radius = ComponentGetValue2(particles, "area_circle_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius or 0, "mortal")

local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local whoshot = ComponentGetValue2(comp, "mWhoShot") or 0
local herdid = ComponentGetValue2(comp, "mShooterHerdId")
local friendlyfire = ComponentGetValue2(comp, "friendly_fire")

for i = 1, #enemies do
    if GameGetGameEffectCount(enemies[i], "PROTECTION_RADIOACTIVITY") == 0 then
        -- hopefully should be the final fix here (I'm so glad that mShooterHerdId exists)
        local herdcomp = EntityGetFirstComponent(enemies[i], "GenomeDataComponent")
        local herd = nil
        if herdcomp ~= nil then
            herd = ComponentGetValue2(herdcomp, "herd_id")
        end
        if herd == nil or herdid == nil or friendlyfire == true or (whoshot ~= enemies[i] and GetHerdRelation(herdid, herd) <= 60) then
            local damage = radius * 0.006
            if GameGetGameEffectCount(enemies[i], "ALLERGY_RADIOACTIVE") > 0 then
                -- deal double damage
                damage = radius * 0.012
            end
            EntityInflictDamage(enemies[i], damage, "DAMAGE_RADIOACTIVE", "$damage_radioactive", "NORMAL", 0, 0, whoshot)
        end
    end
end