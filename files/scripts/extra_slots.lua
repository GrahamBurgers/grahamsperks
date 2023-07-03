local wands = EntityGetWithTag("wand")
for i = 1, #wands do
    if not EntityHasTag(wands[i], "graham_wand_inelidgible") then
        EntityAddTag(wands[i], "graham_wand_inelidgible")
        local comp = EntityGetFirstComponentIncludingDisabled(wands[i], "AbilityComponent") or 0
        if comp ~= 0 then
            local capacity = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
            SetRandomSeed(comp + GameGetFrameNum(), wands[i] + 42)
            local count = tonumber(GlobalsGetValue("graham_extra_slots_amount", "0") or "0")
            local amount = Random(0 - count, count) * 4
            ComponentObjectSetValue2(comp, "gun_config", "deck_capacity", math.max(1, capacity + amount))
        end
    end
end