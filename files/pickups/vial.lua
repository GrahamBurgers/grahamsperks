local vial = "mods/Hydroxide/files/arcane_alchemy/items/vials/empty_vial.xml"
if ModIsEnabled("Hydroxide") and ModDoesFileExist(vial) then
    local x, y, rot = EntityGetTransform(GetUpdatedEntityID())
    local ent = EntityLoad(vial, x, y)
    EntitySetTransform(ent, x, y, rot)
    EntityApplyTransform(ent, x, y, rot)
    EntityKill(GetUpdatedEntityID())
end