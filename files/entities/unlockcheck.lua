dofile_once("data/scripts/perks/perk.lua")
local player = GetUpdatedEntityID()
local x, y = EntityGetTransform( player )
local comp = GameGetGameEffect( player, "PROTECTION_POLYMORPH" )
if comp ~= 0 then
	local duration = ComponentGetValue2( comp, "frames")
	if duration >= 2 then
		if HasFlagPersistent("graham_progress_sheep") ~= true then
			AddFlagPersistent("graham_progress_sheep")
			GamePrint( "$graham_perk_unlock" )
			GamePrint( "$graham_perk_unlock_sheep" )
			EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
			EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
			perk_spawn(x, y-40, "GRAHAM_SHEEPIFICATION")
		end
	end
end

local robotic = tonumber(GlobalsGetValue( "GRAHAM_ONEOFFS", "0" ))

if robotic >= 3 and HasFlagPersistent("graham_progress_robot") ~= true then
	AddFlagPersistent("graham_progress_robot")
    GamePrint( "$graham_perk_unlock" )
    GamePrint( "$graham_perk_unlock_robot" )
	EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
	EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
	perk_spawn(x, y-40, "GRAHAM_MATERIALIST")
end

local children = EntityGetAllChildren( player )
if children == nil then return end
for i, child in ipairs(children) do
	if EntityGetName(child) == "inventory_quick" then
		local inventory_items = EntityGetAllChildren(child)
		if(inventory_items ~= nil) then
			for j, item in ipairs(inventory_items) do
				if EntityHasTag( item, "wand" ) and EntityHasTag( item, "wand_experimental" ) and HasFlagPersistent("graham_progress_tech") ~= true then
					AddFlagPersistent("graham_progress_tech")
					GamePrint( "$graham_perk_unlock" )
					GamePrint( "$graham_perk_unlock_tech" )
					EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
					EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
					perk_spawn(x, y-40, "GRAHAM_ROBOTS")
				end
			end
		end
    break
	end
end