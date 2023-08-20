local me = GetUpdatedEntityID()
---@diagnostic disable-next-line: undefined-global
if #PhysicsBodyIDGetFromEntity(me) < 1 then
    if EntityGetFirstComponent(me, "AnimalAIComponent") ~= nil then
        EntitySetComponentsWithTagEnabled(me, "enabled_in_world", false)
        EntityAddComponent2(me, "LuaComponent", {
            script_source_file="mods/grahamsperks/files/scripts/drone_fix.lua"
        })
    else
        EntitySetComponentsWithTagEnabled(me, "enabled_in_world", true)
    end
end