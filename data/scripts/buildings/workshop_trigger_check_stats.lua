dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	SetRandomSeed(x, y)

	-- Note! 
	--  * For global stats use StatsGetValue("enemies_killed")
	--  * For biome stats use StatsBiomeGetValue("enemies_killed")
	--
	-- the difference is that StatsBiomeGetValue() tracks the stats diff since calling StatsResetBiome()
	-- which is what workshop_exit calls
	--
	--
	-- this does the workshop rewards for playing in a certain way
	-- 1) killed none
	
	local reference_id = EntityGetClosestWithTag( x, y, "workshop_reference" )

	local enemies_killed = tonumber( StatsBiomeGetValue("enemies_killed") )
	print(enemies_killed)
	if( enemies_killed == 0 ) then
		print("KILLED NONE")
		local sx,sy = x,y
		
		if ( reference_id ~= NULL_ENTITY ) then
			sx,sy = EntityGetTransform( reference_id )
		else
			print("No reference point found for workshop no-kill chest")
		end
		
		local cx, cy = GameGetCameraPos()

			print("Loading chest_random.xml to " .. tostring(sx) .. ", " .. tostring(sy))

			if ModSettingGet("grahamsperks.pacifist") == "yes" then

				if Random(1, 12) == 12 then
					local eid = EntityLoad( "data/entities/animals/mini_mimic.xml", sx, sy )
				else
					local eid = EntityLoad( "mods/grahamsperks/files/pickups/chest_mini.xml", sx, sy )
					change_entity_ingame_name( eid, "$item_chest_treasure_pacifist" )
				end
			else
				local eid = EntityLoad( "data/entities/items/pickup/chest_random.xml", sx, sy )
				change_entity_ingame_name( eid, "$item_chest_treasure_pacifist" )
			end
	else
		print("KILLED ALL")
		
		-- Below is the script to spawn the Bloody Chest if you have Bloody Bonus
		if GameHasFlagRun("PERK_PICKED_GRAHAM_BLOODY_EXTRA_PERK") then
			local current_biome = BiomeMapGetName(x, y - 500):gsub("$biome_", "")
			if BiomeMapGetName(x, y - 1000):gsub("$biome_", "") == "crypt" then current_biome = crypt end
			
			local kills_needed = 100
			
			if current_biome == "coalmine" or current_biome == "coalmine_alt" then kills_needed = 20 end
			if current_biome == "excavationsite" or current_biome == "fungicave" then kills_needed = 40 end
			if current_biome == "snowcave" or current_biome == "wandcave" then kills_needed = 30 end
			if current_biome == "snowcastle" then kills_needed = 40 end
			if current_biome == "rainforest" or current_biome == "rainforest_open" then kills_needed = 30 end
			if current_biome == "vault" then kills_needed = 20 end
			if current_biome == "crypt" then kills_needed = 40 end
				
			if GameHasFlagRun("PERK_PICKED_GLOBAL_GORE") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_GENOME_MORE_HATRED") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_ANGRY_GHOST") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_VAMPIRISM") then kills_needed = kills_needed * 0.8 end
			
			kills_needed = math.floor(kills_needed) - 1
		
			if( enemies_killed >= kills_needed ) then
				local sx,sy = x,y
			
				if ( reference_id ~= NULL_ENTITY ) then
					sx,sy = EntityGetTransform( reference_id )
				else
					print("No reference point found for workshop no-kill chest")
				end
		
				local cx, cy = GameGetCameraPos()
				local chance = 12
				if HasFlagPersistent("graham_bloodymimic_killed") == false then
					chance = 6
				end

				if Random(1, chance) == chance then
					local eid = EntityLoad( "data/entities/animals/bloody_mimic.xml", sx, sy )
				else
					local eid = EntityLoad( "mods/grahamsperks/files/pickups/chest_bloody.xml", sx, sy + 7)
				end
			
			end
		end
	end
end