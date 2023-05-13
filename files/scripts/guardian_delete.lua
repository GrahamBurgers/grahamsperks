local entity_id = GetUpdatedEntityID()
local root_entity = EntityGetRootEntity( entity_id )


if ( EntityHasTag( root_entity, "necrobot_NOT" ) ) then
    EntityKill(entity_id)
end