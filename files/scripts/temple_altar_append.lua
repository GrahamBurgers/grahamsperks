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
end
-- this swag code is by Copi :^)