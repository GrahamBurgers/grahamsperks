local me = GetUpdatedEntityID()
local COUNT = 9
dofile_once("data/scripts/lib/utilities.lua")
local kill = false

local projectile = EntityGetFirstComponentIncludingDisabled(me, "ProjectileComponent")
if projectile ~= nil then
    local shooter = ComponentGetValue2(projectile, "mWhoShot")
    local parent = ComponentGetValue2(projectile, "on_death_emit_particle_count")
	if shooter and shooter > 0 and parent > 0 then
        local id = ComponentGetValue2(projectile, "bounce_energy")
		local x1, y1 = EntityGetTransform(shooter)
        local x2, y2 = EntityGetTransform(parent)
        if x1 and x2 and y1 and y2 then
            local x = x1 * (id / COUNT) + x2 * ((COUNT - id) / COUNT)
            local y = y1 * (id / COUNT) + y2 * ((COUNT - id) / COUNT)
            EntitySetTransform(me, x, y)
        else
            kill = true
        end
    else
        kill = true
    end
else
    kill = true
end

if kill then
    EntityAddComponent2(me, "LifetimeComponent", {
        lifetime=60,
        fade_sprites=true
    })
    EntityRemoveComponent(me, GetUpdatedComponentID())
end