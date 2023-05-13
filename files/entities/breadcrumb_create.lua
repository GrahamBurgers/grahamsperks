dofile_once("data/scripts/lib/utilities.lua")
local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

if #EntityGetInRadiusWithTag(x, y, 50, "graham_breadcrumb") < 1 then
	shoot_projectile(player, "mods/grahamsperks/files/entities/breadcrumb.xml", x, y, 0, 0, false)
end