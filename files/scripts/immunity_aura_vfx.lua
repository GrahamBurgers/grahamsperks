local me = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "graham_flum_shader")
if comp == nil then return end
local x, y = EntityGetTransform(me)
local amount = math.min(1199, ComponentGetValue2(comp, "value_int"))
if #EntityGetInRadiusWithTag(x, y, 5, "graham_flum_shader") > 0 then
    amount = amount + 1
elseif amount > 0 then
    amount = amount - 1
end
ComponentSetValue2(comp, "value_int", amount)
local intensity = math.max(0, (1/(1+1.8^(-(amount/100)+4))))
if intensity < 0.1 then intensity = 0 end
GameSetPostFxParameter("grahams_perks_distortion_strength", intensity, 0.0, 0.0, 0.0)