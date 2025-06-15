local owner = GetUpdatedEntityID()
local x, y = EntityGetTransform(owner)
local enemies = EntityGetInRadiusWithTag(x, y, 250, "enemy")
local players = EntityGetInRadiusWithTag(x, y, 250, "player_unit")
for i = 1, #players do
    enemies[#enemies+1] = players[i]
end
-- redefining variables scares me, so i'll define them first here

for i,enemy in ipairs(enemies) do
    if enemy ~= owner and EntityHasTag(enemy, "graham_bleedingedge_proc") ~= true then
        local dmg = EntityGetFirstComponent(enemy, "DamageModelComponent")
        if dmg then
            if EntityHasTag(enemy, "player_unit") then
                local ch = EntityGetAllChildren(enemy, "bleedingedge")
                if (not ch) or (#ch < 1) then
                    LoadGameEffectEntityTo(enemy, "mods/grahamsperks/files/effects/bleedingedge.xml")
                else
                    local game = EntityGetFirstComponent(ch[1], "GameEffectComponent")
                    if game then
                        ComponentSetValue2(game, "frames", 1)
                    end
                end
            end
            local hp = ComponentGetValue2(dmg, "hp" )
            local max_hp = ComponentGetValue2(dmg, "max_hp")
            if hp > 0 and hp <= (max_hp * 0.1) then
                local ragdoll = EntityHasTag(enemy, "player_unit") and "BLOOD_EXPLOSION" or "NORMAL"
                EntityInflictDamage(enemy, hp * 100, "DAMAGE_CURSE", "$perkname_graham_edge", ragdoll, 0, 0, enemy)

                local blood = ComponentGetValue2(dmg, "blood_material")
                local bleeds = (blood ~= "") and (ComponentGetValue2(dmg, "blood_multiplier") > 0)

                local x2, y2 = EntityGetTransform(enemy)
                local poof = EntityLoad("mods/grahamsperks/files/entities/poof.xml", x2, y2)
                local particles = EntityGetComponent(poof, "ParticleEmitterComponent") or {}
                for j = 1, #particles do
                    ComponentSetValue2(particles[j], "emitted_material_name", (bleeds and blood) or "plasma_fading")
                end
                EntityAddTag(enemy, "graham_bleedingedge_proc")
            end
        end
    end
end