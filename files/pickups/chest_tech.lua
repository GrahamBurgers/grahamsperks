dofile_once("data/scripts/lib/utilities.lua")
local function make_random_card(x, y)
    dofile_once( "data/scripts/gun/gun_actions.lua" )
	SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end


	if ( string.len(item) > 0 ) then
        print("random: " .. item)
		return item
	else
		print( "No valid action entity found!" )
	end
end

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

    local count = tonumber(GlobalsGetValue( "GRAHAM_TECH_CHEST_COUNT_OPENED", "0" ))
    GlobalsSetValue( "GRAHAM_TECH_CHEST_COUNT_OPENED", tostring(count + 1) )

    SetRandomSeed( rand_x + 18349, rand_y + 456828)

    local to_be_spawned = {}
    local length = math.min(2 + count, 8)
    local spells_random = {
    "GRAHAM_FOAMARMOR", "GRAHAM_INTENSIFY", "GRAHAM_STASIS",
    "TRUE_ORBIT", "ZERO_DAMAGE", "HOOK",
    "CASTER_CAST", "GRAHAM_PASSIVES", "GRAHAM_MIXUP",
    "NOLLA", "LIFETIME", "LIFETIME_DOWN",
    "SWAPPER_PROJECTILE", "TEMPORARY_PLATFORM", "TRANSMUTATION",
    "MATERIAL_BLOOD", "ALCOHOL_BLAST", "HITFX_CRITICAL_BLOOD"}
    if HasFlagPersistent("card_unlocked_maths") then
        local toggles = {
            {"GRAHAM_TOGGLER", "GRAHAM_TOGGLE_RED"},
            {"GRAHAM_TOGGLER", "GRAHAM_TOGGLE_BLUE"},
            {"GRAHAM_TOGGLER2", "GRAHAM_TOGGLE_GREEN"},
            {"GRAHAM_TOGGLER2", "GRAHAM_TOGGLE_YELLOW"},
            {"GRAHAM_TOGGLER_ALT", "GRAHAM_TOGGLE_RED"},
            {"GRAHAM_TOGGLER_ALT", "GRAHAM_TOGGLE_BLUE"},
            {"GRAHAM_TOGGLER2_ALT", "GRAHAM_TOGGLE_GREEN"},
            {"GRAHAM_TOGGLER2_ALT", "GRAHAM_TOGGLE_YELLOW"},
        }
        SetRandomSeed( rand_x + 18349, rand_y + 9568299)
        local num = Random(1, #toggles)
        to_be_spawned[#to_be_spawned+1] = toggles[num][1]
        to_be_spawned[#to_be_spawned+1] = toggles[num][2]
        local requirements = {
            "IF_PROJECTILE", "IF_HP", "IF_ENEMY", "IF_HALF", "IF_ELSE", "IF_END", "GRAHAM_TOGGLEROFF"
        }
        SetRandomSeed( rand_x + 1835449, rand_y + 156828799)
        to_be_spawned[#to_be_spawned+1] = requirements[Random(1, #requirements)]
    else
        length = math.ceil(length / 2)
    end

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
    EntityRemoveTag(pid, "perk")

    for i = 1, length do
        SetRandomSeed( rand_x + 18349, rand_y + 456828 + i)
        to_be_spawned[#to_be_spawned+1] = spells_random[Random(1, #spells_random)]
    end

    if count == 14 then table.insert(to_be_spawned, "SUMMON_WANDGHOST") end
    if count == 24 then table.insert(to_be_spawned, "REGENERATION_FIELD") end
    to_be_spawned[#to_be_spawned+1] = make_random_card(x, y)

    local x2 = x - ((#to_be_spawned - 1) * 7)
    for i = 1, #to_be_spawned do
        CreateItemActionEntity(to_be_spawned[i], x2, y)
        x2 = x2 + 14
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