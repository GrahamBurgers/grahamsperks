local wands = EntityGetWithTag("wand")
for rng_idx, wand in ipairs(wands) do
	if EntityHasTag(wand, "graham_wand_ineligible") then
		goto continue1
	end
	EntityAddTag(wand, "graham_wand_ineligible")
	local comp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
	if not comp then
		goto continue1
	end

	local x, y = EntityGetTransform(wand)
	local capacity = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
	SetRandomSeed(comp + GameGetFrameNum(), wand + 42 * rng_idx)
	local count = tonumber(GlobalsGetValue("graham_extra_slots_amount", "0") or "0") * 4
	local capacity_change = Random(-count, count)
	local capacity_with_acs = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
	local capacity_without_acs = EntityGetWandCapacity(wand)
	local always_casts = math.max(0, capacity_with_acs - capacity_without_acs)
	local new_capacity = math.max(always_casts + 1, capacity + capacity_change)

	ComponentObjectSetValue2(comp, "gun_config", "deck_capacity", new_capacity)

	local children = EntityGetAllChildren(wand)
	if not children then
		goto continue1
	end

	for spell_idx = new_capacity + 1, #children do
		local spell = children[spell_idx]
		local comp2 = EntityGetFirstComponentIncludingDisabled(spell, "ItemActionComponent")
		if not comp2 then
			goto continue2
		end

		EntityRemoveFromParent(spell)
		EntitySetTransform(spell, x, y)

		local spell_components = EntityGetAllComponents(spell)

		for _, spell_component in ipairs(spell_components) do
			if not ComponentHasTag(spell_component, "item_unidentified") then
				EntitySetComponentIsEnabled(spell, spell_component, true)
			end
		end
		local velcomp = EntityGetFirstComponentIncludingDisabled(spell, "VelocityComponent")
		if velcomp then
			ComponentSetValue2(velcomp, "mVelocity", Random(-100, 100), Random(-50, -100))
		end
		::continue2::
	end
	::continue1::
end

