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
		if rnd <= 10 then
			-- 10%: Random potions
			table.insert(entities, { "data/entities/items/pickup/potion_random_material.xml" })
			table.insert(entities, { "data/entities/items/pickup/potion_random_material.xml" })
		elseif rnd <= 20 then
			-- 10%: Large extra max health
			if Random(1, 50) == 50 then
				table.insert( entities, { "data/entities/animals/illusions/dark_alchemist.xml" } )
			else
				table.insert( entities, { "data/entities/items/pickup/heart_better.xml" })
			end
		elseif rnd <= 40 then
			-- 20%: Identical lost chest
			-- Load it directly here to avoid rng wackiness
			EntityLoad("mods/grahamsperks/files/pickups/chest_lost.xml", x + 1, y - 1)
		elseif rnd <= 45 then
			-- 10%: Containers
			table.insert(entities, { "mods/grahamsperks/files/pickups/balloon.xml" })
			table.insert(entities, { "mods/grahamsperks/files/pickups/vial.xml" })
			table.insert(entities, { "data/entities/items/pickup/potion.xml" })
		elseif rnd <= 55 then
			-- 5%: Holy bomb
			table.insert(entities, { "data/entities/projectiles/bomb_holy.xml" })
			good_item_dropped = false
		elseif rnd <= 60 then
			-- 5%: Eye
			EntityLoad("mods/grahamsperks/files/entities/eye/blood_orb.xml", x-10, y)
			EntityLoad("mods/grahamsperks/files/entities/eye/blood_orb.xml", x+10, y)
			good_item_dropped = false
		elseif rnd <= 65 then
			-- 5%: Bunch of wands and ghosts
			for i = 1, Random(2, 6) do
				table.insert(entities, { "data/entities/animals/wand_ghost_charmed.xml" })
				if Random(1, 2) == 1 then
					table.insert(entities, { "data/entities/items/wand_level_02.xml" })
				else
					table.insert(entities, { "data/entities/items/wand_level_01.xml" })
				end
			end
			good_item_dropped = false
		elseif rnd <= 70 then
			-- 5%: Mini mimic
			table.insert(entities, { "data/entities/animals/mini_mimic.xml" })
			good_item_dropped = false
		elseif rnd <= 75 then
			-- 5%: Gourds
			for i = 1, Random(1, 3) do
				table.insert(entities, { "data/entities/items/pickup/gourd.xml" })
			end
		elseif rnd <= 80 then
			-- 5%: Gold
			drops = {
				"10",
				"10",
				"10",
				"10",
				"50",
				"50",
				"50",
				"200",
				"200",
				"1000",
			}
			for i = 1, Random(5, 14) do
				value = drops[Random(1, #drops)]
				if Random(1, i) == i then
					chest_load_gold_entity( "data/entities/items/pickup/goldnugget_" .. value .. ".xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
				else
					chest_load_gold_entity( "data/entities/items/pickup/bloodmoney_" .. value .. ".xml", x + Random(-10,10), y - 4 + Random(-10,5), remove_gold_timer )
				end
			end

		elseif rnd <= 82 then
			-- 6%: spells
			local amount = Random(5,8)
			for i=1,amount do
				make_random_card( x + (i - (amount / 2)) * 8, y - 4 + Random(-5,5) )
			end
		elseif rnd <= 88 then
			-- 2%: Midas
			EntityConvertToMaterial(GetUpdatedEntityID(), "midas_precursor")
		elseif rnd <= 90 then
			-- 2%: Wacky items
			drops = {
				"data/entities/items/pickup/physics_greed_die.xml",
				"data/entities/items/pickup/physics_gold_orb_greed.xml",
				"data/entities/items/pickup/musicstone.xml",
				"mods/grahamsperks/files/pickups/magmastone.xml",
				"mods/grahamsperks/files/pickups/safe.xml"
			}
			table.insert(entities, { drops[Random(1, #drops)] })
			table.insert(entities, { drops[Random(1, #drops)] })
		else
			-- 10%: Double roll
			-- No triple roll because the double roll chance is 10% anyway
			count = count + 2
		end
	end

	for i,entity in ipairs(entities) do
		local eid = 0
		if( entity[2] ~= nil and entity[3] ~= nil ) then 
			eid = EntityLoad( entity[1], entity[2], entity[3] ) 
		else
			eid = EntityLoad( entity[1], rand_x + 1, rand_y )
			EntityApplyTransform( eid, x + Random(-12,12), y - 4 + Random(-7,7)  )
		end

		local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

		-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
		if item_comp ~= nil then
			if( ComponentGetValue2( item_comp, "auto_pickup") ) then
				ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
			end
		end

		local comp = EntityGetFirstComponentIncludingDisabled(eid, "ProjectileComponent")
		if comp ~= nil and entity[1] == "data/entities/projectiles/bomb_holy.xml" then
			ComponentSetValue2(comp, "lifetime", 400)
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
	GamePrintImportant( "$logdesc_graham_chest_lost", "" )
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