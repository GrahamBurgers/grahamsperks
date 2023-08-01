SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
local options = {
    "wand",
    "potion_blood",
    "potion_graham_mundane",
}
local random = options[Random(1, #options)]
GlobalsSetValue("graham_prayerstatue_type", random)
GlobalsSetValue("graham_prayerstatue_message", GameTextGet("$graham_offering_" .. random))
dofile("mods/grahamsperks/files/scripts/statue_dialogue_change.lua")