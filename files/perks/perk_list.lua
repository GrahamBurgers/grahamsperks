---@diagnostic disable: undefined-global, param-type-mismatch
dofile_once("data/scripts/lib/utilities.lua")

local to_insert = {
  {
    id = "GRAHAM_HEALTHY_HEARTS",
    ui_name = "$perkname_graham_healthy_hearts",
    ui_description = "$perkdesc_graham_healthy_hearts",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/healthyhearts.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/healthyhearts.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_YES,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local value = GlobalsGetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", "1" )
		GlobalsSetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", value + 1 )
		add_halo_level(entity_who_picked, 1)
    end,
    func_remove = function( entity_who_picked )
      GlobalsSetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", 1 )
    end,
},
{
    id = "GRAHAM_SPAWN_ITEMS",
    ui_name = "$perkname_graham_item_lottery",
    ui_description = "$perkdesc_graham_item_lottery",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/itemlottery.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/itemlottery.png",
	  one_off_effect = true,
    usable_by_enemies = false,
    stackable = STACKABLE_YES,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
      local x, y = EntityGetTransform( entity_who_picked )
      EntityLoad("data/entities/items/pickup/potion_random_material.xml", x - 30, y)
      EntityLoad("data/entities/items/pickup/potion_aggressive.xml", x + 30, y)
      EntityLoad("data/entities/items/pickup/powder_stash.xml", x + 15, y)
      EntityLoad("data/entities/items/wand_level_03.xml", x, y - 30)
      SetRandomSeed(x + y, GameGetFrameNum())
      local rockrandom = Random(1, 6)
      if ( rockrandom == 1) then EntityLoad("data/entities/items/pickup/thunderstone.xml", x - 15, y) end
      if ( rockrandom == 2) then EntityLoad("data/entities/items/pickup/brimstone.xml", x - 15, y) end
      if ( rockrandom == 3) then EntityLoad("data/entities/items/pickup/waterstone.xml", x - 15, y) end
      if ( rockrandom == 4) then EntityLoad("data/entities/items/pickup/stonestone.xml", x - 15, y) end
      if ( rockrandom == 5) then EntityLoad("data/entities/items/pickup/safe_haven.xml", x - 15, y) end
      if ( rockrandom == 6) then EntityLoad("mods/grahamsperks/files/pickups/safe.xml", x - 15, y) end
    end,
},
{
    id = "GRAHAM_MEAT_MONEY",
    ui_name = "$perkname_graham_meat_money",
    ui_description = "$perkdesc_graham_meat_money",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/meatmoney.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/meatmoney.png",
    usable_by_enemies = true,
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/goldmeat.xml", x, y )
		EntityAddChild( entity_who_picked, entity_id )
    end,
},
{
    id = "GRAHAM_HEAT_WAVE",
    ui_name = "$perkname_graham_heatwave",
    ui_description = "$perkdesc_graham_heatwave",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/heatwave.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/heatwave.png",
    game_effect = "PROTECTION_FREEZE",
    usable_by_enemies = true,
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/heatwave.xml", x, y )
		EntityAddChild( entity_who_picked, entity_id )

		if GameHasFlagRun("PERK_PICKED_FREEZE_FIELD") then
			local child_id = EntityLoad( "data/entities/misc/perks/freeze_field.xml", x, y )
			EntityAddTag( child_id, "perk_entity" )
			EntityAddChild( entity_who_picked, child_id )
		end
    end,
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
]]--
{
		id = "GRAHAM_BLEED_SALT",
		ui_name = "$perkname_graham_salt_blood",
		ui_description = "$perkdesc_graham_salt_blood",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/saltblood.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/saltblood.png",
		stackable = STACKABLE_YES,
		stackable_is_rare = false,
		usable_by_enemies = true,
		func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/sponge.xml", x, y )
		EntityAddChild( entity_who_picked, entity_id )
		
			local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )

		local salty = GlobalsGetValue( "SALTBLOOD_MULTIPLIER", "1" )
		GlobalsSetValue( "SALTBLOOD_MULTIPLIER", salty + salty / 15 + 3 )

			if( damagemodels ~= nil ) then
				for i,damagemodel in ipairs(damagemodels) do
					ComponentSetValue( damagemodel, "blood_material", "salt" )
					ComponentSetValue( damagemodel, "blood_spray_material", "salt" )
					ComponentSetValue( damagemodel, "blood_multiplier", salty )
					
					local projectile_resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "projectile" ))
					local explosion_resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "explosion" ))
					local ice_resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "ice" ))
					local electric_resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "electricity" ))
					local melee_resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "melee" ))

					projectile_resistance = projectile_resistance * 0.8
					explosion_resistance = explosion_resistance * 0.8
					ice_resistance = ice_resistance * 0.85
					electric_resistance = electric_resistance * 0.85
					melee_resistance = melee_resistance * 0.7

					ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", tostring(projectile_resistance) )
					ComponentObjectSetValue( damagemodel, "damage_multipliers", "explosion", tostring(explosion_resistance) )
					ComponentObjectSetValue( damagemodel, "damage_multipliers", "ice", tostring(ice_resistance) )
					ComponentObjectSetValue( damagemodel, "damage_multipliers", "melee", tostring(melee_resistance) )
					ComponentObjectSetValue( damagemodel, "damage_multipliers", "electricity", tostring(electric_resistance) )
				end
			end
			
		end,
		func_remove = function( entity_who_picked )
			local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
			if( damagemodels ~= nil ) then
				for i,damagemodel in ipairs(damagemodels) do
					ComponentSetValue( damagemodel, "blood_material", "blood" )
					ComponentSetValue( damagemodel, "blood_spray_material", "blood" )
					ComponentSetValue( damagemodel, "blood_multiplier", "1.0" )
					ComponentSetValue( damagemodel, "blood_sprite_directional", "" )
					ComponentSetValue( damagemodel, "blood_sprite_large", "" )
					ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", "1.0" )
					GlobalsSetValue( "SALTBLOOD_MULTIPLIER", "nil" )
				end
			end
		end,
},
{
		id = "GRAHAM_WAND_REFORGE",
		ui_name = "$perkname_graham_wand_reforge",
		ui_description = "$perkdesc_graham_wand_reforge",
  		ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/reforge.png",
   		perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/reforge.png",
		stackable = STACKABLE_YES,
		one_off_effect = true,
		usable_by_enemies = false,
		func = function( entity_perk_item, entity_who_picked, item_name )
			local wand = find_the_wand_held( entity_who_picked )
			local x,y = EntityGetTransform( entity_who_picked )
			
			SetRandomSeed( entity_who_picked, wand )
			
			if ( wand ~= NULL_ENTITY ) then
				local comp = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" )
				
				if ( comp ~= nil ) then
					local mana_max = ComponentGetValue2( comp, "mana_max" )
					local mana_charge_speed = ComponentGetValue2( comp, "mana_charge_speed" )
					local reload_time = tonumber( ComponentObjectGetValue( comp, "gun_config", "reload_time" ) )
					local cast_delay = tonumber( ComponentObjectGetValue( comp, "gunaction_config", "fire_rate_wait" ) )
					local deck_capacity = ComponentObjectGetValue( comp, "gun_config", "deck_capacity" )
					local deck_capacity2 = EntityGetWandCapacity( wand )
					local always_casts = deck_capacity - deck_capacity2
					
					if mana_max < 2000 then mana_max = mana_max + Random( 60, 100 )
					if mana_max > 2000 then mana_max = 2000 end end
					
					if mana_charge_speed < 1000 then mana_charge_speed = mana_charge_speed + Random( 30, 90 )
					if mana_charge_speed > 1000 then mana_charge_speed = 1000 end end
					
					if cast_delay > -21 then cast_delay = cast_delay + Random( -8, -12 )
					if cast_delay < -21 then cast_delay = -21 end end 

					if reload_time > -21 then reload_time = reload_time + Random( -6, -10 )
					if reload_time < -21 then reload_time = -21 end end
				
					if deck_capacity2 < 25 then deck_capacity2 = deck_capacity2 + Random( 1, 3 )
					if deck_capacity2 > 25 then deck_capacity2 = 25 end end
					
					ComponentSetValue2( comp, "mana_max", mana_max )			
					ComponentSetValue2( comp, "mana_charge_speed", mana_charge_speed )
					ComponentObjectSetValue( comp, "gun_config", "reload_time", tostring(reload_time) )
					ComponentObjectSetValue( comp, "gunaction_config", "fire_rate_wait", tostring(cast_delay) )
					ComponentObjectSetValue( comp, "gun_config", "deck_capacity", deck_capacity2 + always_casts )

					if ( Random(1, 3) == 1) then
						ComponentObjectSetValue( comp, "gun_config", "shuffle_deck_when_empty", 0 )
					end
				end
			end
		end,
},
{
    id = "GRAHAM_WIZARDS",
    ui_name = "$perkname_graham_elementals",
    ui_description = "$perkdesc_graham_elementals",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/mages.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/mages.png",
    usable_by_enemies = false,
    one_off_effect = true,
    stackable = STACKABLE_YES,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
		add_halo_level(entity_who_picked, 1)
		local x, y = EntityGetTransform( entity_who_picked )
		EntityLoad("mods/grahamsperks/files/pickups/magmastone.xml", x, y - 15)
    end,
},
{
    id = "GRAHAM_BLOODY_EXTRA_PERK",
    ui_name = "$perkname_graham_bloody_perk",
    ui_description = "$perkdesc_graham_bloody_perk",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/bloodybonus.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		add_halo_level(entity_who_picked, -1)
		local x, y = EntityGetTransform( entity_who_picked )
    end,
},
{
    id = "GRAHAM_LUCKY_CLOVER",
    ui_name = "$perkname_graham_lucky_clover",
    ui_description = "$perkdesc_graham_lucky_clover",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/luckyclover.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/luckyclover.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
    end,
},
{
    id = "GRAHAM_REVENGE_FREEZE",
    ui_name = "$perkname_graham_revenge_freeze",
    ui_description = "$perkdesc_graham_revenge_freeze",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/revengefreeze.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/revengefreeze.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
	
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_received = "mods/grahamsperks/files/revenge_freeze.lua",
			execute_every_n_frame = "-1",
		} )

	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			local resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "fire" ))
			resistance = resistance * 0.5
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "fire", tostring(resistance) )
			
			resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "ice" ))
			resistance = resistance * 0.5
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "ice", tostring(resistance) )
		end
	end

    end,
},
{
    id = "GRAHAM_ZAP_TAP",
    ui_name = "$perkname_graham_zaptap",
    ui_description = "$perkdesc_graham_zaptap",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/zaptap.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/zaptap.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_YES,
    stackable_maximum = 8,
    game_effect = "PROTECTION_MELEE",
    remove_other_perks = {"PROTECTION_MELEE"},
    func = function( entity_perk_item, entity_who_picked, item_name )

		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_about_to_be_received = "mods/grahamsperks/files/zaptap.lua",
			execute_every_n_frame = "-1",
		} )

    local var_comp = get_variable_storage_component(entity_who_picked, "zap_tap_radius")
    local radius = ComponentGetValue2(var_comp, "value_int")
    if var_comp ~= nil then
      ComponentSetValue2(var_comp, "value_int", radius + 8)	
    else
      EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
        value_int=18,
        name="zap_tap_radius"
      })
    end
    
    end,
    func_remove = function( entity_who_picked )
      local var_comp = get_variable_storage_component(entity_who_picked, "zap_tap_radius")
      EntityRemoveComponent(entity_who_picked, var_comp)
    end,
},
{
    id = "GRAHAM_LIFE_LOTTERY",
    ui_name = "$perkname_graham_lifelottery",
    ui_description = "$perkdesc_graham_lifelottery",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/lifelottery/spoopyboi2.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/lifelottery/spoopyboi.png",
    one_off_effect = true,
    not_in_default_perk_pool = true,
    usable_by_enemies = false,
    stackable = STACKABLE_YES,
      func = function( entity_perk_item, entity_who_picked, item_name )
      local x, y = EntityGetTransform( entity_who_picked )
      SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
      local goodluck = Random(1, 6)
          
      if GameHasFlagRun("greed_curse") then
        if ( goodluck < 5) then EntityLoad("data/entities/projectiles/deck/touch_gold.xml", x, y) end
        if ( goodluck >= 5) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x-15, y) end
        if ( goodluck >= 6) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x+15, y) end
      else
        if ( goodluck <= 3) then EntityLoad("data/entities/items/pickup/chest_random_super.xml", x, y+5) end
        if ( goodluck > 3) then EntityLoad("data/entities/projectiles/deck/touch_gold.xml", x, y) end
      end
    end,
},
{
  id = "GRAHAM_IOU",
  ui_name = "$perkname_graham_iou",
  ui_description = "$perkdesc_graham_iou",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/iou.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/iou.png",
  usable_by_enemies = false,
  not_in_default_perk_pool = false,
  one_off_effect = true,
  stackable = STACKABLE_YES,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local x, y = EntityGetTransform(entity_who_picked)
    
    if GameHasFlagRun("PERK_PICKED_EDIT_WANDS_EVERYWHERE") then
      local eid = EntityLoad( "mods/grahamsperks/files/pickups/chest_lost.xml", x + 12, y )
      change_entity_ingame_name( eid, "$graham_chest_tinker" )
      dofile("mods/grahamsperks/files/scripts/IOU.lua")
    else
      local entity_id = EntityLoad( "mods/grahamsperks/files/effects/tinkering.xml", x, y )
      EntityAddChild( entity_who_picked, entity_id )
    end

  end,
},
{
    id = "GRAHAM_BREADCRUMBS",
    ui_name = "$perkname_graham_breadcrumbs",
    ui_description = "$perkdesc_graham_breadcrumbs",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/breadcrumbs.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/breadcrumbs.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
      EntityAddComponent( entity_who_picked, "LuaComponent", 
      {
        _tags = "perk_component",
        script_source_file = "mods/grahamsperks/files/entities/breadcrumb_create.lua",
        execute_every_n_frame = "1",
      } )
    end,
},
{
  id = "GRAHAM_CAMPFIRE",
  ui_name = "$perkname_graham_campfire",
  ui_description = "$perkdesc_graham_campfire",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/campfire.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/campfire.png",
  usable_by_enemies = false,
  stackable = STACKABLE_NO,
  not_in_default_perk_pool = false,
  func = function( entity_perk_item, entity_who_picked, item_name )
  end,
},
{
  id = "GRAHAM_GUARD",
  ui_name = "$perkname_graham_guard",
  ui_description = "$perkdesc_graham_guard",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/guard.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/guard.png",
  stackable = STACKABLE_NO,
  func = function( entity_perk_item, entity_who_picked, item_name )
    -- this one is safe exploration, by the way
  
    EntityAddComponent( entity_who_picked, "LuaComponent", 
    {
      _tags = "perk_component",
      script_source_file = "mods/grahamsperks/files/scripts/protection.lua",
      execute_every_n_frame = "30",
    })
  end,
},
{
  id = "GRAHAM_TIPSY_GHOST",
  ui_name = "$perkname_graham_tipsy_ghost",
  ui_description = "$perkdesc_graham_tipsy_ghost",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/tipsy_ghost.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/tipsy_ghost.png",
  usable_by_enemies = false,
  stackable = STACKABLE_YES,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local x,y = EntityGetTransform( entity_who_picked )
    local child_id = EntityLoad( "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_ghost.xml", x, y )
    EntityAddTag( child_id, "perk_entity" )
    EntityAddChild( entity_who_picked, child_id )

    EntityLoad("data/entities/items/pickup/potion_empty.xml", x, y)

    perk_pickup_event("GHOST")
    
    if ( GameHasFlagRun( "player_status_tipsy_ghost" ) == false ) then
      GameAddFlagRun( "player_status_tipsy_ghost" )
      add_ghostness_level(entity_who_picked)
    end

    ConvertMaterialEverywhere( CellFactory_GetType("alcohol_gas"), CellFactory_GetType("graham_air") )
  end,
  func_remove = function( entity_who_picked )
    reset_perk_pickup_event("GHOST")
    GameRemoveFlagRun( "player_status_tipsy_ghost" )
  end,
  
},
{
  id = "GRAHAM_PROJECTILES",
  ui_name = "$perkname_graham_proj",
  ui_description = "$perkdesc_graham_proj",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/projectiles.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/projectiles.png",
  not_in_default_perk_pool = false,
  usable_by_enemies = true,
  stackable = STACKABLE_YES,
  stackable_maximum = 4,
  stackable_is_rare = true,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
    local resistance = 0
    if( damagemodels ~= nil ) then
      for i,damagemodel in ipairs(damagemodels) do
        resistance = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "projectile" ))
        resistance = resistance * 0.125
        ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", tostring(resistance) )
        break
      end
    end

    EntityAddComponent( entity_who_picked, "LuaComponent",
		{
			_tags = "perk_component",
			script_damage_about_to_be_received = "mods/grahamsperks/files/effects/damagedouble.lua",
			execute_every_n_frame = "-1",
		} )
  end,

  func_remove = function( entity_who_picked )
    local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
    if( damagemodels ~= nil ) then
      for i,damagemodel in ipairs(damagemodels) do
        ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", "1.0" )
      end
    end
  end,
},
{
  id = "GRAHAM_BLEEDING_EDGE",
  ui_name = "$perkname_graham_edge",
  ui_description = "$perkdesc_graham_edge",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/bleedingedge.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/bleedingedge.png",
  usable_by_enemies = false,
  not_in_default_perk_pool = false,
  stackable = STACKABLE_NO,
  func = function( entity_perk_item, entity_who_picked, item_name )
    -- technically this should work perfectly fine when used by enemies, which would be really funny
    -- wouldn't apply to the player, or exclude the entity that has it, though
    -- if i fix those later, i'll turn it on
  EntityAddComponent( entity_who_picked, "LuaComponent",
  {
    _tags = "perk_component",
    script_source_file = "mods/grahamsperks/files/scripts/bleeding_edge.lua",
    execute_every_n_frame = "1",
  } )
  end,
},
{
  id = "GRAHAM_BLOODORB",
  ui_name = "$perkname_graham_bloodorb",
  ui_description = "$perkdesc_graham_bloodorb",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/wanderingeye.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/wanderingeye.png",
  usable_by_enemies = false,
  not_in_default_perk_pool = false,
  stackable = STACKABLE_YES,
  stackable_is_rare = true,
  stackable_maximum = 3,
  func = function( entity_perk_item, entity_who_picked, item_name )
    for i = 1, 3, 1 do
      local x,y = EntityGetTransform( entity_who_picked )
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

        EntityAddComponent(child_id, "VariableStorageComponent", {
          _tags="wizard_orb_id",
          name="wizard_orb_id",
          value_int=orbs,
        })
      else
        EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
          _tags="graham_blood_orbs",
          value_int=1,
        })

        EntityAddComponent(child_id, "VariableStorageComponent", {
          _tags="wizard_orb_id",
          name="wizard_orb_id",
          value_int=1,
        })
      end
      
      EntityAddChild(entity_who_picked, child_id)
    end
  end,
  func_remove = function( entity_who_picked )
    local varsto = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_blood_orbs")
    if varsto ~= nil then
      ComponentSetValue2(varsto, "value_int", 0)
    end
	end,
},
{
  id = "GRAHAM_MAP",
  ui_name = "$perkname_graham_map",
  ui_description = "$perkdesc_graham_map",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/map.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/map.png",
  not_in_default_perk_pool = true,
  stackable = STACKABLE_NO,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local x,y = EntityGetTransform( entity_who_picked )
    local child_id = EntityLoad( "mods/grahamsperks/files/entities/map/map.xml", x, y )
    EntityAddTag( child_id, "perk_entity" )
    EntityAddChild( entity_who_picked, child_id )
  end,
},
{
  id = "GRAHAM_MAP2",
  ui_name = "$perkname_graham_map2",
  ui_description = "$perkdesc_graham_map2",
  ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/map2.png",
  perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/map2.png",
  not_in_default_perk_pool = true,
  stackable = STACKABLE_NO,
  func = function( entity_perk_item, entity_who_picked, item_name )
    local x,y = EntityGetTransform( entity_who_picked )
    local child_id = EntityLoad( "mods/grahamsperks/files/entities/map2/map.xml", x, y )
    EntityAddTag( child_id, "perk_entity" )
    EntityAddChild( entity_who_picked, child_id )
  end,
},

}
for i,v in ipairs(to_insert) do
    table.insert(perk_list, v)
end

----UNLOCKABLES----

if HasFlagPersistent("graham_progress_sheep") then
table.insert(perk_list,{
    id = "GRAHAM_SHEEPIFICATION",
    ui_name = "$perkname_graham_sheepification",
    ui_description = "$perkdesc_graham_sheepification",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/baba.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/baba.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_YES,
    stackable_maximum = 2,
    func = function( entity_perk_item, entity_who_picked, item_name )
        EntityAddComponent2(entity_who_picked,"LuaComponent",
        {
            _tags = "perk_component",
            _enabled = 1,
            script_shot="mods/grahamsperks/files/polychance.lua",
            execute_every_n_frame= -1
        })
    end,
})
else
table.insert(perk_list,{
    id = "GRAHAM_SHEEPIFICATION",
    ui_name = "$perkname_graham_sheepification",
    ui_description = "$perkdesc_graham_sheepification",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/baba.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/baba.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = true,
    stackable = STACKABLE_YES,
    stackable_maximum = 2,
    func = function( entity_perk_item, entity_who_picked, item_name )
            EntityAddComponent2(entity_who_picked,"LuaComponent",
        {
            _tags = "perk_component",
            _enabled = 1,
            script_shot="mods/grahamsperks/files/polychance.lua",
            execute_every_n_frame= -1
        })
    end,
})
end

if HasFlagPersistent("graham_progress_robot") then
table.insert(perk_list,{
    id = "GRAHAM_MATERIALIST",
    ui_name = "$perkname_graham_materialist",
    ui_description = "$perkdesc_graham_materialist",
    ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/materialist.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/materialist.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/wandcharger.xml", x, y )
		EntityAddChild( entity_who_picked, entity_id )
    end,
})
else
table.insert(perk_list,{
    id = "GRAHAM_MATERIALIST",
    ui_name = "$perkname_graham_materialist",
    ui_description = "$perkdesc_graham_materialist",
    ui_icon = "mods/grahamsperks/files/perks/perks_gfx/gui/materialist.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/materialist.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = true,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		local x, y = EntityGetTransform( entity_who_picked )
		local entity_id = EntityLoad( "mods/grahamsperks/files/entities/wandcharger.xml", x, y )
		EntityAddChild( entity_who_picked, entity_id )
    end,
})
end
if HasFlagPersistent("graham_progress_lucky") then
table.insert(perk_list,{
    id = "GRAHAM_LUCKYDAY",
    ui_name = "$perkname_graham_luckyday",
    ui_description = "$perkdesc_graham_luckyday",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/luckyday.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/luckyday.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_about_to_be_received = "mods/grahamsperks/files/luckyday.lua",
			execute_every_n_frame = "-1",
		} )
    end,
})
else
table.insert(perk_list,{
    id = "GRAHAM_LUCKYDAY",
    ui_name = "$perkname_graham_luckyday",
    ui_description = "$perkdesc_graham_luckyday",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/luckyday.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/luckyday.png",
    usable_by_enemies = true,
    not_in_default_perk_pool = true,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_about_to_be_received = "mods/grahamsperks/files/luckyday.lua",
			execute_every_n_frame = "-1",
		} )
    end,
})
end

if HasFlagPersistent("graham_progress_tech") then
table.insert(perk_list,{
    id = "GRAHAM_ROBOTS",
    ui_name = "$perkname_graham_robot",
    ui_description = "$perkdesc_graham_robot",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/robot.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/robot.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    game_effect = "PROTECTION_ELECTRICITY",
    remove_other_perks = {"PROTECTION_ELECTRICITY"},
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
        GenomeSetHerdId( entity_who_picked, "player_robotic" )
	local x, y = EntityGetTransform( entity_who_picked )
	local entity_id = EntityLoad( "mods/grahamsperks/files/entities/oil.xml", x, y )
	EntityAddChild( entity_who_picked, entity_id )
    end,
})
else
table.insert(perk_list,{
    id = "GRAHAM_ROBOTS",
    ui_name = "$perkname_graham_robot",
    ui_description = "$perkdesc_graham_robot",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/robot.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/robot.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = true,
    game_effect = "PROTECTION_ELECTRICITY",
    remove_other_perks = {"PROTECTION_ELECTRICITY"},
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
    GenomeSetHerdId( entity_who_picked, "player_robotic" )
	local x, y = EntityGetTransform( entity_who_picked )
	local entity_id = EntityLoad( "mods/grahamsperks/files/entities/oil.xml", x, y )
	EntityAddChild( entity_who_picked, entity_id )
    end,
})
end

if HasFlagPersistent("graham_progress_hunger") then
table.insert(perk_list,{
    id = "GRAHAM_DEATH",
    ui_name = "$perkname_graham_death",
    ui_description = "$perkdesc_graham_death",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/death.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/death.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		AddFlagPersistent("graham_death_hp_boost")
		add_halo_level(entity_who_picked, -1)
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_received = "mods/grahamsperks/files/demise.lua",
			execute_every_n_frame = "-1",
		} )
    end,
	func_remove = function( entity_who_picked )
		RemoveFlagPersistent("graham_death_hp_boost")
	end,
})
else
table.insert(perk_list,{
    id = "GRAHAM_DEATH",
    ui_name = "$perkname_graham_death",
    ui_description = "$perkdesc_graham_death",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/death.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/death.png",
    usable_by_enemies = false,
    not_in_default_perk_pool = true,
    stackable = STACKABLE_NO,
    func = function( entity_perk_item, entity_who_picked, item_name )
		AddFlagPersistent("graham_death_hp_boost")
		add_halo_level(entity_who_picked, -1)
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_damage_received = "mods/grahamsperks/files/demise.lua",
			execute_every_n_frame = "-1",
		} )
    end,
	func_remove = function( entity_who_picked )
		RemoveFlagPersistent("graham_death_hp_boost")
	end,
})
end

if HasFlagPersistent("graham_progress_immunity") then
  table.insert(perk_list,{
    id = "GRAHAM_IMMUNITY_AURA",
    ui_name = "$perkname_graham_immunityaura",
    ui_description = "$perkdesc_graham_immunityaura",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/immunityaura.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/immunityaura.png",
    usable_by_enemies = false,
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
      local x, y = EntityGetTransform( entity_who_picked )
      local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/none.xml", x, y )
      EntityAddChild( entity_who_picked, entity_id )
  
      EntityLoad("mods/grahamsperks/files/entities/immunityaura/potion_flum.xml", x, y)
  
      EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
        name="graham_immunityaura",
        value_string="NONE",
      })
    end,
  })
else
  table.insert(perk_list,{
    id = "GRAHAM_IMMUNITY_AURA",
    ui_name = "$perkname_graham_immunityaura",
    ui_description = "$perkdesc_graham_immunityaura",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/immunityaura.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/immunityaura.png",
    usable_by_enemies = false,
    stackable = STACKABLE_NO,
    not_in_default_perk_pool = true,
    func = function( entity_perk_item, entity_who_picked, item_name )
      local x, y = EntityGetTransform( entity_who_picked )
      local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/none.xml", x, y )
      EntityAddChild( entity_who_picked, entity_id )
  
      EntityLoad("mods/grahamsperks/files/entities/immunityaura/potion_flum.xml", x, y)
  
      EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
        name="graham_immunityaura",
        value_string="NONE",
      })
    end,
  })
end

if HasFlagPersistent("graham_bloodymimic_killed") then
  table.insert(perk_list,{
    id = "GRAHAM_MAGIC_SKIN",
    ui_name = "$perkname_graham_magicskin",
    ui_description = "$perkdesc_graham_magicskin",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/magicskin.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/magicskin.png",
    usable_by_enemies = false,
    stackable = STACKABLE_YES,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
      add_halo_level(entity_who_picked, -1)
      local x, y = EntityGetTransform(entity_who_picked)

      local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
      if( damagemodels ~= nil ) then
        for i,damagemodel in ipairs(damagemodels) do
          local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
          local max_hp = old_max_hp * 2
          
          local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
          if max_hp_cap > 0 then
            max_hp = math.min( max_hp, max_hp_cap )
          end
          
          local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
          current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
          
          ComponentSetValue( damagemodel, "max_hp", max_hp )
          ComponentSetValue( damagemodel, "hp", current_hp )
        end
      end

      local value = GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ) + 1
      GlobalsSetValue( "GRAHAM_MAGIC_SKIN_COUNTER", value )
      value = tostring(math.min(6, value))
      -- EntityLoad("data/entities/items/wand_level_0" .. value .. ".xml", x, y - 5)
  
      local child_id = EntityLoad( "mods/grahamsperks/files/entities/magic_skin.xml", x, y )
      EntityAddChild( entity_who_picked, child_id )
    end,
    func_remove = function( entity_who_picked )
      local count = tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ))
      GlobalsSetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" )
      local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
      if( damagemodels ~= nil ) then
        for i,damagemodel in ipairs(damagemodels) do
          local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
          local max_hp = old_max_hp
          while count > 0 do
            max_hp = max_hp * 0.5
            count = count - 1
          end
          
          local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
          if max_hp_cap > 0 then
            max_hp = math.min( max_hp, max_hp_cap )
          end
          
          local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
          current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
          
          ComponentSetValue( damagemodel, "max_hp", max_hp )
          ComponentSetValue( damagemodel, "hp", current_hp )
        end
      end
    end,
  })
else
  table.insert(perk_list,{
    id = "GRAHAM_MAGIC_SKIN",
    ui_name = "$perkname_graham_magicskin",
    ui_description = "$perkdesc_graham_magicskin",
    ui_icon =   "mods/grahamsperks/files/perks/perks_gfx/gui/magicskin.png",
    perk_icon = "mods/grahamsperks/files/perks/perks_gfx/out/magicskin.png",
    usable_by_enemies = false,
    stackable = STACKABLE_YES,
    not_in_default_perk_pool = true,
    func = function( entity_perk_item, entity_who_picked, item_name )
      add_halo_level(entity_who_picked, -1)
      local x, y = EntityGetTransform(entity_who_picked)

      local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
      if( damagemodels ~= nil ) then
        for i,damagemodel in ipairs(damagemodels) do
          local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
          local max_hp = old_max_hp * 2
          
          local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
          if max_hp_cap > 0 then
            max_hp = math.min( max_hp, max_hp_cap )
          end
          
          local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
          current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
          
          ComponentSetValue( damagemodel, "max_hp", max_hp )
          ComponentSetValue( damagemodel, "hp", current_hp )
        end
      end

      local value = GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ) + 1
      GlobalsSetValue( "GRAHAM_MAGIC_SKIN_COUNTER", value )
      value = tostring(math.min(6, value))
      -- EntityLoad("data/entities/items/wand_level_0" .. value .. ".xml", x, y - 5)
  
      local child_id = EntityLoad( "mods/grahamsperks/files/entities/magic_skin.xml", x, y )
      EntityAddChild( entity_who_picked, child_id )
    end,
    func_remove = function( entity_who_picked )
      local count = tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ))
      GlobalsSetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" )
      local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
      if( damagemodels ~= nil ) then
        for i,damagemodel in ipairs(damagemodels) do
          local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
          local max_hp = old_max_hp
          while count > 0 do
            max_hp = max_hp * 0.5
            count = count - 1
          end
          
          local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
          if max_hp_cap > 0 then
            max_hp = math.min( max_hp, max_hp_cap )
          end
          
          local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
          current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
          
          ComponentSetValue( damagemodel, "max_hp", max_hp )
          ComponentSetValue( damagemodel, "hp", current_hp )
        end
      end
    end,
  })
end