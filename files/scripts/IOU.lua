dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk.lua" )

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)
if EntityHasTag(player, "polymorphed") or #EntityGetInRadiusWithTag(x, y, 2, "player_unit") == 0 then return end

local count = 1
while count > 0 do
	EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y)
	local pid = perk_spawn_random(x,y)
	-- rerandomize if picked perk is gamble or IOU
	component_read( get_variable_storage_component(pid, "perk_id"), { value_string = "" }, function(comp)
		print(comp.value_string)
		if comp.value_string ~= "GAMBLE" and comp.value_string ~= "GRAHAM_IOU" then
			perk_pickup(pid, player, "", false, false )
			count = count - 1
		else
			--print("IOU perk spawned another IOU. Rerandomizing...")
			EntityKill(pid)
		end
	end)
end

EntityKill(entity_id)