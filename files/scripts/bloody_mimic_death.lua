function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	dofile_once("data/scripts/lib/utilities.lua")
	dofile_once("data/scripts/perks/perk.lua")

	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)

	-- unlock blood carving and magic skin
	if HasFlagPersistent("graham_bloodymimic_killed") == false then
		AddFlagPersistent("graham_bloodymimic_killed")
		local pid = perk_spawn(x, y, "GRAHAM_MAGIC_SKIN")
		EntityRemoveTag(pid, "perk")

		EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y)
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y)
		GamePrint( "$graham_perk_unlock" )
		GamePrint( "$graham_perk_unlock_blood" )
	else
		dofile_once( "data/scripts/perks/perk.lua" )
		local pid = perk_spawn_random( x, y - 2, true )
		EntityRemoveTag(pid, "perk")
	end
end