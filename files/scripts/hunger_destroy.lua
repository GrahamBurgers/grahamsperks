function material_area_checker_success( x, y )
    EntityLoad("mods/grahamsperks/files/entities/hunger_convert.xml", x, y)
    EntityLoad("data/entities/particles/supernova.xml", x, y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/sun/supernova", x, y )
    AddFlagPersistent("graham_progress_appeased")
end