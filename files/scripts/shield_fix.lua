local me = GetUpdatedEntityID()
local shields = EntityGetAllChildren(me) or {}
if EntityGetFirstComponent(shields[1], "InheritTransformComponent") ~= nil then return end
for i = 1, #shields do
    local comps = EntityGetAllComponents(shields[i]) or 0
    for a = 1, #comps do
        EntitySetComponentIsEnabled(shields[i], comps[a], true)
    end
end