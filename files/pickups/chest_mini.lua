dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )
dofile_once( "data/scripts/game_helpers.lua" )

-------------------------------------------------------------------------------

function make_random_card( x, y )
	-- this does NOT call SetRandomSeed() on purpouse. 
	-- SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end


	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

function chest_load_gold_entity( entity_filename, x, y, remove_timer )
	local eid = load_gold_entity( entity_filename, x, y, remove_timer )
	local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

	-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
	if item_comp ~= nil then
		if( ComponentGetValue2( item_comp, "auto_pickup") ) then
			ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
		end
	end
end

-------------------------------------------------------------------------------

function drop_random_reward( x, y, entity_id, rand_x, rand_y, set_rnd_  )
	local set_rnd = false 
	if( set_rnd_ ~= nil ) then set_rnd = set_rnd_ end

	if( set_rnd ) then
		SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	end

	local good_item_dropped = true

	local entities = {}
	local drops = {}
	local value = nil

	local remove_gold_timer = false
	
	local comp_worldstate = EntityGetFirstComponent( GameGetWorldStateEntity(), "WorldStateComponent" )
	if( comp_worldstate ~= nil ) then
		if( ComponentGetValue2( comp_worldstate, "perk_gold_is_forever" ) ) then
			remove_gold_timer = true
		end
	end

	-- CHEST DROPS GO HERE (Welcome to elseif hell)
	local count = 1
	while( count > 0 ) do
		count = count - 1
		local rnd = Random(1,100)
		if rnd <= 15 then
			-- 15%: Healthy Heart
			table.insert( entities, { "mods/grahamsperks/files/pickups/heart_healthy.xml" })
		elseif rnd <= 30 then
			-- 15%: Goobers
			table.insert( entities, { "mods/grahamsperks/files/entities/mini_tanks/tank.xml" })
			if Random(1, 2) == 1 then
				table.insert( entities, { "mods/grahamsperks/files/entities/mini_tanks/tank_rocket.xml" })
			else
				table.insert( entities, { "mods/grahamsperks/files/entities/mini_tanks/tank_super.xml" })
			end
			table.insert( entities, { "mods/grahamsperks/files/entities/mini_tanks/toasterbot.xml" })
		elseif rnd <= 35 then
			-- 5%: Coffee
			table.insert( entities, { "mods/grahamsperks/files/entities/coffee.xml" })
		elseif rnd <= 40 then
			-- 5%: Book
			table.insert( entities, { "mods/grahamsperks/files/entities/books/chestbook.xml" })
		elseif rnd <= 55 then
			-- 15%: Spells
			local amount = Random(3,5)
			for i=1,amount do
				make_random_card( x + (i - (amount / 2)) * 8, y - 4 + Random(-5,5) )
			end
		elseif rnd <= 65 then
			-- 10%: Cyber Eye or Verikuu
			if Random(1, 2) == 1 then
				table.insert( entities, { "mods/grahamsperks/files/pickups/cybereye.xml" } )
			else
				table.insert( entities, { "mods/grahamsperks/files/pickups/bloodmoon.xml" } )
			end
		elseif rnd <= 75 then
			-- 10%: Campfire (worse)
			table.insert(entities, { "mods/grahamsperks/files/entities/fireplace_worse.xml" })
		elseif rnd <= 85 then
			-- 10%: Ham
			for i = 1, Random(3, 6) do
				table.insert(entities, { "data/entities/animals/longleg.xml" })
			end
			local depth = math.max(0, math.ceil(y / 400))
			for i = 1, depth do
				table.insert(entities, { "data/entities/animals/longleg.xml" })
			end
		elseif rnd <= 90 then
			-- 5%: Swapper
			if Random(1, 10) == 1 then
				table.insert(entities, { "data/entities/animals/wizard_swapper.xml" })
			else
				table.insert(entities, { "data/entities/items/wand_level_03.xml" })
			end
		elseif rnd <= 98 then
			-- 8%: Double roll
			count = count + 2
		else
			-- 2%: Triple roll
			count = count + 3
		end
	end

	for i,entity in ipairs(entities) do
		local eid = 0 
		if( entity[2] ~= nil and entity[3] ~= nil ) then 
			eid = EntityLoad( entity[1], entity[2], entity[3] ) 
		else
			eid = EntityLoad( entity[1], rand_x, rand_y )
			EntityApplyTransform( eid, x + Random(-10,10), y - 4 + Random(-5,5)  )
		end

		local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

		-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
		if item_comp ~= nil then
			if( ComponentGetValue2( item_comp, "auto_pickup") ) then
				ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )
			end
		end

		if entity[1] == "data/entities/animals/longleg.xml" then
			EntityAddComponent2(eid, "LuaComponent", {
				script_source_file="mods/grahamsperks_chinese/files/scripts/tank_teleport.lua"
			})
		end
	end


	return good_item_dropped
end

function on_open( entity_item )
	local x, y = EntityGetTransform( entity_item )
	local rand_x = x
	local rand_y = y

	-- PositionSeedComponent
	local position_comp = EntityGetFirstComponent( entity_item, "PositionSeedComponent" )
	if( position_comp ) then
		rand_x = tonumber(ComponentGetValue( position_comp, "pos_x") )
		rand_y = tonumber(ComponentGetValue( position_comp, "pos_y") )
	end

	SetRandomSeed( rand_x, rand_y )

	-- money
	-- card
	-- potion
	-- wand
	-- bunch of spiders
	-- bomb
	local good_item_dropped = drop_random_reward( x, y, entity_item, rand_x, rand_y, false )
	
	if good_item_dropped then
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
	else
		EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", x, y)
	end
end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "$log_chest", "" )
	-- GameTriggerMusicCue( "item" )

	--if (remove_entity == false) then
	--	EntityLoad( "data/entities/misc/chest_random_dummy.xml", x, y )
	--end

	on_open( entity_item )
	
	EntityKill( entity_item )
end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
	
	on_open( entity_item )

	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end