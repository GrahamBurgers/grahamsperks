dofile_once("data/scripts/lib/utilities.lua")

local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(GetUpdatedEntityID())
local radius = 18
local entities = EntityGetInRadiusWithTag(x, y, radius, "hittable")
local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent")
-- awful code but it actually works
local shooter, bx, by, ex, ey
if not comp then return end
shooter = ComponentGetValue2(comp, "mWhoShot")

for i = 1, #entities do
	if (shooter and shooter ~= 0) and (shooter ~= entities[i] and EntityGetHerdRelation( shooter, entities[i]) <= 60) then
		ex, ey = EntityGetTransform(entities[i])
		bx, by = EntityGetTransform(me)

		if EntityGetComponent(entities[i], "PhysicsBodyComponent") == nil and EntityGetComponent(entities[i], "PhysicsBody2Component") == nil and not EntityHasTag(entities[i], "glue_NOT") then
			if math.sqrt((bx - x)^2 + (by - y)^2) < radius then
				EntityApplyTransform(entities[i], ex + (bx - ex) / 4, ey + (by - ey) / 3)
				local velocity = EntityGetFirstComponentIncludingDisabled(entities[i], "CharacterDataComponent") or 0
				if velocity ~= 0 then
					ComponentSetValue2(velocity, "mVelocity", 0, 0)
				end
			end
		end
	end
end