dofile_once("data/scripts/lib/utilities.lua")

local polytools = dofile_once( "mods/grahamsperks/lib/polytools.lua" )
local effect_id = GetUpdatedEntityID()
local root_entity = EntityGetRootEntity( effect_id )
polytools.polymorph(root_entity, "data/entities/animals/longleg.xml", 360, true, nil, true)
local x, y = EntityGetTransform(ham)
local poof = EntityLoad( "data/entities/particles/polymorph_explosion.xml", x, y )
EntityAddComponent2(poof, "AudioComponent", {
	file="data/audio/Desktop/misc.bank",
	event_root="game_effect/polymorph" 
})
EntityKill( effect_id )