local wands = EntityGetWithTag("wand")
for i = 1, #wands do
    if not EntityHasTag(wands[i], "graham_wand_ineligible") then
        EntityAddTag(wands[i], "graham_wand_ineligible")
        local comp = EntityGetFirstComponentIncludingDisabled(wands[i], "AbilityComponent")
        if comp ~= nil then
            local x, y = EntityGetTransform(wands[i])
            local capacity = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
            SetRandomSeed(comp + GameGetFrameNum(), wands[i] + 42)
            local count = tonumber(GlobalsGetValue("graham_extra_slots_amount", "0") or "0")
            local amount = Random(0 - count, count) * 4
            ComponentObjectSetValue2(comp, "gun_config", "deck_capacity", math.max(1, capacity + amount))

            local deck_capacity = ComponentObjectGetValue( comp, "gun_config", "deck_capacity" )
            local deck_capacity2 = EntityGetWandCapacity( wands[i] )
            local always_casts = math.max( 0, deck_capacity - deck_capacity2 )
            local c = EntityGetAllChildren( wands[i] )
            if ( c ~= nil ) and ( #c > deck_capacity2 + always_casts ) then
                for j=always_casts+1,#c do
                    local v = c[j]
                    local comp2 = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent" )
                    
                    if ( comp2 ~= nil ) and ( j > deck_capacity2 + always_casts ) then
                        EntityRemoveFromParent( v )
                        EntitySetTransform( v, x, y )
                        
                        local all = EntityGetAllComponents( v )
                        
                        for a,b in ipairs( all ) do
                            EntitySetComponentIsEnabled( v, b, true )
                        end
                        local velcomp = EntityGetFirstComponentIncludingDisabled(v, "VelocityComponent") or 0
                        ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
                    end
                end
            end
        end
    end
end