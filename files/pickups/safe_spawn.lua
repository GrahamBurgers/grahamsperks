dofile_once("data/scripts/lib/utilities.lua")

local time_buildup_start = 120
local time_spawn = time_buildup_start + 80

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local t = GameGetFrameNum()
local comp = get_variable_storage_component(entity_id, "throw_time")
local throw_time = ComponentGetValue2(comp, "value_int")

if throw_time < 0 then return end -- not thrown yet

if t == throw_time + time_buildup_start then
	-- buildup
	local e = EntityLoad("mods/grahamsperks/files/pickups/safe_emitter.xml", pos_x, pos_y)
	EntityAddChild(entity_id, e)
	EntitySetComponentsWithTagEnabled(entity_id, "enabled_before_spawn", true)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y )
elseif t == throw_time + time_spawn then
	-- spawn safe haven
	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/heart_fullhp/create", pos_x, pos_y )
	EntityLoad("mods/grahamsperks/files/pixelscenes/safe.xml", pos_x, pos_y)
	
	-- spawn healing projectiles
	SetRandomSeed(t, t)
	local projectile_count = Random(5, 40)
	for i=1,projectile_count do
		local x = pos_x + ProceduralRandom(pos_x, pos_y - i, -30, 30)
		local y = pos_y + ProceduralRandom(pos_x + i, pos_y * 0.63, -18, 18) - 20
		if Random(1, 6) == 1 then 
			local e = EntityLoad("data/entities/items/pickup/bloodmoney_50.xml", x, y)
		else
			local e = EntityLoad("data/entities/items/pickup/bloodmoney_10.xml", x, y)
		end
	end

	-- props
	EntityLoad("mods/grahamsperks/files/entities/mana.xml", pos_x, pos_y)
	EntityLoad("data/entities/props/physics_tubelamp.xml", pos_x + 14, pos_y - 37)
	EntityLoad("data/entities/buildings/biome_modifiers/drain_pipe.xml", pos_x - 10, pos_y - 44)
	EntityLoad("data/entities/projectiles/deck/regeneration_aura.xml", pos_x, pos_y - 22)
	
	-- cleanup
	EntityKill(entity_id)
end

