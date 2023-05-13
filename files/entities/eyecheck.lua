local me = GetUpdatedEntityID() 
local x, y = EntityGetTransform(me)

if #EntityGetInRadiusWithTag(x, y, 30, "graham_snub") > 0 then
	EntityLoad("data/entities/particles/image_emitters/wand_effect.xml", x, y)
	EntityLoad("mods/grahamsperks/files/pickups/chest_bloody.xml", x, y)
	EntityLoad("mods/grahamsperks/files/entities/brickwork_convert.xml", x, y)
	EntityKill(me)
elseif #EntityGetInRadiusWithTag(x, y, 30, "graham_ase") > 0 then
	EntityLoad("data/entities/particles/image_emitters/wand_effect.xml", x, y)
	EntityLoad("data/entities/projectiles/deck/crumbling_earth.xml", x, y - 60)
	EntityLoad("mods/grahamsperks/files/pickups/chest_bloody.xml", x, y)
	EntityLoad("mods/grahamsperks/files/entities/brickwork_convert2.xml", x, y)
	EntityKill(me)
end