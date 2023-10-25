local entity = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(entity)
local x2, y2 = 123, 321

SetRandomSeed(x + entity, y + GameGetFrameNum())
if Random(1, 14) < 14 then return end

-- try 80 times to teleport, do nothing if it fails
for i = 1, 80 do
    SetRandomSeed(x + i, y + GameGetFrameNum())
    x2 = x + Random(-150, 150) * 3
    y2 = y + Random(-80, 80)
    -- influence from cursor (but backwards)
    local comp = EntityGetFirstComponent(entity, "Inventory2Component")
    if comp ~= nil then
        local item = ComponentGetValue2(comp, "mActiveItem")
        if item ~= nil then
            local _, _, dir = EntityGetTransform(item)
            if dir ~= nil then
                x2 = x2 - (math.cos(dir) * 50)
                y2 = y2 - (math.sin(dir) * 50)
            end
        end
    end
    local power = Random(0.4, 0.8)
    x2 = x2 * power
    y2 = y2 * power
    if RaytracePlatforms(x2 + 20, y2 + 20, x2 - 20, y2 - 20) == false and RaytracePlatforms(x2 - 20, y2 + 20, x2 + 20, y2 - 20) == false and DoesWorldExistAt(x2-10, y2-10, x2+10, y2+10) then
        EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
        EntityApplyTransform(entity, x2, y2)
        GamePlaySound("data/audio/Desktop/misc.bank", "game_effect/teleport/tick", x2, y2)
        if EntityHasTag(entity, "player_unit") then GamePrint("$log_teleported") end
        break
    end
end