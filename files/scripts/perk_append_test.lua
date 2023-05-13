function perk_spawn_many( x, y, dont_remove_others_, ignore_these_ )
    dofile_once("data/scripts/lib/utilities.lua")
    dofile_once( "data/scripts/perks/perk_list.lua" )
    dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
    dofile_once("data/scripts/perks/perk_utilities.lua")

	local perk_count = tonumber( GlobalsGetValue( "TEMPLE_PERK_COUNT", "3" ) )
	
	local count = perk_count
	local width = 60
	local item_width = width / count
	local dont_remove_others = dont_remove_others_ or false
	local ignore_these = ignore_these_ or {}


	local perks = perk_get_spawn_order( ignore_these )

	for i=1,count do
		local next_perk_index = tonumber( GlobalsGetValue( "TEMPLE_NEXT_PERK_INDEX", "1" ) )
		local perk_id = perks[next_perk_index]
		
		while( perk_id == nil or perk_id == "" ) do
			-- if we over flow
			perks[next_perk_index] = "LEGGY_FEET"
			next_perk_index = next_perk_index + 1		
			if next_perk_index > #perks then
				next_perk_index = 1
			end
			perk_id = perks[next_perk_index]
		end

		-- ignore_these == empty?
		--[[
		for a,b in ipairs( ignore_these ) do
			if ( perk_id == b ) then
				next_perk_index = next_perk_index + 1
				if next_perk_index > #perks then
					next_perk_index = 1
				end
				perk_id = perks[next_perk_index]
				break
			end
		end
		]]--
		
		next_perk_index = next_perk_index + 1
		if next_perk_index > #perks then
			next_perk_index = 1
		end
		GlobalsSetValue( "TEMPLE_NEXT_PERK_INDEX", tostring(next_perk_index) )

		local magicskin = tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ))
		if magicskin ~= nil then
			if magicskin > 0 then
				SetRandomSeed(x + (i-0.5)*item_width, perk_id)
				local rand = (( magicskin * 2.5 )^2) + 50
				if rand >= Random(0, 99) then
					perk_id = "GRAHAM_MAGIC_SKIN"
				end
				-- GamePrint("magic skins owned: " .. tostring(magicskin))
				-- GamePrint("chance: " .. tostring(rand))
			end
		end

		GameAddFlagRun( "PERK_" .. perk_id )
		perk_spawn( x + (i-0.5)*item_width, y, perk_id, dont_remove_others )
	end
end