function on_open( entity_item )

    dofile_once("data/scripts/perks/perk.lua")
    local x, y = EntityGetTransform( GetUpdatedEntityID() )

    EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)

    if HasFlagPersistent("graham_progress_immunity") == false then
        AddFlagPersistent("graham_progress_immunity")
        perk_spawn(x, y, "GRAHAM_IMMUNITY_AURA", true)
        GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
        GameTriggerMusicEvent( "music/oneshot/dark_03", true, x, y )

		GamePrint( "$graham_perk_unlock" )
		GamePrint( "$graham_perk_unlock_immunity" )

		EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y)
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y)
    else
        EntityLoad("mods/grahamsperks/files/entities/immunityaura/potion_flum.xml", x, y)
    end

end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
	
	on_open( entity_item )

	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "$log_chest", "" )
	-- GameTriggerMusicCue( "item" )

	--if (remove_entity == false) then
	--	EntityLoad( "data/entities/misc/chest_random_dummy.xml", x, y )
	--end

	on_open( entity_item )
	
	EntityKill( entity_item )
end