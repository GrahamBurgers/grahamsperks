local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local this = GetUpdatedComponentID()
local times = ComponentGetValue2(this, "mTimesExecuted")
local proj = EntityGetFirstComponentIncludingDisabled(me, "ProjectileComponent")
local item = EntityGetFirstComponentIncludingDisabled(me, "ItemComponent")
local sprite = EntityGetFirstComponentIncludingDisabled(me, "SpriteComponent", "magmastone_tele")
local TIMER = 120
local who
if proj then who = ComponentGetValue2(proj, "mWhoShot") or 0 end
if times < TIMER then
    if sprite then
        ComponentSetValue2(sprite, "special_scale_x", 2 - (times / TIMER) * 2)
        ComponentSetValue2(sprite, "special_scale_y", 2 - (times / TIMER) * 2)
    end
end
if times > TIMER or EntityGetRootEntity(me) ~= me or who == 0 then
    EntityRemoveComponent(me, this)
    if sprite then EntityRemoveComponent(me, sprite) end
    if item then ComponentSetValue2(item, "auto_pickup", false) end
    return
end
if times == TIMER and who > 0 and EntityHasTag(who, "player_unit") then
    local x2, y2 = EntityGetTransform(who)
    EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
    EntityLoad( "data/entities/particles/teleportation_target.xml", x2, y2 )
    GamePlaySound("data/audio/Desktop/misc.bank", "game_effect/teleport/tick", x, y)
    EntityApplyTransform(me, x2, y2)
    if item then ComponentSetValue2(item, "auto_pickup", true) end
    local phys = EntityGetFirstComponent(me, "PhysicsBodyComponent")
    if phys then
        EntitySetComponentIsEnabled(me, phys, false)
    end
end