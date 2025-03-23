if ModSettingGet("grahamsperks.FlumShader") ~= false then
    local me = EntityGetRootEntity(GetUpdatedEntityID())
    local comp = EntityGetFirstComponentIncludingDisabled(me, "VariableStorageComponent", "graham_flum_shader")
    if not comp then return end
    local power = ComponentGetValue2(GetUpdatedComponentID(), "execute_every_n_frame") -- hax or genius?
    local amount = math.min(1199, ComponentGetValue2(comp, "value_int"))
    if #EntityGetAllChildren(me, "graham_flum_shader") > 0 then
        amount = amount + power
    elseif amount > 0 then
        amount = amount - power
    else
        return -- don't bother with anything else if nothing happens
    end
    ComponentSetValue2(comp, "value_int", amount)
    local intensity = math.max(0, (1/(1+1.8^(-(amount/100)+4))))
    if intensity < 0.1 then intensity = 0 end
    GameSetPostFxParameter("grahams_perks_distortion_strength", intensity, 0.0, 0.0, 0.0)
end