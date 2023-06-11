local function global_add(global)
    local num = tonumber(GlobalsGetValue(global)) or 0
    GlobalsSetValue(global, tostring(num + 1))
end

local function set_random_offering()
    local options = {
        "cold", "hot", "creepy", "pure", "unstable", "chaotic"
    }
    SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
    local random = options[Random(1, #options)]
    GlobalsSetValue("graham_prayerstatue_type", random)
    GlobalsSetValue("graham_prayerstatue_message", GameTextGet("$graham_prayerstatue_offering", GameTextGet("$graham_offering_" .. random)))
    dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")
end

local function offer_item(who, item, needed)

end

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    if tonumber(GlobalsGetValue("graham_prayerstatue_favour", "0")) > 0 then
        local inv_comp = EntityGetFirstComponentIncludingDisabled(entity_who_interacted, "Inventory2Component")
        local item = "0"
        if inv_comp ~= nil then
            item = ComponentGetValue2(inv_comp, "mActiveItem")
        end
        offer_item(entity_who_interacted, item, GlobalsGetValue("graham_prayerstatue_type", "0"))
    else
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
            if interactable_name == dialogue[i] then
                local comp = EntityGetFirstComponent(entity_interacted, "InteractableComponent") or 0
                if dialogue[i + 1] == nil then
                    global_add("graham_prayerstatue_favour")
                    set_random_offering()
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