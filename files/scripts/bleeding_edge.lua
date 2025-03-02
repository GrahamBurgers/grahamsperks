local owner = GetUpdatedEntityID()
local enemies = EntityGetWithTag("enemy")
-- redefining variables scares me, so i'll define them first here

for i,enemy in ipairs(enemies) do
    if enemy ~= owner and EntityHasTag(enemy, "graham_bleedingedge_proc") ~= true then
        local dmg = EntityGetFirstComponent(enemy, "DamageModelComponent")
        if dmg then
            local hp = ComponentGetValue2(dmg, "hp" )
            local max_hp = ComponentGetValue2(dmg, "max_hp")
            if hp > 0 and hp <= (max_hp * 0.1) then
                EntityInflictDamage(enemy, max_hp, "DAMAGE_CURSE", "$perkname_graham_edge", "NORMAL", 0, 0, enemy)

                local blood = ComponentGetValue2(dmg, "blood_material")
                local bleeds = (blood ~= "") and (ComponentGetValue2(dmg, "blood_multiplier") > 0)

                local x, y = EntityGetTransform(enemy)
                local poof = EntityLoad("mods/grahamsperks/files/entities/poof.xml", x, y)
                local particles = EntityGetComponent(poof, "ParticleEmitterComponent") or {}
                for j = 1, #particles do
                    ComponentSetValue2(particles[j], "emitted_material_name", (bleeds and blood) or "plasma_fading")
                end
                EntityAddTag(enemy, "graham_bleedingedge_proc")
            end
        end
    end
end