local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)

if #EntityGetInRadiusWithTag(x, y, 50, "graham_spell_circle") > 0 then return end

function make_random_card( x2, y2)
	SetRandomSeed( x2 + GameGetFrameNum(), y2 + 1234)
	local item = ""
	local valid = false
	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		if ( thisitem.spawn_probability ~= "0" ) and (((thisitem.spawn_requires_flag ~= nil ) and HasFlagPersistent( thisitem.spawn_requires_flag )) or (thisitem.spawn_requires_flag == nil )) then
			valid = true
		end
	end
	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x2, y2 )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
local storage = ComponentGetValue2(get_variable_storage_component(me, "graham_spellcircle_amount") or 0, "value_int") or 0
local count = 4 -- + storage
local spawn_x = 30
local spawn_y = 0
local rot_inc = math.pi * 2 / count
for j=1, count do
    local eid = make_random_card( x + spawn_x, y + spawn_y)
    EntityRemoveComponent(eid, EntityGetFirstComponent(eid, "SimplePhysicsComponent") or 0)
    EntityAddTag(eid, "graham_statue_ineligible")
    EntityAddTag(eid, "graham_spell_circle")
    EntityAddComponent(eid, "LuaComponent", {
        execute_every_n_frame="-1",
        script_item_picked_up="mods/grahamsperks/files/scripts/statue_spell.lua",
        remove_after_executed="1"
    })

    spawn_x, spawn_y = vec_rotate(spawn_x, spawn_y, rot_inc)
end

if storage > 1 then
    -- recurse
    local eid = EntityLoad("mods/grahamsperks/files/entities/spell_circle.xml", x, y)
    EntityAddComponent2(eid, "VariableStorageComponent", {
        name="graham_spellcircle_amount",
        value_int=storage - 1
    })
end
EntityKill(me)