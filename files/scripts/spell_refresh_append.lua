local graham_itempickup_old = item_pickup
dofile_once( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
    local x, y = EntityGetTransform(entity_item)
	SetRandomSeed(entity_item + GameGetFrameNum(), entity_who_picked)
    -- Refreshing Variety: decide if we spawn spells instead (hopefully this can't spawn spells without the perk)
    local stack = tonumber(GlobalsGetValue( "GRAHAM_REFRESHER_COUNT", "0" ))
    if (50 * (0.50 ^ (stack - 1)) < Random(1, 100)) then
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
    else
        -- do old script if random chance fails (or if player doesn't have the perk)
        graham_itempickup_old( entity_item, entity_who_picked, name )
    end
end
