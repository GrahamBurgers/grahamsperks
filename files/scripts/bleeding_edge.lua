local owner = GetUpdatedEntityID()
local enemies = EntityGetWithTag("enemy")
-- redefining variables scares me, so i'll define them first here
local damagemodels
local hp
local max_hp
local x, y

for i,enemy in ipairs(enemies) do
    if enemy ~= owner and EntityHasTag(enemy, "graham_bleedingedge_proc") ~= true then
        damagemodels = EntityGetComponent( enemy, "DamageModelComponent" )
        if( damagemodels ~= nil ) then
            for _,v in ipairs(damagemodels) do
                hp = ComponentGetValue2( v, "hp" )
                max_hp = ComponentGetValue2( v, "max_hp") * 0.1
                if hp <= max_hp and hp > 0 then
                    x, y = EntityGetTransform(enemy)
                    EntityInflictDamage(enemy, max_hp, "DAMAGE_CURSE", "Bleeding Edge", "NORMAL", 0, 0, enemy)
                    EntityLoad("mods/grahamsperks/files/entities/poof.xml", x, y)
                    EntityAddTag(enemy, "graham_bleedingedge_proc")
                end
                break
            end
        end
    end
end