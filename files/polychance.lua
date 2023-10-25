function shot(projectile)
    local comps = EntityGetComponent(projectile, "ProjectileComponent")
SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
local rando = 60
if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then rando = 50 end
    if (comps ~= nil) and (Random(1, rando) == 1) then
        for k, v in ipairs(comps) do
            ComponentSetValue(v, "damage_game_effect_entities",
                ComponentGetValue(v, "damage_game_effect_entities") .. "data/entities/misc/effect_polymorph.xml,")
        end
    end
end