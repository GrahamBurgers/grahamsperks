local me = GetUpdatedEntityID()
local player = EntityGetRootEntity(me)
local x, y = EntityGetTransform(player)
local comp = EntityGetFirstComponent(player, "ControlsComponent")
local interact = EntityGetFirstComponentIncludingDisabled(me, "InteractableComponent") or 0
if comp == nil then return end
if (ComponentGetValue2(comp, "mButtonDownRight") or ComponentGetValue2(comp, "mButtonDownLeft") or ComponentGetValue2(comp, "mButtonDownDown") or ComponentGetValue2(comp, "mButtonDownUp")) == true then
    EntitySetComponentIsEnabled(me, interact, false)
    GlobalsSetValue("graham_fortuneteller_frame", tostring(GameGetFrameNum() + 15))
    return
end
if (tonumber(GlobalsGetValue("graham_fortuneteller_frame", "0")) > GameGetFrameNum() - 30) then
    EntitySetComponentIsEnabled(me, interact, false)
    return
end
local items = EntityGetInRadius(x, y, 15) or {}
for i = 1, #items do
    if EntityGetRootEntity(items[i]) == items[i] and EntityGetComponent(items[i], "ItemComponent") ~= nil then
        EntitySetComponentIsEnabled(me, interact, false)
        return
    end
end
EntitySetComponentIsEnabled(me, interact, true)