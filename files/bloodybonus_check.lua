local orig_death = death

local function get(comp, field, value)
	local thing = ComponentObjectGetValue2(comp, field, value)
	ComponentObjectSetValue2(comp, field, value, 0)
	return thing
end
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)
	if GameHasFlagRun("PERK_PICKED_GRAHAM_TRICK_BETRAYAL") and EntityHasTag(entity_thats_responsible, "player_unit") == false and entity_thats_responsible ~= 0 and entity_thats_responsible ~= me then
		local stacks = math.min(5, GameGetGameEffectCount(EntityGetClosestWithTag(x, y, "player_unit"), "EXTRA_MONEY_TRICK_KILL"))
		do_money_drop( 2 * (2 ^ stacks + 1), true )
		-- little light effect
		local eid = EntityCreateNew()
		EntityApplyTransform(eid, x, y)
		EntityAddComponent2(eid, "SpriteComponent", {
			image_file="mods/grahamsperks/files/entities/betrayal.png",
			emissive=true,
			has_special_scale=true,
			special_scale_x=1.5,
			special_scale_y=1.5,
			alpha=0.8,
			offset_x=16.5,
			offset_y=16.5,
		})
		EntityAddComponent2(eid, "SpriteComponent", {
			image_file="data/particles/fog_of_war_hole.xml",
			fog_of_war_hole=true,
			has_special_scale=true,
			special_scale_x=4,
			special_scale_y=4,
			offset_x=16.5,
			offset_y=16.5,
		})
		EntityAddComponent2(eid, "LifetimeComponent", {
			lifetime=120,
			fade_sprites=true,
		})
	else
		orig_death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	end

	if GameHasFlagRun("PERK_PICKED_GRAHAM_REPOSSESSION") then
		local player = EntityGetClosestWithTag(x, y, "player_unit")
		-- find nearby projectiles
		local projectiles = EntityGetInRadiusWithTag(x, y, 500, "projectile") or {}
		for i = 1, #projectiles do
			local proj = EntityGetFirstComponentIncludingDisabled(projectiles[i], "ProjectileComponent") or {}
			-- if this owns them, make them friendly
			if ComponentGetValue2(proj, "mWhoShot") == me then
				-- make sprites transparent
				local sprites = EntityGetComponent(projectiles[i], "SpriteComponent") or {}
				for k = 1, #sprites do
					ComponentSetValue2(sprites[k], "alpha", 0)
				end
				-- weaken particles
				local particles = EntityGetComponent(projectiles[i], "ParticleEmitterComponent") or {}
				for k = 1, #particles do
					ComponentSetValue2(particles[k], "create_real_particles", false)
					ComponentSetValue2(particles[k], "emitted_material_name", "spark_green")
				end
				local damage = ComponentGetValue2(proj, "damage") +
					get(proj, "damage_by_type", "melee") +
					get(proj, "damage_by_type", "projectile") +
					get(proj, "damage_by_type", "explosion") * 0.35 +
					get(proj, "damage_by_type", "electricity") +
					get(proj, "damage_by_type", "fire") +
					get(proj, "damage_by_type", "drill") +
					get(proj, "damage_by_type", "slice") +
					get(proj, "damage_by_type", "ice") +
					get(proj, "damage_by_type", "physics_hit") +
					get(proj, "damage_by_type", "radioactive") +
					get(proj, "damage_by_type", "poison") +
					get(proj, "damage_by_type", "overeating") +
					get(proj, "damage_by_type", "curse") +
					get(proj, "damage_by_type", "holy") +
					get(proj, "config_explosion", "damage") * 0.35
				ComponentSetValue2(proj, "damage", 0)
				ComponentObjectSetValue2(proj, "damage_by_type", "healing", math.min(-0.08, damage * -0.75))

				EntityAddComponent2(projectiles[i], "SpriteComponent", {
					image_file="mods/grahamsperks/files/entities/repossession_heal.png",
					emissive=true,
					additive=true,
					alpha=0.8,
					offset_x=3.5,
					offset_y=3.5,
				})
				EntityAddComponent2(projectiles[i], "AudioComponent", {
					file="data/audio/Desktop/projectiles.bank",
					event_root="player_projectiles/bullet_heal",
				})
				local part = EntityAddComponent2(projectiles[i], "ParticleEmitterComponent", {
					emitted_material_name="spark_green",
					x_pos_offset_min=-3,
					x_pos_offset_max=3,
					y_pos_offset_min=-3,
					y_pos_offset_max=3,
					x_vel_min=-1,
					x_vel_max=1,
					y_vel_min=-1,
					y_vel_max=1,
					count_min=1,
					count_max=4,
					lifetime_min=0.5,
					lifetime_max=1.5,
					fade_based_on_lifetime=true,
					create_real_particles=false,
					emit_cosmetic_particles=true,
					emission_interval_min_frames=3,
					emission_interval_max_frames=1,
					velocity_always_away_from_center=14,
					is_emitting=true,
				})
				ComponentSetValue2(part, "gravity", 0, 10)
				ComponentSetValue2(proj, "explosion_dont_damage_shooter", true)
				ComponentSetValue2(proj, "collide_with_shooter_frames", 1)
				ComponentSetValue2(proj, "mWhoShot", player)
				ComponentSetValue2(proj, "mShooterHerdId", StringToHerdId("player"))
				ComponentSetValue2(proj, "friendly_fire", true)
				ComponentSetValue2(proj, "spawn_entity", "")
				ComponentSetValue2(proj, "on_collision_spawn_entity", false)
				ComponentSetValue2(proj, "on_collision_die", true)
				ComponentSetValue2(proj, "on_death_explode", true)
				ComponentSetValue2(proj, "collide_with_entities", true)
				ComponentSetValue2(proj, "lifetime", ComponentGetValue2(proj, "lifetime") * 1.5)
				ComponentSetValue2(proj, "damage_game_effect_entities", "data/entities/particles/heal_effect.xml")
				ComponentObjectSetValue2(proj, "config_explosion", "explosion_sprite", "data/particles/explosion_016_slime.xml")
				ComponentObjectSetValue2(proj, "config_explosion", "create_cell_probability", 0)
				ComponentObjectSetValue2(proj, "config_explosion", "damage", 0)
			end
		end
	end

	if EntityHasTag(entity_thats_responsible, "player_unit") then
		local x2, y2 = EntityGetTransform(entity_thats_responsible)
		local dmg = EntityGetFirstComponent(entity_thats_responsible, "DamageModelComponent")

		if dmg and (ComponentGetValue2(dmg, "hp") * 25 <= 20) then
			SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
			if Random(1, ComponentGetValue2(dmg, "hp") * 250) == 1 and GlobalsGetValue( "GRAHAM_SPAWNED_LUCKY", "0" ) ~= "yes" then
				if HasFlagPersistent("graham_progress_lucky") ~= true then
					AddFlagPersistent("graham_progress_lucky")
					GamePrint( "$graham_perk_unlock" )
					GamePrint( "$graham_perk_unlock_lucky" )
					EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-5)
					EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-5)
					dofile_once("data/scripts/perks/perk.lua")
					perk_spawn(x, y-8, "GRAHAM_LUCKYDAY")
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

				EntityLoad("mods/grahamsperks/files/entities/blood_circle.xml", x2, y2)
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