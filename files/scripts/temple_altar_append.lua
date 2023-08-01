dofile( "data/scripts/perks/perk.lua" )
-- Save old function to call
local spawn_hp_old = spawn_hp
-- Overwrite function
function spawn_hp( x, y )
    -- Run saved old function
    spawn_hp_old(x, y)
    -- If the perk is picked
    if GameHasFlagRun("PERK_PICKED_GRAHAM_CAMPFIRE") then
        -- Find nearest heart
        local heart = EntityGetClosestWithTag(x-16, y + 15, "item_pickup")
        if heart ~= nil then
            -- If exists, kill it then swap with a fireplace
            EntityKill(heart)
            EntityLoad("mods/grahamsperks/files/entities/fireplace.xml", x-16, y+15 )
        end
    end
    local pid
    local count = math.min(10, GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" )) -- cap at 10
    for i = 1, count do
        pid = perk_spawn_random(x - 6 + (count * -8) + i * 16, y - 26, true)
        EntityAddComponent(pid, "LuaComponent", {
            script_item_picked_up="mods/grahamsperks/files/scripts/magic_skin_curse.lua"
        })
        EntityAddComponent(pid, "SpriteComponent", {
            image_file="mods/grahamsperks/files/entities/skin_perk.png",
            offset_x = "8",
            offset_y = "8",
            update_transform = "1" ,
            update_transform_rotation = "0",
            z_index="0.8",
        })
    end
    EntityLoad("mods/grahamsperks/files/entities/magic_skin_replacer.xml", x + 450, y)
end