local x, y = EntityGetTransform(GetUpdatedEntityID())
EntityLoad("mods/grahamsperks/files/entities/progress/progress_shape.xml", x, y)
local flags = {
    "graham_progress_tech_chest_rain", "graham_progress_mini_chest_rain", "graham_progress_lost_chest_rain", "graham_progress_bloody_chest_rain",
    "graham_progress_gluestick_exchange", "graham_progress_coffee_exchange", "graham_progress_experimental_exchange", "graham_progress_rotting_exchange", "graham_progress_petworm_exchange", "graham_progress_candyheart_exchange",
    "graham_progress_appeased",
    "graham_progress_lucky", "graham_progress_hunger", "graham_progress_sheep","graham_bloodymimic_killed","graham_progress_tech","graham_progress_lukki","graham_progress_robot","graham_progress_deathquest",
    "graham_minimimic_killed", "graham_bloodymimic_killed",
}

if HasFlagPersistent("graham_used_unlock_all") then
    GameCreateSpriteForXFrames("mods/grahamsperks/files/entities/progress/progress_cracked.png", x, y, false, 0, 0, 5)
else
    GameCreateSpriteForXFrames("mods/grahamsperks/files/entities/progress/progress_back.png", x, y, false, 0, 0, 5)
end


local set1 = true
local set2 = true
for i = 1, #flags do
    if HasFlagPersistent(flags[i]) then
        GameCreateSpriteForXFrames("mods/grahamsperks/files/entities/progress/progress_" .. tostring(i) .. ".png", x, y, false, 0, 0, 5)
    else
        if i < 11 then
            set1 = false
        elseif i > 11 then
            set2 = false
        end
    end
end

if set1 then
    GameCreateSpriteForXFrames("mods/grahamsperks/files/entities/progress/set1.png", x, y, false, 0, 0, 5)
end
if set2 then
    GameCreateSpriteForXFrames("mods/grahamsperks/files/entities/progress/set2.png", x, y, false, 0, 0, 5)
end