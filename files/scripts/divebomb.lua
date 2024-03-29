local DISTANCE = 120
local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local enemies = EntityGetInRadiusWithTag(x, y, DISTANCE, "enemy") or {}
local comp = EntityGetFirstComponentIncludingDisabled(me, "ProjectileComponent")
local whoshot = 0
if comp ~= nil then
    whoshot = ComponentGetValue2(comp, "mWhoShot")
end
for i, enemy in ipairs(enemies) do
    local x2, y2 = EntityGetTransform(enemy)
    -- remember, up is down
    if y < y2 - 10 and math.abs(x - x2) < DISTANCE / 12 and RaytracePlatforms( x - 4, y, x2 + 4, y2) ~= true and whoshot ~= enemy then
        dofile_once("data/scripts/lib/utilities.lua")

        edit_component( me, "VelocityComponent", function(comp,vars)
            local vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
        
            vel_y = math.max(vel_y, 0) + math.abs(vel_x) * 1.4
            vel_x = ((x2 - x) * 15) - (DISTANCE / math.abs(y2 - y)) -- try to course-correct to the enemy
        
            ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
        end)

        EntityRemoveComponent(me, GetUpdatedComponentID())
        break
    end
end