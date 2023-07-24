local material = CellFactory_GetName(GetMaterialInventoryMainMaterial(GetUpdatedEntityID()))
if material == "graham_graymatter_liquid" then
    EntityKill(GetUpdatedEntityID())
    local x, y = EntityGetTransform(GetUpdatedEntityID())
    EntityLoad("data/entities/items/pickup/potion_empty.xml", x, y)
end
GamePrint(material)