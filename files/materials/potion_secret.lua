local ms_insert = {
        {
        material="graham_meathealthy",
        cost=300,
    },
        {
        material="graham_meatgreedy",
        cost=100,
    }
}

local mm_insert = {
        {
        material="graham_precursor",
        cost=50,
	}
}

for k, v in ipairs(ms_insert) do
    table.insert(materials_standard, v)
end

for k, v in ipairs(mm_insert) do
    table.insert(materials_magic, v)
end