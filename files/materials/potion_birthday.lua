local ms_insert = {
        {
        material="graham_birthday",
        cost=400,
    },
        {
        material="graham_copium",
        cost=400,
	},
}

for k, v in ipairs(ms_insert) do
    table.insert(materials_standard, v)
    table.insert(materials_magic, v)
end