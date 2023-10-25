if GameHasFlagRun("graham_crystalball") then
    local me = GetUpdatedEntityID()
    local x, y = EntityGetTransform(me)
    EntityAddComponent(me, "BookComponent")
    -- set random wisdom
    local comp = EntityGetFirstComponent(me, "ItemComponent") or 0
    SetRandomSeed(comp, GameGetFrameNum() + me)
    if #EntityGetInRadiusWithTag(x, y, 110, "graham_stargazer") > 0 then
        -- death quest hint
        local count = tonumber(GlobalsGetValue("graham_stargazer_count", "1"))
        local message = GameTextGetTranslatedOrNot("$graham_deathquest_" .. tostring(count))
        ComponentSetValue2(comp, "ui_description", message)
        if count > 5 then count = 0 end
        GlobalsSetValue("graham_stargazer_count", tostring(count + 1))
        GameScreenshake(50, x, y)
        GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y)
    else
        local options_max = 40
        local option = "$graham_wisdom_" .. tostring(Random(1, options_max))
        local message = GameTextGet("$graham_wisdom_start", GameTextGetTranslatedOrNot(option))
        ComponentSetValue2(comp, "ui_description", message)
    end
else
    GameAddFlagRun("graham_crystalball")
end