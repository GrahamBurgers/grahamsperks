local player = EntityGetWithTag( "player_unit" )[1]
local children = EntityGetAllChildren( player )

if children == nil then return end
for i, child in ipairs(children) do
	if EntityGetName(child) == "inventory_quick" then
		local inventory_items = EntityGetAllChildren(child)
		if(inventory_items ~= nil) then
			for i, item in ipairs(inventory_items) do
				if EntityHasTag( item, "wand" ) then
					local ac_id = EntityGetFirstComponentIncludingDisabled( item, "AbilityComponent" )
					local mana = ComponentGetValue2( ac_id, "mana" )
					local mana_charge_speed = ComponentGetValue2( ac_id, "mana_charge_speed" )
					--local boost = 0.002 * math.sqrt(tonumber(GlobalsGetValue( "GRAHAM_ONEOFFS", "0" )))
					local oneoffs = tonumber(GlobalsGetValue( "GRAHAM_ONEOFFS", "0" ))
					local boost = (1 - (1 / (oneoffs + 1))) / 60
					ComponentSetValue2(ac_id,"mana",math.max(mana+(mana_charge_speed * boost ), 0))
				end
			end
		end
    break
	end
end