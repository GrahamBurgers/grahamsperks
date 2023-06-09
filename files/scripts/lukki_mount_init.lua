local function toggle_comps(who, tag, toggle)
    local comps = EntityGetAllComponents(who)
    for i = 1, #comps do
        if ComponentHasTag(comps[i], tag) then
            EntitySetComponentIsEnabled(who, comps[i], toggle)
        end
    end
end

local me = GetUpdatedEntityID()
toggle_comps(me, "graham_lukki_mount", false)
toggle_comps(me, "graham_lukki_dismount", true)

local comp = EntityGetFirstComponent(me, "AreaDamageComponent") or 0
ComponentSetValue2(comp, "entity_responsible", me)