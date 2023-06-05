local j = GetUpdatedEntityID()
--[[
local comp = EntityGetFirstComponentIncludingDisabled(j, "ItemActionComponent")
if comp ~= nil then
    local id = ComponentGetValue2(comp, "action_id")
    dofile_once("data/scripts/gun/gun_actions.lua")
    SetRandomSeed(id, j)
    for a, b in ipairs(actions) do
        if b.id == id then
            EntityAddComponent2(j, "VariableStorageComponent", {
                _tags="graham_spell_type",
                value_string=b.type
            })
            GamePrint(id .. " = " .. b.id)
            GamePrint(tostring(b.type))
            break
        end
    end
end]]--
local comp = EntityGetAllComponents(j) or {}
for i = 1, #comp do
    if ComponentGetTypeName( comp[i] ) == "SpriteComponent" then
        local sprite = ComponentGetValue2(comp[i], "image_file")
        if sprite == "data/ui_gfx/inventory/item_bg_passive.png" then
            EntityAddTag(j, "graham_is_passive")
            break
        end
    end
end