dofile_once( "data/scripts/lib/utilities.lua" )

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id  = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	if( damage < 0 ) then return end
	local dmg = EntityGetFirstComponent(entity_id, "DamageModelComponent")
	local health = 0
	local max_health = 0
	if dmg then
		health = ComponentGetValue2(dmg, "hp")
		max_health = ComponentGetValue2(dmg, "max_hp")
		if health - damage < max_health / 10 and health - damage > 0 then
			EntityInflictDamage(entity_id, max_health * 100, "DAMAGE_OVEREATING", "$perkname_graham_death", "BLOOD_EXPLOSION", 0, 0)
			EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y)
			ComponentSetValue2(dmg, "hp", 0)
			EntityLoad("mods/grahamsperks/files/entities/hunger_circle.xml", x, y)
			GamePrintImportant( "$graham_hungered3", "$graham_hungered4" )
			EntityAddComponent2(entity_id, "LuaComponent", {
				script_source_file="mods/grahamsperks/files/scripts/kill.lua",
			})
		end
	end
end