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
        material="graham_bubblygas",
        cost=100,
    },
        {
        material="graham_hellblood",
        cost=80,
    },
        {
        material="graham_meatgreedy",
        cost=40,
    },
        {
        material="graham_meathealthy",
        cost=40,
    },
    {
        material="graham_confuse",
        cost=40,
    },
    {
        material="graham_tele_chaotic",
        cost=40,
    },
    {
        material="graham_precursor",
        cost=1,
    },
}

for k, v in ipairs(ms_insert) do
    table.insert(potions, v)
end