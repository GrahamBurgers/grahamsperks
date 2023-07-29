local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ParticleEmitterComponent") or 0
if comp ~= 0 then
    if ComponentGetValue2(comp, "emitted_material_name") == "magic_liquid_unstable_teleportation" then
        ComponentSetValue2(comp, "emitted_material_name", "magic_liquid_faster_levitation")
    elseif ComponentGetValue2(comp, "emitted_material_name") == "magic_liquid_faster_levitation" then
        ComponentSetValue2(comp, "emitted_material_name", "magic_liquid_unstable_teleportation")
    end
end