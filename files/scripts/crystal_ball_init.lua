if GameHasFlagRun("graham_crystalball") then
    local me = GetUpdatedEntityID()
    -- set random wisdom
    local comp = EntityGetFirstComponent(me, "ItemComponent") or 0
    SetRandomSeed(comp, GameGetFrameNum() + me)
    local options_max = 40
    local option = "$graham_wisdom_" .. tostring(Random(1, options_max))
    local message = GameTextGet("$graham_wisdom_start", GameTextGetTranslatedOrNot(option))
    ComponentSetValue2(comp, "ui_description", message)
    -- add book component
    EntityAddComponent(me, "BookComponent")
else
    GameAddFlagRun("graham_crystalball")
end