local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "LifetimeComponent") or 0
local value = tonumber(GlobalsGetValue( "GRAHAM_ROBOTS_COUNT", "0"))
local lifetime = 3600 + (600 * ((value / 3) - 1))
ComponentSetValue2(comp, "kill_frame", GameGetFrameNum() + lifetime)