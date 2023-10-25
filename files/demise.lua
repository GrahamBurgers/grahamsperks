dofile_once( "data/scripts/lib/utilities.lua" )

function damage_received( damage, desc, entity_who_caused, is_fatal )

local entity_id    = GetUpdatedEntityID()
local x, y, angle = EntityGetTransform( entity_id )

if( damage < 0 ) then return end

local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
local health = 0

if( damagemodels ~= nil ) then
	for i,v in ipairs(damagemodels) do
	
		health = tonumber( ComponentGetValue( v, "hp" ) )
		maxHealth = tonumber( ComponentGetValue( v, "max_hp" ) )
		break
	end

	if health - damage < maxHealth / 5 then
		EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y)
		ComponentSetValue2(damagemodels[1], "hp", 0)
		EntityLoad("mods/grahamsperks/files/entities/hunger_circle.xml", x, y)
		GamePrintImportant( "$graham_hungered3", "$graham_hungered4" )
		EntityAddComponent2(entity_id, "LuaComponent", {
			script_source_file="mods/grahamsperks/files/scripts/kill.lua"
		})
	end
end

end