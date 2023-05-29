local ms_insert = {
        {
        material="graham_mundane",
        cost=300,
    },
        {
        material="graham_beans",
        cost=100,
    },
        {
        material="graham_stickyfungus",
        cost=100,
    },
        {
        material="graham_pureliquid",
        cost=80,
    },
        {
        material="graham_wormygold",
        cost=1,
    },
}

local mm_insert = {
        {
        material="graham_mundane",
        cost=150,
    },
        {
        material="graham_slush",
        cost=150,
    },
        {
        material="graham_statium",
        cost=100,
    },
        {
        material="graham_tele_chaotic",
        cost=80,
    },
        {
        material="graham_bubbly",
        cost=50,
    },
        {
        material="graham_resist",
        cost=20,
    },
        {
        material="graham_confuse",
        cost=20,
    },
}

for k, v in ipairs(ms_insert) do
    table.insert(materials_standard, v)
end

for k, v in ipairs(mm_insert) do
    table.insert(materials_magic, v)
end