local me = GetUpdatedEntityID()
local player = EntityGetRootEntity(me)
local comp = EntityGetFirstComponent(player, "ControlsComponent")
local interact = EntityGetFirstComponentIncludingDisabled(me, "InteractableComponent") or 0
if comp == nil then return end
if ComponentGetValue2(comp, "mButtonDownRight") or ComponentGetValue2(comp, "mButtonDownLeft") or ComponentGetValue2(comp, "mButtonDownDown") or ComponentGetValue2(comp, "mButtonDownUp") == true then
    EntitySetComponentIsEnabled(me, interact, false)
    return
end
EntitySetComponentIsEnabled(me, interact, true)
local message = GameTextGet("$graham_fortuneteller", tostring(math.ceil(50 * 0.8 ^ tonumber(GlobalsGetValue( "GRAHAM_FORTUNETELLER_COUNT", "-1" )))))
ComponentSetValue2(interact, "ui_text", message)