local player = EntityGetRootEntity(GetUpdatedEntityID())
local comp = EntityGetFirstComponentIncludingDisabled(player, "SpriteStainsComponent") or 0
if comp ~= 0 then
    if ComponentGetIsEnabled(comp) then
        EntityAddRandomStains(player, CellFactory_GetType("graham_unstainer"), 400)
        EntityAddComponent2(player, "LuaComponent", {
            script_source_file="mods/grahamsperks/files/scripts/clean_on.lua",
            execute_every_n_frame=5,
            remove_after_executed=true,
        })
    end
end