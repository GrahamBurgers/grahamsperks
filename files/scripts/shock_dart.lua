local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
if comp ~= 0 then
	local mat = ComponentGetValue2(comp, "emitted_material_name")
	ComponentSetValue2(comp, "emitted_material_name", ({
		magic_liquid_unstable_teleportation = "magic_liquid_faster_levitation",
		magic_liquid_faster_levitation = "magic_liquid_unstable_teleportation"
	})[mat] or mat)
end