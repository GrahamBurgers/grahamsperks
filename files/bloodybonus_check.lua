local orig_death = death

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)
	if GameHasFlagRun("PERK_PICKED_GRAHAM_TRICK_BETRAYAL") and EntityHasTag(entity_thats_responsible, "player_unit") == false and entity_thats_responsible ~= 0 and entity_thats_responsible ~= me then
		local stacks = math.min(5, GameGetGameEffectCount(EntityGetClosestWithTag(x, y, "player_unit"), "EXTRA_MONEY_TRICK_KILL"))
		do_money_drop( 2 * (2 ^ stacks + 1), true )
		-- little light effect
		local eid = EntityCreateNew()
		EntityApplyTransform(eid, x, y)
		EntityAddComponent2(eid, "MagicXRayComponent", {
		radius=6,
		})
	else
		orig_death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	end

	if GameHasFlagRun("PERK_PICKED_GRAHAM_REPOSSESSION") then
		local genomecomp = EntityGetFirstComponent(entity_thats_responsible, "GenomeDataComponent")
		local herd = 0
		if genomecomp ~= nil then
			herd = ComponentGetValue2(genomecomp, "herd_id")
		end
		-- find nearby projectiles
		local projectiles = EntityGetInRadiusWithTag(x, y, 500, "projectile") or {}
		for i = 1, #projectiles do
			local comps = EntityGetComponent(projectiles[i], "ProjectileComponent") or {}
			local yes = false
			-- if this owns them, make them friendly
			for j = 1, #comps do
				if ComponentGetValue2(comps[j], "mWhoShot") == me then
					ComponentSetValue2(comps[j], "explosion_dont_damage_shooter", true)
					ComponentSetValue2(comps[j], "mWhoShot", entity_thats_responsible)
					ComponentSetValue2(comps[j], "mShooterHerdId", herd)
					ComponentSetValue2(comps[j], "never_hit_player", true)
					-- don't die from acid balls
					ComponentObjectSetValue2(comps[j], "config_explosion", "create_cell_probability", 0)
					yes = true
				end
			end
			-- make sprites transparent
			if yes == true then
				local sprites = EntityGetComponent(projectiles[i], "SpriteComponent") or {}
				for k = 1, #sprites do
					local alpha = ComponentGetValue2(sprites[k], "alpha") or 1
					ComponentSetValue2(sprites[k], "alpha", alpha / 4)
				end
			end
			-- weaken particles
			local particles = EntityGetComponent(projectiles[i], "ParticleEmitterComponent") or {}
			for k = 1, #particles do
				ComponentSetValue2(particles[k], "create_real_particles", false)
			end
		end
	end
	
	if EntityHasTag(entity_thats_responsible, "player_unit") then

		local x, y = EntityGetTransform(entity_thats_responsible)

		local damagemodels = EntityGetComponent( entity_thats_responsible, "DamageModelComponent" )
		local health = 0
		if( damagemodels ~= nil ) then
			for i,v in ipairs(damagemodels) do
				maxhealth = 25 * tonumber( ComponentGetValue2( v, "max_hp" ) )
				health = 25 * tonumber( ComponentGetValue2( v, "hp" ) )
				break
			end
		end

		if health <= 20 then
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

			local remainder = tonumber( GlobalsGetValue("GRAHAM_BLOODY_BONUS_KILLS", "20") ) - 1
			GlobalsSetValue("GRAHAM_BLOODY_BONUS_KILLS", tostring(remainder))

			local enum = ModSettingGet("grahamsperks.BloodyBonus") or 2
			local cond = false

			if ( enum == 1 ) then
                cond = true
            elseif enum == 2 and (remainder % 5 == 0 or remainder < 5) then
                cond = true
            end

			if remainder > 0 and cond == true then
				if remainder == 1 then
					GamePrint("$graham_1killleft" )
				else
					GamePrint(GameTextGet("$graham_killsleft", tostring(remainder)))
				end
			end

			if remainder <= 0 and GlobalsGetValue("GRAHAM_SPAWN_BLOODY_CHEST", "0") ~= "1" then
				GlobalsSetValue("GRAHAM_SPAWN_BLOODY_CHEST", "1")
				SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
				local message = "$graham_bloodied_0" .. tostring( Random(1,9) )

				EntityLoad("mods/grahamsperks/files/entities/blood_circle.xml", x, y)
				GamePrintImportant( message, "$graham_bloodied_desc" )

				local perk = EntityGetWithTag("perk_entity")
				for i = 1, #perk do
					local ui = EntityGetFirstComponent(perk[i], "UIIconComponent")
					if ui then
						local current = ComponentGetValue2(ui, "icon_sprite_file")
						if current == "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus.png" then
							ComponentSetValue2(ui, "icon_sprite_file", "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus_on.png")
						end
					end
				end
			end
		end
	end
end