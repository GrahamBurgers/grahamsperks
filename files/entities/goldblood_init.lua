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
	material=Get_type_or_panic(Options[count].mat1),
	material2=Get_type_or_panic(Options[count].mat2),
	kill_after_message=false,
})
ComponentSetValue2(m, "area_aabb", -5, 0, 5, 2)

m = EntityAddComponent2(me, "MaterialAreaCheckerComponent", {
	_tags="removable_thing",
	look_for_failure=false,
	update_every_x_frame=15,
	material=Get_type_or_panic(Options[count].mat3),
	material2=Get_type_or_panic(Options[count].mat4),
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