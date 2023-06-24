dofile_once("data/scripts/lib/utilities.lua")

local x, y = EntityGetTransform(GetUpdatedEntityID())
local entities = EntityGetInRadiusWithTag(x, y, 18, "hittable")
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent")
-- awful code but it actually works
local shooter, bx, by, ex, ey, cx, cy
if comp ~= nil then
	shooter = ComponentGetValue2(comp, "mWhoShot") or 0
end

for i = 1, #entities do
	if shooter ~= entities[i] and not EntityHasTag(entities[i], "glue_NOT") and EntityGetComponent(entities[i], "PhysicsBody2Component") == nil then
		ex, ey = EntityGetTransform(entities[i])
		cx = get_variable_storage_component( entities[i], "graham_brambles_x" )
		cy = get_variable_storage_component( entities[i], "graham_brambles_y" )
		if cx ~= nil and cy ~= nil then
			bx = ComponentGetValue2(cx, "value_int")
			by = ComponentGetValue2(cy, "value_int")

			if (math.abs( x - bx ) + math.abs( y - by)) > 18 then
				ComponentSetValue2(cx, "value_int", x)
				ComponentSetValue2(cy, "value_int", y)
			else
				EntityApplyTransform(entities[i], ex + (bx - ex) / 6, ey + (by - ey) / 4)
				local velocity = EntityGetFirstComponentIncludingDisabled(entities[i], "CharacterDataComponent") or 0
				if velocity ~= 0 then
					ComponentSetValue2(velocity, "mVelocity", 0, 0)
				end
			end
			
			if GameGetFrameNum() % 12 == 0 then
				EntityInflictDamage(entities[i], 0.024, "DAMAGE_SLICE", "$graham_name_bramball", "NONE", 0, 0, shooter)
			end
		else
			EntityAddComponent2(entities[i], "VariableStorageComponent", {
				name="graham_brambles_x",
				value_int=ex,
			})
			EntityAddComponent2(entities[i], "VariableStorageComponent", {
				name="graham_brambles_y",
				value_int=ey,
			})
		end
	else
		if GameGetFrameNum() % 12 == 0 and shooter ~= entities[i] then
			EntityInflictDamage(entities[i], 0.024, "DAMAGE_SLICE", "$graham_name_bramball", "NONE", 0, 0, shooter)
		end
	end
end