local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "LuaComponent", "readd_luckyday") or 0
ComponentSetValue2(comp, "script_damage_about_to_be_received", "mods/grahamsperks/files/luckyday.lua")
ComponentRemoveTag(comp, "readd_luckyday")