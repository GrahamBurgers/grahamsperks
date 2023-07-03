local player = EntityGetWithTag("player_unit")[1]
local x, y = EntityGetTransform(player)
local midas_id = EntityLoad( "data/entities/animals/boss_centipede/ending/midas_radioactive.xml", x, y )
local comp_damagemodel = EntityGetFirstComponent( player, "DamageModelComponent" )
if( comp_damagemodel ~= nil ) then
    ComponentSetValue( comp_damagemodel, "materials_damage_proportional_to_maxhp", "1" )
end

EntityAddChild( player, midas_id )

EntityLoad( "data/entities/animals/boss_centipede/ending/midas_sand.xml", x, y )
EntityLoad( "data/entities/animals/boss_centipede/ending/midas_chunks.xml", x, y )
GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/midas_above/create", x, y )

local comp = EntityGetComponentIncludingDisabled(player, "DamageModelComponent") or {}
for i = 1, #comp do
	EntitySetComponentIsEnabled(player, comp[i], true)
end

comp = EntityGetComponent(player, "CharacterDataComponent") or {}
for i = 1, #comp do
    ComponentSetValue2(comp[i], "flying_needs_recharge", true)
    ComponentSetValue2(comp[i], "fly_time_max", 0)
end