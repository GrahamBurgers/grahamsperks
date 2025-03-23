local graham_itempickup_old = item_pickup
dofile_once( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
    local x, y = EntityGetTransform(entity_item)
	SetRandomSeed(entity_item + GameGetFrameNum(), entity_who_picked)
    -- refresh cyber eyes
    local eyes = EntityGetInRadiusWithTag(x, y, 32, "cyber_eye")
    for i = 1, #eyes do
        local c = EntityGetFirstComponentIncludingDisabled(eyes[i], "VariableStorageComponent", "cyber_eye_charge")
        local item = EntityGetFirstComponentIncludingDisabled(eyes[i], "ItemComponent")
        if c and item then
            local new = ComponentGetValue2(c, "value_int") + 1800
            ComponentSetValue2(c, "value_int", new)
            ComponentSetValue2(item, "uses_remaining", math.ceil(new / 6))
        end
    end

    -- Refreshing Variety: decide if we spawn spells instead (hopefully this can't spawn spells without the perk)
    local comp = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "graham_refresher")
    local stack = comp and ComponentGetValue2(comp, "value_int") or 0
    if comp and (50 * (0.50 ^ (stack - 1)) < Random(1, 100)) then
        -- try not to dupe spells with entangled worlds
        if EntityHasTag(entity_who_picked, "player_unit") and not EntityHasTag(entity_who_picked, "ew_notplayer") then
            EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y-12)

            -- decide how many to spawn, up to a max of 10
            local amount = math.min(10, Random(3, 5) + stack - 1)
            for i = 1, amount do
                -- "borrowed" code from copi
                local card = CreateItemActionEntity(GetRandomAction(x + Random(-10000, 10000), y + Random(-10001, 10000), 6, i), x, y)
                local velcomp = EntityGetFirstComponentIncludingDisabled(card, "VelocityComponent") or 0
                ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
            end

            -- remove the item from the game
            EntityKill( entity_item )
        end

    else
        -- do old script if random chance fails (or if player doesn't have the perk)
        graham_itempickup_old( entity_item, entity_who_picked, name )
    end
end
