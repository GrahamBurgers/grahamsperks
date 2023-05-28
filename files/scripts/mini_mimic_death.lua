function death()
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	local component_id = EntityGetFirstComponent( entity_id, "DamageModelComponent" ) or 0
	SetRandomSeed(x, y)

	-- gold drop
	EntityLoad( "data/entities/items/pickup/goldnugget_10.xml",  x - 5, y - 10 )
	EntityLoad( "data/entities/items/pickup/goldnugget_50.xml",  x, y - 10 )
	EntityLoad( "data/entities/items/pickup/goldnugget_10.xml",  x + 5, y - 10 )

	local rnd = Random(1, 8)
	-- GamePrint("rolled a " .. rnd)
	
	if rnd == 1 then
		EntityLoad( "mods/grahamsperks/files/spells/circle_sweet.xml",  x, y )
	elseif rnd == 2 then
		-- widdle chest
		ComponentSetValue2(component_id, "ragdoll_material", "graham_sweetgas")
		EntityLoad( "mods/grahamsperks/files/pickups/chest_SMALLER.xml",  x, y )
	elseif rnd == 3 then
		ComponentSetValue2(component_id, "ragdoll_material", "gold")
	elseif rnd == 4 then
		ComponentSetValue2(component_id, "ragdoll_material", "material_rainbow")
	elseif rnd == 5 then
		-- Spawn two random mini perk spells
		SetRandomSeed(entity_id + x, component_id + y)
		local options = {
					"GRAHAM_MINI_HEATWAVE",
					"GRAHAM_MINI_FREEZEFIELD",
					"GRAHAM_MINI_DISSOLVEPOWDERS",
					"GRAHAM_MINI_ATTRACTGOLD",
					"GRAHAM_MINI_ELECTRICITY",
					"GRAHAM_MINI_NOKNOCKBACK",
					"GRAHAM_MINI_MIDASMEAT",
				}
				
		local result = options[math.random(1, #options)]
		CreateItemActionEntity(result, x - 12, y)
		
		result = options[math.random(1, #options)]
		CreateItemActionEntity(result, x + 12, y)
	elseif rnd == 6 then
		EntityLoad( "data/entities/items/pickup/goldnugget_200.xml",  x, y - 10 )
	elseif rnd == 7 then
		EntityLoad( "data/entities/items/pickup/heart.xml",  x, y )
	elseif rnd == 8 then
		EntityLoad( "data/entities/items/pickup/potion_porridge.xml",  x, y - 8 )
	end

	-- unlock the mini spells
	if HasFlagPersistent("graham_minimimic_killed") == false then
		AddFlagPersistent("graham_minimimic_killed")
	end
end