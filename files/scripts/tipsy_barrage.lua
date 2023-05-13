dofile_once( "data/scripts/lib/utilities.lua" )

local ghost = GetUpdatedEntityID()
local x, y = EntityGetTransform(ghost)
local player = EntityGetRootEntity(GetUpdatedEntityID())
local x2, y2 = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")

if x2 ~= nil then
    local dir_x = x - x2
    local dir_y = y - y2
    shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_dig.xml", x, y, dir_x * -4, dir_y * -4)
end