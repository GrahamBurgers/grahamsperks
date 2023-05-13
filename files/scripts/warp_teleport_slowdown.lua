local me = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(me, "ProjectileComponent")
if projcomp ~= nil then
    local entity_who_shot = ComponentGetValue2(projcomp, "mWhoShot")
    if entity_who_shot ~= nil then
        local x, y = EntityGetTransform( entity_who_shot )
        local entity_id = EntityLoad( "mods/grahamsperks/files/effects/movement_slower.xml", x, y )
        EntityAddChild( entity_who_shot, entity_id )
    end
end