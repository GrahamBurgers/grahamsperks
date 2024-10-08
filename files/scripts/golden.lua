local entity_id = GetUpdatedEntityID()
local particle = "gold"
local comps

SetRandomSeed( entity_id, entity_id )

comps = EntityGetComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		local cosmetic = ComponentGetValue2( v, "emit_cosmetic_particles" )
		
		if cosmetic then
			if ( particle ~= nil ) then
				ComponentSetValue2( v, "emitted_material_name", particle )
			else
				ComponentSetValue2( v, "is_emitting", false )
			end
		end
	end
end

comps = EntityGetComponentIncludingDisabled( entity_id, "SpriteParticleEmitterComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		ComponentSetValue2( v, "is_emitting", false )
	end
end

comps = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		ComponentSetValue2( v, "visible", false )
	end
end

comps = EntityGetComponentIncludingDisabled( entity_id, "ProjectileComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", "" )
		
		if ( particle ~= nil ) then
			ComponentObjectSetValue2( v, "config_explosion", "spark_material", particle )
		else
			ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", false )
			ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", false )
		end
	end
end

-- Make glimmer spells work with plasma emitters. Thank you Conga Lyne!!!
comps = EntityGetComponent( entity_id, "LaserEmitterComponent" ) or {}
for k=1,#comps do
    local v = comps[k]
    ComponentObjectSetValue2( v, "laser", "beam_particle_type", CellFactory_GetType(particle))
end