local varsto = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "VariableStorageComponent")
if varsto ~= nil then
	local player = EntityGetRootEntity(GetUpdatedEntityID())
    if ComponentGetValue2(varsto, "name") == "parent_gameeffect" and EntityHasTag(player, "player_unit") then
        local entity = EntityCreateNew()
		EntityAddComponent2(entity, "GameEffectComponent", {
			frames=30,
			effect= ComponentGetValue2(varsto, "value_string"),
			exclusivity_group=1,
		})
		EntityAddChild(player, entity)
    end
end