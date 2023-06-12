local orig_death = death
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	orig_death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	
	if EntityHasTag(entity_thats_responsible, "player_unit") then

		if GameHasFlagRun("PERK_PICKED_GRAHAM_REPOSSESSION") then
			local me = GetUpdatedEntityID()
			local x, y = EntityGetTransform(me)
			local projectiles = EntityGetInRadiusWithTag(x, y, 500, "projectile") or {}
			for i = 1, #projectiles do
				local comps = EntityGetComponent(projectiles[i], "ProjectileComponent") or {}
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "mWhoShot") == me then
						ComponentSetValue2(comps[j], "explosion_dont_damage_shooter", true)
						ComponentSetValue2(comps[j], "mWhoShot", entity_thats_responsible)
						ComponentSetValue2(comps[j], "never_hit_player", true)
						GamePrint("worked")
					end
				end
			end
		end
	
		local x, y = EntityGetTransform(entity_thats_responsible)

		local damagemodels = EntityGetComponent( entity_thats_responsible, "DamageModelComponent" )
		local health = 0
		if( damagemodels ~= nil ) then
			for i,v in ipairs(damagemodels) do
				maxhealth = 25 * tonumber( ComponentGetValue( v, "max_hp" ) )
				health = 25 * tonumber( ComponentGetValue( v, "hp" ) )
				break
			end
		end
		
		if health <= 20 then
			local message = ModSettingGet("grahamsperks.respawns")
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
			if Random(1, health * 10) == 1 and GlobalsGetValue( "GRAHAM_SPAWNED_LUCKY", 0 ) ~= yes then
				if HasFlagPersistent("graham_progress_lucky") ~= true then
					AddFlagPersistent("graham_progress_lucky")
					GamePrint( "$graham_perk_unlock" )
					GamePrint( "$graham_perk_unlock_lucky" )
					EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
					EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
					dofile_once("data/scripts/perks/perk.lua")
					perk_spawn(x, y-40, "GRAHAM_LUCKYDAY")
				end
			end
		end
		
		if GameHasFlagRun("PERK_PICKED_GRAHAM_BLOODY_EXTRA_PERK") then
			
			local enemies_killed = tonumber( StatsBiomeGetValue("enemies_killed") )
			  
			-- transform a string like "$biome_coalmine" to "coalmine"
			local current_biome = BiomeMapGetName(x, y):gsub("$biome_", "")
			
			local kills_needed = 0
			
			if current_biome == "coalmine" or current_biome == "coalmine_alt" then kills_needed = 20 end
			if current_biome == "excavationsite" or current_biome == "fungicave" then kills_needed = 40 end
			if current_biome == "snowcave" or current_biome == "wandcave" then kills_needed = 30 end
			if current_biome == "snowcastle" then kills_needed = 40 end
			if current_biome == "rainforest" or currentbiome == "rainforest_open" then kills_needed = 30 end
			if current_biome == "vault" then kills_needed = 20 end
			if current_biome == "crypt" then kills_needed = 40 end
				
			if GameHasFlagRun("PERK_PICKED_GLOBAL_GORE") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_GENOME_MORE_HATRED") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_ANGRY_GHOST") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_VAMPIRISM") then kills_needed = kills_needed * 0.8 end
			
			kills_needed = math.floor(kills_needed) - 1
			
			local remainder = kills_needed - enemies_killed

			local message = ModSettingGet("grahamsperks.bloodybonus")
			local stuff = false
			
			if ( message == "all" ) then stuff = true end
			if message == "milestone" and remainder % 5 == 0 then stuff = true end
			if message == "milestone" and remainder < 5 then stuff = true end
			
			if remainder > 0 and stuff == true then
				if remainder == 1 then
					GamePrint("$graham_1killleft" )
				else
					GameTextGet("$graham_killsleft", tostring(remainder))
				end
			end
			
			if ( enemies_killed == kills_needed ) then
				SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
				local message = "$graham_bloodied_0" .. tostring( Random(1,9) )				

				EntityLoad("mods/grahamsperks/files/entities/blood_circle.xml", x, y)
				GamePrintImportant( message, "$graham_bloodied_desc" )
			end
		end
	end
  
end