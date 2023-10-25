dofile_once("data/scripts/lib/utilities.lua")

-- I'm sure this works just fine

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") or {}

if projcomp ~= nil then
	local shooter = ComponentGetValue2(projcomp, "mWhoShot")
	if EntityGetIsAlive(shooter) then

	  local varcomp = EntityGetFirstComponentIncludingDisabled(shooter, "VariableStorageComponent") or {}

	  local enemy = ComponentGetValue2(varcomp, "value_int")

	  -- stop attack prematurely if player is targetted so they don't get projectiles spawned ontop of them
	  if EntityHasTag(enemy,"player_unit") == true then
	      EntityKill(entity_id)
	  end

	  local enemy_x, enemy_y = EntityGetTransform(enemy)
	  
	  if(x > enemy_x + 1) then     
	      x = enemy_x + 1
	  end
	  if(x < enemy_x - 1) then
	      x = enemy_x - 1
	  end
	  if(y > enemy_y - 1) then
	      y = enemy_y - 1
	  end
	  if(y < enemy_y - 1) then
	      y = enemy_y - 1
	  end
	  EntitySetTransform(entity_id, x, y)
	else
	  EntityKill(entity_id)
	end
end