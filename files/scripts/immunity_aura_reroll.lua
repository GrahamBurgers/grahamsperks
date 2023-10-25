dofile_once("data/scripts/lib/utilities.lua")

local me = GetUpdatedEntityID()

if #EntityGetWithTag("graham_immunityaura") > 0 and #EntityGetWithTag("graham_immunityaura_cooldown") <= 0 then
        local x, y = EntityGetTransform(me)
        local entity = EntityGetClosestWithTag(x, y, "graham_immunityaura")
        local player = EntityGetRootEntity(entity)

        -- remove current immunity aura
        EntityKill(entity)

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

        local comp = get_variable_storage_component(player, "graham_immunityaura")
        local current = ComponentGetValue2(comp, "value_string")
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
            local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/cooldown.xml", x, y )
            EntityAddChild( player, entity_id )
            GamePrintImportant("$graham_immunityaura_none1", "$graham_immunityaura_none2")

            EntityAddComponent( player, "LuaComponent",
            {
                _tags = "perk_component",
                script_damage_about_to_be_received = "mods/grahamsperks/files/entities/immunityaura/resistance.lua",
                execute_every_n_frame = "-1",
            } )
        else

            -- roll new random
            SetRandomSeed( GameGetFrameNum(), x + y )
            local result = options[Random(1, #options)]

            -- add new and print message
            GamePrintImportant("$graham_immunityaura_change", "$graham_immunityaura_" .. tostring(result))
            local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/" .. tostring(result) .. ".xml", x, y )
            EntityAddChild( player, entity_id )
            local entity_id = EntityLoad( "mods/grahamsperks/files/entities/immunityaura/cooldown.xml", x, y )
            EntityAddChild( player, entity_id )

            -- remember our current immunity
            ComponentSetValue2(comp, "value_string", tostring(result))
        end
    end