function item_pickup(me)
    EntityRemoveTag(me, "graham_spell_circle")
    EntityAddComponent(me, "SimplePhysicsComponent", {
        _tags="enabled_in_world"
    })
    local x, y = EntityGetTransform(me)
    local spells = EntityGetInRadiusWithTag(x, y, 80, "graham_statue_ineligible")
    for i = 1, #spells do
        local x2, y2 = EntityGetTransform(spells[i])
        EntityLoad("data/entities/particles/poof_blue.xml", x2, y2)
        if spells[i] ~= me and EntityGetRootEntity(spells[i]) == spells[i] then
            EntityKill(spells[i])
        end
    end
end