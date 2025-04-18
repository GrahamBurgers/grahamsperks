local function is_shop_wand(wand_entity)
    local x, y = EntityGetTransform(wand_entity)
    if (BiomeMapGetName(x, y) == "$biome_holymountain" or BiomeMapGetName(x, y) == "$biome_boss_arena") and EntityGetFirstComponent(wand_entity, "ItemCostComponent") then
        local itemcomp = EntityGetFirstComponent(wand_entity, "ItemComponent")
        if itemcomp then
            if ComponentGetValue2(itemcomp, "has_been_picked_by_player") then return false end
        end
        return true
    end
    return false
end

function kick( entity_who_kicked )
    local x, y = EntityGetTransform(entity_who_kicked)
    local wands = EntityGetInRadiusWithTag(x, y, 10, "wand") or 0
    -- bags of many support
    local helditem = EntityGetFirstComponent(entity_who_kicked, "Inventory2Component")
    if helditem then
        local item = ComponentGetValue2(helditem, "mActiveItem")
        if item and EntityHasTag(item, "bags_of_many") then return end
    end

    -- try not to dupe spells with entangled worlds
    if not (EntityHasTag(entity_who_kicked, "player_unit") and not EntityHasTag(entity_who_kicked, "ew_notplayer")) then return end

    for i = 1, #wands do
        local x2, y2 = EntityGetTransform(wands[i])
        if EntityGetRootEntity(wands[i]) == wands[i] then
            local removed = false
            local spells = EntityGetAllChildren(wands[i]) or {}
            if #spells > 0 then
                for j = 1, #spells do
                    if EntityHasTag(spells[j], "card_action") then
                        -- make sure it's not an always cast
                        local item = EntityGetFirstComponentIncludingDisabled(spells[j], "ItemComponent") or 0
                        if ComponentGetValue2(item, "permanently_attached") ~= true then
                            -- make the spell normal
                            EntityRemoveFromParent(spells[j])
                            SetRandomSeed(x + entity_who_kicked, spells[j] + wands[i])

                            local all = EntityGetAllComponents( spells[j] )
                            for a,b in ipairs( all ) do
                                if not (ComponentHasTag(b, "item_unidentified") or ComponentAddTag(b, "not_enabled_in_wand")) then
                                    EntitySetComponentIsEnabled( spells[j], b, true ) -- hopefully not hax
                                end
                            end

                            EntitySetTransform(spells[j], x2, y2, 0)
                            EntityApplyTransform(spells[j], x2, y2, 0)
                            local velcomp = EntityGetFirstComponentIncludingDisabled(spells[j], "VelocityComponent") or 0
                            ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
                            removed = true
                        end
                    end
                end

                if is_shop_wand(wands[i]) and removed then
                    -- player stole spells from a wand in a shop
                    -- anger the gods
                    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", x2, y2 )
                	if( GlobalsGetValue( "TEMPLE_PEACE_WITH_GODS" ) == "1" ) then
                        GamePrintImportant( "$logdesc_temple_peace_temple_break", "" )
                    else
                        GameScreenshake( 150 )
                        dofile_once( "data/scripts/biomes/temple_shared.lua" )
                        if( GlobalsGetValue( "TEMPLE_SPAWN_GUARDIAN" ) ~= "1" ) then
                            temple_spawn_guardian( x2, y2 )
                            GlobalsSetValue( "TEMPLE_SPAWN_GUARDIAN", "1" )
                        end

                        if tonumber(GlobalsGetValue("STEVARI_DEATHS", "0")) < 3 then
                            GamePrintImportant( "$logdesc_temple_spawn_guardian", "" )
                        else
                            GamePrintImportant( "$logdesc_gods_are_very_angry", "" )
                            GameGiveAchievement( "GODS_ENRAGED" )
                        end

                        -- poof shop wands
                        local poof = EntityGetInRadiusWithTag(x2, y2, 150, "wand")
                        for q = 1, #poof do
                            if is_shop_wand(poof[q]) then
                                local x3, y3 = EntityGetTransform(poof[q])
                                EntityLoad("data/entities/particles/poof_blue.xml", x3, y3)
                                EntityKill(poof[q])
                            end
                        end
                    end
                end
            end

            if removed then
                GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x2, y2)
            else
                GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/casting_empty_wand", x2, y2)
            end
        end
    end

end