---@diagnostic disable: undefined-global
local STREAMING_EVENT_AUTHOR_GRAHAM = "Graham" -- not sure if this should be 'Graham' or 'Graham's Things'
local function graham_add_name(entity)
	local name = StreamingGetRandomViewerName()
	if name ~= "" then
		local gui = GuiCreate()
		GuiStartFrame(gui)
		local width = GuiGetTextDimensions( gui, name, 0.7 ) * 0.75
		GuiDestroy(gui)

		EntityAddComponent2(entity, "SpriteComponent", {
			_tags = "enabled_in_world",
			image_file = "data/fonts/font_pixel_white.xml",
			emissive = true,
			is_text_sprite = true,
			offset_x = width,
			offset_y = -10,
			alpha = 0.5,
			update_transform = true,
			update_transform_rotation = false,
			text = name,
			has_special_scale = true,
			special_scale_x = 0.7,
			special_scale_y = 0.7,
			z_index = -9000,
			never_ragdollify_on_death = true
		})
	end
end
local to_insert = {
	{
		id             = "GRAHAM_BANISH",
		ui_name        = "$graham_streaming_name_banish",
		ui_description = "$graham_streaming_desc_banish",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png", -- is this used anywhere?
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.2,
        delay_timer    = 180,
		action_delayed = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
			SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            local enemies = EntityGetInRadiusWithTag(x, y, 180, "graham_midas_curseable")
            if #enemies > 0 then
                local enemy = enemies[Random(1, #enemies)]
                x, y = EntityGetTransform(enemy)
                dofile_once("mods/grahamsperks/files/scripts/midas_gold.lua")
                obliterate(enemy)
                EntityLoad( "mods/grahamsperks/files/entities/lucky.xml", x, y )
				GameScreenshake(120)
            else
                GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_denied", x, y)
            end
		end,
	},
	{
		id             = "GRAHAM_MINICHEST",
		ui_name        = "$graham_streaming_name_minichest",
		ui_description = "$graham_streaming_desc_minichest",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 1,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            if Random(1, 10) == 10 then
				EntityLoad("data/entities/animals/mini_mimic.xml", x + 8, y)
            else
                EntityLoad("mods/grahamsperks/files/pickups/chest_mini.xml", x, y + 20)
            end
		end,
	},
	{
		id             = "GRAHAM_BLOODYCHEST",
		ui_name        = "$graham_streaming_name_bloodychest",
		ui_description = "$graham_streaming_desc_bloodychest",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.25,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
            if Random(1, 8) == 8 then
				EntityLoad("data/entities/animals/bloody_mimic.xml", x + 8, y)
            else
                EntityLoad("mods/grahamsperks/files/pickups/chest_bloody.xml", x, y + 20)
            end
		end,
	},
	{
		id             = "GRAHAM_LOSTCHEST",
		ui_name        = "$graham_streaming_name_lostchest",
		ui_description = "$graham_streaming_desc_lostchest",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
            EntityLoad("mods/grahamsperks/files/pickups/chest_lost.xml", x, y + 20)
		end,
	},
	{
		id             = "GRAHAM_DRONES",
		ui_name        = "$graham_streaming_name_drones",
		ui_description = "$graham_streaming_desc_drones",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
			shoot_projectile(player, "mods/grahamsperks/files/spells/shield_drone.xml", x + 12, y, 12, 0)
			shoot_projectile(player, "mods/grahamsperks/files/spells/support_drone.xml", x - 12, y, -12, 0)
			shoot_projectile(player, "mods/grahamsperks/files/spells/attack_drone.xml", x, y - 8, 0, -8)
		end,
	},
	{
		id             = "GRAHAM_HAIL",
		ui_name        = "$graham_streaming_name_hail",
		ui_description = "$graham_streaming_desc_hail",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_NEUTRAL,
		weight         = 1,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
			shoot_projectile(player, "mods/grahamsperks/files/spells/cloud_hail.xml", x, y, 0, 0)
			shoot_projectile(player, "mods/grahamsperks/files/spells/cloud_hail.xml", x + 65, y - 8, 0, 0)
			shoot_projectile(player, "mods/grahamsperks/files/spells/cloud_hail.xml", x - 65, y - 8, 0, 0)
		end,
	},
	{
		id             = "GRAHAM_MIDASMEAT",
		ui_name        = "$graham_streaming_name_midasmeat",
		ui_description = "$graham_streaming_desc_midasmeat",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 1,
		delay_timer    = 180,
		action_delayed = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("mods/grahamsperks/files/streaming/midasmeat.xml", x, y)
		end,
	},
	{
		id             = "GRAHAM_MUNDANE",
		ui_name        = "$graham_streaming_name_mundane",
		ui_description = "$graham_streaming_desc_mundane",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_NEUTRAL,
		weight         = 1,
		delay_timer    = 180,
		action_delayed = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("mods/grahamsperks/files/streaming/mundane.xml", x, y)
		end,
	},
	{
		id             = "GRAHAM_CORRUPT",
		ui_name        = "$graham_streaming_name_corrupt",
		ui_description = "$graham_streaming_desc_corrupt",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_NEUTRAL,
		weight         = 0.75,
		delay_timer    = 180,
		action_delayed = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityLoad("mods/grahamsperks/files/streaming/corrupt.xml", x, y)
		end,
	},
	{
		id             = "GRAHAM_CHAOS",
		ui_name        = "$graham_streaming_name_chaos",
		ui_description = "$graham_streaming_desc_chaos",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 1.25,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
            EntityAddRandomStains(player, CellFactory_GetType("graham_tele_chaotic"), Random(20, 80))
			local enemies = EntityGetInRadiusWithTag(x, y, 240, "enemy")
			for i = 1, #enemies do
				EntityAddRandomStains(enemies[i], CellFactory_GetType("graham_tele_chaotic"), Random(20, 80))
			end
		end,
	},
	{
		id             = "GRAHAM_BRAMBLES",
		ui_name        = "$graham_streaming_name_brambles",
		ui_description = "$graham_streaming_desc_brambles",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 1,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local count = 28
			local spawn_x = 60
			local spawn_y = 0
			local rot_inc = math.pi * 2 / count
			for i=1, count do
				local eid = EntityLoad("mods/grahamsperks/files/entities/brambles.xml", x + spawn_x, y + spawn_y)
				local comp = EntityGetFirstComponent(eid, "ProjectileComponent")
				if comp ~= nil then
					ComponentSetValue2(comp, "lifetime", 200)
				end
				spawn_x, spawn_y = vec_rotate(spawn_x, spawn_y, rot_inc)
			end
			count = 42
			spawn_x = 90
			spawn_y = 0
			rot_inc = math.pi * 2 / count
			for i=1, count do
				local eid = EntityLoad("mods/grahamsperks/files/entities/brambles.xml", x + spawn_x, y + spawn_y)
				local comp = EntityGetFirstComponent(eid, "ProjectileComponent")
				if comp ~= nil then
					ComponentSetValue2(comp, "lifetime", 400)
				end
				spawn_x, spawn_y = vec_rotate(spawn_x, spawn_y, rot_inc)
			end
		end,
	},
	{
		id             = "GRAHAM_FUZZ",
		ui_name        = "$graham_streaming_name_fuzz",
		ui_description = "$graham_streaming_desc_fuzz",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 0.5,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local count = 2
			local spawn_x, spawn_y = 0, 0
			if Random(1, 2) == 1 then
				spawn_x = 160
			else
				spawn_y = 160
			end
			local rot_inc = math.pi * 2 / count
			local eid
			for i=1, count do
				EntityLoad("data/entities/particles/poof_blue.xml", x + spawn_x + 10, y + spawn_y)
				eid = EntityLoad("data/entities/animals/graham_fuzz.xml", x + spawn_x + 10, y + spawn_y)
				graham_add_name(eid)
				EntityLoad("data/entities/particles/poof_blue.xml", x + spawn_x - 10, y + spawn_y)
				eid = EntityLoad("data/entities/animals/graham_fuzz.xml", x + spawn_x - 10, y + spawn_y)
				graham_add_name(eid)
				spawn_x, spawn_y = vec_rotate(spawn_x, spawn_y, rot_inc)
			end
		end,
	},
	{
		id             = "GRAHAM_HAZMAT",
		ui_name        = "$graham_streaming_name_hazmat",
		ui_description = "$graham_streaming_desc_hazmat",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 0.2,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local count = 4
			local spawn_x, spawn_y = 70, 70
			local rot_inc = math.pi * 2 / count
			local eid
			for i=1, count do
				eid = EntityLoad("data/entities/animals/graham_miner_gasser.xml", x + spawn_x, y + spawn_y)
				graham_add_name(eid)
				EntityLoad("data/entities/particles/poof_blue.xml", x + spawn_x, y + spawn_y)
				spawn_x, spawn_y = vec_rotate(spawn_x, spawn_y, rot_inc)
			end
		end,
	},
	{
		id             = "GRAHAM_TANKS",
		ui_name        = "$graham_streaming_name_tanks",
		ui_description = "$graham_streaming_desc_tanks",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		action          = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local options = { "tank.xml", "tank_rocket.xml", "tank_super.xml", "toasterbot.xml" }
			local eid
			eid = EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x + 30, y + 30)
			graham_add_name(eid)
			eid = EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x - 30, y + 30)
			graham_add_name(eid)
			eid = EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x + 30, y - 30)
			graham_add_name(eid)
			eid = EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x - 30, y - 30)
			graham_add_name(eid)
		end,
	},
	{
		id             = "GRAHAM_BALLS",
		ui_name        = "$graham_streaming_name_balls",
		ui_description = "$graham_streaming_desc_balls",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 0.75,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local eid = EntityLoad("mods/grahamsperks/files/streaming/balls.xml")
			EntityAddChild(player, eid)
		end,
	},
	{
		id             = "GRAHAM_MANAHEART",
		ui_name        = "$graham_streaming_name_manaheart",
		ui_description = "$graham_streaming_desc_manaheart",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		delay_timer    = 7200,
		action_delayed = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			CreateItemActionEntity( "GRAHAM_MANAHEART", x, y )
			EntityLoad("data/entities/particles/poof_blue.xml", x, y)
		end,
	},
	{
		id             = "GRAHAM_PASSIVEALWAYSCAST",
		ui_name        = "$graham_streaming_name_passivealwayscast",
		ui_description = "$graham_streaming_desc_passivealwayscast",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.25,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local card = GetRandomActionWithType( x, y, 1, ACTION_TYPE_PASSIVE, 666 )
			local wand = find_the_wand_held( player )
				
			if ( wand ~= NULL_ENTITY ) then
				local comp = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" )
				if ( comp ~= nil ) then
					AddGunActionPermanent( wand, card )
				end
			end
		end,
	},
	{
		id             = "GRAHAM_TIPSY",
		ui_name        = "$graham_streaming_name_tipsy",
		ui_description = "$graham_streaming_desc_tipsy",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			for i = 1, Random(2, 4) do
				local eid = EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/tipsy_ghost.xml", x, y)
				EntityAddComponent2(eid, "LifetimeComponent", {
					lifetime=10800,
				})
				local comp = EntityGetFirstComponent(eid, "LuaComponent") or 0
				ComponentSetValue2(comp, "execute_every_n_frame", Random(400, 800))
				if i == 1 then
					EntityAddComponent2(eid, "UIIconComponent", {
						name="$graham_streaming_name_tipsy",
						description="$graham_streaming_desc_tipsy",
						icon_sprite_file="mods/grahamsperks/files/streaming/tipsy.png",
						is_perk=false,
						display_above_head=false,
						display_in_hud=true,
					})
				end
				graham_add_name(eid)
				EntityAddChild(player, eid)
			end
		end,
	},
	{
		id             = "GRAHAM_CONFUSE",
		ui_name        = "$graham_streaming_name_confuse",
		ui_description = "$graham_streaming_desc_confuse",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 0.75,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			EntityIngestMaterial( player, CellFactory_GetType("material_confusion"), 600 )
			local comp = EntityGetFirstComponent(player, "IngestionComponent")
			if comp ~= nil then
				ComponentSetValue2(comp, "ingestion_size", ComponentGetValue2(comp, "ingestion_size") / 2)
			end
		end,
	},
	{
		id             = "GRAHAM_CAT",
		ui_name        = "$graham_streaming_name_cat",
		ui_description = "$graham_streaming_desc_cat",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_NEUTRAL,
		weight         = 0.05,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			EntityLoad("mods/grahamsperks/files/pixelscenes/cat2.xml", x, y + 80)
		end,
	},
	{
		id             = "GRAHAM_WISDOM",
		ui_name        = "$graham_streaming_name_wisdom",
		ui_description = "$graham_streaming_desc_wisdom",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.75,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			EntityLoad("data/entities/particles/poof_blue.xml", x, y)
			EntityLoad("mods/grahamsperks/files/pickups/crystal_ball.xml", x + 5, y + 5)
			EntityLoad("mods/grahamsperks/files/pickups/crystal_ball.xml", x + 5, y - 5)
			EntityLoad("mods/grahamsperks/files/pickups/crystal_ball.xml", x - 5, y + 5)
			EntityLoad("mods/grahamsperks/files/pickups/crystal_ball.xml", x - 5, y - 5)
		end,
	},
	{
		id             = "GRAHAM_TRANSLOCATION",
		ui_name        = "$graham_streaming_name_translocation",
		ui_description = "$graham_streaming_desc_translocation",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_GOOD,
		weight         = 0.5,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local eid = shoot_projectile(player, "mods/grahamsperks/files/spells/translocation.xml", x, y, 0, 0)
			EntityAddChild(player, eid)
			EntityAddComponent(eid, "InheritTransformComponent")
			EntityAddComponent2(eid, "UIIconComponent", {
				name="$graham_streaming_name_translocation",
				description="$graham_streaming_desc_translocation",
				icon_sprite_file="mods/grahamsperks/files/streaming/translocation.png",
				is_perk=false,
				display_above_head=false,
				display_in_hud=true,
			})
		end,
	},
	{
		id             = "GRAHAM_GUARDIAN",
		ui_name        = "$graham_streaming_name_guardian",
		ui_description = "$graham_streaming_desc_guardian",
		ui_icon        = "mods/grahamsperks/files/conjurer/entities/healthy_heart.png",
		ui_author      = STREAMING_EVENT_AUTHOR_GRAHAM,
        kind           = STREAMING_EVENT_BAD,
		weight         = 1,
		action         = function(event)
			local players = EntityGetWithTag("player_unit")
			local player = players[Random(1, #players)]
            local x, y = EntityGetTransform(player)
            SetRandomSeed(x + y - 2480, player + GameGetFrameNum() + 2490)
			local eid = EntityLoad("mods/grahamsperks/files/effects/guardian.xml")
			EntityRemoveComponent(eid, EntityGetFirstComponent(eid, "LuaComponent") or 0)
			EntityAddChild(player, eid)
		end,
	},
}

local len = #streaming_events
for i=1, #to_insert do
	streaming_events[len+i] = to_insert[i]
end