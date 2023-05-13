graham_oneoffs = perk_pickup 

function perk_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks, no_perk_entity_ )
	
	for i, perk in ipairs(perk_list) do
		if perk.ui_name == item_name then
			if perk.one_off_effect == true then
				local graham_oneoffs = tonumber(GlobalsGetValue( "GRAHAM_ONEOFFS", "1" ))
				GlobalsSetValue( "GRAHAM_ONEOFFS", tostring(1 + graham_oneoffs) )
				if GameHasFlagRun("PERK_PICKED_GRAHAM_MATERIALIST") then GamePrint("$graham_materialist") end
				break
			end
		end
	end

	graham_oneoffs( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks, no_perk_entity_ )
end