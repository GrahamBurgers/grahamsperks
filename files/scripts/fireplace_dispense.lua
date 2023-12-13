dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local player = EntityGetClosestWithTag(x, y, "player_unit")
local x2, y2 = EntityGetTransform(player)

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
            if hp < max_hp and fireplace_hp_used < max_hp and distance < 20 then
                -- If healing is applicable, then heal and add to counter
                local hp = hp + (max_hp / 100)
                if hp > max_hp then hp = max_hp end
                fireplace_hp_used = fireplace_hp_used + (max_hp / 100)
                local storage_comp = get_variable_storage_component(entity_id, "fireplace_hp_used")
                ComponentSetValue2(storage_comp, "value_float", fireplace_hp_used)
                ComponentSetValue2( v, "hp", hp)

            end
            local sprite = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent") or 0
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
                ComponentSetValue2( uiinfo, "ui_text", tostring(display) .. " health remaining")
                ComponentSetValue2(sprite, "alpha", 0.1 + trans )
            else
                ComponentSetValue2( uiinfo, "ui_text", "0 health left")
                ComponentSetValue2(sprite, "alpha", 0 )
            end
        break
    end
end