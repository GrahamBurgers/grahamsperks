RegisterSpawnFunction( 0xff03deaf, "spawn_fish" )
RegisterSpawnFunction( 0xff420A3D, "spawn_trigger_check_stats" )
RegisterSpawnFunction( 0xff420a3f, "spawn_trigger_check_stats_reference" )

function spawn_trigger_check_stats( x, y )
	EntityLoad( "data/entities/buildings/workshop_trigger_check_stats.xml", x, y )
end

function spawn_trigger_check_stats_reference( x, y )
	EntityLoad( "data/entities/buildings/workshop_trigger_check_stats_reference.xml", x, y )
end

function spawn_fish(x, y)
	local f = GameGetOrbCountAllTime()
	
	for i=1,f do
		EntityLoad( "data/entities/animals/fish.xml", x, y )
	end
end