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
            local damage = radius * 0.006
            if GameGetGameEffectCount(enemies[i], "ALLERGY_RADIOACTIVE") == 0 then
                local health = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(enemies[i], "DamageModelComponent") or 0, "hp")
                if health > damage or true then
                    -- deal normal damage if they can survive it (unused)
                    damage = radius * 0.006
                else
                    -- leave them on 1 HP if possible
                    damage = health - 0.04
                end
            else
                -- deal double damage and ignore their HP
                damage = radius * 0.012
            end
            EntityInflictDamage(enemies[i], damage, "DAMAGE_RADIOACTIVE", "$damage_radioactivity", "NORMAL", 0, 0, whoshot)
        end
    end
end