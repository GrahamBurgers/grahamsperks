dofile_once( "data/scripts/lib/utilities.lua" )

SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
local me = GetUpdatedEntityID()
local player = EntityGetRootEntity(me)
local x, y = EntityGetTransform(me)
local storage = EntityGetFirstComponent(me, "VariableStorageComponent", "tipsy_ghost_charge")
local target = EntityGetClosestWithTag(x, y, "homing_target")
if not storage then return end
local charge = ComponentGetValue2(storage, "value_float")
local wait = ComponentGetValue2(storage, "value_int")

local add = 0.1
local comp = GameGetGameEffect(EntityGetRootEntity(me), "DRUNK")
local supercharge = false
if comp and comp > 0 then -- drunk immunity
    ComponentSetValue2(comp, "effect", "NONE")
    EntityAddTag(ComponentGetEntity(comp), "drunbk")
end -- supercharge
if #EntityGetAllChildren(player, "drunbk") > 0 then
    add = add + 0.05
    supercharge = true
end

if target then
    local x2, y2 = EntityGetTransform(target)
    local ai = EntityGetFirstComponent(target, "AnimalAIComponent")
    if wait <= 0 and (not RaytracePlatforms(x, y, x2, y2)) and ai and ComponentGetValue2(ai, "mHasBeenAttackedByPlayer") then
        local drunk = GameGetGameEffectCount(target, "DRUNK") > 0
        local dir = math.atan((y2 - y) / (x2 - x))
        if x2 < x then dir = dir + math.pi end
        if not supercharge then dir = dir + Random(math.pi / 20, math.pi / -20) end
        local vx, vy = math.cos(dir) * 200, math.sin(dir) * 200
        if charge >= 150 and drunk then
            shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_homing.xml", x, y, 0, -200)
            charge = charge - 150
            wait = 140
        elseif charge >= 150 then
            if Random(1, 10) == 1 then
                local eid = shoot_projectile( player, "data/entities/items/pickup/jar_of_urine.xml", x, y, vx * 1.5, vy * 1.5)
                PhysicsApplyForce(eid, vx * 1.5, vy * 1.5)
            else
                local eid = shoot_projectile( player, "data/entities/items/pickup/potion_alcohol.xml", x, y, vx * 0.5, vy * 0.5)
                PhysicsApplyForce(eid, vx * 0.5, vy * 0.5)
            end
            charge = charge - 150
            wait = 180
        elseif charge >= 5 and drunk then
            shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_spark.xml", x, y, vx * 2.5, vy * 2.5)
            charge = charge - 5
            wait = 24
        elseif charge >= 20 then
            shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_shot.xml", x, y, vx, vy)
            charge = charge - 20
            wait = 80
        end
    end
end

charge = math.min(150, charge + add)
wait = math.max(0, wait - 1)
ComponentSetValue2(storage, "value_float", charge)
ComponentSetValue2(storage, "value_int", wait)

local sprite = EntityGetFirstComponentIncludingDisabled(me, "SpriteComponent", "tipsy_slider")
if sprite then
    ComponentSetValue2(sprite, "special_scale_x", math.max(0, charge) / 150)
    local file = ComponentGetValue2(sprite, "image_file")
    local notfull = "mods/grahamsperks/files/entities/tipsy_ghost/charge_slider_tipsy.png"
    local full = "mods/grahamsperks/files/entities/tipsy_ghost/charge_slider_full.png"
    local faster = "mods/grahamsperks/files/entities/tipsy_ghost/charge_slider_faster.png"
    local todo = file
    if ComponentGetValue2(sprite, "special_scale_x") >= 1 then
        todo = full
        ComponentSetValue2(sprite, "image_file", full)
        EntityRefreshSprite(me, sprite)
    elseif supercharge then
        todo = faster
        ComponentSetValue2(sprite, "image_file", faster)
        EntityRefreshSprite(me, sprite)
    else
        todo = notfull
        ComponentSetValue2(sprite, "image_file", notfull)
        EntityRefreshSprite(me, sprite)
    end
    if todo ~= file then
        ComponentSetValue2(sprite, "image_file", todo)
        EntityRefreshSprite(me, sprite)
    end
end