local me = GetUpdatedEntityID()
dofile_once("mods/grahamsperks/files/entities/goldblood.lua")

local reset = EntityGetAllComponents(me)
for i = 1, #reset do
	if ComponentHasTag(reset[i], "removable_thing") then
		EntityRemoveComponent(me, reset[i])
	end
end

local var = EntityGetFirstComponent(me, "VariableStorageComponent", "goldblood")
local count = var and ComponentGetValue2(var, "value_int") or 1

local m = EntityAddComponent2(me, "MaterialAreaCheckerComponent", {
	_tags="removable_thing",
	look_for_failure=false,
	update_every_x_frame=15,
	material=CellFactory_GetType(Options[count].mat1 or "just_death"),
	material2=CellFactory_GetType(Options[count].mat2 or "just_death"),
	kill_after_message=false,
})
ComponentSetValue2(m, "area_aabb", -5, 0, 5, 2)

m = EntityAddComponent2(me, "MaterialAreaCheckerComponent", {
	_tags="removable_thing",
	look_for_failure=false,
	update_every_x_frame=15,
	material=CellFactory_GetType(Options[count].mat3 or "just_death"),
	material2=CellFactory_GetType(Options[count].mat4 or "just_death"),
	kill_after_message=false,
})
ComponentSetValue2(m, "area_aabb", -5, 0, 5, 2)

EntityAddComponent2(me, "SpriteComponent", {
	_tags="removable_thing",
	image_file="mods/grahamsperks/files/entities/goldblood/" .. Options[count].img,
	offset_x=25,
	offset_y=25,
	z_index=15,
})