local options = {
    -- type, message
    {"potion", "cold"},
    {"potion", "hot"},
    {"potion", "creepy"},
    {"potion", "pure"},
    {"potion", "unstable"},
    {"potion", "chaotic"},
}

local function global_add(global)
    local num = tonumber(GlobalsGetValue(global)) or 0
    GlobalsSetValue(global, tostring(num + 1))
end

local function set_random_offering()
    SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
    local random = Random(1, #options)
    GlobalsSetValue("graham_prayerstatue_type", tostring(random))
    GlobalsSetValue("graham_prayerstatue_message", GameTextGet("$graham_prayerstatue_offering", GameTextGet("$graham_offering_" .. options[random][2])))
    dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")
end

local function get_potion_material(potion)
    if EntityGetComponent( potion, "PotionComponent" ) == nil then return nil end
    local matid = GetMaterialInventoryMainMaterial( potion )
        local inv = EntityGetFirstComponentIncludingDisabled( potion, "MaterialInventoryComponent" )
        if inv then
            local counts = ComponentGetValue2( inv, "count_per_material_type" )
            if counts then
                local amount = counts[ matid+1 ]
                local bar = 500
                if amount >= bar then
                    return matid
                end
            end
        end
    return nil
end

local function offer_item(who, item, type)
    local x, y = EntityGetTransform(who)
    if options[type][1] == "potion" then
        local needed = options[type][2]
        local id = get_potion_material(item) or 0
        local material = CellFactory_GetName(id)
        
        local done = false
        if needed == "cold" and (material == "snow" or material == "blood_cold" or material == "blood_cold_vapour" or material == "water_ice") then
            done = true
        end
        if needed == "hot" and (material == "lava" or material == "liquid_fire_weak" or material == "liquid_fire" or material == "water_ice") then
            done = true
        end
        if needed == "creepy" and (material == "creepy_liquid" or material == "graham_creepypoly" or material == "graham_graymatter_liquid" or material == "fungi_creeping") then
            done = true
        end
        if needed == "pure" and (material == "purifying_powder" or material == "graham_pureliquid" or material == "water" or material == "blood_worm") then
            done = true
        end
        if needed == "unstable" and (material == "magic_liquid_unstable_teleportation" or material == "magic_liquid_unstable_polymorph" or material == "gunpowder_unstable") then
            done = true
        end
        if needed == "chaotic" and (material == "magic_liquid_polymorph_random" or material == "graham_tele_chaotic" or material == "gunpowder_unstable") then
            done = true
        end

        if done then
            EntityRemoveFromParent(item)
            EntitySetComponentsWithTagEnabled(item, "enabled_in_world", true)
            EntitySetComponentsWithTagEnabled(item, "enabled_in_hand", false)
            EntityKill(item)
            EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y)
            global_add("graham_prayerstatue_favour")
            set_random_offering()
        end
    end
end

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    if tonumber(GlobalsGetValue("graham_prayerstatue_favour", "0")) > 0 then
        local inv_comp = EntityGetFirstComponentIncludingDisabled(entity_who_interacted, "Inventory2Component")
        local item = "0"
        if inv_comp ~= nil then
            item = ComponentGetValue2(inv_comp, "mActiveItem")
        end
        offer_item(entity_who_interacted, item, tonumber(GlobalsGetValue("graham_prayerstatue_type", "0")))
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