GamePrint("working")
dofile_once("data/scripts/perks/perk.lua")

local x, y = EntityGetTransform( GetUpdatedEntityID() )
local books = EntityGetWithTag( "graham_book" )

if ( #books > 0 ) then
	local tx = 0
	local ty = 0
	for i,tablet_id in ipairs(books) do
		local in_world = false
		local components = EntityGetComponent( tablet_id, "PhysicsBodyComponent" )
		
		if( components ~= nil ) then
			in_world = true
		end
		
		tx, ty = EntityGetTransform( tablet_id )

		if in_world then
			local distance = math.abs(x - tx) + math.abs(y - ty)
		
			if ( distance < 56 ) then
				if EntityHasTag( tablet_id, "grahamhungry" ) then
					EntityConvertToMaterial( tablet_id, "graham_graymatter_liquid")
					EntityKill( tablet_id )
					if HasFlagPersistent("graham_progress_hunger") then
						EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", tx, ty)
						GamePrintImportant( "$graham_hungered", "$graham_hungered2" )
					else
						local player = EntityGetClosestWithTag(x, y, "player_unit" )
						x, y = EntityGetTransform( player )
		
						GamePrintImportant( "$graham_hungered", "" )
						GamePrint( "$graham_perk_unlock" )
						GamePrint( "$graham_perk_unlock_hunger" )
						AddFlagPersistent("graham_progress_hunger")
						EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
						EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
						dofile_once("data/scripts/perks/perk.lua")
						perk_spawn(x, y-40, "GRAHAM_DEATH")
					end
				else
					EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", tx, ty)
					EntityConvertToMaterial( tablet_id, "gold")
					EntityKill( tablet_id )
					GamePrintImportant( "$log_altar_magic", "" )
				end
			end
		end
	end
end