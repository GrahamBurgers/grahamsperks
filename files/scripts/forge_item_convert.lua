dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/gun/gun_actions.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- convert items
local converted = false

for _, id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "grahams_things")) do
    -- make sure item is not carried in inventory or wand
    if EntityGetRootEntity(id) == id then
        SetRandomSeed(pos_x, GameGetFrameNum())
        local x,y = EntityGetTransform(id)
		
		-- thank you very very much to Copi and Conga (and Pyry!) for helping me debug
		local base_options = {
		  "bloodmoon.xml",
		  "burg.xml",
		  "cybereye.xml",
		  "safe.xml",
		  "magmastone.xml",
		  "soapstone.xml"
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
		EntityLoad("mods/grahamsperks/files/entities/wood_convert.xml", x, y)

        EntityKill(id)
        EntityKill(EntityGetInRadiusWithTag(pos_x, pos_y, 10, "graham_converter")[1])
    end
end

if converted then
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_01", true, pos_x, pos_y )
end