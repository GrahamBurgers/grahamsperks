local me = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(me, "ProjectileComponent")

local x, y = EntityGetTransform(me)
local die = EntityGetInRadiusWithTag(x, y, 2, "graham_brambles_active")
if #die > 64 then -- PANIC!
    EntityLoad("data/entities/projectiles/deck/death_cross_big_explosion.xml", x, y)
    for i = 1, #die do
        EntityKill(die[i])
        EntityKill(me)
    end
    return
end

-- force turn into brambles after losing some lifetime
if proj and EntityHasTag(me, "graham_bramball") then
    if ComponentGetValue2(proj, "lifetime") <= 120 then
        EntityLoad("mods/grahamsperks/files/entities/bramball_caller.xml", x, y)
    end
end