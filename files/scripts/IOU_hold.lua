local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local tinkering = EntityGetInRadiusWithTag(x, y, 500, "workshop") or {}
local game = EntityGetFirstComponent(me, "GameEffectComponent")
local can_tinker = false
for i = 1, #tinkering do
    local x2, y2 = EntityGetTransform(tinkering[i])
    local hitbox = EntityGetFirstComponent(tinkering[i], "HitboxComponent")
    if hitbox then
        local mx = x2 + ComponentGetValue2(hitbox, "aabb_min_x")
        local bx = x2 + ComponentGetValue2(hitbox, "aabb_max_x")
        local my = y2 + ComponentGetValue2(hitbox, "aabb_min_y")
        local by = y2 + ComponentGetValue2(hitbox, "aabb_max_y")
        if x > mx and x < bx and y > my and y < by then
            can_tinker = true
            break
        end
    end
end
if can_tinker and game then
    ComponentSetValue2(game, "frames", ComponentGetValue2(game, "frames") + 1)
end