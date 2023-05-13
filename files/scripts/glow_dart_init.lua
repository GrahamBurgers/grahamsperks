local entity_id = GetUpdatedEntityID()
SetRandomSeed( entity_id, entity_id )

local options = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "spark_purple_bright"}
local result = options[Random(1, #options)]

comps = EntityGetComponent( entity_id, "ParticleEmitterComponent" )
if ( comps ~= nil ) then
    for i,v in ipairs( comps ) do
        local cosmetic = ComponentGetValue2( v, "emit_cosmetic_particles" )
        
        if cosmetic then
            ComponentSetValue2( v, "emitted_material_name", result )
        end
    end
end