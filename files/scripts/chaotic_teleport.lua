local entity = EntityGetRootEntity(GetUpdatedEntityID())
local x, y = EntityGetTransform(entity)
local x2, y2 = 123, 321

-- try 80 times to teleport, do nothing if it fails
for i = 1, 80 do
    SetRandomSeed(x + i, y + GameGetFrameNum())
    x2 = x + Random(-200, 200) * 3
    y2 = y + Random(-100, 100)
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

-- chaos, chaos!
local comp = GetUpdatedComponentID()
if Random(1, 4) == 4 then
    ComponentSetValue2(comp, "execute_every_n_frame", Random(1, 5))
else
    ComponentSetValue2(comp, "execute_every_n_frame", Random(20, 150))
end