local me = GetUpdatedEntityID()
EntitySetComponentsWithTagEnabled(me, "graham_lukki_mount", false)
EntitySetComponentsWithTagEnabled(me, "graham_lukki_dismount", true)

local comp = EntityGetFirstComponent(me, "AreaDamageComponent") or 0
ComponentSetValue2(comp, "entity_responsible", me)