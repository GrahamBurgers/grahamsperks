local player = EntityGetRootEntity(GetUpdatedEntityID())

-- turn off stain component
local comp = EntityGetFirstComponentIncludingDisabled(player, "SpriteStainsComponent") or 0
EntitySetComponentIsEnabled(player, comp, false)
-- reenable if item is not held
EntityAddComponent2(player, "LuaComponent", {
    _tags="graham_soapstone_remover",
    script_source_file="mods/grahamsperks/files/scripts/soapstone_remove.lua",
    execute_every_n_frame=5,
    remove_after_executed=true,
})