dofile_once("data/scripts/perks/perk.lua")

local x, y = EntityGetTransform( GetUpdatedEntityID() )
local books = EntityGetWithTag( "graham_book" )

local function EntityGetInRadiusWithName(x2, y2, radius, name)
	local list = EntityGetInRadius(x2, y2, radius)
	local new_list = {}
	for i = 1, #list do
		if EntityGetName(list[i]) == name then
			table.insert(new_list, list[i])
		end
	end
	return new_list
end

local eggs = EntityGetInRadiusWithName(x, y, 56, "$graham_lukkiegg")
if ( #eggs > 0) then
	for i,egg_id in ipairs(eggs) do
		local x2, y2 = EntityGetTransform(egg_id)
		if EntityGetRootEntity(egg_id) == egg_id then
			GamePrintImportant( "$log_altar_magic", "" )
			if HasFlagPersistent("graham_progress_lukki") ~= true then
				AddFlagPersistent("graham_progress_lukki")
				GamePrint( "$graham_perk_unlock" )
				GamePrint( "$graham_perk_unlock_lukki" )
				EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x2, y2)
				EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x2, y2)
				dofile_once("data/scripts/perks/perk.lua")
				perk_spawn(x2, y2, "GRAHAM_LUKKI_MOUNT")
				GamePlaySound("data/audio/Desktop/animals.bank", "animals/lukki_eggs/destroy", x2, y2)
			else
				-- if lukki mount is already unlocked, then babies
				SetRandomSeed(GameGetFrameNum(), x2 + y2)
				GamePlaySound("data/audio/Desktop/animals.bank", "animals/lukki_eggs/destroy", x2, y2)
				for p = 1, Random(5, 10) do
					local eid = EntityLoad("data/entities/animals/lukki/lukki_tiny.xml", x2, y2)
					EntityAddComponent2(eid, "LuaComponent", {
						script_source_file="mods/grahamsperks/files/scripts/tank_teleport.lua"
					})
					local comp = EntityGetFirstComponentIncludingDisabled(eid, "GenomeDataComponent") or 0
					ComponentSetValue2(comp, "herd_id", StringToHerdId("player"))
					comp = EntityGetFirstComponentIncludingDisabled(eid, "AreaDamageComponent") or 0
					ComponentSetValue2(comp, "entities_with_tag", "enemy")
				end
			end
			EntityKill(egg_id)
		end
	end
end

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