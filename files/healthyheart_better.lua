grahamburger_func = item_pickup
-- old item_pickup is now named grahamburger_func (Make sure you try to be creative with these names)

function item_pickup( entity_item, entity_who_picked, name )

    local damagemodel = EntityGetFirstComponent( entity_who_picked, "DamageModelComponent" )
    local multiplier = tonumber( GlobalsGetValue( "HEARTS_MORE_EXTRA_HP_MULTIPLIER", "1" ) ) 
    local second_mult = GlobalsGetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", "1" )
    -- to scale with stronger hearts perk
    
    local hp = ComponentGetValue2( damagemodel, "hp" ) --current_hp with no changes
    if GameHasFlagRun( "PERK_PICKED_GRAHAM_HEALTHY_HEARTS" ) then
        hp = hp + 2 * multiplier * second_mult
        --Gets the current hp, and adds 25. (all hp and damage is later multiplied by 25) 
    end
    grahamburger_func( entity_item, entity_who_picked, name ) --Call old function so max_hp is applied
    ComponentSetValue2( damagemodel, "hp", hp ) --Set hp
end