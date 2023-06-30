dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk.lua" )
dofile_once( "data/scripts/perks/perk_list.lua" )

local player = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(player)
if EntityHasTag(player, "polymorphed") or #EntityGetInRadiusWithTag(x, y, 2, "player_unit") == 0 then return end
EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y)

local count = 1

while count > 0 do
	local pid = perk_spawn_random(x,y)
	-- rerandomize if picked perk is gamble or IOU
	component_read( get_variable_storage_component(pid, "perk_id"), { value_string = "" }, function(comp)
		perk_pickup(pid, player, "", false, false )
		count = count - 1

		local perk_data = get_perk_with_id( perk_list, comp.value_string )
		local perk_name = GameTextGetTranslatedOrNot( perk_data.ui_name )
		local perk_desc = GameTextGetTranslatedOrNot( perk_data.ui_description )
		GamePrintImportant( perk_name, perk_desc )
	end)
end

