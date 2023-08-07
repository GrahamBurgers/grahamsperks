local varsto = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "VariableStorageComponent")
if varsto ~= nil then
    if ComponentGetValue2(varsto, "name") == "parent_gameeffect" then
        local entity = EntityCreateNew()
		EntityAddComponent2(entity, "GameEffectComponent", {
			frames=30,
			effect= ComponentGetValue2(varsto, "value_string"),
			exclusivity_group=1,
		})
		EntityAddChild(EntityGetRootEntity(GetUpdatedEntityID()), entity)
    end
end