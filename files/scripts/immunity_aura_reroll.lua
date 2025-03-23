dofile_once("data/scripts/lib/utilities.lua")

local me = GetUpdatedEntityID()
local player = EntityGetRootEntity(me)
local imm = EntityGetAllChildren(player, "graham_immunityaura") or {}
local cool = EntityGetAllChildren(player, "graham_immunityaura_cooldown") or {}

if #imm > 0 and #cool <= 0 then
    local x, y = EntityGetTransform(me)

    -- remove current immunity aura
    for i = 1, #imm do
        EntityKill(imm[i])
    end

    -- fx
    EntityRemoveIngestionStatusEffect( player, "CONFUSION" );
    GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
    GameTriggerMusicEvent( "music/oneshot/tripping_balls_01", false, x, y )

    -- table setup; don't give player immunities they already have

    local options = {}
    if GameGetGameEffect(player, "PROTECTION_FIRE") == 0 then
        table.insert(options, "red")
    end
    if GameGetGameEffect(player, "PROTECTION_EXPLOSION") == 0 then
        table.insert(options, "orange")
    end
    if GameGetGameEffect(player, "PROTECTION_ELECTRICITY") == 0 then
        table.insert(options, "yellow")
    end
    if GameGetGameEffect(player, "PROTECTION_RADIOACTIVITY") == 0 then
        table.insert(options, "green")
    end
    if GameGetGameEffect(player, "PROTECTION_FREEZE") == 0 then
        table.insert(options, "cyan")
    end
    if GameGetGameEffect(player, "BREATH_UNDERWATER") == 0 then
        table.insert(options, "blue")
    end
    if GameGetGameEffect(player, "PROTECTION_MELEE") == 0 then
        table.insert(options, "purple")
    end

    local comp = EntityGetFirstComponent(player, "VariableStorageComponent", "graham_immunityaura")
    local current = comp and ComponentGetValue2(comp, "value_string") or "oops"
    -- remove current immunity from pool
    for o, type in ipairs(options) do
        if type == current then
            table.remove(options, o)
        end
    end

    if #options < 1 then
        -- do nothing if we can't benefit the player
        -- convert immunity aura into a permanent passive damage resistance
        -- i think this works?
        GamePrintImportant("$graham_immunityaura_none1", "$graham_immunityaura_none2")

        EntityAddComponent2(player, "LuaComponent", {
            _tags = "perk_component",
            script_damage_about_to_be_received="mods/grahamsperks/files/entities/immunityaura/resistance.lua",
            execute_every_n_frame=-1,
        })
    else

        -- roll new random
        SetRandomSeed( GameGetFrameNum(), x + y )
        local result = options[Random(1, #options)]

        -- add new and print message
        GamePrintImportant("$graham_immunityaura_change", "$graham_immunityaura_" .. tostring(result))
        local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/" .. tostring(result) .. ".xml", x, y )
        EntityAddChild( player, entity_id )
        entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/cooldown.xml", x, y )
        EntityAddChild( player, entity_id )

        if comp then
            -- remember our current immunity
            ComponentSetValue2(comp, "value_string", tostring(result))
        end
    end
end