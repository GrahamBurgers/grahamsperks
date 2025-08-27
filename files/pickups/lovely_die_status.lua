dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

function bullet_circle( target_list, count, speed)
	local how_many = count or 4
	local angle_inc = ( 2 * 3.14159 ) / how_many
	local theta = rot
	local length = speed or 200

	for i=1,how_many do
		local target = target_list[math.random(1, #target_list)]
		local vel_x = math.cos( theta ) * length
		local vel_y = 0 - math.sin( theta ) * length
		
		local bid
		
		bid = shoot_projectile( entity_id, target, pos_x + math.cos( theta ) * 12, pos_y - math.sin( theta ) * 12, vel_x, vel_y )
		
		if ( bid ~= nil ) then
			EntityAddComponent2( bid, "VariableStorageComponent", { _tags="no_gold_drop", })
			local comp = EntityGetFirstComponent( bid, "GenomeDataComponent")
			if comp ~= nil then
				-- ComponentSetValue2( comp, "herd_id", StringToHerdId("player") )
				local charm_component = GetGameEffectLoadTo( bid, "CHARM", true )
				if( charm_component ~= nil ) then
					ComponentSetValue2( charm_component, "frames", 600 )
				end
			end
			local proj = EntityGetFirstComponent( bid, "ProjectileComponent")
			if proj ~= nil then
				ComponentSetValue2(proj, "mWhoShot", EntityGetClosestWithTag(pos_x, pos_y, "player_unit"))
			end
		end
		
		theta = theta + angle_inc
	end
end

local status = 0
local rstorage = 0

local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( variablestorages ~= nil ) then
	local uses_counter
	for j,storage_id in ipairs(variablestorages) do
		local var_name = ComponentGetValue( storage_id, "name" )
		if ( var_name == "rolling" ) then
			status = ComponentGetValue2( storage_id, "value_int" )
			rstorage = storage_id
		end
		if ( var_name == "uses" ) then
			uses_counter = storage_id
		end
	end
	
	if ( status > 0 ) then
		status = status + 1
		
		if ( status >= 20 ) then
			local players = EntityGetInRadiusWithTag( pos_x, pos_y, 480, "player_unit" )
			
			status = 0
			local result = Random( 1, 6 )
			local special = Random( 1, 50 )
			
			local textprint = "$item_die_"
			local anim = "default"
			
			if ( special < 50 ) then
				textprint = textprint .. tostring( result )
				
				if ( #players > 0 ) then
					GamePrint( textprint )
				end
				
				anim = "rolled_" .. tostring( result )
				
				if ( result == 1 ) then
					bullet_circle({"data/entities/projectiles/deck/duck.xml"}, 8, 480)
				elseif ( result == 2 ) then
					bullet_circle({"data/entities/projectiles/healshot.xml"}, 20, 120)
				elseif ( result == 3 ) then
					bullet_circle({"data/entities/items/pickup/egg_purple.xml", "data/entities/items/pickup/egg_monster.xml", "data/entities/items/pickup/egg_red.xml"}, 3, 20)
				elseif ( result == 4 ) then
					bullet_circle({"mods/grahamsperks/files/entities/potion_pheromone.xml"}, 4, 180)
				elseif ( result == 5 ) then
					bullet_circle({"data/entities/animals/healerdrone_physics.xml"}, 1, 10)
				elseif ( result == 6 ) then
					bullet_circle({"mods/grahamsperks/files/entities/mini_tanks/tank.xml", "mods/grahamsperks/files/entities/mini_tanks/tank_rocket.xml", "mods/grahamsperks/files/entities/mini_tanks/tank_super.xml", "mods/grahamsperks/files/entities/mini_tanks/toasterbot.xml", }, 3, 230)
				end
			else
				textprint = "$graham_lovely_die_"
				
				if ( result <= 3 ) then
					textprint = textprint .. "bad"
					anim = "rolled_bad"
					dofile_once("data/scripts/perks/perk.lua")
					local x, y = EntityGetTransform(players[1])
					local perk = perk_spawn(x, y, "GENOME_MORE_HATRED", true) or 0
					perk_pickup(perk, players[1], EntityGetName(perk), true, false)
				else
					textprint = textprint .. "good"
					anim = "rolled_good"
					dofile_once("data/scripts/perks/perk.lua")
					perk_spawn( pos_x, pos_y, "GRAHAM_LUKKI_MOUNT", true )
					EntityLoad("data/entities/particles/poof_blue.xml", pos_x, pos_y)
					EntityKill( entity_id )
				end
				
				if ( #players > 0 ) then
					GamePrint( textprint )
				end
			end
			
			edit_component2( entity_id, "SpriteComponent", function(comp,vars)
				ComponentSetValue2( comp, "rect_animation", anim )
			end)

			local uses = ComponentGetValue2(uses_counter, "value_int")
			uses = uses + 1
			ComponentSetValue2(uses_counter, "value_int", uses)
			if uses >= Random(4, 8) + ((GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") and 2) or 0) then
				EntityLoad("data/entities/particles/poof_blue.xml", pos_x, pos_y)
				GamePrint("$graham_lovely_die_poof")
				EntityKill(entity_id)
			end
		end
	end
	
	ComponentSetValue2( rstorage, "value_int", status )
end