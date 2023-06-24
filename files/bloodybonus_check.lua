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
				local yes = false
				for j = 1, #comps do
					if ComponentGetValue2(comps[j], "mWhoShot") == me then
						ComponentSetValue2(comps[j], "explosion_dont_damage_shooter", true)
						ComponentSetValue2(comps[j], "mWhoShot", entity_thats_responsible)
						ComponentSetValue2(comps[j], "never_hit_player", true)
						yes = true
					end
				end
				if yes == true then
					local sprites = EntityGetComponent(projectiles[i], "SpriteComponent") or {}
					for k = 1, #sprites do
						local alpha = ComponentGetValue2(sprites[k], "alpha") or 1
						ComponentSetValue2(sprites[k], "alpha", alpha / 4)
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
			if Random(1, health * 10) == 1 and GlobalsGetValue( "GRAHAM_SPAWNED_LUCKY", "0" ) ~= "yes" then
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
            -- Cpoi:
            -- We have switch cases at home
            -- Switch cases at home:
            local kills_needed = ({
                ["coalmine"]        = 20,
                ["coalmine_alt"]    = 20,
                ["excavationsite"]  = 40,
                ["fungicave"]       = 40,
                ["snowcave"]        = 30,
                ["wandcave"]        = 30,
                ["snowcastle"]      = 40,
                ["rainforest"]      = 30,
                ["rainforest_open"] = 30,
                ["vault"]           = 20,
                ["crypt"]           = 40,
            })[BiomeMapGetName(x, y):sub(8,-1)] or 0

			if GameHasFlagRun("PERK_PICKED_GLOBAL_GORE") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_GENOME_MORE_HATRED") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_ANGRY_GHOST") then kills_needed = kills_needed * 0.8 end
			if GameHasFlagRun("PERK_PICKED_VAMPIRISM") then kills_needed = kills_needed * 0.8 end

			kills_needed = math.floor(kills_needed) - 1

			local remainder = kills_needed - enemies_killed

			local enum = ModSettingGet("grahamsperks.BloodyBonus")
			local cond = false

			if ( enum == 1 ) then
                cond = true
            elseif enum == 2 and (remainder % 5 or remainder < 5) then
                cond = true
            end

			if remainder > 0 and cond == true then
				if remainder == 1 then
					GamePrint("$graham_1killleft" )
				else
					GamePrint(GameTextGet("$graham_killsleft", tostring(remainder)))
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