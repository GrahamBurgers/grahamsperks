local function calculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local me = GetUpdatedEntityID()
local ai = EntityGetFirstComponentIncludingDisabled(me, "AnimalAIComponent") or 0
ComponentSetValue2(ai, "attack_ranged_enabled", false)
local x2, y2 = EntityGetTransform(me)
-- hax?
EntityRemoveTag(me, "enemy")
local enemy = EntityGetClosestWithTag(x2, y2, "enemy")
EntityAddTag(me, "enemy")

local x, y = EntityGetTransform(enemy)
x = x or x2 + 9000
y = y or y2 + 9000

local radius = 40
if calculateDistance(x, y, x2, y2) > radius + 180 then
    local comp = EntityGetFirstComponent(me, "VariableStorageComponent") or 0
    ComponentSetValue2(comp, "value_int", 0)
    return
end

-- hopefully will not cause lag
local multiplier = ((GameGetGameEffectCount(me, "MOVEMENT_FASTER") + GameGetGameEffectCount(me, "MOVEMENT_FASTER_2X") * 2) - (GameGetGameEffectCount(me, "SLIMY") + GameGetGameEffectCount(me, "MOVEMENT_SLOWER") + GameGetGameEffectCount(me, "MOVEMENT_SLOWER_2X") * 2))

if calculateDistance(x, y, x2, y2) > radius + 3 then
    local distance = calculateDistance(x, y, x2, y2)
    local dx = (x - x2) / distance
    local dy = (y - y2) / distance
    local speed = 1.5
    if GameGetGameEffectCount(me, "CONFUSION") > 0 then speed = -1.5 end
    x2 = x2 + dx * speed ^ multiplier
    y2 = y2 + dy * speed ^ multiplier
else
    local speed = 0.02
    if GameGetGameEffectCount(me, "CONFUSION") > 0 then speed = -0.02 end
    speed = speed * 1.5 ^ multiplier

    local angle = math.atan2(y - y2, x - x2)
    angle = math.pi + angle + speed
    x2 = x + math.cos(angle) * radius
    y2 = y + math.sin(angle) * radius
    ComponentSetValue2(ai, "attack_ranged_enabled", true)
    local prey = ComponentGetValue2(ai, "mGreatestPrey") or 0
    if prey ~= 0 then
        local x3, y3 = EntityGetTransform(prey)
        if x3 ~= nil then
            if x3 > x2 then
                ComponentSetValue2(ai, "attack_ranged_offset_x", x - x2)
            else
                ComponentSetValue2(ai, "attack_ranged_offset_x", x2 - x)
            end
        end
        ComponentSetValue2(ai, "attack_ranged_offset_y", y - y2)
    end
end

EntityApplyTransform(me, x2, y2, 0)

local comp = EntityGetFirstComponent(me, "VariableStorageComponent") or 0
ComponentSetValue2(comp, "value_int", enemy)