dofile_once("data/scripts/lib/utilities.lua")
local me = GetUpdatedEntityID()
local mx, my = EntityGetTransform(me)
EntityLoad("mods/grahamsperks/files/entities/statue_image.xml", mx, my)

function make_random_card( x2, y2)
	SetRandomSeed( x2 + GameGetFrameNum(), y2 + 1234)
	local item = ""
	local valid = false
	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			if HasFlagPersistent( thisitem.spawn_requires_flag ) then
				valid = true
            end
			if( thisitem.spawn_probability == "0" ) then
				valid = false
			end
		else
			valid = true
		end
	end
	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x2, y2 )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

function offer_wand()
    local x, y = mx, my
    local wands = EntityGetInRadiusWithTag(x, y, 20, "wand") or {}
    for i = 1, #wands do
        if not EntityHasTag(wands[i], "graham_statue_ineligible") and EntityGetRootEntity(wands[i]) == wands[i] then
            dofile_once("data/scripts/gun/gun_actions.lua")

            x, y = EntityGetTransform(wands[i])
            SetRandomSeed(wands[i] + x, GameGetFrameNum() + y)
            EntityLoad("data/entities/particles/poof_blue.xml", x, y)

            -- spell removal script
            local spells = EntityGetAllChildren(wands[i]) or 0
            if spells ~= 0 then
                for j = 1, #spells do
                    if EntityHasTag(spells[j], "card_action") then
                        -- make the spell normal
                        SetRandomSeed(x + spells[j], spells[j] + y)
                        EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_world", true)
                        EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_hand", false)
                        EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_inventory", false)
                        EntityRemoveFromParent(spells[j])
                        EntityApplyTransform(spells[j], x, y, 0)
                        local velcomp = EntityGetFirstComponentIncludingDisabled(spells[j], "VelocityComponent") or 0
                        ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
                    end
                end
            end
            EntityKill(wands[i])
            return true
        end
    end

    return false
end

local function offer_potion(type)
    local x, y = mx, my
    type = type:gsub("potion_", "")
    local potions = EntityGetInRadiusWithTag(x, y, 20, "potion") or {}
    for i, potion in ipairs(potions) do
        x, y = EntityGetTransform(potion)
        if EntityGetComponent( potion, "PotionComponent" ) ~= nil and EntityGetRootEntity(potion) == potion then
            local matid = GetMaterialInventoryMainMaterial( potion )
            local inv = EntityGetFirstComponentIncludingDisabled( potion, "MaterialInventoryComponent" )
            if inv then
                local counts = ComponentGetValue2( inv, "count_per_material_type" )
                if counts then
                    local amount = counts[ matid+1 ]
                    local bar = 500
                    if amount >= bar then
                        if CellFactory_GetName(matid) == type then
                            EntityLoad("data/entities/particles/poof_blue.xml", x, y)
                            EntityKill(potion)
                            return true
                        else
                            return false
                        end
                    end
                end
            end
        end
        return false
    end
end

if GameGetFrameNum() % 20 == 0 then
    dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")

    local type = GlobalsGetValue("graham_prayerstatue_type", "nil") or "nil"
    local favour = tonumber(GlobalsGetValue("graham_prayerstatue_favour", "0"))
    if favour < 1 or type == "nil" then return end
    SetRandomSeed(mx + my, GameGetFrameNum() + favour)

    local yeah = false
    if type == "wand" then
        yeah = offer_wand()
    end

    if string.find(type, "potion_") then
        yeah = offer_potion(type)
    end

    if yeah then
        local global = "graham_prayerstatue_favour"
        local num = tonumber(GlobalsGetValue(global)) or 0
        GlobalsSetValue(global, tostring(num + 1))

        local eid = EntityLoad("mods/grahamsperks/files/entities/spell_circle.xml", mx, my - 70)
        EntityAddComponent2(eid, "VariableStorageComponent", {
            name="graham_spellcircle_amount",
            value_int=num
        })

        EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", mx, my - 70)
        local comp = get_variable_storage_component(me, "graham_prayerstatue_uses") or 0
        local uses = ComponentGetValue2(comp, "value_int")
        ComponentSetValue2(comp, "value_int", uses + 1)
    
        if Random(uses, 4) == 4 then
            dofile("mods/grahamsperks/files/scripts/statue_random.lua")
            GameScreenshake(40)
            EntityLoad("mods/grahamsperks/files/entities/statue_destruction.xml", mx, my)
            EntityKill(me)
        end
    end
end