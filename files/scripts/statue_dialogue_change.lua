local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "InteractableComponent") or 0
local message = GameTextGetTranslatedOrNot(GlobalsGetValue("graham_prayerstatue_message", "$graham_prayerstatue_intro0") or "$graham_prayerstatue_intro0")
if ComponentGetValue2(comp, "name") == "$graham_prayerstatue_intro0" then return end
local new_message = ""
for i = 1, string.len(message) do
    SetRandomSeed(GameGetFrameNum(), i)
    local random = Random(1, 60)
    if random == 1 then
        new_message = new_message .. "\\"
    elseif random == 2 then
        new_message = new_message .. "#"
    elseif random == 3 then
        new_message = new_message .. "-"
    elseif random == 4 then
        new_message = new_message .. "_"
    elseif random == 5 then
        new_message = new_message .. "/"
    else
        new_message = new_message .. string.sub(message, i, i)
    end
end
ComponentSetValue2(comp, "ui_text", new_message)