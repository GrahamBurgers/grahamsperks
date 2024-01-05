function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local me = GetUpdatedEntityID()
    local varsto = EntityGetFirstComponent(me, "VariableStorageComponent", "player_riding_id") or 0
    local player_riding = ComponentGetValue2(varsto, "value_int")
    local kick = EntityGetFirstComponentIncludingDisabled(entity_who_interacted, "KickComponent") or 0
    SetRandomSeed(GetUpdatedComponentID(), GameGetFrameNum())
    local speak = ModIsEnabled("grahamsdialogue") and Random(1, 4) == 1

    if player_riding ~= 0 and player_riding ~= entity_who_interacted then return end

    local comp = EntityGetFirstComponent(me, "InteractableComponent") or 0
    if interactable_name == "graham_lukki_mount" then
        ComponentSetValue2(comp, "name", "graham_lukki_dismount")
        ComponentSetValue2(comp, "ui_text", "$graham_lukki_dismount")
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_mount", true)
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_dismount", false)
        ComponentSetValue2(varsto, "value_int", entity_who_interacted)
        ComponentSetValue2(kick, "player_kickforce", 0)
        if speak then
            dofile_once("mods/grahamsdialogue/files/common.lua")
            for i = 1, #Custom_speak_lines do
                if Custom_speak_lines[i][1] == "lukki_mount_on" then
                    local type = Random(2, #Custom_speak_lines[i])
                    Speak(me, Custom_speak_lines[i][type], pools.CUSTOM, false)
                    break
                end
            end
        end
    else
        ComponentSetValue2(comp, "name", "graham_lukki_mount")
        ComponentSetValue2(comp, "ui_text", "$graham_lukki_mount")
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_mount", false)
        EntitySetComponentsWithTagEnabled(me, "graham_lukki_dismount", true)
        ComponentSetValue2(varsto, "value_int", 0)
        ComponentSetValue2(kick, "player_kickforce", 28)
        if speak then
            dofile_once("mods/grahamsdialogue/files/common.lua")
            for i = 1, #Custom_speak_lines do
                if Custom_speak_lines[i][1] == "lukki_mount_off" then
                    local type = Random(2, #Custom_speak_lines[i])
                    Speak(me, Custom_speak_lines[i][type], pools.CUSTOM, false)
                    break
                end
            end
        end
    end
end