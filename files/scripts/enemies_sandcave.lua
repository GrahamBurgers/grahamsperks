table.insert(g_small_enemies, {
    prob   		= 0.1,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/graham_miner_gasser.xml"
})
table.insert(g_small_enemies, {
    prob   		= 0.1,
    min_count	= 1,
    max_count	= 1,
    entity 	= "data/entities/animals/graham_fuzz.xml"
})
table.insert(g_big_enemies, {
    prob   		= 0.1,
    min_count	= 2,
    max_count	= 3,
    entity 	= "data/entities/animals/graham_fuzz.xml"
})
table.insert(g_big_enemies, {
    prob   		= 0.08,
    min_count	= 1,
    max_count	= 1,
    entities 	= {
        {
            min_count	= 1,
            max_count 	= 2,
            entity = "data/entities/animals/scavenger_glue.xml",
        },
        {
            min_count	= 1,
            max_count 	= 2,
            entity = "data/entities/animals/graham_miner_gasser.xml",
        },
    }
})