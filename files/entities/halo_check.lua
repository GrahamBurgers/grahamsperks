local lvl = tonumber( GlobalsGetValue( "PLAYER_HALO_LEVEL", "0" ) )

if lvl >= 3 then
	local x, y = EntityGetTransform(EntityGetWithTag("player_unit")[1])
	local me = GetUpdatedEntityID()
	local x2, y2 = EntityGetTransform(me)
	x2 = x2 - 70
	
	local dir_x = x - x2
	local dir_y = y - y2
	local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)

	if distance < 10 then
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x2, y2)
		EntityLoad("mods/grahamsperks/files/entities/halo_pure.xml", x2 + 70, y2)
		EntityLoad("data/entities/items/pickup/goldnugget_10000.xml", x2 + 70, y2 - 40)
		EntityLoad("data/entities/buildings/chest_light.xml", x2 + 70, y2)
		EntityKill(me)
	end

elseif lvl <= -3 then
	local x, y = EntityGetTransform(EntityGetWithTag("player_unit")[1])
	local me = GetUpdatedEntityID()
	local x2, y2 = EntityGetTransform(me)
	x2 = x2 + 70
	
	local dir_x = x - x2
	local dir_y = y - y2
	local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)

	if distance < 10 then
		EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", x2, y2)
		EntityLoad("mods/grahamsperks/files/entities/halo_dark.xml", x2 - 70, y2)
		EntityLoad("data/entities/items/pickup/bloodmoney_10000.xml", x2 - 70, y2 - 40)
		EntityLoad("data/entities/buildings/chest_dark.xml", x2 - 70, y2)
		EntityKill(me)
	end

end