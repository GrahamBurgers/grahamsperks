dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity( entity_id )
local x,y = EntityGetTransform( player_id )
local distance = 22.5

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "wizard_orb_id" )
if ( comp ~= nil ) then
	local id = ComponentGetValue2( comp, "value_int" )
	
	local varsto = EntityGetFirstComponentIncludingDisabled(player_id, "VariableStorageComponent", "graham_blood_orbs")
	local count = 1
	if varsto ~= nil then
		count = ComponentGetValue2(varsto, "value_int")
	end

	local circle = math.pi * 2
	local inc = circle / count
	
	local dir = inc * id + GameGetFrameNum() * 0.01
	
	local nx = x + math.cos( dir ) * distance
	local ny = y - math.sin( dir ) * distance
	
	EntitySetTransform( entity_id, nx, ny )
	EntityApplyTransform( entity_id, nx, ny )
end

local particle = EntityGetFirstComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")
local dmg = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
if dmg and particle then
	local amount = ComponentGetValue2(dmg, "hp") / ComponentGetValue2(dmg, "max_hp")
	ComponentSetValue2(particle, "count_min", amount * 2)
	ComponentSetValue2(particle, "count_min", amount * 4)
	ComponentSetValue2(particle, "lifetime_min", math.max(0.25, amount * 2))
	ComponentSetValue2(particle, "lifetime_max", math.max(0.25, amount * 3))
end

-- inherit some immunities
local immunities = {"PROTECTION_FIRE", "PROTECTION_RADIOACTIVITY", "PROTECTION_EXPLOSION", "PROTECTION_MELEE", "PROTECTION_ELECTRICITY", "PROTECTION_FREEZE", "PROTECTION_ALL"}
for i = 1, #immunities do
	if GameGetGameEffectCount(EntityGetRootEntity(entity_id), immunities[i]) > 0 then
		local entity = EntityCreateNew()
		EntityAddComponent2(entity, "GameEffectComponent", {
			frames=5,
			effect=immunities[i],
		})
		EntityAddChild(entity_id, entity)
	end
end