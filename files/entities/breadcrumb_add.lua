local me = GetUpdatedEntityID()

EntityAddComponent2(me, "LuaComponent", {
	script_source_file = "mods/grahamsperks/files/entities/breadcrumb.lua",
	remove_after_executed = false,
	execute_every_n_frame = 1,
})