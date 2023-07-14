---@diagnostic disable: undefined-global, lowercase-global
local to_insert = {
	{
		id                  = "GRAHAM_MIST_SWEET",
		name                = "$graham_name_mist_sweet",
		description         = "$graham_desc_mist_sweet",
		sprite              = "mods/grahamsperks/files/spells/mist_sweet.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.6,0.8,1.0,1.5",
		price               = 80,
		mana                = 120,
		max_uses            = 8,
		related_projectiles = { "mods/grahamsperks/files/spells/mist_sweet.xml" },
		action              = function()
			current_reload_time = current_reload_time + 60
			add_projectile("mods/grahamsperks/files/spells/mist_sweet.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
		end,
	},
	{
		id                  = "GRAHAM_MATERIAL_PURE",
		name                = "$graham_name_material_pure",
		description         = "$graham_desc_material_pure",
		sprite              = "mods/grahamsperks/files/spells/material_pure.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.5,0.7,0.9,1.1",
		price               = 120,
		max_uses            = 250,
		mana                = 0,
		sound_loop_tag      = "sound_spray",
		related_projectiles = { "mods/grahamsperks/files/spells/material_pure.xml" }, -- yes vanilla sets this for materials too
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/material_pure.xml")
			c.fire_rate_wait = c.fire_rate_wait - 5
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},
	{
		id                  = "GRAHAM_MATERIAL_RADIOACTIVE",
		name                = "$graham_name_material_radioactive",
		description         = "$graham_desc_material_radioactive",
		sprite              = "mods/grahamsperks/files/spells/material_radioactive.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "2,3,4",
		spawn_probability   = "2.2,2.6,3.0",
		price               = 20,
		mana                = 5,
		sound_loop_tag      = "sound_spray",
		related_projectiles = { "mods/grahamsperks/files/spells/material_radioactive.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/material_radioactive.xml")
			c.game_effect_entities = c.game_effect_entities .. "mods/grahamsperks/files/entities/effect_apply_toxic.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 20
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 15
		end,
	},
	{
		id                  = "GRAHAM_COFFEE",
		name                = "$graham_name_coffee",
		description         = "$graham_desc_coffee",
		sprite              = "mods/grahamsperks/files/spells/coffee.png",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "1,2,3,5",
		spawn_probability   = "0.4,0.8,0.4,1.0",
		price               = 320,
		max_uses            = 1,
		mana                = 100,
		never_unlimited     = true,
		related_projectiles = { "mods/grahamsperks/files/entities/coffee.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/entities/coffee.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},
	{
		id                     = "GRAHAM_ROT",
		name                   = "$graham_name_rot",
		description            = "$graham_desc_rot",
		sprite                 = "mods/grahamsperks/files/spells/rot.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3,4",
		spawn_probability      = "0.4,0.4,0.4,0.4,0.4",
		price                  = 150,
		mana                   = 20,
		related_extra_entities = { "mods/grahamsperks/files/spells/rot.xml,data/entities/particles/tinyspark_green.xml," },
		action                 = function()
			c.extra_entities = c.extra_entities ..
				"mods/grahamsperks/files/spells/rot.xml,data/entities/particles/tinyspark_green.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 10
			draw_actions(1, true)
		end,
	},
	{
		id                     = "GRAHAM_EXTINGUISHER",
		name                   = "$graham_name_extinguisher",
		description            = "$graham_desc_extinguisher",
		sprite                 = "mods/grahamsperks/files/spells/extinguisher.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3,4",
		spawn_probability      = "1,0.8,0.5,0.2,0.1",
		price                  = 100,
		mana                   = 3,
		related_extra_entities = { "mods/grahamsperks/files/spells/extinguisher.xml," },
		action                 = function()
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/extinguisher.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 6
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_WOOD",
		name                = "$graham_name_wood",
		description         = "$graham_desc_wood",
		sprite              = "mods/grahamsperks/files/spells/wood.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,5",
		spawn_probability   = "0.8,0.8,0.8,0.8",
		price               = 10,
		mana                = 5,
		related_projectiles = { "mods/grahamsperks/files/spells/wood.xml" },
		action              = function()
			current_reload_time = current_reload_time + 2
			add_projectile("mods/grahamsperks/files/spells/wood.xml")
		end,
	},
	{
		id                  = "GRAHAM_ORB_BLUE",
		name                = "$graham_name_orb_blue",
		description         = "$graham_desc_orb_blue",
		sprite              = "mods/grahamsperks/files/spells/orb_blue.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5",
		spawn_probability   = "0.4,0.5,0.6,0.7,1.8",
		price               = 140,
		mana                = 10,
		--max_uses = 100,
		related_projectiles = { "mods/grahamsperks/files/spells/orb_blue.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 9
			add_projectile("mods/grahamsperks/files/spells/orb_blue.xml")
		end,
	},
	{
		id                  = "GRAHAM_ORB_BLUE_TIMER",
		name                = "$graham_name_orb_blue_timer",
		description         = "$graham_desc_orb_blue_timer",
		sprite              = "mods/grahamsperks/files/spells/orb_blue_timer.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5",
		spawn_probability   = "0.6,0.7,0.8,0.9,1.0",
		price               = 140,
		mana                = 15,
		--max_uses = 100,
		related_projectiles = { "mods/grahamsperks/files/spells/orb_blue.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 9
			add_projectile_trigger_timer("mods/grahamsperks/files/spells/orb_blue.xml", 160, 1)
		end,
	},
	{
		id                  = "GRAHAM_SPARK_BOLT",
		name                = "$graham_name_spark_bolt",
		description         = "$graham_desc_spark_bolt",
		sprite              = "mods/grahamsperks/files/spells/spark_bolt.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "0.5,0.25,0.125",
		price               = 100,
		mana                = -5,
		related_projectiles = { "mods/grahamsperks/files/spells/spark_bolt.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/spark_bolt.xml")
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake - 0.5
			c.spread_degrees = c.spread_degrees + 1.0
			c.damage_critical_chance = c.damage_critical_chance - 5
		end,
	},
	{
		id                  = "GRAHAM_TOUCH_ICE",
		name                = "$graham_name_touch_ice",
		description         = "$graham_desc_touch_ice",
		sprite              = "mods/grahamsperks/files/spells/touch_ice.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4,5,6,7,10",
		spawn_probability   = "0.1,0.1,0.1,0.1,0.2,0.3,0.4,0.8",
		price               = 420,
		mana                = 280,
		max_uses            = 5,
		related_projectiles = { "mods/grahamsperks/files/spells/touch_ice.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/touch_ice.xml")
		end
	},
	{
		id                = "GRAHAM_MANAHEART",
		name              = "$graham_name_manaheart",
		description       = "$graham_desc_manaheart",
		sprite            = "mods/grahamsperks/files/spells/manaheart.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "1,1,0.6,0.6,1,1",
		price             = 200,
		mana              = -240,
		action            = function()
			current_reload_time = current_reload_time + 10
			draw_actions(1, true)
			if reflecting then return end

			local AMOUNT = 60

			local me = GetUpdatedEntityID()
			local inv_comp = EntityGetFirstComponentIncludingDisabled(me, "Inventory2Component")
			if inv_comp ~= nil then
				me = ComponentGetValue2(inv_comp, "mActiveItem")
			end

			local comp = EntityGetFirstComponentIncludingDisabled(me, "AbilityComponent") or 0
			if comp ~= 0 then
				ComponentSetValue2(comp, "mana_max", ComponentGetValue2(comp, "mana_max") - AMOUNT)
				if EntityGetComponent(me, "LuaComponent", "mana_debt_script") == nil then
					EntityAddComponent2(me, "LuaComponent", {
						_tags="mana_debt_script,enabled_in_hand,enabled_in_world,enabled_in_inventory",
						script_source_file = "mods/grahamsperks/files/scripts/mana_heartbreak.lua",
						execute_every_n_frame = 15,
					})
				end

				local storage = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "mana_debt")
				if storage ~= nil then
					ComponentSetValue2(storage, "value_int", ComponentGetValue2(storage, "value_int") + AMOUNT)
				else
					EntityAddComponent2(me, "VariableStorageComponent", {
						_tags="mana_debt,enabled_in_hand,enabled_in_world",
						value_int=AMOUNT
					})
				end
			end
		end,
	},
	{
		id                = "GRAHAM_CRIT_DOWN",
		name              = "$graham_name_crit_down",
		description       = "$graham_desc_crit_down",
		sprite            = "mods/grahamsperks/files/spells/critminus.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "0.1,0.4,0.4,0.4,0.4",
		price             = 140,
		mana              = 4,
		--max_uses = 50,
		action            = function()
			c.damage_critical_chance = c.damage_critical_chance - 50
			c.damage_projectile_add = c.damage_projectile_add + 0.4
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_CIRCLE_SWEET",
		name                = "$graham_name_circle_sweet",
		description         = "$graham_desc_circle_sweet",
		sprite              = "mods/grahamsperks/files/spells/circle_sweet.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.6,1,0.6,0.6",
		price               = 180,
		mana                = 100,
		max_uses            = 2,
		related_projectiles = { "mods/grahamsperks/files/spells/circle_sweet.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/circle_sweet.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id                  = "GRAHAM_CIRCLE_ANGY",
		name                = "$graham_name_circle_angy",
		description         = "$graham_desc_circle_angy",
		sprite              = "mods/grahamsperks/files/spells/circle_angy.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.4,0.4,1,0.4",
		price               = 160,
		mana                = 120,
		max_uses            = 4,
		related_projectiles = { "mods/grahamsperks/files/spells/circle_angy.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/circle_angy.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
		end,
	},
	{
		id                  = "GRAHAM_CIRCLE_DULLED",
		name                = "$graham_name_circle_dulled",
		description         = "$graham_desc_circle_dulled",
		sprite              = "mods/grahamsperks/files/spells/circle_dulled.png",
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.2,0.2,0.6,0.2",
		price               = 160,
		mana                = 120,
		max_uses            = 2,
		related_projectiles = { "mods/grahamsperks/files/spells/circle_dulled.xml" },
		action              = function()
			SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
			if Random(1, 2) == 1 then
				add_projectile("mods/grahamsperks/files/spells/circle_lava.xml")
			else
				add_projectile("mods/grahamsperks/files/spells/circle_acid.xml")
			end
			c.fire_rate_wait = c.fire_rate_wait + 80
		end,
	},
	{
		id                = "GRAHAM_UMBRELLA",
		name              = "$graham_name_umbrella",
		description       = "$graham_desc_umbrella",
		sprite            = "mods/grahamsperks/files/spells/umbrella.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "1,1,0.3,0.3,0.3",
		price             = 120,
		mana              = 5,
		custom_xml_file   = "mods/grahamsperks/files/spells/umbrella.xml",
		action            = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end,
	},
	{
		id                = "GRAHAM_UNBRELLA",
		name              = "$graham_name_unbrella",
		description       = "$graham_desc_unbrella",
		sprite            = "mods/grahamsperks/files/spells/unbrella.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "0.6,0.6,0.1,0.1,0.1",
		price             = 120,
		mana              = 5,
		custom_xml_file   = "mods/grahamsperks/files/spells/unbrella.xml",
		action            = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end,
	},
	{
		id                = "GRAHAM_GRAB_BAG",
		name              = "$graham_name_grab_bag",
		description       = "$graham_desc_grab_bag",
		sprite            = "mods/grahamsperks/files/spells/grab_bag.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5",
		spawn_probability = "0.5,0.6,0.7,0.8,0.9",
		price             = 140,
		mana              = 20,
		--max_uses = 50,
		custom_xml_file   = "data/entities/misc/custom_cards/electric_charge.xml",
		action            = function()
			c.damage_projectile_add = c.damage_projectile_add - 0.16
			c.damage_fire_add = c.damage_fire_add + 0.04
			c.damage_ice_add = c.damage_ice_add + 0.04
			c.damage_slice_add = c.damage_slice_add + 0.04
			c.damage_curse_add = c.damage_curse_add + 0.04
			c.damage_drill_add = c.damage_drill_add + 0.04
			c.damage_electricity_add = c.damage_electricity_add + 0.04
			c.damage_explosion_add = c.damage_explosion_add + 0.04
			c.damage_melee_add = c.damage_melee_add + 0.04
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_SNUB",
		name                = "$graham_name_snub",
		description         = "$graham_desc_snub",
		sprite              = "mods/grahamsperks/files/spells/snub.png",
		type                = ACTION_TYPE_UTILITY,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "0.6,1.2,0.4,0.8,0.2,0.4,0.1",
		price               = 140,
		mana                = 100,
		related_projectiles = { "mods/grahamsperks/files/entities/snub.xml" },
		action              = function()
			if reflecting then return end

			local entity_who_shot = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity_who_shot)
			local entity_id = EntityLoad("mods/grahamsperks/files/effects/snub_invis.xml", x, y)
			EntityAddChild(entity_who_shot, entity_id)
			entity_id = EntityLoad("mods/grahamsperks/files/effects/snub_blind.xml", x, y)
			EntityAddChild(entity_who_shot, entity_id)
			EntityAddRandomStains(entity_who_shot, CellFactory_GetType("graham_unstainer"), 400)
			add_projectile("mods/grahamsperks/files/entities/snub.xml")
		end,
	},
	{
		id                  = "GRAHAM_TELEPORT",
		name                = "$graham_name_teleport",
		description         = "$graham_desc_teleport",
		sprite              = "mods/grahamsperks/files/spells/teleport.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3",
		spawn_probability   = "0.8,0.6,0.4,0.2",
		price               = 180,
		mana                = 60,
		custom_xml_file     = "mods/grahamsperks/files/spells/teleport_fast_card.xml",
		related_projectiles = { "mods/grahamsperks/files/spells/teleport_fast.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 35
			if refecting then return end
			add_projectile("mods/grahamsperks/files/spells/teleport_fast.xml")
		end,
	},
	{
		id                = "GRAHAM_TOGGLER",
		name              = "$graham_name_toggler",
		description       = "$graham_desc_toggler",
		sprite            = "mods/grahamsperks/files/spells/toggler.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "10", -- MANA_REDUCE
		spawn_probability = "0.2", -- MANA_REDUCE
		price             = 120,
		mana              = 0,
		action            = function()
			current_reload_time = current_reload_time + 10
			if reflecting then return end -- technically means reflecting wont catch the draw

			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE", "null"))
			if (toggle ~= 1) and (toggle ~= 0) then GamePrint("$graham_enable_redblue") end
			if (toggle == 0) then
				toggle = 1
				GamePrint("$graham_toggle_blue")
			else
				toggle = 0
				GamePrint("$graham_toggle_red")
			end
			toggle = tostring(toggle)
			GlobalsSetValue("GRAHAM_TOGGLE", toggle)
			draw_actions(1, true)
		end,
	},
	{
		id                = "GRAHAM_TOGGLER2",
		name              = "$graham_name_toggler2",
		description       = "$graham_desc_toggler2",
		sprite            = "mods/grahamsperks/files/spells/toggler2.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "10", -- MANA_REDUCE
		spawn_probability = "0.2", -- MANA_REDUCE
		price             = 120,
		mana              = 0,
		action            = function()
			current_reload_time = current_reload_time + 10
			if reflecting then return end

			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE2", "null"))
			if (toggle ~= 1) and (toggle ~= 0) then GamePrint("$graham_enable_greenyellow") end
			if (toggle == 0) then
				toggle = 1
				GamePrint("$graham_toggle_yellow")
			else
				toggle = 0
				GamePrint("$graham_toggle_green")
			end
			toggle = tostring(toggle)
			GlobalsSetValue("GRAHAM_TOGGLE2", toggle)

			draw_actions(1, true)
		end,
	},
	{
		id                = "GRAHAM_TOGGLEROFF",
		name              = "$graham_name_toggleroff",
		description       = "$graham_desc_toggleroff",
		sprite            = "mods/grahamsperks/files/spells/toggler3.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "10", -- MANA_REDUCE
		spawn_probability = "0.2", -- MANA_REDUCE
		price             = 120,
		mana              = 0,
		action            = function()
			current_reload_time = current_reload_time + 20
			if reflecting then return end

			local chatspam = GlobalsGetValue("GRAHAM_TOGGLE", "null")
			local chatspam2 = GlobalsGetValue("GRAHAM_TOGGLE2", "null")

			if (chatspam ~= "null") or (chatspam2 ~= "null") then GamePrint("$graham_toggle_disable") end
			GlobalsSetValue("GRAHAM_TOGGLE", "null")
			GlobalsSetValue("GRAHAM_TOGGLE2", "null")

			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLE_BLUE",
		name                = "$graham_name_toggle_blue",
		description         = "$graham_desc_toggle_blue",
		sprite              = "mods/grahamsperks/files/spells/if_blue.png",
		spawn_requires_flag = "card_unlocked_maths",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "10", -- MANA_REDUCE
		spawn_probability   = "0.2", -- MANA_REDUCE
		price               = 100,
		mana                = 0,
		action              = function(recursion_level, iteration)
			if reflecting then return end

			local endpoint = -1
			local elsepoint = -1
			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE", "null"))
			local doskip = true

			if (toggle == 1) then
				doskip = false
			end

			if (#deck > 0) then
				for i, v in ipairs(deck) do
					if (v ~= nil) then
						if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
							endpoint = -1
							break
						end

						if (v.id == "IF_ELSE") then
							endpoint = i
							elsepoint = i
						end

						if (v.id == "IF_END") then
							endpoint = i
							break
						end
					end
				end

				local envelope_min = 1
				local envelope_max = 1

				if doskip then
					if (elsepoint > 0) then
						envelope_max = elsepoint
					elseif (endpoint > 0) then
						envelope_max = endpoint
					end

					for i = envelope_min, envelope_max do
						local v = deck[envelope_min]

						if (v ~= nil) then
							table.insert(discarded, v)
							table.remove(deck, envelope_min)
						end
					end
				else
					if (elsepoint > 0) then
						envelope_min = elsepoint

						if (endpoint > 0) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end

						for i = envelope_min, envelope_max do
							local v = deck[envelope_min]

							if (v ~= nil) then
								table.insert(discarded, v)
								table.remove(deck, envelope_min)
							end
						end
					end
				end
			end

			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLE_RED",
		name                = "$graham_name_toggle_red",
		description         = "$graham_desc_toggle_red",
		sprite              = "mods/grahamsperks/files/spells/if_red.png",
		spawn_requires_flag = "card_unlocked_maths",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "10", -- MANA_REDUCE
		spawn_probability   = "0.2", -- MANA_REDUCE
		price               = 100,
		mana                = 0,
		action              = function(recursion_level, iteration)
			if reflecting then return end

			local endpoint = -1
			local elsepoint = -1
			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE", "null"))
			local doskip = true

			if (toggle == 0) then
				doskip = false
			end

			if (#deck > 0) then
				for i, v in ipairs(deck) do
					if (v ~= nil) then
						if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
							endpoint = -1
							break
						end

						if (v.id == "IF_ELSE") then
							endpoint = i
							elsepoint = i
						end

						if (v.id == "IF_END") then
							endpoint = i
							break
						end
					end
				end

				local envelope_min = 1
				local envelope_max = 1

				if doskip then
					if (elsepoint > 0) then
						envelope_max = elsepoint
					elseif (endpoint > 0) then
						envelope_max = endpoint
					end

					for i = envelope_min, envelope_max do
						local v = deck[envelope_min]

						if (v ~= nil) then
							table.insert(discarded, v)
							table.remove(deck, envelope_min)
						end
					end
				else
					if (elsepoint > 0) then
						envelope_min = elsepoint

						if (endpoint > 0) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end

						for i = envelope_min, envelope_max do
							local v = deck[envelope_min]

							if (v ~= nil) then
								table.insert(discarded, v)
								table.remove(deck, envelope_min)
							end
						end
					end
				end
			end

			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLE_YELLOW",
		name                = "$graham_name_toggle_yellow",
		description         = "$graham_desc_toggle_yellow",
		sprite              = "mods/grahamsperks/files/spells/if_yellow.png",
		spawn_requires_flag = "card_unlocked_maths",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "10", -- MANA_REDUCE
		spawn_probability   = "0.2", -- MANA_REDUCE
		price               = 100,
		mana                = 0,
		action              = function(recursion_level, iteration)
			if reflecting then return end

			local endpoint = -1
			local elsepoint = -1
			local entity_id = GetUpdatedEntityID()
			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE2", "null"))
			local doskip = true

			if (toggle == 1) then
				doskip = false
			end

			if (#deck > 0) then
				for i, v in ipairs(deck) do
					if (v ~= nil) then
						if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
							endpoint = -1
							break
						end

						if (v.id == "IF_ELSE") then
							endpoint = i
							elsepoint = i
						end

						if (v.id == "IF_END") then
							endpoint = i
							break
						end
					end
				end

				local envelope_min = 1
				local envelope_max = 1

				if doskip then
					if (elsepoint > 0) then
						envelope_max = elsepoint
					elseif (endpoint > 0) then
						envelope_max = endpoint
					end

					for i = envelope_min, envelope_max do
						local v = deck[envelope_min]

						if (v ~= nil) then
							table.insert(discarded, v)
							table.remove(deck, envelope_min)
						end
					end
				else
					if (elsepoint > 0) then
						envelope_min = elsepoint

						if (endpoint > 0) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end

						for i = envelope_min, envelope_max do
							local v = deck[envelope_min]

							if (v ~= nil) then
								table.insert(discarded, v)
								table.remove(deck, envelope_min)
							end
						end
					end
				end
			end

			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLE_GREEN",
		name                = "$graham_name_toggle_green",
		description         = "$graham_desc_toggle_green",
		sprite              = "mods/grahamsperks/files/spells/if_green.png",
		spawn_requires_flag = "card_unlocked_maths",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "10", -- MANA_REDUCE
		spawn_probability   = "0.2", -- MANA_REDUCE
		price               = 100,
		mana                = 0,
		action              = function(recursion_level, iteration)
			if reflecting then return end

			local endpoint = -1
			local elsepoint = -1
			local entity_id = GetUpdatedEntityID()
			local comp = EntityGetFirstComponent(entity_id, "DamageModelComponent")
			local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE2", "null"))
			local doskip = true
			if (toggle == 0) then
				doskip = false
			end

			if (#deck > 0) then
				for i, v in ipairs(deck) do
					if (v ~= nil) then
						if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
							endpoint = -1
							break
						end

						if (v.id == "IF_ELSE") then
							endpoint = i
							elsepoint = i
						end

						if (v.id == "IF_END") then
							endpoint = i
							break
						end
					end
				end

				local envelope_min = 1
				local envelope_max = 1

				if doskip then
					if (elsepoint > 0) then
						envelope_max = elsepoint
					elseif (endpoint > 0) then
						envelope_max = endpoint
					end

					for i = envelope_min, envelope_max do
						local v = deck[envelope_min]

						if (v ~= nil) then
							table.insert(discarded, v)
							table.remove(deck, envelope_min)
						end
					end
				else
					if (elsepoint > 0) then
						envelope_min = elsepoint

						if (endpoint > 0) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end

						for i = envelope_min, envelope_max do
							local v = deck[envelope_min]

							if (v ~= nil) then
								table.insert(discarded, v)
								table.remove(deck, envelope_min)
							end
						end
					end
				end
			end

			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_HEATWAVE",
		name                = "$graham_name_mini_heatwave",
		description         = "$graham_desc_mini_heatwave",
		sprite              = "mods/grahamsperks/files/spells/mini_heatwave.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_heatwave.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_FREEZEFIELD",
		name                = "$graham_name_mini_freezefield",
		description         = "$graham_desc_mini_freezefield",
		sprite              = "mods/grahamsperks/files/spells/mini_freezefield.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_freezefield.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_DISSOLVEPOWDERS",
		name                = "$graham_name_mini_dissolvepowders",
		description         = "$graham_desc_mini_dissolvepowders",
		sprite              = "mods/grahamsperks/files/spells/mini_dissolvepowders.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_dissolvepowders.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_ATTRACTGOLD",
		name                = "$graham_name_mini_attractgold",
		description         = "$graham_desc_mini_attractgold",
		sprite              = "mods/grahamsperks/files/spells/mini_attractgold.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_attractgold.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_ELECTRICITY",
		name                = "$graham_name_mini_electricity",
		description         = "$graham_desc_mini_electricity",
		sprite              = "mods/grahamsperks/files/spells/mini_electricity.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_electricity.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_NOKNOCKBACK",
		name                = "$graham_name_mini_noknockback",
		description         = "$graham_desc_mini_noknockback",
		sprite              = "mods/grahamsperks/files/spells/mini_noknockback.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_noknockback.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_MINI_MIDASMEAT",
		name                = "$graham_name_mini_midasmeat",
		description         = "$graham_desc_mini_midasmeat",
		sprite              = "mods/grahamsperks/files/spells/mini_midasmeat.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,5,6",
		spawn_probability   = "0.3,1,0.5,1,1",
		spawn_requires_flag = "graham_minimimic_killed",
		price               = 180,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/mini_midasmeat.xml",
		action              = function()
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_BUBBLES",
		name                = "$graham_name_bubbles",
		description         = "$graham_desc_bubbles",
		sprite              = "mods/grahamsperks/files/spells/bubbles.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",   -- BUBBLESHOT
		spawn_probability   = "0.8,0.8,0.8,0.2", -- BUBBLESHOT
		price               = 100,
		mana                = 30,
		--max_uses = 120,
		related_projectiles = { "mods/grahamsperks/files/spells/bubble_toxic.xml", 3 },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/bubble_fire.xml")
			add_projectile("mods/grahamsperks/files/spells/bubble_elec.xml")
			add_projectile("mods/grahamsperks/files/spells/bubble_toxic.xml")
			c.fire_rate_wait = c.fire_rate_wait + 14
			c.dampening = 0.1
			c.spread_degrees = c.spread_degrees + 9.0
		end,
	},
	{
		id                     = "GRAHAM_ORBIT_BLUE",
		name                   = "$graham_name_ominousorbit",
		description            = "$graham_desc_ominousorbit",
		sprite                 = "mods/grahamsperks/files/spells/orbit_blue.png",
		spawn_requires_flag    = "card_unlocked_dragon",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,4,5",     -- GRAVITY_FIELD_ENEMY
		spawn_probability      = "0.5,0.2,0.8,0.4,0.2", -- GRAVITY_FIELD_ENEMY
		price                  = 140,
		mana                   = 50,
		related_extra_entities = { "data/entities/misc/orbit_blue.xml" },
		action                 = function()
			c.speed_multiplier = c.speed_multiplier * 0.8
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/orbit_blue.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_VEIN",
		name                = "$graham_name_vein",
		description         = "$graham_desc_vein",
		sprite              = "mods/grahamsperks/files/spells/vein.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "1,0.5,0.25,0.125",
		spawn_requires_flag = "card_unlocked_mestari",
		price               = 80,
		mana                = 2,
		custom_xml_file     = "mods/grahamsperks/files/spells/vein.xml",
		action              = function()
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_CURSE_SHOT",
		name                = "$graham_name_curse_shot",
		description         = "$graham_desc_curse_shot",
		sprite              = "mods/grahamsperks/files/spells/curse_shot.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",   -- BUBBLESHOT
		spawn_probability   = "0.8,0.8,0.8,0.2", -- BUBBLESHOT
		price               = 100,
		mana                = 30,
		--max_uses = 120,
		related_projectiles = { "mods/grahamsperks/files/spells/curse_shot.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/curse_shot.xml")
			c.fire_rate_wait = c.fire_rate_wait + 2
		end,
	},
	--[[
	this one is eh (i removed some of the assets)
	{
		id          = "GRAHAM_GOLD_BALL",
		name 		= "$graham_name_gold_ball",
		description = "$graham_desc_gold_ball",
		sprite 		= "mods/grahamsperks/files/spells/goldball.png",
		related_projectiles	= {"mods/grahamsperks/files/spells/goldball.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "1,2,3,4", -- BUBBLESHOT
		spawn_probability                 = "0.2,0.8,0.2,0.8", -- BUBBLESHOT
		price = 300,
		mana = 30,
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 60
			add_projectile("mods/grahamsperks/files/spells/goldball.xml")
		end,
	},
]] --
	{
		id                  = "GRAHAM_BREADCRUMB",
		name                = "$graham_name_breadcrumb",
		description         = "$graham_desc_breadcrumb",
		sprite              = "mods/grahamsperks/files/spells/breadcrumb.png",
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4",
		spawn_probability   = "0.4,0.6,0.8,1.0,1.5",
		price               = 160,
		mana                = 20,
		related_projectiles = { "mods/grahamsperks/files/spells/breadcrumb.xml" },
		action              = function()
			current_reload_time = current_reload_time + 60
			c.fire_rate_wait = c.fire_rate_wait + 60
			add_projectile("mods/grahamsperks/files/spells/breadcrumb.xml")
		end,
	},
	{
		id                  = "GRAHAM_QUIVER",
		name                = "$graham_name_quiver",
		description         = "$graham_desc_quiver",
		sprite              = "mods/grahamsperks/files/spells/arrow_ball.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3",
		spawn_probability   = "0.6,0.2,0.6,0.2",
		price               = 80,
		mana                = 20,
		related_projectiles = { "mods/grahamsperks/files/spells/arrow_ball.xml" },
		action              = function()
			current_reload_time = current_reload_time + 5
			c.fire_rate_wait = c.fire_rate_wait + 30
			add_projectile("mods/grahamsperks/files/spells/arrow_ball.xml")
		end,
	},
	{
		id                     = "GRAHAM_CONNECTIONTRAIL",
		name                   = "$graham_name_connectiontrail",
		description            = "$graham_desc_connectiontrail",
		sprite                 = "mods/grahamsperks/files/spells/connectiontrail.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,4,5",
		spawn_probability      = "0.2,0.4,0.6,8",
		price                  = 100,
		mana                   = 25,
		related_extra_entities = { "mods/grahamsperks/files/spells/connection_trail.xml," },
		action                 = function()
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/connection_trail.xml,"
			c.damage_projectile_add = c.damage_projectile_add - 0.12
			c.fire_rate_wait = c.fire_rate_wait + 12
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_BLACKLIGHT_ARROW",
		name                = "$graham_name_blacklight_arrow",
		description         = "$graham_desc_blacklight_arrow",
		sprite              = "mods/grahamsperks/files/spells/blacklight_arrow.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5",     -- BULLET
		spawn_probability   = "0.2,0.2,0.2,0.2,0.2", -- BULLET
		price               = 150,
		mana                = 30,
		--max_uses = -1,
		related_projectiles = { "mods/grahamsperks/files/spells/blacklight_arrow.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/blacklight_arrow.xml")
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.screenshake = c.screenshake + 2
			c.damage_critical_chance = c.damage_critical_chance + 5
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 13.0
		end,
	},
	{
		id                  = "GRAHAM_BLACKLIGHT_ARROW_TRIGGER",
		name                = "$graham_name_blacklight_arrow_trigger",
		description         = "$graham_desc_blacklight_arrow_trigger",
		sprite              = "mods/grahamsperks/files/spells/blacklight_arrow_trigger.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",   -- BULLET
		spawn_probability   = "0.2,0.2,0.2,0.2", -- BULLET
		price               = 150,
		mana                = 40,
		--max_uses = -1,
		related_projectiles = { "mods/grahamsperks/files/spells/blacklight_arrow.xml" },
		action              = function()
			add_projectile_trigger_hit_world("mods/grahamsperks/files/spells/blacklight_arrow.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.screenshake = c.screenshake + 2
			c.damage_critical_chance = c.damage_critical_chance + 5
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 13.0
		end,
	},
	{
		id                  = "GRAHAM_BLACKLIGHT_ARROW_TIMER",
		name                = "$graham_name_blacklight_arrow_timer",
		description         = "$graham_desc_blacklight_arrow_timer",
		sprite              = "mods/grahamsperks/files/spells/blacklight_arrow_timer.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",   -- BULLET
		spawn_probability   = "0.2,0.2,0.2,0.2", -- BULLET
		price               = 150,
		mana                = 40,
		--max_uses = -1,
		related_projectiles = { "mods/grahamsperks/files/spells/blacklight_arrow.xml" },
		action              = function()
			add_projectile_trigger_timer("mods/grahamsperks/files/spells/blacklight_arrow.xml", 20, 1)
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.screenshake = c.screenshake + 2
			c.damage_critical_chance = c.damage_critical_chance + 5
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 13.0
		end,
	},
	{
		id                     = "GRAHAM_STASIS",
		name                   = "$graham_name_stasis",
		description            = "$graham_desc_stasis",
		sprite                 = "mods/grahamsperks/files/spells/stasis.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "0.4,0.6,0.4,0.6",
		price                  = 100,
		mana                   = 8,
		related_extra_entities = { "mods/grahamsperks/files/spells/stasis.xml," },
		action                 = function()
			c.speed_multiplier = c.speed_multiplier * 0
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/stasis.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_RAINBOW",
		name                = "$graham_name_rainbow",
		description         = "$graham_desc_rainbow",
		sprite              = "mods/grahamsperks/files/spells/rainbow.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.6,0.8,1.0,1.5",
		price               = 80,
		max_uses            = 20,
		mana                = 15,
		related_projectiles = { "mods/grahamsperks/files/spells/rainbow.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/rainbow.xml")
		end,
	},
	{
		id                  = "GRAHAM_REDHANDS",
		name                = "$graham_name_redhands",
		description         = "$graham_desc_redhands",
		sprite              = "mods/grahamsperks/files/spells/redhands.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.1,0.2,0.3,0.4",
		price               = 200,
		mana                = 35,
		related_projectiles = { "mods/grahamsperks/files/spells/redhand.xml", 3 },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 40
			current_reload_time = current_reload_time + 20
			add_projectile("mods/grahamsperks/files/spells/redhand.xml")
			add_projectile("mods/grahamsperks/files/spells/redhand.xml")
			add_projectile("mods/grahamsperks/files/spells/redhand.xml")
		end,
	},
	{
		id                  = "GRAHAM_HANDPORTAL",
		name                = "$graham_name_handportal",
		description         = "$graham_desc_handportal",
		sprite              = "mods/grahamsperks/files/spells/hand_portal.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.05,0.1,0.15,0.2",
		price               = 200,
		mana                = 100,
		max_uses            = 8,
		related_projectiles = { "mods/grahamsperks/files/spells/hand_portal.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 40
			add_projectile("mods/grahamsperks/files/spells/hand_portal.xml")
		end,
	},
	{
		id                     = "GRAHAM_GUARDIAN_SHOT",
		name                   = "$graham_name_guardianshot",
		description            = "$graham_desc_guardianshot",
		sprite                 = "mods/grahamsperks/files/spells/guardian.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,10",
		spawn_probability      = "0.6,0.8,1.0,0.5",
		price                  = 200,
		mana                   = 40,
		max_uses               = 10,
		related_extra_entities = { "mods/grahamsperks/files/entities/hitfx_guardian_shot.xml" },
		action                 = function()
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/entities/hitfx_guardian_shot.xml,"
			draw_actions(1, true)
			current_reload_time = current_reload_time + 10
			c.fire_rate_wait = c.fire_rate_wait + 10
		end,
	},
	{
		id                  = "GRAHAM_GLOW_DART",
		name                = "$graham_name_glowdart",
		description         = "$graham_desc_glowdart",
		sprite              = "mods/grahamsperks/files/spells/glow_dart.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "1.2,0.1,0.1,1.2",
		price               = 200,
		mana                = 8,
		related_projectiles = { "mods/grahamsperks/files/spells/glow_dart.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait - 4
			current_reload_time = current_reload_time - 4
			add_projectile("mods/grahamsperks/files/spells/glow_dart.xml")
		end,
	},
	{
		id                  = "GRAHAM_INFERNAL_GLARE",
		name                = "$graham_name_infernalglare",
		description         = "$graham_desc_infernalglare",
		sprite              = "mods/grahamsperks/files/spells/infernal_glare.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4,5",
		spawn_probability   = "1,1,1",
		price               = 100,
		mana                = 60,
		max_uses            = 25,
		related_projectiles = { "mods/grahamsperks/files/spells/infernal_glare_beam.xml", 12 },
		action              = function()
			--[[
			c.fire_rate_wait = c.fire_rate_wait + 33
			if reflecting then
				add_projectile("mods/grahamsperks/files/spells/infernal_glare_beam.xml")
			else
				add_projectile("mods/grahamsperks/files/spells/infernal_glare.xml")
			end
			]]
			--
			for i = 1, 12 do
				add_projectile("mods/grahamsperks/files/spells/infernal_glare_beam.xml")
			end
			c.pattern_degrees = 30
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},
	{
		id                  = "GRAHAM_BARREL",
		name                = "$graham_name_barrel",
		description         = "$graham_desc_barrel",
		sprite              = "mods/grahamsperks/files/spells/barrel.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,2,4",
		spawn_probability   = "0.6,0.6,0.6",
		price               = 130,
		mana                = 80,
		max_uses            = 5,
		related_projectiles = { "mods/grahamsperks/files/spells/barrel.xml" },
		action              = function()
			current_reload_time = current_reload_time + 45
			c.fire_rate_wait = c.fire_rate_wait + 45
			add_projectile("mods/grahamsperks/files/spells/barrel.xml")
		end,
	},
	{
		id                  = "GRAHAM_SACRIFICE",
		name                = "$graham_name_sacrifice",
		description         = "$graham_desc_sacrifice",
		sprite              = "mods/grahamsperks/files/spells/sacrifice.png",
		type                = ACTION_TYPE_UTILITY,
		spawn_requires_flag = "graham_bloodymimic_killed",
		spawn_level         = "2,3,5,6,10",
		spawn_probability   = "0.5,0.25,0.5,0.5,0.3",
		price               = 80,
		mana                = 80,
		action              = function()
			current_reload_time = current_reload_time + 240

			if reflecting then return end
			local player = GetUpdatedEntityID()
			local damagemodels = EntityGetComponent(player, "DamageModelComponent")
			if (damagemodels ~= nil) then
				for i, v in ipairs(damagemodels) do
					local hp = ComponentGetValue2(v, "hp")
					local max_hp = ComponentGetValue2(v, "max_hp")

					if max_hp >= 8 then
						max_hp = max_hp * 0.8
						ComponentSetValue2(v, "max_hp", max_hp)
						if hp > max_hp then
							ComponentSetValue2(v, "hp", max_hp)
						end

						local x, y = EntityGetTransform(player)
						SetRandomSeed(player, GameGetFrameNum())
						local options = { "waterstone.xml", "thunderstone.xml", "stonestone.xml", "brimstone.xml",
							"poopstone.xml" }
						local result = "data/entities/items/pickup/" .. options[Random(1, #options)]
						EntityLoad(result, x, y)

						-- using add_projectile on firestone or thunderstone crashes the game. no idea why
						EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y - 5)
						add_projectile("mods/grahamsperks/files/spells/material_healthium.xml")
					end
				end
			end
		end,
	},
	{
		id                     = "GRAHAM_POWDER_EVAPORATION",
		name                   = "$graham_name_powder_evaporation",
		description            = "$graham_desc_powder_evaporation",
		sprite                 = "mods/grahamsperks/files/spells/powder_evaporation.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3,4",
		spawn_probability      = "0.4,0.4,0.4,0.4,0.4",
		price                  = 150,
		mana                   = 30,
		related_extra_entities = { "mods/grahamsperks/files/spells/powder_evaporation.xml," },
		action                 = function()
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/powder_evaporation.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_HOLY_BULLET",
		name                = "$graham_name_holyshot",
		description         = "$graham_desc_holyshot",
		sprite              = "mods/grahamsperks/files/spells/holy_bullet.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4",
		spawn_probability   = "0.2,0.3,0.4",
		price               = 80,
		mana                = 120,
		related_projectiles = { "mods/grahamsperks/files/spells/holy_bullet.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/holy_bullet.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},
	-- NEW SINCE 1.5
	{
		id                  = "GRAHAM_ROLLOUT",
		name                = "$graham_name_rollout",
		description         = "$graham_desc_rollout",
		sprite              = "mods/grahamsperks/files/spells/rollout.png",
		custom_xml_file     = "mods/grahamsperks/files/spells/rollout_card.xml",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,2,3,4",
		spawn_probability   = "0.4,1,0.5,1",
		price               = 130,
		mana                = 60,
		max_uses            = 12,
		related_projectiles = { "mods/grahamsperks/files/spells/rollout.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 150
			c.damage_critical_chance = c.damage_critical_chance + 5
			add_projectile("mods/grahamsperks/files/spells/rollout.xml")
		end,
	},
	{
		id                  = "GRAHAM_WILLOWISP",
		name                = "$graham_name_willowisp",
		description         = "$graham_desc_willowisp",
		sprite              = "mods/grahamsperks/files/spells/willowisp.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "1,1,1",
		price               = 40,
		mana                = 6,
		related_projectiles = { "mods/grahamsperks/files/spells/willowisp.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait - 6
			add_projectile("mods/grahamsperks/files/spells/willowisp.xml")
		end,
	},
	{
		-- trans rights
		id                  = "GRAHAM_TRANSLOCATION",
		name                = "$graham_name_circle_translocation",
		description         = "$graham_desc_circle_translocation",
		sprite              = "mods/grahamsperks/files/spells/translocation.png",
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "1,2,3,4,5,6",       -- SHIELD_FIELD
		spawn_probability   = "0.2,0.2,0.2,0.6,0.6,0.2", -- SHIELD_FIELD
		price               = 260,
		mana                = 60,
		max_uses            = 6,
		related_projectiles = { "mods/grahamsperks/files/spells/translocation.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/translocation.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
	{
		id                  = "GRAHAM_FOAMARMOR",
		name                = "$graham_name_foamarmor",
		description         = "$graham_desc_foamarmor",
		sprite              = "mods/grahamsperks/files/spells/foamarmor.png",
		custom_xml_file     = "mods/grahamsperks/files/spells/foamarmor.xml",
		type                = ACTION_TYPE_UTILITY,
		spawn_level         = "0,1",
		spawn_probability   = "1,0.5",
		price               = 320,
		mana                = 140,
		max_uses            = 2,
		related_projectiles = { "mods/grahamsperks/files/entities/foamarmor.xml" },
		action              = function()
			if reflecting then return end
			local entity_who_shot = GetUpdatedEntityID()
			local x, y = EntityGetTransform(entity_who_shot)
			local entity_id = EntityLoad("mods/grahamsperks/files/effects/foam_armor.xml", x, y)
			EntityAddChild(entity_who_shot, entity_id)
			add_projectile("mods/grahamsperks/files/entities/foamarmor.xml")

			local comp = EntityGetFirstComponent(entity_who_shot, "DamageModelComponent") or 0
			ComponentSetValue2(comp, "hp", ComponentGetValue2(comp, "hp") + 0.8)
			ComponentSetValue2(comp, "max_hp", ComponentGetValue2(comp, "max_hp") + 0.8)
		end,
	},
	{
		id                  = "GRAHAM_BRAMBALL",
		name                = "$graham_name_bramball",
		description         = "$graham_desc_bramball",
		sprite              = "mods/grahamsperks/files/spells/bramball.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1",
		spawn_probability   = "1,1.5",
		price               = 80,
		mana                = 15,
		related_projectiles = { "mods/grahamsperks/files/spells/bramball.xml" },
		action              = function()
			add_projectile("mods/grahamsperks/files/spells/bramball.xml")
			c.fire_rate_wait = c.fire_rate_wait + 14
		end,
	},
	{
		id                  = "GRAHAM_BRAMBALL_TRIGGER",
		name                = "$graham_name_bramball_trigger",
		description         = "$graham_desc_bramball_trigger",
		sprite              = "mods/grahamsperks/files/spells/bramball_trigger.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1",
		spawn_probability   = "0.8,1",
		price               = 110,
		mana                = 20,
		related_projectiles = { "mods/grahamsperks/files/spells/bramball.xml" },
		action              = function()
			add_projectile_trigger_hit_world("mods/grahamsperks/files/spells/bramball.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 14
		end,
	},
	{
		id                     = "GRAHAM_GOLDEN",
		name                   = "$graham_name_golden",
		description            = "$graham_desc_golden",
		sprite                 = "mods/grahamsperks/files/spells/golden.png",
		spawn_requires_flag    = "card_unlocked_paint",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2",
		spawn_probability      = "0.4,1,0.5",
		price                  = 30,
		mana                   = 0,
		related_extra_entities = { "mods/grahamsperks/files/spells/golden.xml," },
		action                 = function()
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/golden.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLER_ALT",
		name                = "$graham_name_toggler_alt",
		description         = "$graham_desc_toggler_alt",
		sprite              = "mods/grahamsperks/files/spells/toggler_alt.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level       = "10",
		spawn_probability = "0.2",
		price               = 120,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/toggler_alt.xml",
		action              = function()
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLER2_ALT",
		name                = "$graham_name_toggler_alt",
		description         = "$graham_desc_toggler_alt",
		sprite              = "mods/grahamsperks/files/spells/toggler2_alt.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level       = "10",
		spawn_probability = "0.2",
		price               = 120,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/toggler2_alt.xml",
		action              = function()
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOGGLER3_ALT",
		name                = "$graham_name_toggler3_alt",
		description         = "$graham_desc_toggler3_alt",
		sprite              = "mods/grahamsperks/files/spells/toggler3_alt.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level       = "10",
		spawn_probability = "0.2",
		price               = 120,
		mana                = 0,
		custom_xml_file     = "mods/grahamsperks/files/spells/toggler3_alt.xml",
		action              = function()
			draw_actions(1, true)
		end,
	},
	--[[
	{
		id                  = "GRAHAM_ECHO_BUBBLE",
		name                = "$graham_name_echo_bubble",
		description         = "$graham_desc_echo_bubble",
		sprite              = "mods/grahamsperks/files/spells/echo_bubble.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5",
		spawn_probability   = "0.6,0.7,0.8,0.9,1.0",
		price               = 60,
		mana                = 20,
		--max_uses = 100,
		related_projectiles = { "mods/grahamsperks/files/spells/echo_bubble.xml" },
		action              = function()
			current_reload_time = current_reload_time + 30
			add_projectile("mods/grahamsperks/files/spells/echo_bubble.xml")
			c.damage_critical_chance = c.damage_critical_chance + 15
		end,
	},
	]]--
	{
		id                = "GRAHAM_PASSIVES",
		name              = "$graham_name_passives",
		description       = "$graham_desc_passives",
		sprite            = "mods/grahamsperks/files/spells/passives.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4,5",
		spawn_probability = "1,1,1,1,1,1",
		price             = 30,
		mana              = 0,
		custom_xml_file   = "mods/grahamsperks/files/spells/passives.xml",
		action            = function()
			-- does nothing to the projectiles
			current_reload_time = current_reload_time + 5
			draw_actions(1, true)
		end,
	},
	{
		id                     = "GRAHAM_DIVEBOMB",
		name                   = "$graham_name_divebomb",
		description            = "$graham_desc_divebomb",
		sprite                 = "mods/grahamsperks/files/spells/divebomb.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,3,5",
		spawn_probability      = "0.6,1,1",
		price                  = 150,
		mana                   = 18,
		related_extra_entities = { "mods/grahamsperks/files/spells/divebomb.xml," },
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 8
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/divebomb.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                     = "GRAHAM_MIXUP",
		name                   = "$graham_name_mixup",
		description            = "$graham_desc_mixup",
		sprite                 = "mods/grahamsperks/files/spells/mixup.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5",
		spawn_probability      = "0.5,0.5,0.5,0.5",
		price                  = 50,
		mana                   = 24,
		action                 = function()
			draw_actions(1, true)

			if reflecting then
				current_reload_time = current_reload_time - 30
				c.damage_critical_chance = c.damage_critical_chance + 30
			else
				local shooter = EntityGetRootEntity(GetUpdatedEntityID())
				local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
				local activeitem = 0
				if inv2comp then
					activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
				end
				local projs = 0
				local mods  = 0
				if EntityHasTag(activeitem, "wand") then
					local spells = EntityGetAllChildren(activeitem) or {}
					for i, j in ipairs(spells) do
						if EntityHasTag(j, "graham_spelltype_projectile") then
							projs = projs + 1
						elseif EntityHasTag(j, "graham_spelltype_modifier") then
							mods = mods + 1
						end
					end
				end
				if projs > mods then
					current_reload_time = current_reload_time - 30
				else
					c.damage_critical_chance = c.damage_critical_chance + 30
				end
			end
		end,
	},
	{
		id                = "GRAHAM_SLICESHIELD",
		name              = "$graham_name_sliceshield",
		description       = "$graham_desc_sliceshield",
		sprite            = "mods/grahamsperks/files/spells/sliceshield.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4",
		spawn_probability = "0.8,1,0.4,0.4",
		price             = 120,
		mana              = 20,
		custom_xml_file   = "mods/grahamsperks/files/spells/sliceshield.xml",
		action            = function()
			-- does nothing to the projectiles
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	{
		id                     = "GRAHAM_INTENSIFY",
		name                   = "$graham_name_intensify",
		description            = "$graham_desc_intensify",
		sprite                 = "mods/grahamsperks/files/spells/intensify.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5,6",
		spawn_probability      = "1,1,1,1",
		price                  = 250,
		mana                   = 30,
		related_extra_entities = { "mods/grahamsperks/files/spells/intensify.xml," },
		action                 = function()
			current_reload_time = current_reload_time + 12
			c.trail_material_amount = c.trail_material_amount * 2
			c.extra_entities = c.extra_entities .. "mods/grahamsperks/files/spells/intensify.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_INVISIBLE",
		name                = "$graham_name_invisible",
		description         = "$graham_desc_invisible",
		sprite              = "mods/grahamsperks/files/spells/invisible.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,2,5",
		spawn_probability   = "1,1,1",
		price               = 100,
		mana                = 12,
		related_projectiles = { "mods/grahamsperks/files/spells/invisible.xml" },
		action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 4
			add_projectile("mods/grahamsperks/files/spells/invisible.xml")
		end,
	},
	{
		id                = "GRAHAM_VIBRANT_BULB",
		name              = "$graham_name_vibrantbulb",
		description       = "$graham_desc_vibrantbulb",
		sprite            = "mods/grahamsperks/files/spells/vibrantbulb.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "1,1,0.3,0.3,0.3",
		price             = 40,
		mana              = 8,
		custom_xml_file   = "mods/grahamsperks/files/spells/vibrantbulb.xml",
		action            = function()
			-- does nothing to the projectiles
			current_reload_time = current_reload_time - 6
			draw_actions(1, true)
		end,
	},
	{
		id                = "GRAHAM_DIM_BULB",
		name              = "$graham_name_dimbulb",
		description       = "$graham_desc_dimbulb",
		sprite            = "mods/grahamsperks/files/spells/dimbulb.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "1,1,0.3,0.3,0.3",
		price             = 40,
		mana              = 8,
		custom_xml_file   = "mods/grahamsperks/files/spells/dimbulb.xml",
		action            = function()
			-- does nothing to the projectiles
			current_reload_time = current_reload_time - 6
			draw_actions(1, true)
		end,
	},
	{
		id                  = "GRAHAM_TOXIC_POTION",
		name                = "$graham_name_toxic_potion",
		description         = "$graham_desc_toxic_potion",
		sprite              = "mods/grahamsperks/files/spells/toxic_potion.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5",
		spawn_probability   = "1,1,1,1,1",
		price               = 80,
		mana                = 30,
		related_projectiles = { "mods/grahamsperks/files/spells/toxic_potion.xml" },
		action              = function()
			current_reload_time = current_reload_time + 30
			add_projectile("mods/grahamsperks/files/spells/toxic_potion.xml")
		end,
	},
}
for i, v in ipairs(to_insert) do
	table.insert(actions, v)
end
