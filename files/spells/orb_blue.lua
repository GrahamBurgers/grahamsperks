dofile_once("data/scripts/lib/utilities.lua")

local execute_times = 57
local damage_min = 0.1
local damage_max = 0.8
local radius_min = 0
local radius_max = 8

local entity_id = GetUpdatedEntityID()
local projectile_comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" )
local storage_comp = get_variable_storage_component( entity_id, "base_damage" )
if projectile_comp == nil or storage_comp == nil then return end

local t = ComponentGetValue2( GetUpdatedComponentID(), "mTimesExecuted" )

-- store or recall base damage
if t == 0 then
	damage_max = ComponentGetValue2(projectile_comp, "damage")
	ComponentSetValue2(storage_comp, "value_float", damage_max)
else
	damage_max = ComponentGetValue2(storage_comp, "value_float")
    if t == 57 then
        EntityAddComponent2(entity_id, "HitEffectComponent", {
            effect_hit="LOAD_CHILD_ENTITY",
            value_string="data/entities/misc/curse_strong_init.xml"
        })
    end
end

t = t / execute_times -- 0...1
local current_damage = lerp(damage_max, damage_min, t)
local current_radius = lerp(radius_max, radius_min, t)

-- update damage & enable projectile collision
component_write( projectile_comp, { damage = current_damage, collide_with_entities = true } )

-- update visuals
local comp = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent" )
if comp then
    ComponentSetValue2(comp, "area_circle_radius", current_radius, current_radius)
end