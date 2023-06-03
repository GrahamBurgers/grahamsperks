function spawn_heart( x, y )
	local r = ProceduralRandom( x, y )
	SetRandomSeed( x, y )
	local heart_spawn_percent = 0.7
	local chest_spawn_percent = 0.3
	
	local year, month, day = GameGetDateAndTimeLocal()
	if ( month == 2 ) and ( day == 14 ) then heart_spawn_percent = 0.35 end

	-- new chest_spawn_percent variable is influenced by the lucky clover perk to make hearts/chests 20% more common, i think
	if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then heart_spawn_percent = heart_spawn_percent - 0.1 end
	if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then chest_spawn_percent = chest_spawn_percent - 0.3 end
	
	if (r > heart_spawn_percent) then
		--i'm paranoid about the heart spawn chances not being correct, so the healthy heart spawn is based off of in-game frame number.
		--not seed-based, but whatever
		SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
			local rnd =  Random( 1, 5 )
			
			if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then rnd = Random( 1, 6 ) end
			
			if GameHasFlagRun("PERK_PICKED_GRAHAM_HEALTHY_HEARTS") then
				-- no natural Healthy Heart spawns if you have Healthy Hearts already
				local entity = EntityLoad( "data/entities/items/pickup/heart.xml", x, y)
			else
				if ( rnd >= 5 ) then
					local entity = EntityLoad( "mods/grahamsperks/files/pickups/heart_healthy.xml", x, y)
				else
					local entity = EntityLoad( "data/entities/items/pickup/heart.xml", x, y)
				end
			end

	elseif (r > chest_spawn_percent) then
		SetRandomSeed( x+45, y-2123 )
		local rnd = Random( 1, 100 )
		
		if (rnd <= 90) or (y < 512 * 3) then
			rnd = Random( 1, 1000 )
			
			if( Random( 1, 300 ) == 1 ) then spawn_mimic_sign( x, y ) end
			
			if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then rnd = rnd + ((1000 - rnd) * 0.3) end

			-- modified version of the chest spawn script in order to spawn the modded chests
			
			if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") and ModSettingGet("grahamsperks.luckyclover") == "yes" then rnd = rnd + 5 end
			
			if ( rnd >= 1000 ) then
				local entity = EntityLoad( "data/entities/items/pickup/chest_random_super.xml", x, y)
				--GamePrint("spawning great chest")
			elseif (rnd >= 900 ) then
				local entity = EntityLoad( "mods/grahamsperks/files/pickups/chest_lost.xml", x, y)
				--GamePrint("spawning lost chest")
			elseif (rnd >= 850 ) then
				
				SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
				if Random(1, 3) == 3 then
					local entity = EntityLoad( "data/entities/animals/mini_mimic.xml", x, y)
					-- GamePrint("spawning mini mimic")
				else
					local entity = EntityLoad( "mods/grahamsperks/files/pickups/chest_mini.xml", x, y)
					-- GamePrint("spawning mini chest")
				end
			elseif (rnd >= 775 ) or (rnd >= 725 and (BiomeMapGetName(x, y):gsub("$biome_", "") == "vault")) then
				local entity = EntityLoad( "mods/grahamsperks/files/pickups/safe.xml", x, y)
				--GamePrint("spawning safe")
			else
				local entity = EntityLoad( "data/entities/items/pickup/chest_random.xml", x, y)
				--GamePrint("spawning chest")
			end

		else
			rnd = Random( 1, 100 )
			if( Random( 1, 30 ) == 1 ) then spawn_mimic_sign( x, y ) end

			if( rnd <= 95 ) then
				local entity = EntityLoad( "data/entities/animals/chest_mimic.xml", x, y)
			else
				local entity = EntityLoad( "data/entities/items/pickup/chest_leggy.xml", x, y)
			end
		end
	end
end