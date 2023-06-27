function material_area_checker_success( x, y )
    ConvertMaterialEverywhere(CellFactory_GetType("graham_graymatter_liquid"), CellFactory_GetType("graham_yum"))
    EntityLoad("data/entities/particles/supernova.xml", x, y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/sun/supernova", x, y )
    AddFlagPersistent("graham_progress_appeased")
end