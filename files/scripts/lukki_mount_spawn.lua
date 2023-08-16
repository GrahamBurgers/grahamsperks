if #EntityGetWithTag("graham_lukki_mount") == 0 then
    if GameGetFrameNum() - tonumber(GlobalsGetValue("graham_lukki_mount_last_spotted", "-999999")) > 300 then
        local x, y = EntityGetTransform(GetUpdatedEntityID())
        EntityLoad("mods/grahamsperks/files/entities/lukki_mount/lukki_mount.xml", x, y)
        EntityLoad( "data/entities/particles/teleportation_target.xml", x, y )
        GlobalsSetValue("graham_lukki_mount_last_spotted", tostring(GameGetFrameNum()))
    end
else
    GlobalsSetValue("graham_lukki_mount_last_spotted", tostring(GameGetFrameNum()))
end