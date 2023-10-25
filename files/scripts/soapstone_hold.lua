local player = EntityGetRootEntity(GetUpdatedEntityID())

local remover = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "graham_soapstone_remover")
if remover ~= nil then
    EntityRemoveComponent(player, remover)
end
EntityAddRandomStains( player, CellFactory_GetType("graham_unstainer"), 400 )

EntityAddComponent2(player, "LuaComponent", {
    script_source_file="mods/grahamsperks/files/scripts/soapstone_clean.lua",
    execute_every_n_frame=5,
    remove_after_executed=true,
})