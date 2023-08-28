local graham_death_old = death

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    if graham_death_old ~= nil then
        graham_death_old(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    end
    if ModIsEnabled("noita-together") or ModIsEnabled("raksa") then return end
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    -- check in reverse order
    -- step 3
    if HasFlagPersistent("graham_deathquest_02") and EntityHasTag(entity_thats_responsible, "secret_fruit") then
        RemoveFlagPersistent("graham_deathquest_02")
        GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y)
        GameScreenshake(100, x, y)
        AddFlagPersistent("graham_deathquest_03")
        AddFlagPersistent("graham_death_is_ok")
        AddFlagPersistent("graham_progress_deathquest")
    else
        -- step 2
        if HasFlagPersistent("graham_deathquest_01") and damage_message == "$damage_radioactive" then
            RemoveFlagPersistent("graham_deathquest_01")
            GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y)
            GameScreenshake(75, x, y)
            AddFlagPersistent("graham_deathquest_02")
            AddFlagPersistent("graham_death_is_ok")
        else
            -- step 1
            if EntityGetName(entity_thats_responsible) == "$animal_ghost" then
                AddFlagPersistent("graham_deathquest_01")
                GameScreenshake(50, x, y)
                GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y)
                AddFlagPersistent("graham_death_is_ok")
            else
                RemoveFlagPersistent("graham_deathquest_01")
                RemoveFlagPersistent("graham_deathquest_02")
                RemoveFlagPersistent("graham_deathquest_03")
            end
        end

    end
end