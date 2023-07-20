local wand = EntityGetParent(GetUpdatedEntityID())
if EntityHasTag(wand, "wand") then
    local ac_id = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" ) or 0
    local mana = ComponentGetValue2( ac_id, "mana" )
    local mana_charge_speed = ComponentGetValue2( ac_id, "mana_charge_speed" )
    local amount = 0
    -- get passives
    local spells = EntityGetAllChildren(wand) or {}
    for i, j in ipairs(spells) do
        if EntityHasTag(j, "graham_spelltype_passive") then
            amount = amount + 1
        end
    end
    amount = math.max(0, amount / 60)

    ComponentSetValue2(ac_id,"mana",math.max(mana+(mana_charge_speed * amount ), 0))
end