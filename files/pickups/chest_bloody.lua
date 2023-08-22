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
	
	-- using deferred loading of entities, since loading some of them (e.g. potion.xml) will call SetRandomSeed(...)
	-- if position is not given (in entities table), will load the entity to rand_x, rand_y and then move it to chest position
	-- reason for this is that then the SetRandomSeed() of those entities will be deterministic 
	-- but for some reason it cannot be done to random_card.xml, since I'm guessing
	local entities = {}

	local count = 1
	while( count > 0 ) do
		count = count - 1
		local rnd = 9001

		dofile_once( "data/scripts/perks/perk.lua" )
		local pid = perk_spawn_random( x, y, true )
		EntityRemoveTag(pid, "perk")
		good_item_dropped = true
		

	end

	for i,entity in ipairs(entities) do
		local eid = 0 
		if( entity[2] ~= nil and entity[3] ~= nil ) then 
			eid = EntityLoad( entity[1], entity[2], entity[3] ) 
		else
			eid = EntityLoad( entity[1], rand_x, rand_y )
			EntityApplyTransform( eid, x, y - 4)
		end

		local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

		-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
		if item_comp ~= nil then
			if( ComponentGetValue2( item_comp, "auto_pickup") ) then
				ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
			end
		end
	end


	return good_item_dropped
end

function drop_money( entity_item )
	
	-- 
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