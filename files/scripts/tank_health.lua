local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "LifetimeComponent") or 0
local value = tonumber(GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0"))
local lifetime = ComponentGetValue2(comp, "lifetime") + value
ComponentSetValue2(comp, "kill_frame", GameGetFrameNum() + lifetime)
local me = GetUpdatedEntityID()
EntityRemoveTag(me, "homing_target")
EntityRemoveTag(me, "destruction_target")
EntityRemoveTag(me, "mortal")
EntityRemoveTag(me, "hittable")