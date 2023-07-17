dofile_once("data/scripts/perks/perk.lua")
dofile_once("data/scripts/lib/utilities.lua")

local x, y = EntityGetTransform( GetUpdatedEntityID() )
local books = EntityGetWithTag( "graham_book" )

local function EntityGetInRadiusWithName(x2, y2, radius, name)
	local list = EntityGetInRadius(x2, y2, radius)
	local new_list = {}
	for i = 1, #list do
		if EntityGetName(list[i]) == name then
			table.insert(new_list, list[i])
		end
	end
	return new_list
end

local eggs = EntityGetInRadiusWithName(x, y, 56, "$graham_lukkiegg")
if ( #eggs > 0) then
	for i,egg_id in ipairs(eggs) do
		local x2, y2 = EntityGetTransform(egg_id)
		if EntityGetRootEntity(egg_id) == egg_id then
			GamePrintImportant( "$log_altar_magic", "" )
			if HasFlagPersistent("graham_progress_lukki") ~= true then
				AddFlagPersistent("graham_progress_lukki")
				GamePrint( "$graham_perk_unlock" )
				GamePrint( "$graham_perk_unlock_lukki" )
				EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x2, y2)
				EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x2, y2)
				dofile_once("data/scripts/perks/perk.lua")
				perk_spawn(x2, y2, "GRAHAM_LUKKI_MOUNT")
				GamePlaySound("data/audio/Desktop/animals.bank", "animals/lukki_eggs/destroy", x2, y2)
			else
				-- if lukki mount is already unlocked, then babies
				SetRandomSeed(GameGetFrameNum(), x2 + y2)
				GamePlaySound("data/audio/Desktop/animals.bank", "animals/lukki_eggs/destroy", x2, y2)
				for p = 1, Random(5, 10) do
					local eid = EntityLoad("data/entities/animals/lukki/lukki_tiny.xml", x2, y2)
					EntityLoadToEntity("mods/grahamsperks/files/entities/charm_light.xml", eid)
					EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x2, y2)
					EntityAddComponent2(eid, "LuaComponent", {
						script_source_file="mods/grahamsperks/files/scripts/tank_teleport.lua"
					})
					local comp = EntityGetFirstComponentIncludingDisabled(eid, "GenomeDataComponent") or 0
					ComponentSetValue2(comp, "herd_id", StringToHerdId("player"))
					comp = EntityGetFirstComponentIncludingDisabled(eid, "AreaDamageComponent") or 0
					ComponentSetValue2(comp, "entities_with_tag", "enemy")
				end
			end
			EntityKill(egg_id)
		end
	end
end

if ( #books > 0 ) then
	local tx = 0
	local ty = 0
	for i,tablet_id in ipairs(books) do
		local in_world = false
		local components = EntityGetComponent( tablet_id, "PhysicsBodyComponent" )
		
		if( components ~= nil ) then
			in_world = true
		end
		
		tx, ty = EntityGetTransform( tablet_id )

		if in_world then
			local distance = math.abs(x - tx) + math.abs(y - ty)
		
			if ( distance < 56 ) then
				if EntityHasTag( tablet_id, "grahamhungry" ) then
					EntityConvertToMaterial( tablet_id, "graham_graymatter_liquid")
					EntityKill( tablet_id )
					if HasFlagPersistent("graham_progress_hunger") then
						EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", tx, ty)
						GamePrintImportant( "$graham_hungered", "$graham_hungered2" )
					else
						local player = EntityGetClosestWithTag(x, y, "player_unit" )
						x, y = EntityGetTransform( player )
		
						GamePrintImportant( "$graham_hungered", "" )
						GamePrint( "$graham_perk_unlock" )
						GamePrint( "$graham_perk_unlock_hunger" )
						AddFlagPersistent("graham_progress_hunger")
						EntityLoad("data/entities/particles/image_emitters/orb_effect.xml", x, y-40)
						EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y-40)
						dofile_once("data/scripts/perks/perk.lua")
						perk_spawn(x, y-40, "GRAHAM_DEATH")
					end
				else
					EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", tx, ty)
					EntityConvertToMaterial( tablet_id, "gold")
					EntityKill( tablet_id )
					GamePrintImportant( "$log_altar_magic", "" )
				end
			end
		end
	end
end

-- efficient(?) code
local function new_chest_rain(type)
	if( GlobalsGetValue("GRAHAM_" .. string.upper(type) .. "_CHEST_RAIN") ~= "1" ) then
		local chests = EntityGetInRadiusWithName(x, y, 56, "$graham_chest_" .. type)
		for i = 1, #chests do
			GamePrintImportant( "$log_altar_magic", "" )
			local cx, cy = EntityGetTransform(chests[i])
			EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", cx, cy)

			local player = EntityGetClosestWithTag(x, y, "player_unit")
			EntityKill(chests[i])

			local eid = EntityLoad("mods/grahamsperks/files/entities/custom_chest_rain.xml", cx, cy)
			EntityAddChild( player, eid )
			local comp = get_variable_storage_component(eid, "graham_chest_type")
			ComponentSetValue2(comp, "value_string", "mods/grahamsperks/files/pickups/chest_" .. type .. ".xml")
			GlobalsSetValue("GRAHAM_" .. string.upper(type) .. "_CHEST_RAIN", "1" )
			AddFlagPersistent("graham_progress_" .. type .. "_chest_rain")
			break
		end
	end
end

new_chest_rain("bloody")
new_chest_rain("mini")
new_chest_rain("lost")
new_chest_rain("tech")
new_chest_rain("immunity") -- in case you just need a lot of flummoxium, for some reason

local burgers = EntityGetInRadiusWithName(x, y, 56, "$item_burger")
for i = 1, #burgers do
	if EntityGetRootEntity(burgers[i]) == burgers[i] then
		GamePrintImportant( "$log_altar_magic", "" )
		local cx, cy = EntityGetTransform(burgers[i])
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", cx, cy)

		local player = EntityGetClosestWithTag(x, y, "player_unit")
		EntityKill(burgers[i])

		local eid = EntityLoad("mods/grahamsperks/files/entities/custom_chest_rain.xml", cx, cy)
		EntityAddChild( player, eid )
		local comp = get_variable_storage_component(eid, "graham_chest_type")
		ComponentSetValue2(comp, "value_string", "mods/grahamsperks/files/pickups/heart_healthy.xml")
	end
end

local function bump_spell(entity, x2, y2)
	SetRandomSeed(x2 + y2, entity + GameGetFrameNum())
	EntitySetComponentsWithTagEnabled(entity, "enabled_in_world", true)
	EntitySetComponentsWithTagEnabled(entity, "enabled_in_hand", false)
	EntitySetComponentsWithTagEnabled(entity, "enabled_in_inventory", false)
	EntityRemoveFromParent(entity)
	EntityApplyTransform(entity, x2, y2, 0)
	local velcomp = EntityGetFirstComponentIncludingDisabled(entity, "VelocityComponent") or 0
	ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
end

local function spell_is_unlocked(id)
	dofile_once("data/scripts/gun/gun_actions.lua")
	for i = 1, #actions do
		if actions[i].id == id then
			if (((actions[i].spawn_requires_flag ~= nil ) and HasFlagPersistent( actions[i].spawn_requires_flag )) or (actions[i].spawn_requires_flag == nil )) then
				return true
			end
			print(id .. " is not unlocked!")
			return false
		end
	end
end

local function custom_wand_spells(entity, filepath, spells, flag)
	local name = EntityGetFilename(entity)
	name = string.gsub(name, "\\", "/")
	name = string.match(name, "(mods/.*)")

	if name == filepath and EntityGetRootEntity(entity) == entity then
		local cx, cy = EntityGetTransform(entity)
		local children = EntityGetAllChildren(entity) or {}
		for i = 1, #children do
			if EntityHasTag(children[i], "card_action") then
				bump_spell(children[i], cx, cy)
				local comp = EntityGetComponentIncludingDisabled(children[i], "ItemComponent") or {}
				for j = 1, #comp do
					ComponentSetValue2(comp[j], "permanently_attached", false)
				end
			end
		end
		EntityKill(entity)

		for i=1,4 do
			local rnd = Random( 1, #spells )
			if spell_is_unlocked(spells[rnd]) then
				local eid = CreateItemActionEntity( spells[rnd], cx - 8 * 4 + (i-1) * 16, cy )
				bump_spell(eid, cx, cy)
			end
			table.remove( spells, rnd )
		end

		GamePrintImportant( "$log_altar_magic", "" )
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", cx, cy)
		AddFlagPersistent("graham_progress_" .. flag .. "_exchange")
	end
end

local wands = EntityGetInRadiusWithTag(x, y, 56, "wand")
for i = 1, #wands do
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/candyheart.xml", {"ZERO_DAMAGE", "PROJECTILE_TRANSMUTATION_FIELD", "LIGHT_SHOT", "HITFX_TOXIC_CHARM", "GRAHAM_GUARDIAN_SHOT", "RAINBOW_TRAIL", "GRAHAM_GOLDEN", "GRAHAM_MATERIAL_RADIOACTIVE"}, "candyheart")
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/coffee.xml", {"SPEED", "CHAOTIC_ARC", "ACCELERATING_SHOT", "DAMAGE", "GRAHAM_CIRCLE_ANGY", "GRAHAM_FOAMARMOR", "GRAHAM_SNUB", "GRAHAM_STASIS"}, "coffee")
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/experimental.xml", {"GRAHAM_TOGGLER_ALT", "GRAHAM_TOGGLER2_ALT", "GRAHAM_TOGGLER3_ALT", "LIGHT", "SPELLS_TO_POWER", "CHAINSAW", "TRANSMUTATION", "CHAIN_SHOT"}, "experimental")
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/gluestick.xml", {"BOUNCE", "BOUNCE_HOLE", "BOUNCE_LARPA", "BOUNCE_PLASMA", "REMOVE_BOUNCE", "BOUNCE_SMALL_EXPLOSION", "BOUNCE_EXPLOSION", "BOUNCE_LIGHTNING"}, "gluestick")
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/petworm.xml", {"WORM_SHOT", "GRAHAM_MINI_DISSOLVEPOWDERS", "DIGGER", "SLOW_BULLET", "METEOR", "SWARM_WASP", "VACUUM_POWDER", "ORBIT_LARPA"}, "petworm")
	custom_wand_spells(wands[i], "mods/grahamsperks/files/wands/rotting.xml", {"GRAHAM_MINI_MIDASMEAT", "DISC_BULLET_BIGGER", "PIPE_BOMB_DETONATION", "BLOOD_MAGIC", "MATERIAL_BLOOD", "BLOODLUST", "HITFX_PETRIFY", "ESSENCE_TO_POWER"}, "rotting")
end