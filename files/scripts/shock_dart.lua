local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent")
local line = EntityGetFirstComponent(GetUpdatedEntityID(), "CardinalMovementComponent")
if comp and line then
	local mat = ComponentGetValue2(comp, "emitted_material_name")
	if mat == "magic_liquid_faster_levitation" then
		ComponentSetValue2(comp, "emitted_material_name", "magic_liquid_unstable_teleportation")
		ComponentSetValue2(line, "horizontal_movement", false)
		ComponentSetValue2(line, "vertical_movement", false)
		ComponentSetValue2(line, "intercardinal_movement", true)
	else
		ComponentSetValue2(comp, "emitted_material_name", "magic_liquid_faster_levitation")
		ComponentSetValue2(line, "horizontal_movement", true)
		ComponentSetValue2(line, "vertical_movement", true)
		ComponentSetValue2(line, "intercardinal_movement", false)
	end
end