local ms_insert = {
        {
        material="graham_graymatter_liquid",
        cost=9999999,
    },
}

local mm_insert = {
        {
        material="graham_graymatter_liquid",
        cost=9999999,
    },
    {
        material="graham_love",
        cost=9999999,
    },
}

for k, v in ipairs(ms_insert) do
    table.insert(materials_standard, v)
end

for k, v in ipairs(mm_insert) do
    table.insert(materials_magic, v)
end