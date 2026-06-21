Options = {
	{img = "bleed.png", reward="gold", mat1 = "blood", mat2 = "meat", mat3 = "blood_fading", mat4 = "apotheosis_blood_infectious"},
	{img = "drown.png", reward="graham_statium", mat1 = "water", mat2 = "water_fading", mat3 = "graham_water_cloud", mat4 = "apotheosis_magic_liquid_suffocatium"},
	{img = "puke.png",  reward="magic_liquid_faster_levitation_and_movement", mat1 = "vomit", mat2 = "graham_resist"},
	{img = "trip.png",  reward="graham_ascendum", mat1 = "fungi", mat2 = "graham_stickyfungus", mat3 = "graham_driedfungus", mat4 = "fungi_green"},
	{img = "see.png",   reward="magic_gas_midas", mat1 = "blood_worm", mat2 = "magic_liquid_invisibility"},
	{img = "feast.png", reward="magic_liquid_hp_regeneration", mat1 = "graham_meatdone", mat2 = "meat_done", mat3 = "graham_meatgreedy", mat4 = "graham_meathealthy"},
}

function Get_type_or_panic(type)
	local thing = CellFactory_GetType(type)
	if thing == -1 then return CellFactory_GetType("shock_powder") end
	return thing
end

function material_area_checker_success(x, y)
	local me = GetUpdatedEntityID()
    local var = EntityGetFirstComponent(me, "VariableStorageComponent", "goldblood")
    local count = var and ComponentGetValue2(var, "value_int") or 1

	-- reward
	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
	local entity = EntityCreateNew()
	EntitySetTransform(entity, x, y)
	EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
		kill_when_finished=true,
		from_material=Get_type_or_panic(Options[count].mat1),
		to_material=Get_type_or_panic(Options[count].reward),
		radius=30,
		steps_per_frame=4,
		clean_stains=false,
		is_circle=true,
		loop=false,
	})
	EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
		kill_when_finished=true,
		from_material=Get_type_or_panic(Options[count].mat2),
		to_material=Get_type_or_panic(Options[count].reward),
		radius=30,
		steps_per_frame=4,
		clean_stains=false,
		is_circle=true,
		loop=false,
	})
	EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
		kill_when_finished=true,
		from_material=Get_type_or_panic(Options[count].mat3),
		to_material=Get_type_or_panic(Options[count].reward),
		radius=30,
		steps_per_frame=4,
		clean_stains=false,
		is_circle=true,
		loop=false,
	})
	EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
		kill_when_finished=true,
		from_material=Get_type_or_panic(Options[count].mat4),
		to_material=Get_type_or_panic(Options[count].reward),
		radius=30,
		steps_per_frame=4,
		clean_stains=false,
		is_circle=true,
		loop=false,
	})
	if var then
		count = count + 1
		ComponentSetValue2(var, "value_int", count)
	end

    if count > #Options then
        EntityKill(me)
        entity = EntityCreateNew()
        EntitySetTransform(entity, x, y)
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=Get_type_or_panic("templebrick_diamond_static"),
            to_material=Get_type_or_panic("graham_ash"),
            radius=128,
            steps_per_frame=20,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=Get_type_or_panic("templebrick_golden_static"),
            to_material=Get_type_or_panic("graham_ash"),
            radius=128,
            steps_per_frame=20,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
    else
        EntityAddComponent2(me, "LuaComponent", {
			script_source_file="mods/grahamsperks/files/entities/goldblood_init.lua",
			execute_on_added=true,
			remove_after_executed=true,
		})
    end
end