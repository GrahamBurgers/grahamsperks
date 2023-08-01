local graham_potion_a_materials = potion_a_materials

function potion_a_materials()
	local random = Random( 1, 8 )
	if random < 8 then
        return graham_potion_a_materials()
    else
        return random_from_array( { "graham_mundane", "graham_coffee", "graham_stickyfungus", "graham_confuse", "graham_resist" } )
    end
end