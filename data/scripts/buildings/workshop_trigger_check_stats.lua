dofile_once("data/scripts/lib/utilities.lua")
-- copi: this script deeply disturbs me
function collision_trigger()
    local entity_id = GetUpdatedEntityID()
    local x, y      = EntityGetTransform(entity_id)
    SetRandomSeed(x, y)

    -- Note!
    --  * For global stats use StatsGetValue("enemies_killed")
    --  * For biome stats use StatsBiomeGetValue("enemies_killed")
    --
    -- the difference is that StatsBiomeGetValue() tracks the stats diff since calling StatsResetBiome()
    -- which is what workshop_exit calls
    --
    --
    -- this does the workshop rewards for playing in a certain way
    -- 1) killed none

    local reference_id = EntityGetClosestWithTag(x, y, "workshop_reference")

    local enemies_killed = tonumber(StatsBiomeGetValue("enemies_killed"))
    print(enemies_killed)
    if (enemies_killed == 0) then
        print("KILLED NONE")
        local sx, sy = x, y

        if (reference_id ~= NULL_ENTITY) then
            sx, sy = EntityGetTransform(reference_id)
        else
            print("No reference point found for workshop no-kill chest")
        end

        local cx, cy = GameGetCameraPos()

        print(table.concat { "Loading chest_random.xml to ", tostring(sx), ", ", tostring(sy) })

        if ModSettingGet("grahamsperks.PacifistChest") then
            if Random(1, 12) == 12 then
                local eid = EntityLoad("data/entities/animals/mini_mimic.xml", sx, sy)
            else
                local eid = EntityLoad("mods/grahamsperks/files/pickups/chest_mini.xml", sx, sy)
                change_entity_ingame_name(eid, "$item_chest_treasure_pacifist")
            end
        else
            local eid = EntityLoad("data/entities/items/pickup/chest_random.xml", sx, sy)
            change_entity_ingame_name(eid, "$item_chest_treasure_pacifist")
        end
    else
        print("KILLED ALL")

        -- Below is the script to spawn the Bloody Chest if you have Bloody Bonus
        if GameHasFlagRun("PERK_PICKED_GRAHAM_BLOODY_EXTRA_PERK") then
            local current_biome = BiomeMapGetName(x, y - 500):gsub("$biome_", "")
            if BiomeMapGetName(x, y - 1000):gsub("$biome_", "") == "crypt" then current_biome = "crypt" end

            -- Cpoi:
            -- We have switch cases at home
            -- Switch cases at home:
            local kills_needed = ({
                ["coalmine"]        = 20,
                ["coalmine_alt"]    = 20,
                ["excavationsite"]  = 40,
                ["fungicave"]       = 40,
                ["snowcave"]        = 30,
                ["wandcave"]        = 30,
                ["snowcastle"]      = 40,
                ["rainforest"]      = 30,
                ["rainforest_open"] = 30,
                ["vault"]           = 20,
                ["crypt"]           = 40,
            })[current_biome] or 100

			kills_needed = kills_needed * (0.8 ^ (tonumber(( 1 + GlobalsGetValue( "PLAYER_HALO_LEVEL", "0" )) * -1)))
			kills_needed = math.floor(kills_needed) - 1 -- I forget what this part is supposed to do

            if (enemies_killed >= kills_needed) then
                local sx, sy = x, y

                if (reference_id ~= NULL_ENTITY) then
                    sx, sy = EntityGetTransform(reference_id)
                else
                    print("No reference point found for workshop no-kill chest")
                end

                local chance = 12
                if HasFlagPersistent("graham_bloodymimic_killed") == false then
                    chance = 6
                end

                if Random(1, chance) == chance then
                    local eid = EntityLoad("data/entities/animals/bloody_mimic.xml", sx, sy)
                else
                    local eid = EntityLoad("mods/grahamsperks/files/pickups/chest_bloody.xml", sx, sy + 7)
                end
            end
        end
    end
end
