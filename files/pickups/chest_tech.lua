dofile_once("data/scripts/lib/utilities.lua")
function on_open( entity_item )
    local x, y = EntityGetTransform(entity_item)
    EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
	local rand_x = x
	local rand_y = y

	-- PositionSeedComponent
	local position_comp = EntityGetFirstComponent( entity_item, "PositionSeedComponent" )
	if position_comp then
		rand_x = tonumber(ComponentGetValue( position_comp, "pos_x") ) or x
		rand_y = tonumber(ComponentGetValue( position_comp, "pos_y") ) or y
	end

    SetRandomSeed( rand_x, rand_y )

    local to_be_spawned = {}
    local spells_random = {
    "GRAHAM_TOGGLER", "GRAHAM_TOGGLE_RED", "GRAHAM_TOGGLE_BLUE",
    "GRAHAM_TOGGLER2", "GRAHAM_TOGGLE_GREEN", "GRAHAM_TOGGLE_YELLOW",
    "GRAHAM_TOGGLEROFF", "GRAHAM_PASSIVES", "GRAHAM_MIXUP",
    "NOLLA", "LIFETIME", "LIFETIME_DOWN",
    "SWAPPER_PROJECTILE", "TEMPORARY_PLATFORM", "TRANSMUTATION",
    "MATERIAL_BLOOD", "ALCOHOL_BLAST", "HITFX_CRITICAL_BLOOD"}

        dofile_once( "data/scripts/perks/perk.lua" )
        local pid = perk_spawn_random( x, y - 20, true )
        EntityAddComponent(pid, "LuaComponent", {
            script_item_picked_up="mods/grahamsperks/files/scripts/magic_skin_curse.lua"
        })
        EntityAddComponent(pid, "SpriteComponent", {
            image_file="mods/grahamsperks/files/entities/skin_perk.png",
            offset_x = "8",
            offset_y = "8",
            update_transform = "1" ,
            update_transform_rotation = "0",
            z_index="0.8",
        })

    if Random(1, 10) == 1 then table.insert(spells_random, "SUMMON_WANDGHOST") end

    local length = #spells_random
    for i = 1, #spells_random do
        if Random(1, i) == 1 then
            table.insert(to_be_spawned, spells_random[Random(1, #spells_random)])
        end
    end

    local x2 = x - ((#to_be_spawned - 1) * 7.5)
    for i = 1, #to_be_spawned do
        CreateItemActionEntity(to_be_spawned[i], x2, y)
        x2 = x2 + 15
    end
end

function physics_body_modified( is_destroyed )
	local entity_item = GetUpdatedEntityID()
	on_open( entity_item )
	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "$log_chest", "" )
	on_open( entity_item )
	
	EntityKill( entity_item )
end