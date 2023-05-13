local entity_id = GetUpdatedEntityID()
local player = EntityGetRootEntity(entity_id)
local skins = GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" )
local damage = ( skins * skins ) / 25

local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
if( damagemodels ~= nil ) then
    for i,damagemodel in ipairs(damagemodels) do
        local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
        local x, y = EntityGetTransform(player)
        local current_biome = BiomeMapGetName(x, y):gsub("$biome_", "")

        if hp > damage + 1 and current_biome ~= "holymountain" then
            EntityInflictDamage(player, damage, "DAMAGE_CURSE", "curse", "NORMAL", 0, 0, player)
        end
    end
end