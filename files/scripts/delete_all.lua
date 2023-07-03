local x2, y2 = EntityGetTransform(GetUpdatedEntityID())
local items = EntityGetWithTag("item_pickup")
for i = 1, #items do
    EntityKill(items[i])
end

local item = EntityGetWithTag("item")
for i = 1, #item do
    EntityKill(item[i])
end

local wand = EntityGetWithTag("wand")
for i = 1, #wand do
    EntityKill(wand[i])
end

local perks = EntityGetWithTag("perk")
for i = 1, #perks do
    EntityKill(perks[i])
end

local potions = EntityGetWithTag("potion")
for i = 1, #potions do
    EntityKill(potions[i])
end

local spells = EntityGetWithTag("card_action")
for i = 1, #spells do
    EntityKill(spells[i])
end

local sampo = EntityGetWithTag("this_is_sampo")
for i = 1, #sampo do
    EntityKill(sampo[i])
end

local positions = {156, 1325, 2859, 4909, 6445, 8493, 10541, 13096}
local x, y = EntityGetTransform(GetUpdatedEntityID())
for i = 1, #positions do
    if y > positions[i] and not GameHasFlagRun("graham_message_" .. tostring(positions[i])) then
        GameAddFlagRun("graham_message_" .. tostring(positions[i]))
        GamePrint(GameTextGetTranslatedOrNot("$graham_deathcomplete_" .. tostring(i)))
        GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y)
    end
end