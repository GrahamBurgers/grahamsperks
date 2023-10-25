local me = GetUpdatedEntityID()
local wand = EntityGetParent(me)
local comp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") or 0
if comp ~= 0 then
    if ComponentGetValue2(comp, "mana") >= ComponentGetValue2(comp, "mana_max") then
        EntitySetComponentsWithTagEnabled(me, "graham_lightbulb", true)
        local effect = EntityCreateNew()
        EntityAddComponent2(effect, "GameEffectComponent", {
            effect="MOVEMENT_FASTER",
            exclusivity_group=8,
            frames=4,
        })
        EntityAddChild(EntityGetRootEntity(me), effect)
    else
        EntitySetComponentsWithTagEnabled(me, "graham_lightbulb", false)
    end
end