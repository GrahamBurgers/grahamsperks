if GameHasFlagRun("graham_crystalball") then
    local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ItemComponent") or 0
    SetRandomSeed(comp, GameGetFrameNum())
    local options_max = 30
    local option = "$graham_wisdom_" .. tostring(Random(1, options_max))
    local message = GameTextGet("$graham_wisdom_start", GameTextGetTranslatedOrNot(option))
    ComponentSetValue2(comp, "ui_description", message)
else
    GameAddFlagRun("graham_crystalball")
end