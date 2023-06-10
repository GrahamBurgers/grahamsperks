function kick( entity_who_kicked )

    local x, y = EntityGetTransform(entity_who_kicked)
    local wands = EntityGetInRadiusWithTag(x, y, 10, "wand") or 0
    for i = 1, #wands do
        if EntityGetRootEntity(wands[i]) == wands[i] then
            local spells = EntityGetAllChildren(wands[i]) or 0
            if spells ~= 0 and EntityGetFirstComponent(wands[i], "ItemCostComponent") == nil then
                for j = 1, #spells do
                    if EntityHasTag(spells[j], "card_action") then
                        -- make sure it's not an always cast
                        local item = EntityGetFirstComponentIncludingDisabled(spells[j], "ItemComponent") or 0
                        if ComponentGetValue2(item, "permanently_attached") ~= true then
                            -- make the spell normal
                            local x2, y2 = EntityGetTransform(wands[i])
                            SetRandomSeed(x + entity_who_kicked, spells[j] + wands[i])
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_world", true)
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_hand", false)
                            EntitySetComponentsWithTagEnabled(spells[j], "enabled_in_inventory", false)
                            EntityRemoveFromParent(spells[j])
                            EntityApplyTransform(spells[j], x2, y2)
                            local velcomp = EntityGetFirstComponentIncludingDisabled(spells[j], "VelocityComponent") or 0
                            ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
                        end
                    end
                end
            end
        end
    end

end