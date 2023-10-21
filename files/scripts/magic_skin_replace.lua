dofile_once("data/scripts/perks/perk.lua")
local x, y = EntityGetTransform(GetUpdatedEntityID())
x = x + 200
local perks = EntityGetInRadiusWithTag(x, y, 300, "perk")
local magicskin = tonumber(GlobalsGetValue( "GRAHAM_MAGIC_SKIN_COUNTER", "0" ))
if magicskin > 0 and DoesWorldExistAt(x - 50, y + 50, x + 50, y + 50) and magicskin < 30 then
    for i = 1, math.ceil(magicskin / 1.5) do
        SetRandomSeed(x + 23499, y + 45082420)
        local number = Random(1, #perks)
        local x2, y2 = EntityGetTransform(perks[number])
        perk_spawn( x2, y2, "GRAHAM_MAGIC_SKIN", false )
        EntityKill(perks[number])
        table.remove(perks, number)
    end
    EntityKill(GetUpdatedEntityID())
end