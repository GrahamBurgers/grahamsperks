local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)

EntityAddComponent2(me, "LuaComponent", {
	script_source_file = "mods/grahamsperks/files/entities/breadcrumb.lua",
	remove_after_executed = true,
	execute_every_n_frame = 1,
})