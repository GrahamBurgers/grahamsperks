dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed(pos_x, GameGetFrameNum() + pos_y)

-- convert items
local converted = false
local death = false

for _, id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "grahams_things")) do
    -- make sure item is not carried in inventory or wand
    if EntityGetRootEntity(id) == id then
		local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
		local picked = false
		if comp ~= nil then
			picked = ComponentGetValue2(comp, "has_been_picked_by_player")
		end
		if picked then
			local x,y = EntityGetTransform(id)
			
			-- thank you very very much to Copi and Conga (and Pyry!) for helping me debug
			local base_options = {
			"bloodmoon.xml",
			"cybereye.xml",
			"safe.xml",
			"magmastone.xml",
			"soapstone.xml",
			"lovely_die.xml",
			}

			local name = EntityGetFilename(id):match("%w*.%w*$")
			local filtered_options = {}
			for _, option in ipairs(base_options) do
				if option ~= name then
					table.insert(filtered_options, option)
				end
			end

			EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
			EntityLoad("mods/grahamsperks/files/pickups/" .. filtered_options[Random(1, #filtered_options)], x, y)
			EntityKill(id)
			converted = true
		end
    end
end
for _, id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "graham_runestone")) do
	local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
	local picked = false
	if comp ~= nil then
		picked = ComponentGetValue2(comp, "has_been_picked_by_player")
	end
	if picked and EntityGetRootEntity(id) == id then
		local x, y, rot = EntityGetTransform(id)
		local opts = { "runestone_laser.xml", "runestone_fireball.xml", "runestone_lava.xml", "runestone_slow.xml", "runestone_null.xml", "runestone_disc.xml", "runestone_metal.xml", "runestone_graham_phase.xml", }
		local name = EntityGetFilename(1581):match(".*/(.*)")
		local filtered_options = {}
		for _, option in ipairs(opts) do
			if option ~= name then
				table.insert(filtered_options, option)
			end
		end
		local eid = EntityLoad( "data/entities/items/pickup/runestones/" .. opts[Random(1, #opts)], x, y )
		-- seamless!
		EntitySetTransform(eid, x, y, rot)
		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(id)
		converted = true
	end
end
for _, id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "wand")) do
	local comp = EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
	local picked = false
	if comp ~= nil then
		picked = ComponentGetValue2(comp, "has_been_picked_by_player")
	end
	if picked and EntityGetRootEntity(id) == id then
		local x, y = EntityGetTransform(id)
		local filepath = EntityGetFilename(id)
		if filepath ~= nil and filepath ~= "" then
			EntityLoad( filepath, x, y )
			EntityLoad("data/entities/projectiles/explosion.xml", x, y)
			EntityKill(id)
			converted = true
			death = true
		end
	end
end

if converted then
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_01", true, pos_x, pos_y )
	if Random(1, 3 + ((GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") and 2) or 0)) == 1 or death then
		EntityKill(EntityGetInRadiusWithTag(pos_x, pos_y, 10, "graham_converter")[1])
		EntityLoad("mods/grahamsperks/files/entities/wood_convert.xml", pos_x, pos_y)
	end
end