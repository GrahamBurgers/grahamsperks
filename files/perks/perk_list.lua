---@diagnostic disable: undefined-global, param-type-mismatch
dofile_once("data/scripts/lib/utilities.lua")

local function removechild(who, name)
	local children = EntityGetAllChildren(who) or {}
	for i = 1, #children do
		if EntityGetName(children[i]) == name or EntityHasTag(children[i], name) then
			EntityKill(children[i])
		end
	end
end
local function removelua(who, tag)
	local comps = EntityGetComponentIncludingDisabled(who, "LuaComponent", tag) or {}
	for i = 1, #comps do
		EntityRemoveComponent(who, comps[i])
	end
end
local function removevar(who, tag)
	local comps = EntityGetComponentIncludingDisabled(who, "VariableStorageComponent", tag) or {}
	for i = 1, #comps do
		EntityRemoveComponent(who, comps[i])
	end
end
local function firsteffect(flag)
	local thing = not GameHasFlagRun("graham_firsteffect_" .. flag)
	GameAddFlagRun("graham_firsteffect_" .. flag)
	return thing
end

local to_insert = {
	{
		id = "GRAHAM_HEALTHY_HEARTS",
		ui_name = "$perkname_graham_healthy_hearts",
		ui_description = "$perkdesc_graham_healthy_hearts",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/healthyhearts.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/healthyhearts.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local value = GlobalsGetValue("HEALTHY_HEARTS_HP_MULTIPLIER", "1")
			GlobalsSetValue("HEALTHY_HEARTS_HP_MULTIPLIER", value + 1)
			add_halo_level(entity_who_picked, 1)
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("HEALTHY_HEARTS_HP_MULTIPLIER", 1)
			add_halo_level(entity_who_picked, -1)
		end,
	},
	{
		id = "GRAHAM_SPAWN_ITEMS",
		ui_name = "$perkname_graham_item_lottery",
		ui_description = "$perkdesc_graham_item_lottery",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/itemlottery.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/itemlottery.png",
		one_off_effect = true,
		do_not_remove=true,
		usable_by_enemies = false,
		stackable = STACKABLE_YES,
		not_in_default_perk_pool = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)

			if EntityHasTag(entity_who_picked, "player_unit") and not EntityHasTag(entity_who_picked, "ew_notplayer") then
				local p1 = EntityLoad("data/entities/items/pickup/potion_random_material.xml", x - 30, y)
				local phys1 = EntityGetFirstComponent(p1, "PhysicsBodyCollisionDamageComponent")
				if phys1 then ComponentSetValue2(phys1, "damage_multiplier", 0) end
				local p2 = EntityLoad("data/entities/items/pickup/potion_aggressive.xml", x + 30, y)
				local phys2 = EntityGetFirstComponent(p2, "PhysicsBodyCollisionDamageComponent")
				if phys2 then ComponentSetValue2(phys2, "damage_multiplier", 0) end
				local p3 = EntityLoad("data/entities/items/pickup/powder_stash.xml", x + 15, y)
				local dmg3 = EntityGetFirstComponent(p3, "DamageModelComponent")
				if dmg3 then ComponentSetValue2(dmg3, "max_hp", ComponentGetValue2(dmg3, "max_hp") * 4) end
				if dmg3 then ComponentSetValue2(dmg3, "hp", ComponentGetValue2(dmg3, "hp") * 4) end
				EntityLoad("data/entities/items/wand_level_03.xml", x, y - 30)

				local rx, ry = EntityGetTransform(entity_perk_item)
				SetRandomSeed(rx + 459835, ry + 389636)
				local rock = {
					"data/entities/items/pickup/thunderstone.xml",
					"data/entities/items/pickup/brimstone.xml",
					"data/entities/items/pickup/waterstone.xml",
					"data/entities/items/pickup/safe_haven.xml",
					"mods/grahamsperks/files/pickups/soapstone.xml",
					"mods/grahamsperks/files/pickups/lovely_die.xml",
				}
				EntityLoad(rock[Random(1, #rock)], x - 15, y)
			end
		end,
	},
	{
		id = "GRAHAM_MEAT_MONEY",
		ui_name = "$perkname_graham_meat_money",
		ui_description = "$perkdesc_graham_meat_money",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/meatmoney.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/meatmoney.png",
		usable_by_enemies = true,
		stackable = STACKABLE_NO,
		not_in_default_perk_pool = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local entity_id = EntityLoad("mods/grahamsperks/files/entities/goldmeat.xml", x, y)
			EntityAddChild(entity_who_picked, entity_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_midasmeat")
		end
	},
	{
		id = "GRAHAM_HEAT_WAVE",
		ui_name = "$perkname_graham_heatwave",
		ui_description = "$perkdesc_graham_heatwave",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/heatwave.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/heatwave.png",
		game_effect = "PROTECTION_FREEZE",
		usable_by_enemies = true,
		stackable = STACKABLE_NO,
		not_in_default_perk_pool = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local entity_id = EntityLoad("mods/grahamsperks/files/entities/heatwave.xml", x, y)
			EntityAddChild(entity_who_picked, entity_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_heatwave")
		end
	},
	--[[
{
    id = "GRAHAM_PURE_BLOOD",
    ui_name = "$perkname_graham_pure_blood",
    ui_description = "$perkdesc_graham_pure_blood",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/pureblood.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/pureblood.png",
    usable_by_enemies = true,
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local damagemodels = EntityGetFirstComponentIncludingDisabled( entity_who_picked, "DamageModelComponent" )
				ComponentSetValue( damagemodels, "blood_material", "graham_pureliquid" )
				ComponentSetValue( damagemodels, "blood_spray_material", "graham_pureliquid" )
				ComponentSetValue( damagemodels, "blood_multiplier", 2 )

    end,
},
]] --
	{
		id = "GRAHAM_BLEED_SALT",
		ui_name = "$perkname_graham_salt_blood",
		ui_description = "$perkdesc_graham_salt_blood",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/saltblood.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/saltblood.png",
		stackable = STACKABLE_YES,
		stackable_is_rare = false,
		usable_by_enemies = true,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local entity_id = EntityLoad("mods/grahamsperks/files/entities/sponge.xml", x, y)
			EntityAddChild(entity_who_picked, entity_id)

			local damagemodel = EntityGetFirstComponent(entity_who_picked, "DamageModelComponent")
			if damagemodel then
				ComponentSetValue2(damagemodel, "blood_material", "salt")
				ComponentSetValue2(damagemodel, "blood_spray_material", "salt")
				ComponentSetValue2(damagemodel, "blood_multiplier", ComponentGetValue2(damagemodel, "blood_multiplier") + 0.5)

				local projectile_resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "projectile") * 0.75
				local explosion_resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "explosion") * 0.75
				local ice_resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "ice") * 0.75
				local electric_resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "electricity") * 0.75
				local melee_resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "melee") * 0.75

				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "projectile", projectile_resistance)
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "explosion", explosion_resistance)
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "ice", ice_resistance)
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "melee", melee_resistance)
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "electricity", electric_resistance)
			end
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_saltblood")
			local damagemodel = EntityGetFirstComponent(entity_who_picked, "DamageModelComponent")
			if damagemodel then
				ComponentSetValue2(damagemodel, "blood_material", "blood")
				ComponentSetValue2(damagemodel, "blood_spray_material", "blood")
				ComponentSetValue2(damagemodel, "blood_multiplier", 1.0)
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "projectile", 1)
			end
		end,
	},
	{
		id = "GRAHAM_WAND_REFORGE",
		ui_name = "$perkname_graham_wand_reforge",
		ui_description = "$perkdesc_graham_wand_reforge",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/reforge.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/reforge.png",
		stackable = STACKABLE_YES,
		one_off_effect = true,
		do_not_remove=true,
		usable_by_enemies = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local wand = find_the_wand_held(entity_who_picked)

			SetRandomSeed(entity_who_picked, wand)

			if (wand ~= NULL_ENTITY) then
				local comp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")

				if comp then
					local mana_max = ComponentGetValue2(comp, "mana_max")
					local mana_charge_speed = ComponentGetValue2(comp, "mana_charge_speed")
					local reload_time = tonumber(ComponentObjectGetValue(comp, "gun_config", "reload_time"))
					local cast_delay = tonumber(ComponentObjectGetValue(comp, "gunaction_config", "fire_rate_wait"))
					local deck_capacity = ComponentObjectGetValue(comp, "gun_config", "deck_capacity")
					local deck_capacity2 = EntityGetWandCapacity(wand)
					local always_casts = deck_capacity - deck_capacity2

					mana_max = math.min(2000, mana_max + Random(60, 100))
					mana_charge_speed = math.min(1000, mana_charge_speed + Random(30, 90))
					cast_delay = math.max(-21, cast_delay + Random(-8, -12))
					reload_time = math.max(-21, reload_time + Random(-6, -10))
					deck_capacity2 = math.min(25, deck_capacity2 + Random(1, 3))

					ComponentSetValue2(comp, "mana_max", mana_max)
					ComponentSetValue2(comp, "mana_charge_speed", mana_charge_speed)
					ComponentObjectSetValue2(comp, "gun_config", "reload_time", reload_time)
					ComponentObjectSetValue2(comp, "gunaction_config", "fire_rate_wait", cast_delay)
					ComponentObjectSetValue2(comp, "gun_config", "deck_capacity", deck_capacity2 + always_casts)

					if (Random(1, 3) == 1) then
						ComponentObjectSetValue2(comp, "gun_config", "shuffle_deck_when_empty", false)
					end
				end
			end
		end,
	},
	{
		id = "GRAHAM_WIZARDS",
		ui_name = "$perkname_graham_elementals",
		ui_description = "$perkdesc_graham_elementals",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/mages.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/mages.png",
		usable_by_enemies = false,
		one_off_effect = true,
		do_not_remove=true,
		stackable = STACKABLE_YES,
		not_in_default_perk_pool = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
			add_halo_level(entity_who_picked, 1)
			if firsteffect("magmastone") then
				local x, y = EntityGetTransform(entity_who_picked)
				EntityLoad("mods/grahamsperks/files/pickups/magmastone.xml", x, y - 15)
			end
		end,
	},
	{
		id = "GRAHAM_BLOODY_EXTRA_PERK",
		ui_name = "$perkname_graham_bloody_perk",
		ui_description = "$perkdesc_graham_bloody_perk",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/bloodybonus.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			add_halo_level(entity_who_picked, -1)
			-- handled in bloodybonus_check.lua
		end,
		func_remove = function(entity_who_picked)
			GameRemoveFlagRun("PERK_PICKED_GRAHAM_BLOODY_EXTRA_PERK")
			add_halo_level(entity_who_picked, 1)
		end
	},
	{
		id = "GRAHAM_LUCKY_CLOVER",
		ui_name = "$perkname_graham_lucky_clover",
		ui_description = "$perkdesc_graham_lucky_clover",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/luckyclover.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/luckyclover.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func_remove = function(entity_who_picked)
			GameRemoveFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER")
		end,
	},
	{
		id = "GRAHAM_REVENGE_FREEZE",
		ui_name = "$perkname_graham_revenge_freeze",
		ui_description = "$perkdesc_graham_revenge_freeze",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/revengefreeze.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/revengefreeze.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent",
				{
					_tags = "perk_component,graham_revengefreeze",
					script_damage_received = "mods/grahamsperks/files/revenge_freeze.lua",
					execute_every_n_frame = "-1",
				})

			if (damagemodels ~= nil) then
				for i, damagemodel in ipairs(damagemodels) do
					local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "fire") * 0.5
					ComponentObjectSetValue(damagemodel, "damage_multipliers", "fire", resistance)

					resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "ice") * 0.5
					ComponentObjectSetValue(damagemodel, "damage_multipliers", "ice", resistance)
				end
			end
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_revengefreeze")
		end,
	},
	{
		id = "GRAHAM_ZAP_TAP",
		ui_name = "$perkname_graham_zaptap",
		ui_description = "$perkdesc_graham_zaptap",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/zaptap.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/zaptap.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		stackable_maximum = 8,
		game_effect = "PROTECTION_MELEE",
		remove_other_perks = { "PROTECTION_MELEE" },
		func = function(entity_perk_item, entity_who_picked, item_name)

			local var_comp = get_variable_storage_component(entity_who_picked, "zap_tap_radius")
			if var_comp ~= nil and var_comp > 0 then
				local radius = ComponentGetValue2(var_comp, "value_int")
				ComponentSetValue2(var_comp, "value_int", radius + 8)
			else
				EntityAddComponent2(entity_who_picked, "LuaComponent", {
					_tags = "perk_component,graham_zaptap",
					script_damage_about_to_be_received = "mods/grahamsperks/files/zaptap.lua",
					execute_every_n_frame = -1,
					limit_how_many_times_per_frame = 1,
				})
				EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
					value_int = 18,
					name = "zap_tap_radius"
				})
			end
		end,
		func_remove = function(entity_who_picked)
			local var_comp = get_variable_storage_component(entity_who_picked, "zap_tap_radius")
			EntityRemoveComponent(entity_who_picked, var_comp)
			removelua(entity_who_picked, "graham_zaptap")
		end,
	},
	{
		id = "GRAHAM_LIFE_LOTTERY",
		ui_name = "$perkname_graham_lifelottery",
		ui_description = "$perkdesc_graham_lifelottery",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/lifelottery.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/lifelottery.png",
		one_off_effect = true,
		do_not_remove=true,
		not_in_default_perk_pool = true,
		usable_by_enemies = false,
		stackable = STACKABLE_YES,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
			local goodluck = Random(1, 6)
			if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then goodluck = goodluck + 1 end

			if GameHasFlagRun("greed_curse") and not GameHasFlagRun("greed_curse_gone") then -- i hate git
				if (goodluck < 5) then EntityLoad("data/entities/projectiles/deck/touch_gold.xml", x, y) end
				if (goodluck >= 5) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x - 15, y) end
				if (goodluck >= 6) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x + 15, y) end
			else
				if (goodluck > 3) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x, y + 5) end
				if (goodluck <= 3) then EntityLoad("data/entities/projectiles/deck/touch_gold.xml", x, y) end
			end
		end,
	},
	{
		id = "GRAHAM_IOU",
		ui_name = "$perkname_graham_iou",
		ui_description = "$perkdesc_graham_iou",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/iou.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/iou.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		one_off_effect = true,
		do_not_remove=true,
		stackable = STACKABLE_YES,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)

			if GameHasFlagRun("PERK_PICKED_EDIT_WANDS_EVERYWHERE") then
				local eid = EntityLoad("mods/grahamsperks/files/pickups/chest_lost.xml", x + 12, y)
				change_entity_ingame_name(eid, "$graham_chest_tinker")
				dofile("mods/grahamsperks/files/scripts/IOU.lua")
			else
				local entity_id = EntityLoad("mods/grahamsperks/files/effects/tinkering.xml", x, y)
				EntityAddChild(entity_who_picked, entity_id)
			end
		end,
	},
	{
		id = "GRAHAM_BREADCRUMBS",
		ui_name = "$perkname_graham_breadcrumbs",
		ui_description = "$perkdesc_graham_breadcrumbs",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/breadcrumbs.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/breadcrumbs.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_breadcrumbs",
				script_source_file = "mods/grahamsperks/files/entities/breadcrumb_create.lua",
				execute_every_n_frame = 1,
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_breadcrumbs")
		end,
	},
	{
		id = "GRAHAM_CAMPFIRE",
		ui_name = "$perkname_graham_campfire",
		ui_description = "$perkdesc_graham_campfire",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/campfire.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/campfire.png",
		usable_by_enemies = false,
		stackable = STACKABLE_NO,
		not_in_default_perk_pool = false,
		func = function(entity_perk_item, entity_who_picked, item_name)
		end,
		func_remove = function(entity_who_picked)
			GameRemoveFlagRun("PERK_PICKED_GRAHAM_CAMPFIRE")
		end,
	},
	{
		id = "GRAHAM_GUARD",
		ui_name = "$perkname_graham_guard",
		ui_description = "$perkdesc_graham_guard",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/guard.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/guard.png",
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			-- this one is safe exploration, by the way

			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_guard",
				script_source_file = "mods/grahamsperks/files/scripts/protection.lua",
				execute_every_n_frame = 30,
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_guard")
		end,
	},
	{
		id = "GRAHAM_TIPSY_GHOST",
		ui_name = "$perkname_graham_tipsy_ghost",
		ui_description = "$perkdesc_graham_tipsy_ghost",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/tipsy_ghost.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/tipsy_ghost.png",
		usable_by_enemies = false,
		stackable = STACKABLE_YES,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local child_id = EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/tipsy_ghost.xml", x, y)
			EntityAddTag(child_id, "perk_entity")
			EntityAddChild(entity_who_picked, child_id)

			perk_pickup_event("GHOST")

			if (GameHasFlagRun("player_status_tipsy_ghost") == false) then
				GameAddFlagRun("player_status_tipsy_ghost")
				add_ghostness_level(entity_who_picked)
			end

			ConvertMaterialEverywhere(CellFactory_GetType("alcohol_gas"), CellFactory_GetType("graham_air"))
		end,
		func_remove = function(entity_who_picked)
			reset_perk_pickup_event("GHOST")
			GameRemoveFlagRun("player_status_tipsy_ghost")
			removechild(entity_who_picked, "tipsy_ghost")
		end,
	},
	{
		id = "GRAHAM_PROJECTILES",
		ui_name = "$perkname_graham_proj",
		ui_description = "$perkdesc_graham_proj2",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/projectiles.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/projectiles.png",
		not_in_default_perk_pool = false,
		usable_by_enemies = true,
		stackable = STACKABLE_YES,
		stackable_maximum = 4,
		stackable_is_rare = true,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local damagemodel = EntityGetFirstComponent(entity_who_picked, "DamageModelComponent")
			if damagemodel then
				local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", "projectile") * 8
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "projectile", resistance)
			end

			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_projectiles",
				script_damage_about_to_be_received = "mods/grahamsperks/files/effects/damagedouble.lua",
				execute_every_n_frame = -1,
			})
		end,

		func_remove = function(entity_who_picked)
			local damagemodel = EntityGetFirstComponent(entity_who_picked, "DamageModelComponent")
			if damagemodel then
				ComponentObjectSetValue2(damagemodel, "damage_multipliers", "projectile", 1)
			end
			removelua(entity_who_picked, "graham_projectiles")
		end,
	},
	{
		id = "GRAHAM_BLEEDING_EDGE",
		ui_name = "$perkname_graham_edge",
		ui_description = "$perkdesc_graham_edge",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/bleedingedge.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/bleedingedge.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			-- technically this should work perfectly fine when used by enemies, which would be really funny
			-- wouldn't apply to the player, or exclude the entity that has it, though
			-- if i fix those later, i'll turn it on
			-- 6/10/25: enabled
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_bleedingedge",
				script_source_file = "mods/grahamsperks/files/scripts/bleeding_edge.lua",
				execute_every_n_frame = 1,
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_bleedingedge")
		end,
	},
	{
		id = "GRAHAM_BLOODORB",
		ui_name = "$perkname_graham_bloodorb",
		ui_description = "$perkdesc_graham_bloodorb",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/wanderingeye.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/wanderingeye.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		stackable_maximum = 3,
		func = function(entity_perk_item, entity_who_picked, item_name)
			for i = 1, 3, 1 do
				local x, y = EntityGetTransform(entity_who_picked)
				local child_id = EntityLoad("mods/grahamsperks/files/entities/eye/blood_orb.xml", x, y)

				-- faction logic
				local factioncomp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "GenomeDataComponent")
				if factioncomp ~= nil then
					local faction = ComponentGetValue2(factioncomp, "herd_id")
					local other = EntityGetFirstComponentIncludingDisabled(child_id, "GenomeDataComponent")
					if other ~= nil then
						ComponentSetValue2(other, "herd_id", faction)
					end
				end

				-- stacking logic
				local varsto = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_blood_orbs")
				if varsto ~= nil then
					local orbs = ComponentGetValue2(varsto, "value_int") + 1
					ComponentSetValue2(varsto, "value_int", orbs)

					EntityAddComponent2(child_id, "VariableStorageComponent", {
						_tags = "wizard_orb_id,graham_bloodorb",
						name = "wizard_orb_id",
						value_int = orbs,
					})
				else
					EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
						_tags = "graham_blood_orbs,graham_bloodorb",
						value_int = 1,
					})

					EntityAddComponent2(child_id, "VariableStorageComponent", {
						_tags = "wizard_orb_id,graham_bloodorb",
						name = "wizard_orb_id",
						value_int = 1,
					})
				end

				EntityAddChild(entity_who_picked, child_id)
				if varsto ~= nil and i == 1 then break end
			end
		end,
		func_remove = function(entity_who_picked)
			local varsto = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_blood_orbs")
			if varsto ~= nil then
				ComponentSetValue2(varsto, "value_int", 0)
			end
			removechild(entity_who_picked, "graham_bloodorb")
			removevar(entity_who_picked, "graham_bloodorb")
		end,
	},
	{
		id = "GRAHAM_BLIND_SPOT",
		ui_name = "$perkname_graham_blindspot",
		ui_description = "$perkdesc_graham_blindspot",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/blindspot.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/blindspot.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			-- hopefully this won't be too op when used by enemies
			local child_id = EntityLoad("mods/grahamsperks/files/entities/halo.xml", x, y)
			EntityAddTag(child_id, "perk_entity")
			EntityAddChild(entity_who_picked, child_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_blindspot")
		end,
	},
	{
		id = "GRAHAM_REFRESHER",
		ui_name = "$perkname_graham_refresher",
		ui_description = "$perkdesc_graham_refresher",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/refresher.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/refresher.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		stackable_maximum = 5,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local comp = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_refresher")
			if (not comp) or comp <= 0 then
				comp = EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
					_tags="graham_refresher",
					value_int=0
				})
			end
			ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") + 1)

			if firsteffect("refresher") then
				local x, y = EntityGetTransform(entity_who_picked)
				local eid = EntityLoad("data/entities/items/pickup/spell_refresh.xml", x, y)
				local item_comp = EntityGetFirstComponent(eid, "ItemComponent")
				if item_comp then
					if (ComponentGetValue2(item_comp, "auto_pickup")) then
						ComponentSetValue2(item_comp, "next_frame_pickable", GameGetFrameNum() + 120)
					end
				end
			end
		end,
		func_remove = function(entity_who_picked)
			local comp = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_refresher")
			if comp then EntityRemoveComponent(entity_who_picked, comp) end
		end,
	},
	--[[
{
  id = "GRAHAM_ALLIANCE",
  ui_name = "$perkname_graham_alliance",
  ui_description = "$perkdesc_graham_alliance",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/alliance.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/alliance.png",
  usable_by_enemies = true,
  not_in_default_perk_pool = false,
  stackable = STACKABLE_YES,
  stackable_maximum = 4,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local amount = GlobalsGetValue( "GRAHAM_ALLIANCE_COUNT", 10 )
    GlobalsSetValue( "GRAHAM_ALLIANCE_COUNT", amount + 10 )
      EntityAddComponent2(entity_who_picked,"LuaComponent",
      {
          _tags = "perk_component",
          _enabled = 1,
          script_shot="mods/grahamsperks/files/scripts/alliance.lua",
          execute_every_n_frame= -1
      })
  end,
  func_remove = function( entity_who_picked )
    GlobalsSetValue( "GRAHAM_ALLIANCE_COUNT", 10 )
  end,
},]] --
	{
		id = "GRAHAM_WAND_KICK",
		ui_name = "$perkname_graham_wandkick",
		ui_description = "$perkdesc_graham_wandkick",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/wandkick.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/wandkick.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_wandkick",
				script_kick = "mods/grahamsperks/files/scripts/wandkick.lua",
				execute_every_n_frame = -1,
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_wandkick")
		end,
	},
	{
		id = "GRAHAM_REPOSSESSION",
		ui_name = "$perkname_graham_repossession",
		ui_description = "$perkdesc_graham_repossession2",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/repossession.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/repossession.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			-- handled in bloodybonus_check.lua
		end,
		func_remove = function(entity_who_picked)
			GameRemoveFlagRun("PERK_PICKED_GRAHAM_REPOSSESSION")
		end,
	},
	{
		id = "GRAHAM_FORTUNE_TELLER",
		ui_name = "$perkname_graham_fortuneteller",
		ui_description = "$perkdesc_graham_fortuneteller",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/fortuneteller.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/fortuneteller.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		stackable_maximum = 5,
		stackable_is_rare = true,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local amount = tonumber(GlobalsGetValue("GRAHAM_FORTUNETELLER_COUNT", "-1") or "-1")
			if amount < 0 then
				local child_id = EntityLoad("mods/grahamsperks/files/entities/fortuneteller.xml")
				EntityAddChild(entity_who_picked, child_id)
			end
			GlobalsSetValue("GRAHAM_FORTUNETELLER_COUNT", tostring(amount + 1))
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("GRAHAM_FORTUNETELLER_COUNT", "-1")
			removechild(entity_who_picked, "graham_fortuneteller")
		end,
	},
	{
		id = "GRAHAM_SILLY_STRAW",
		ui_name = "$perkname_graham_straw",
		ui_description = "$perkdesc_graham_straw",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/straw.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/straw.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable_maximum = 5,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local length = tonumber(GlobalsGetValue("graham_silly_straw_length", "0") or "0")
			local x, y = EntityGetTransform(entity_who_picked)
			if firsteffect("straw") then
				EntityLoad("data/entities/items/pickup/powder_stash.xml", x + 5, y)
				EntityLoad("mods/grahamsperks/files/pickups/balloon.xml", x - 5, y)
			end
			if length < 1 then
				EntityAddComponent2(entity_who_picked, "LuaComponent", {
					_tags = "perk_component,graham_sillystraw",
					script_source_file = "mods/grahamsperks/files/entities/straw/straw.lua",
					execute_every_n_frame = 1,
				})
				GlobalsSetValue("graham_silly_straw_length", "1")
			else
				GlobalsSetValue("graham_silly_straw_length", tostring(length + 1))
			end
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("graham_silly_straw_length", "0")
			removelua(entity_who_picked, "graham_sillystraw")
		end,
	},
	{
		id = "GRAHAM_TRICK_BETRAYAL",
		ui_name = "$perkname_graham_betrayal",
		ui_description = "$perkdesc_graham_betrayal",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/betrayal.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/betrayal.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
		end,
		func_remove = function(entity_who_picked)
			GameRemoveFlagRun("PERK_PICKED_GRAHAM_TRICK_BETRAYAL")
		end,
	},
	{
		id = "GRAHAM_BUYBACK",
		ui_name = "$perkname_graham_buyback",
		ui_description = "$perkdesc_graham_buyback",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/buyback.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/buyback.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = false,
		stackable = STACKABLE_YES,
		one_off_effect = true,
		do_not_remove=true,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local function boop_spell(eid, cost)
				EntitySetComponentsWithTagEnabled(eid, "enabled_in_world", true)
				EntitySetComponentsWithTagEnabled(eid, "enabled_in_hand", false)
				EntitySetComponentsWithTagEnabled(eid, "enabled_in_inventory", false)
				-- boop
				local velcomp = EntityGetFirstComponentIncludingDisabled(eid, "VelocityComponent") or 0
				ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))

				-- this is normal shop script
				local offsetx = 6
				local text = tostring(cost)
				local textwidth = 0

				for j = 1, #text do
					if (string.sub(text, j, j) ~= "1") then
						textwidth = textwidth + 6
					else
						textwidth = textwidth + 3
					end
				end
				offsetx = textwidth * 0.5 - 0.5

				EntityAddComponent2(eid, "SpriteComponent", {
					_tags = "shop_cost,enabled_in_world",
					image_file = "data/fonts/font_pixel_white.xml",
					is_text_sprite = true,
					offset_x = offsetx,
					offset_y = 25,
					update_transform = true,
					update_transform_rotation = false,
					text = tostring(cost),
					z_index = -1,
				})
				EntityAddComponent2(eid, "ItemCostComponent", {
					_tags = "shop_cost,enabled_in_world",
					cost = cost,
					stealable = false
				})
				EntityAddComponent2(eid, "LuaComponent", {
					script_item_picked_up = "data/scripts/items/shop_effect.lua",
				})
			end

			if EntityHasTag(entity_who_picked, "player_unit") and not EntityHasTag(entity_who_picked, "ew_notplayer") then
				local nothing = true
				local x, y = EntityGetTransform(entity_who_picked)
				local items = GameGetAllInventoryItems(entity_who_picked) or {}
				for i = 1, #items do
					if EntityHasTag(items[i], "card_action") then
						EntityRemoveFromParent(items[i])
						EntityApplyTransform(items[i], x, y, 0)

						local comp = EntityGetFirstComponentIncludingDisabled(items[i], "ItemActionComponent") or 0
						local id = ComponentGetValue2(comp, "action_id")
						local entity = CreateItemActionEntity(id, x, y)
						SetRandomSeed(x + GameGetFrameNum(), y + comp)
						local cardcost = 25 * Random(2, 10) -- not sure how to balance this properly
						boop_spell(items[i], cardcost)
						boop_spell(entity, cardcost)
						nothing = false
					end
				end

				if nothing then
					-- live wandering eye reaction
					x, y = EntityGetTransform(entity_perk_item)
					EntityLoad("mods/grahamsperks/files/entities/snub.xml", x, y)
					EntityLoad("mods/grahamsperks/files/entities/eye/blood_orb.xml", x, y)
				end
			end
		end,
	},
	{
		id = "GRAHAM_MAP",
		ui_name = "$perkname_graham_map",
		ui_description = "$perkdesc_graham_map",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/map.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/map.png",
		not_in_default_perk_pool = true,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local child_id = EntityLoad("mods/grahamsperks/files/entities/map/map.xml", x, y)
			EntityAddTag(child_id, "perk_entity")
			EntityAddChild(entity_who_picked, child_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_map")
		end,
	},
	{
		id = "GRAHAM_MAP2",
		ui_name = "$perkname_graham_map2",
		ui_description = "$perkdesc_graham_map2",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/map2.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/map2.png",
		not_in_default_perk_pool = true,
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local child_id = EntityLoad("mods/grahamsperks/files/entities/map2/map.xml", x, y)
			EntityAddTag(child_id, "perk_entity")
			EntityAddChild(entity_who_picked, child_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_map2")
		end,
	},
	{
		id = "GRAHAM_SHEEPIFICATION",
		ui_name = "$perkname_graham_sheepification",
		ui_description = "$perkdesc_graham_sheepification",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/baba.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/baba.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_sheep"),
		stackable = STACKABLE_YES,
		stackable_maximum = 2,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_sheepification",
				_enabled = 1,
				script_shot = "mods/grahamsperks/files/polychance.lua",
				execute_every_n_frame = -1
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_sheepification")
		end,
	},
	{
		id = "GRAHAM_MATERIALIST",
		ui_name = "$perkname_graham_materialist",
		ui_description = "$perkdesc_graham_materialist",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/materialist.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/materialist.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_robot"),
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local entity_id = EntityLoad("mods/grahamsperks/files/entities/wandcharger.xml", x, y)
			EntityAddChild(entity_who_picked, entity_id)
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_materialist")
		end,
	},
	{
		id = "GRAHAM_LUCKYDAY",
		ui_name = "$perkname_graham_luckyday",
		ui_description = "$perkdesc_graham_luckyday",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/luckyday.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/luckyday.png",
		usable_by_enemies = true,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_lucky"),
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_luckyday",
				script_damage_about_to_be_received = "mods/grahamsperks/files/luckyday.lua",
				execute_every_n_frame = -1,
			})
		end,
		func_remove = function(entity_who_picked)
			removelua(entity_who_picked, "graham_luckyday")
		end,
	},
	{
		id = "GRAHAM_ROBOTS",
		ui_name = "$perkname_graham_robot",
		ui_description = "$perkdesc_graham_robot",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/robot.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/robot.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_tech"),
		stackable = STACKABLE_YES,
		stackable_maximum = 3,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			local entity_id = EntityLoad("mods/grahamsperks/files/entities/oil.xml", x, y)
			EntityAddChild(entity_who_picked, entity_id)

			if firsteffect("robots") then
				local value = GlobalsGetValue("GRAHAM_ROBOTS_COUNT", 0)
				GlobalsSetValue("GRAHAM_ROBOTS_COUNT", value + 3)
				local options = { "tank.xml", "tank_rocket.xml", "tank_super.xml", "toasterbot.xml" }
				for i = 1, 3 do
					SetRandomSeed(x, y + i)
					EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x, y)
				end
			end
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("GRAHAM_ROBOTS_COUNT", 0)
		end,
	},
	{
		id = "GRAHAM_DEATH",
		ui_name = "$perkname_graham_death",
		ui_description = "$perkdesc_graham_death",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/death.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/death.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_hunger"),
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			AddFlagPersistent("graham_death_hp_boost")
			add_halo_level(entity_who_picked, -1)
			EntityAddComponent2(entity_who_picked, "LuaComponent",
				{
					_tags = "perk_component,graham_death",
					script_damage_received = "mods/grahamsperks/files/demise.lua",
					execute_every_n_frame = -1,
				})
		end,
		func_remove = function(entity_who_picked)
			RemoveFlagPersistent("graham_death_hp_boost")
			removelua(entity_who_picked, "graham_death")
			add_halo_level(entity_who_picked, 1)
		end,
	},
	{
		id = "GRAHAM_IMMUNITY_AURA",
		ui_name = "$perkname_graham_immunityaura",
		ui_description = "$perkdesc_graham_immunityaura",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/immunityaura.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/immunityaura.png",
		usable_by_enemies = false,
		stackable = STACKABLE_NO,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_immunity"),
		func = function(entity_perk_item, entity_who_picked, item_name)
			local x, y = EntityGetTransform(entity_who_picked)
			if #(EntityGetAllChildren(player, "graham_immunityaura") or {}) == 0 then
				local entity_id = EntityLoad("mods/grahamsperks/files/entities/immunityaura/none.xml", x, y)
				EntityAddChild(entity_who_picked, entity_id)
				local effect = LoadGameEffectEntityTo(entity_who_picked, "mods/grahamsperks/files/effects/confusion.xml")
				EntityAddComponent2(effect, "UIIconComponent", {
					icon_sprite_file="data/ui_gfx/status_indicators/confusion.png",
					is_perk=false,
					display_above_head=true,
					display_in_hud=true,
					name="$status_confusion",
					description="$graham_statusdesc_confusion",
				})
			end

			--[[
			if EntityHasTag(entity_who_picked, "player_unit") and not EntityHasTag(entity_who_picked, "ew_notplayer") then
				EntityLoad("mods/grahamsperks/files/entities/immunityaura/potion_flum.xml", x, y)
			end
			]]--

			EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
				name = "graham_immunityaura",
				value_string = "NONE",
			})
		end,
		func_remove = function(entity_who_picked)
			removechild(entity_who_picked, "graham_immunityaura")
			removechild(entity_who_picked, "graham_immunityaura_cooldown")
		end,
	},
	{
		id = "GRAHAM_MAGIC_SKIN",
		ui_name = "$perkname_graham_magicskin",
		ui_description = "$perkdesc_graham_magicskin",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/magicskin.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/magicskin.png",
		usable_by_enemies = false,
		stackable = STACKABLE_YES,
		not_in_default_perk_pool = not HasFlagPersistent("graham_bloodymimic_killed"),
		func = function(entity_perk_item, entity_who_picked, item_name)
			add_halo_level(entity_who_picked, -1)

			local value = GlobalsGetValue("GRAHAM_MAGIC_SKIN_COUNTER", "0") + 1
			GlobalsSetValue("GRAHAM_MAGIC_SKIN_COUNTER", value)
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("GRAHAM_MAGIC_SKIN_COUNTER", "0")
			add_halo_level(entity_who_picked, 1)
		end,
	},
	{
		id = "GRAHAM_LUKKI_MOUNT",
		ui_name = "$perkname_graham_lukkimount",
		ui_description = "$perkdesc_graham_lukkimount",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/lukkimount.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/lukkimount.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_lukki"),
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddComponent2(entity_who_picked, "LuaComponent", {
				_tags = "perk_component,graham_lukkimount",
				execute_on_added = true,
				script_source_file = "mods/grahamsperks/files/scripts/lukki_mount_spawn.lua",
				execute_every_n_frame = 1,
			})
			perk_pickup_event("LUKKI")
			add_lukkiness_level(entity_who_picked)
		end,
		func_remove = function(entity_who_picked)
			reset_perk_pickup_event("LUKKI")
			removelua(entity_who_picked, "graham_lukkimount")
			local friends = EntityGetWithTag("graham_lukki_mount")
			for i = 1, #friends do
				EntityKill(friends[i])
			end
		end,
	},
	{
		id = "GRAHAM_EXTRA_SLOTS",
		ui_name = "$perkname_graham_extraslots",
		ui_description = "$perkdesc_graham_extraslots",
		ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/extraslots.png",
		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/extraslots.png",
		usable_by_enemies = false,
		not_in_default_perk_pool = not HasFlagPersistent("graham_progress_deathquest"),
		stackable = STACKABLE_YES,
		stackable_is_rare = "1",
		stackable_maximum = 5,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local amount = tonumber(GlobalsGetValue("graham_extra_slots_amount", "0") or "0")
			if amount < 1 then
				EntityAddComponent2(entity_who_picked, "LuaComponent", {
					_tags = "perk_component,graham_extraslots",
					script_source_file = "mods/grahamsperks/files/scripts/extra_slots.lua",
					execute_every_n_frame = 5,
				})
				GlobalsSetValue("graham_extra_slots_amount", "1")
			else
				GlobalsSetValue("graham_extra_slots_amount", tostring(amount + 1))
			end
		end,
		func_remove = function(entity_who_picked)
			GlobalsSetValue("graham_extra_slots_amount", "0")
			removelua(entity_who_picked, "graham_extraslots")
		end,
	},
}

local len = #perk_list
for i=1, #to_insert do
	to_insert[i]._remove = to_insert[i].func_remove
	perk_list[len+i] = to_insert[i]
end