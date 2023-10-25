local particles = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
local _, radius = ComponentGetValue2(particles, "area_circle_radius")
local x, y = EntityGetTransform(GetUpdatedEntityID())
local enemies = EntityGetInRadiusWithTag(x, y, radius or 0, "mortal")

local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent") or 0
local whoshot = ComponentGetValue2(comp, "mWhoShot") or 0
local herdid = ComponentGetValue2(comp, "mShooterHerdId")
local friendlyfire = ComponentGetValue2(comp, "friendly_fire")

for i = 1, #enemies do
    -- hopefully should be the final fix here (I'm so glad that mShooterHerdId exists)
    local herdcomp = EntityGetFirstComponent(enemies[i], "GenomeDataComponent")
    local herd = nil
    if herdcomp ~= 0 then
        herd = ComponentGetValue2(herdcomp, "herd_id")
    end
    if herd == nil or herdid == nil or friendlyfire == true or (whoshot ~= enemies[i] and GetHerdRelation(herdid, herd) <= 60) then
        EntityInflictDamage(enemies[i], radius * 0.005, "DAMAGE_CURSE", "$damage_curse", "NORMAL", 0, 0, whoshot)
    end
end