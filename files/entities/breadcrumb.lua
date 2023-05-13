local x, y = EntityGetTransform(GetUpdatedEntityID())
local players = EntityGetInRadiusWithTag(x, y, 50, "player_unit")

for count, player in ipairs(players) do
	if #EntityGetInRadiusWithTag(x, y, 50, "graham_breadcrumb_effect") > 0 then
	else
		local x, y = EntityGetTransform( player )
		local entity_id = EntityLoad( "mods/grahamsperks/files/effects/breadcrumb.xml", x, y )
		EntityAddChild( player, entity_id )
	end
end