function kick( entity_who_kicked )

    local x, y = EntityGetTransform(entity_who_kicked)
    local wands = EntityGetInRadiusWithTag(x, y, 10, "wand") or 0
    for i = 1, #wands do
        local x2, y2 = EntityGetTransform(wands[i])
        if EntityGetRootEntity(wands[i]) == wands[i] then
            local removed = false
            local spells = EntityGetAllChildren(wands[i]) or 0
            if spells ~= 0 then
                for j = 1, #spells do
                    if EntityHasTag(spells[j], "card_action") then
                        -- make sure it's not an always cast
                        local item = EntityGetFirstComponentIncludingDisabled(spells[j], "ItemComponent") or 0
                        if ComponentGetValue2(item, "permanently_attached") ~= true then
                            -- make the spell normal
                            SetRandomSeed(x + entity_who_kicked, spells[j] + wands[i])
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_world", true)
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_hand", false)
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_inventory", false)
                            EntityRemoveFromParent(spells[j])
                            EntityApplyTransform(spells[j], x2, y2)
                            local velcomp = EntityGetFirstComponentIncludingDisabled(spells[j], "VelocityComponent") or 0
                            ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
                            removed = true
                        end
                    end
                end

                if EntityGetFirstComponent(wands[i], "ItemCostComponent") ~= nil and BiomeMapGetName(x, y) == "$biome_holymountain" then
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

                        if tonumber(GlobalsGetValue("STEVARI_DEATHS", 0)) < 3 then
                            GamePrintImportant( "$logdesc_temple_spawn_guardian", "" )
                        else
                            GamePrintImportant( "$logdesc_gods_are_very_angry", "" )
                            GameGiveAchievement( "GODS_ENRAGED" )
                        end

                        -- poof shop wands
                        local poof = EntityGetInRadiusWithTag(x2, y2, 150, "wand")
                        for q = 1, #poof do
                            if EntityGetFirstComponent(poof[q], "ItemCostComponent") ~= nil and BiomeMapGetName(EntityGetTransform(poof[q])) == "$biome_holymountain" then
                                EntityLoad("data/entities/particles/poof_blue.xml", EntityGetTransform(poof[q]))
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