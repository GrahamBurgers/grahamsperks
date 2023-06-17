function interacting( entity_who_interacted, entity_interacted, interactable_name )
    if tonumber(GlobalsGetValue("graham_prayerstatue_favour", "0")) < 1 then
        local dialogue = {
            "$graham_prayerstatue_intro0",
            "$graham_prayerstatue_intro1",
            "$graham_prayerstatue_intro2",
            "$graham_prayerstatue_intro3",
            "$graham_prayerstatue_intro4",
            "$graham_prayerstatue_intro5",
            "$graham_prayerstatue_intro6",
            "$graham_prayerstatue_intro7",
        }

        for i = 1, #dialogue do
            if GlobalsGetValue("graham_prayerstatue_message", "$graham_prayerstatue_intro0") == dialogue[i] then
                local comp = EntityGetFirstComponent(entity_interacted, "InteractableComponent") or 0
                if dialogue[i + 1] == nil then
                    dofile("mods/grahamsperks/files/scripts/statue_random.lua")
                    GlobalsSetValue("graham_prayerstatue_favour", "1")
                end
                if dialogue[i + 1] == nil then
                    break
                end
                ComponentSetValue2(comp, "name", dialogue[i + 1])
                GlobalsSetValue("graham_prayerstatue_message", dialogue[i + 1] or "error")
                dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")
                break
            end
        end
    end
end