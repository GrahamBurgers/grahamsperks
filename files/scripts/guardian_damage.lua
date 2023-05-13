local entity_id = GetUpdatedEntityID()
local root_entity = EntityGetRootEntity( entity_id )

local damagemodels = EntityGetComponent( root_entity, "DamageModelComponent" )
if( damagemodels ~= nil ) then
    for i,v in ipairs(damagemodels) do
        local hp = ComponentGetValue2( v, "hp" )
        local max_hp = ComponentGetValue2( v, "max_hp")

        hp = 0.0024 + (max_hp / 2000)
        
        -- GamePrint(tostring(hp))
        EntityInflictDamage( root_entity, hp, "DAMAGE_CURSE", "Martyr", "NONE", 0, 0)
        -- ComponentSetValue2( v, "hp", hp)
        break
    end
end