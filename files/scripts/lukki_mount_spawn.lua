if #EntityGetWithTag("graham_lukki_mount") == 0 then
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    EntityLoad("mods/grahamsperks/files/entities/lukki_mount/lukki_mount.xml", x, y)
    EntityLoad( "data/entities/particles/teleportation_target.xml", x, y )
end