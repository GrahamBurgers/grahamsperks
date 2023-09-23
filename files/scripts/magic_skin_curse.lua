local item_pickup_old = nil
if item_pickup ~= nil then
    item_pickup_old = item_pickup
end
---@diagnostic disable-next-line: lowercase-global
function item_pickup( entity_item, entity_who_picked, item_name )
    local comp = EntityGetFirstComponent(entity_who_picked, "DamageModelComponent") or 0
    SetRandomSeed(entity_item, GameGetFrameNum() + entity_who_picked)
    local cap = 9 + (1.5 ^ tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_CURSE", "0" )))
    local amount = Random(cap / 2, cap)
    amount = math.min(40, amount)
    GlobalsSetValue( "GRAHAM_MAGIC_SKIN_CURSE", tostring(1 + tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_CURSE", "0" ))) )
    GamePrint(GameTextGet("$graham_magicskin", tostring(amount)))
    local maxhp = ComponentGetValue2(comp, "max_hp") - amount / 25
    if ComponentGetValue2(comp, "hp") > maxhp then
---@diagnostic disable-next-line: undefined-global
        EntityInflictDamage(entity_who_picked, amount / 25, DAMAGE_CURSE, "$perkname_graham_magicskin", "BLOOD_EXPLOSION", 0, 0)
    end
    ComponentSetValue2(comp, "max_hp", maxhp)
    -- I have no idea if script_item_picked_up gets replaced when there are multiple
    -- This is a precaution in case it does
    if item_pickup_old ~= nil then
        item_pickup_old( entity_item, entity_who_picked, item_name )
    end
end