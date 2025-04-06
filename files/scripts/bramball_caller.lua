local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
local bramballs = EntityGetInRadiusWithTag(x, y, 2, "graham_bramball") or {}
for i = 1, #bramballs do
    EntityRemoveTag(bramballs[i], "graham_bramball")
    local x2, y2 = EntityGetTransform(bramballs[i])
    local vel = EntityGetFirstComponentIncludingDisabled(bramballs[i], "VelocityComponent")
    if vel then
        ComponentSetValue2(vel, "terminal_velocity", 0.1)
        ComponentSetValue2(vel, "apply_terminal_velocity", true) -- if you're using No Speed Limit lol
    end
    local sprite = EntityGetFirstComponentIncludingDisabled(bramballs[i], "SpriteComponent")
    if sprite then
        ComponentSetValue2(sprite, "image_file", "mods/grahamsperks/files/projectiles_gfx/brambles.xml")
        ComponentSetValue2(sprite, "update_transform_rotation", false)
        ComponentSetValue2(sprite, "additive", true)
        EntityRefreshSprite(me, sprite)
    end
    EntityAddComponent2(bramballs[i], "LuaComponent", {
        script_source_file="mods/grahamsperks/files/scripts/brambles.lua"
    })
    EntityAddComponent2(bramballs[i], "GameAreaEffectComponent", {
		radius=18,
		frame_length=12,
    })
    local particles = EntityGetComponent(bramballs[i], "ParticleEmitterComponent") or {}
    for j = 1, #particles do
        EntityRemoveComponent(bramballs[i], particles[j])
    end
end