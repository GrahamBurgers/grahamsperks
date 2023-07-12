local ms_insert = {
    {
        material="graham_bubblygas",
        cost=100,
    },
        {
        material="graham_hellblood",
        cost=80,
    },
        {
        material="graham_confuse",
        cost=40,
    },
    -- silly
        {
        material="graham_beans",
        cost=40,
    },
        {
        material="graham_meatgreedy",
        cost=20,
    },
        {
        material="graham_meathealthy",
        cost=20,
    },
}

for k, v in ipairs(ms_insert) do
    table.insert(potions, v)
end