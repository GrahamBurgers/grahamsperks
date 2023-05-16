local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "LuaComponent", "readd_zaptap") or 0
ComponentSetValue2(comp, "script_damage_about_to_be_received", "mods/grahamsperks/files/zaptap.lua")
ComponentRemoveTag(comp, "readd_zaptap")