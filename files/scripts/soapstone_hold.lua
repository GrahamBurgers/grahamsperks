local me = GetUpdatedEntityID()
local player = EntityGetRootEntity(me)
local x, y = EntityGetTransform(me)

if player ~= me then
    local remover = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "graham_soapstone_remover")
    if remover ~= nil then
        EntityRemoveComponent(player, remover)
    end
end
local soaps = EntityGetInRadiusWithTag(x, y, 20, "human") -- i hope this tag is reliable
for i = 1, #soaps do
    EntityAddRandomStains(soaps[i], CellFactory_GetType("graham_unstainer"), 400)
end

if player ~= me then
    EntityAddComponent2(player, "LuaComponent", {
        script_source_file="mods/grahamsperks/files/scripts/soapstone_clean.lua",
        execute_every_n_frame=5,
        remove_after_executed=true,
    })
end