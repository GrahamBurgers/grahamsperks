local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent") or 0
local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent") or 0
local me = ComponentGetValue2(comp, "value_string")

function isButtonJustDownApotheosis(key_name)
    local binding = ModSettingGet(table.concat({"Apotheosis.bind_",key_name}))
    local mode = "key_code"
    for code in string.gmatch(binding, "[^,]+") do
        if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
            mode = code
        else
            code = tonumber(code)
            if (mode == "key_code" and InputIsKeyJustDown(code))
            or (mode == "mouse_code" and InputIsMouseButtonJustDown(code))
            or (mode == "joystick_code" and InputIsJoystickButtonJustDown(0, code)) then
                return true
            end
        end
    end
end

local should_toggle = false

if ModIsEnabled("Apotheosis") then
    should_toggle = isButtonJustDownApotheosis("altfire")
else
    should_toggle = ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == GameGetFrameNum()
end

if should_toggle then
    -- shared script; find out which toggler we are
    if me == "GRAHAM_TOGGLER_ALT" then

        local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE", "null"))
        if (toggle ~= 1) and (toggle ~= 0) then GamePrint("$graham_enable_redblue") end
        if (toggle == 0) then
            toggle = 1
            GamePrint("$graham_toggle_blue")
        else
            toggle = 0
            GamePrint("$graham_toggle_red")
        end
        toggle = tostring(toggle)
        GlobalsSetValue("GRAHAM_TOGGLE", toggle)

    elseif me == "GRAHAM_TOGGLER2_ALT" then

        local toggle = tonumber(GlobalsGetValue("GRAHAM_TOGGLE2", "null"))
        if (toggle ~= 1) and (toggle ~= 0) then GamePrint("$graham_enable_greenyellow") end
        if (toggle == 0) then
            toggle = 1
            GamePrint("$graham_toggle_yellow")
        else
            toggle = 0
            GamePrint("$graham_toggle_green")
        end
        toggle = tostring(toggle)
        GlobalsSetValue("GRAHAM_TOGGLE2", toggle)

    elseif me == "GRAHAM_TOGGLER3_ALT" then

        local chatspam = GlobalsGetValue("GRAHAM_TOGGLE", "null")
        local chatspam2 = GlobalsGetValue("GRAHAM_TOGGLE2", "null")

        if (chatspam ~= "null") or (chatspam2 ~= "null") then GamePrint("$graham_toggle_disable") end
        GlobalsSetValue("GRAHAM_TOGGLE", "null")
        GlobalsSetValue("GRAHAM_TOGGLE2", "null")

    end
end
