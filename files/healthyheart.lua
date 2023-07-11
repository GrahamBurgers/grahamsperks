local grahamburger_func = item_pickup

function item_pickup( entity_item, entity_who_picked, name )

    local damagemodel = EntityGetFirstComponent( entity_who_picked, "DamageModelComponent" ) or 0
    local multiplier = tonumber( GlobalsGetValue( "HEARTS_MORE_EXTRA_HP_MULTIPLIER", "1" ) ) 
    local second_mult = GlobalsGetValue( "HEALTHY_HEARTS_HP_MULTIPLIER", "1" )
    -- to scale with stronger hearts perk
    
    local hp = ComponentGetValue2( damagemodel, "hp" ) --current_hp with no changes
    if GameHasFlagRun( "PERK_PICKED_GRAHAM_HEALTHY_HEARTS" ) then
        hp = hp + 1 * multiplier * second_mult
        --Gets the current hp, and adds 25. (all hp and damage is later multiplied by 25) 
    end
    grahamburger_func( entity_item, entity_who_picked, name ) --Call old function so max_hp is applied
    ComponentSetValue2( damagemodel, "hp", hp ) --Set hp

    local robots = GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0" )
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    local options = {"tank.xml", "tank_rocket.xml", "tank_super.xml", "toasterbot.xml"}
    for i = 1, robots do
        SetRandomSeed(entity_item + x, y + i)
        EntityLoad("mods/grahamsperks/files/entities/mini_tanks/" .. options[Random(1, #options)], x, y)
    end
end