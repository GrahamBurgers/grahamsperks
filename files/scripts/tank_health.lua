local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "VariableStorageComponent", "minitank_hp") or 0
local value = tonumber(GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0") or "0") - 1
local lifetime = ComponentGetValue2(comp, "value_float") * 1.5 ^ value
ComponentSetValue2(comp, "value_float", lifetime)
ComponentSetValue2(comp, "value_int", lifetime)
local me = GetUpdatedEntityID()
EntityRemoveTag(me, "homing_target")
EntityRemoveTag(me, "destruction_target")
EntityRemoveTag(me, "mortal")
EntityRemoveTag(me, "hittable")