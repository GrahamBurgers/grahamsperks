local entity_id = GetUpdatedEntityID()
SetRandomSeed( entity_id, entity_id )

if Random(1, 10) == 1 then
    EntityAddComponent( entity_id, "HomingComponent",
    {
		target_who_shot="1",
		homing_targeting_coeff="120.0",
		homing_velocity_multiplier="0.98",
		detect_distance="4300",
    } )
end