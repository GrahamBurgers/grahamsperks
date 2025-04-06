local me = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(me, "ProjectileComponent")
-- force turn into brambles after losing some lifetime
if proj and EntityHasTag(me, "graham_bramball") then
    if ComponentGetValue2(proj, "lifetime") <= 180 then
        local x, y = EntityGetTransform(me)
        EntityLoad("mods/grahamsperks/files/entities/bramball_caller.xml", x, y)
    end
end