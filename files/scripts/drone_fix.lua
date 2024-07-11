local me = GetUpdatedEntityID()
---@diagnostic disable-next-line: undefined-global
if ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted") == 1 then -- init
    local item = EntityAddComponent2(me, "ItemComponent", {
        _tags="enabled_in_world",
		item_name="$graham_basedrone",
		ui_description="$graham_drone_desc",
		ui_sprite="mods/grahamsperks/files/pickups/burg.png",
		max_child_items=0,
		is_pickable=true,
		is_equipable_forced=true,
		play_spinning_animation=false,
		preferred_inventory="QUICK",
    })
    local name = EntityGetName(me)
    if name == "$graham_attackdrone" then
        ComponentSetValue2(item, "item_name", "$graham_attackdrone")
        ComponentSetValue2(item, "ui_sprite", "mods/grahamsperks/files/projectiles_gfx/attack_drone_inv.png")
    elseif name == "$graham_supportdrone" then
        ComponentSetValue2(item, "item_name", "$graham_supportdrone")
        ComponentSetValue2(item, "ui_sprite", "mods/grahamsperks/files/projectiles_gfx/support_drone_inv.png")
    elseif name == "$graham_shielddrone" then
        ComponentSetValue2(item, "item_name", "$graham_shielddrone")
        ComponentSetValue2(item, "ui_sprite", "mods/grahamsperks/files/projectiles_gfx/shield_drone_inv.png")
    end
    local c = EntityGetAllComponents(me)
    for i, p in ipairs(c) do
        if not ComponentHasTag(p, "drone_base_comp") then
            ComponentAddTag(p, "enabled_in_world")
        end
    end
    local proj = EntityGetFirstComponent(me, "ProjectileComponent")
    local dmg = EntityGetFirstComponent(me, "DamageModelComponent")
    if proj and dmg then
        local lifetime = ComponentGetValue2(proj, "lifetime") - 1
        ComponentSetValue2(proj, "lifetime", -1)
        ComponentSetValue2(dmg, "max_hp", ComponentGetValue2(dmg, "max_hp") + lifetime / 60)
        ComponentSetValue2(dmg, "hp", ComponentGetValue2(dmg, "hp") + lifetime / 60)
    end
end

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