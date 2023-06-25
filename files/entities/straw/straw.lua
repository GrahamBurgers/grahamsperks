local DISTANCE = 16
local player = GetUpdatedEntityID()
local inv2comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
local activeitem = 0
if inv2comp then
	activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
end

local straw = EntityGetWithTag("graham_sillystraw")
local children = {}
for i = 1, #straw do
	if EntityGetRootEntity(straw[i]) == player then
		table.insert(children, straw[i])
	end
end

if activeitem ~= 0 and EntityGetComponent(activeitem, "MaterialInventoryComponent") then
	local px, py, dir = EntityGetTransform(activeitem)
	local nx = px + (math.cos(dir)) * DISTANCE
	local ny = py + (math.sin(dir)) * DISTANCE
	if #children == 0 then
		local new = EntityLoad("mods/grahamsperks/files/entities/straw/straw.xml", nx, ny)
		EntitySetTransform(new, nx, ny, dir)
		EntityAddChild(player, new)
	else
		for k, child in ipairs(children) do
			EntitySetTransform(child, nx, ny, dir)
			local comp = EntityGetFirstComponentIncludingDisabled(child, "SpriteComponent") or 0
			if math.abs(dir) < math.pi / 2 then
				ComponentSetValue2(comp, "special_scale_y", -1)
			else
				ComponentSetValue2(comp, "special_scale_y", 1)
			end

			local mat_inv = EntityGetFirstComponent(child, "MaterialInventoryComponent") or 0
			local mats_list = ComponentGetValue2(mat_inv, "count_per_material_type")
			local suck = EntityGetComponent(activeitem,"MaterialSuckerComponent")[1]
			local size = ComponentGetValue2(suck,"barrel_size")
			for k, material_count in ipairs(mats_list) do
				local index = k - 1
				if material_count > 0 then
					local mat_inv2 = EntityGetFirstComponent(activeitem, "MaterialInventoryComponent") or 0
					local mats_list2 = ComponentGetValue2(mat_inv2, "count_per_material_type")
					local c = 0
					local sigma = 0
					for k, material_count2 in ipairs(mats_list2) do
						local index2 = k - 1
						sigma = sigma + material_count2
						if index2 == index then
							c = material_count2
						end
					end
					local mat_id = CellFactory_GetName(index)
					if sigma >= size then
						return
					end
					if c + sigma > size then
						AddMaterialInventoryMaterial(activeitem, mat_id, size - sigma)
						AddMaterialInventoryMaterial(child, mat_id, c - size + sigma)
					end
					AddMaterialInventoryMaterial(activeitem, mat_id, c + material_count)
					AddMaterialInventoryMaterial(child, mat_id, 0)
				end
			end
		end
	end
else
	for k,v in ipairs(children) do
		EntityKill(v)
	end
end