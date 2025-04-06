local me = GetUpdatedEntityID()
function material_area_checker_success(x, y)
    local var = EntityGetFirstComponent(me, "VariableStorageComponent", "goldblood")
    local count = 1
    if var then
        count = ComponentGetValue2(var, "value_int")
    else
        var = EntityAddComponent2(me, "VariableStorageComponent", {
            _tags="goldblood",
            value_int=1,
        })
    end
    ComponentSetValue2(var, "value_int", count + 1)

    local options = {
        {img = "bleed.png", mat1 = "blood", mat2 = "meat", reward="gold"},
        {img = "drown.png", mat1 = "water", mat2 = "graham_mundane", reward="graham_statium"},
        {img = "puke.png",  mat1 = "vomit", mat2 = "slime", reward="magic_liquid_faster_levitation_and_movement"},
        {img = "trip.png",  mat1 = "fungi", mat2 = "fungi_green", reward="graham_ascendum"},
        {img = "see.png",   mat1 = "blood_worm", mat2 = "magic_liquid_invisibility", reward="magic_gas_midas"},
        {img = "feast.png", mat1 = "graham_meatdone", mat2 = "meat_done", reward="magic_liquid_hp_regeneration"},
    }

    if count == 1 then
        -- init
        local l = EntityGetFirstComponent(me, "LuaComponent")
        if l then EntityRemoveComponent(me, l) end
    else
        -- reward
        EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
        local entity = EntityCreateNew()
        EntitySetTransform(entity, x, y)
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=CellFactory_GetType(options[count - 1].mat1),
            to_material=CellFactory_GetType(options[count - 1].reward),
            radius=30,
            steps_per_frame=4,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=CellFactory_GetType(options[count - 1].mat2),
            to_material=CellFactory_GetType(options[count - 1].reward),
            radius=30,
            steps_per_frame=4,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
    end
    if count > #options then
        EntityKill(me)
        local entity = EntityCreateNew()
        EntitySetTransform(entity, x, y)
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=CellFactory_GetType("templebrick_diamond_static"),
            to_material=CellFactory_GetType("graham_ash"),
            radius=128,
            steps_per_frame=20,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
        EntityAddComponent2(entity, "MagicConvertMaterialComponent", {
            kill_when_finished=true,
            from_material=CellFactory_GetType("templebrick_golden_static"),
            to_material=CellFactory_GetType("graham_ash"),
            radius=128,
            steps_per_frame=20,
            clean_stains=false,
            is_circle=true,
            loop=false,
        })
    else
        local m = EntityGetFirstComponent(me, "MaterialAreaCheckerComponent")
        if m then EntityRemoveComponent(me, m) end
        m = EntityAddComponent2(me, "MaterialAreaCheckerComponent", {
            look_for_failure=false,
            update_every_x_frame=30,
            material=CellFactory_GetType(options[count].mat1),
            material2=CellFactory_GetType(options[count].mat2),
            kill_after_message=false,
        })
        ComponentSetValue2(m, "area_aabb", -5, 0, 5, 2)
        local s = EntityGetFirstComponent(me, "SpriteComponent")
        if s then EntityRemoveComponent(me, s) end
        s = EntityAddComponent2(me, "SpriteComponent", {
            image_file="mods/grahamsperks/files/entities/goldblood/" .. options[count].img,
            offset_x=25,
            offset_y=25,
            z_index=15,
        })
    end
end

local x, y = EntityGetTransform(me)
material_area_checker_success(x, y)