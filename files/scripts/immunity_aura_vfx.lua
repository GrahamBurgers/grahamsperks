local me = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "graham_flum_shader")
if comp == nil then return end
GamePrint(tostring(comp))
local x, y = EntityGetTransform(me)
local amount = math.min(499, ComponentGetValue2(comp, "value_int"))
if #EntityGetInRadiusWithTag(x, y, 5, "graham_flum_shader") > 0 then
    amount = amount + 1
    GamePrint("going up: " .. tostring(amount))
elseif amount > 0 then
    amount = amount - 1
    GamePrint("going down: " .. tostring(amount))
end
ComponentSetValue2(comp, "value_int", amount)
GameSetPostFxParameter("grahams_perks_distortion_strength", 2/(1+math.exp(-2*(amount/100)-2)), 0.0, 0.0, 0.0)
