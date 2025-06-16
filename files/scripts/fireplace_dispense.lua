dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetClosestWithTag(x, y, "player_unit")
local x2, y2 = EntityGetTransform(player)
if (not player) or (not x2) or (not y2) then return end

local dir_x = x - x2
local dir_y = y - y2
local distance = math.sqrt(dir_x * dir_x + dir_y * dir_y)

local comp = get_variable_storage_component(entity_id, "fireplace_hp_used")
local fireplace_hp_used = ComponentGetValue2(comp, "value_float")

local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
if( damagemodels ~= nil ) then
    for i,v in ipairs(damagemodels) do
        local hp = ComponentGetValue2( v, "hp" )
        local max_hp = ComponentGetValue2( v, "max_hp")
        local sprite = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
        if distance < 20 then
            if hp < max_hp and fireplace_hp_used < max_hp then
                -- If healing is applicable, then heal and add to counter
                hp = hp + (max_hp / 100)
                if hp > max_hp then hp = max_hp end
                fireplace_hp_used = fireplace_hp_used + (max_hp / 100)
                local storage_comp = get_variable_storage_component(entity_id, "fireplace_hp_used")
                ComponentSetValue2(storage_comp, "value_float", fireplace_hp_used)
            end
            if sprite[2] and ComponentGetValue2(sprite[2], "image_file") == "mods/grahamsperks/files/entities/fireplace_mallow.png" then
                EntityLoad("data/entities/particles/heal_effect.xml", x, y)
                ComponentSetValue2(sprite[2], "image_file", "mods/grahamsperks/files/entities/fireplace_mallowless.png")
                hp = hp + 0.601 -- rounding error
                max_hp = max_hp + 0.601
                EntityRefreshSprite(entity_id, sprite[2])
            end
            ComponentSetValue2( v, "hp", hp)
            ComponentSetValue2( v, "max_hp", max_hp)
        end
        local trans = 1 - (fireplace_hp_used / max_hp)
        local emittercomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ParticleEmitterComponent") or 0
        ComponentSetValue2(emittercomp, "count_max", trans * 60 )

        if trans < 0.2 then
            ComponentSetValue2(emittercomp, "is_emitting", false )
        else
            ComponentSetValue2(emittercomp, "is_emitting", true )
        end
        local lights = EntityGetComponentIncludingDisabled(entity_id, "LightComponent") or {}
        for j = 1, #lights do
            ComponentSetValue2(lights[j], "radius", math.max(0, trans * 100))
        end

        local uiinfo = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent") or 0
        -- Very excessive use of parentheses cause I think I forgot the order of operations
        local display = math.floor(max_hp * 25 - fireplace_hp_used * 25)
        if display > 0 then
            ComponentSetValue2( uiinfo, "ui_text", GameTextGet("$graham_campfire_xleft", tostring(display)))
            ComponentSetValue2(sprite[1], "alpha", 0.1 + trans )
        else
            ComponentSetValue2( uiinfo, "ui_text", GameTextGet("$graham_campfire_empty"))
            ComponentSetValue2(sprite[1], "alpha", 0 )
        end
    break
    end
end