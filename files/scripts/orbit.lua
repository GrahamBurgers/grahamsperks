local function calculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local me = GetUpdatedEntityID()
local x2, y2, _, scale_x, _ = EntityGetTransform(me)

local priority1 = "enemy"
local priority2 = "player_unit"
if GameGetGameEffectCount(me, "CHARM") > 0 then
    priority2 = "enemy"
    priority1 = "player_unit"
end

-- hax?
EntityRemoveTag(me, "enemy")
local enemy = EntityGetClosestWithTag(x2, y2, priority1)
EntityAddTag(me, "enemy")

local x, y = EntityGetTransform(enemy)
x = x or x2 + 9000
y = y or y2 + 9000

local radius = 40
if calculateDistance(x, y, x2, y2) > radius + 180 then
    enemy = EntityGetClosestWithTag(x2, y2, priority2)
    x, y = EntityGetTransform(enemy)
    if calculateDistance(x, y, x2, y2) > radius + 280 then
        local comp = EntityGetFirstComponent(me, "VariableStorageComponent") or 0
        ComponentSetValue2(comp, "value_int", 0)
        return
    end
end

-- hopefully will not cause lag
local multiplier = ((GameGetGameEffectCount(me, "MOVEMENT_FASTER") + GameGetGameEffectCount(me, "MOVEMENT_FASTER_2X") * 2) - (GameGetGameEffectCount(me, "SLIMY") + GameGetGameEffectCount(me, "MOVEMENT_SLOWER") + GameGetGameEffectCount(me, "MOVEMENT_SLOWER_2X") * 2))

local ai = EntityGetFirstComponentIncludingDisabled(me, "AnimalAIComponent")
local genome1 = EntityGetFirstComponent(me, "GenomeDataComponent")
local target_herd = StringToHerdId("trap")
if ai and genome1 then
    if calculateDistance(x, y, x2, y2) > radius + 8 then
        -- can't shoot
        ComponentSetValue2(ai, "attack_ranged_enabled", false)

        -- move straight towards target
        local speed = 1.5 ^ multiplier
        if GameGetGameEffectCount(me, "CONFUSION") > 0 then speed = -speed end

        local distance = calculateDistance(x, y, x2, y2)
        local dx = (x - x2) / distance
        local dy = (y - y2) / distance

        x2 = x2 + dx * speed
        y2 = y2 + dy * speed

        -- can't shoot with no friend
        ComponentSetValue2(ai, "attack_ranged_enabled", false)
    else
        -- orbit around target
        local speed = 0.02 * (1.5 ^ multiplier)
        if GameGetGameEffectCount(me, "CONFUSION") > 0 then speed = -speed end
        if GameGetGameEffectCount(me, "FROZEN") > 0 then speed = 0 end

        local angle = math.atan2(y - y2, x - x2)
        angle = math.pi + angle + speed

        x2 = x + math.cos(angle) * radius
        y2 = y + math.sin(angle) * radius

        -- offset eyes and shooting position
        if scale_x > 0 then
            ComponentSetValue2(ai, "attack_ranged_offset_x", x - x2)
            ComponentSetValue2(ai, "eye_offset_x", x - x2)
        else
            ComponentSetValue2(ai, "attack_ranged_offset_x", x2 - x)
            ComponentSetValue2(ai, "eye_offset_x", x2 - x)
        end
        ComponentSetValue2(ai, "attack_ranged_offset_y", y - y2)
        ComponentSetValue2(ai, "eye_offset_y", y - y2)
        ComponentSetValue2(ai, "attack_ranged_enabled", true)

        local genome2 = EntityGetFirstComponent(enemy, "GenomeDataComponent")
        if genome2 then
            target_herd = ComponentGetValue2(genome2, "herd_id") or target_herd
        end
    end
    ComponentSetValue2(genome1, "herd_id", target_herd)
    EntityApplyTransform(me, x2, y2, 0)
end

local comp = EntityGetFirstComponent(me, "VariableStorageComponent") or 0
ComponentSetValue2(comp, "value_int", enemy)