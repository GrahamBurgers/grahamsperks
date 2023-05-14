---@diagnostic disable: undefined-global

local function new_spell_material(material, spells)
    append_effect(material, function(wand)
    end)
    add_spells_to_effect(material, spells)
end

-- these may be unbalanced, i haven't played around with the anvil of destiny too much so i have no idea if these'll interact poorly

add_spells_to_effect("blood", { "GRAHAM_VEIN", "GRAHAM_SACRIFICE" })
add_spells_to_effect("magical_liquid_protection_all", { "GRAHAM_HOLY_BULLET" })
add_spells_to_effect("radioactive_liquid", { "GRAHAM_MATERIAL_RADIOACTIVE" })

-- pure liquid: various 'holy' or 'good' spells
   new_spell_material("graham_pureliquid", {"GRAHAM_MATERIAL_PURE", "GRAHAM_HOLY_BULLET", "GRAHAM_MANAHEART"})
-- hellblood: eeeeeevil
   new_spell_material("graham_hellblood", {"GRAHAM_VEIN", "GRAHAM_SACRIFICE", "GRAHAM_REDHANDS", "GRAHAM_HANDPORTAL", "MATERIAL_BLOOD", "GRAHAM_CURSE_SHOT", "BERSERK_FIELD"})
-- mundanium: sorta basic but not bad spells
   new_spell_material("graham_mundanium", {"BUBBLESHOT", "BOUNCY_ORB", "BULLET", "SPITTER", "TINY_GHOST", "RUBBER_BALL", "GRAHAM_STASIS"})
-- minty marsh: mini perk spells (cause i had to put them somewhere)
   new_spell_material("graham_slush", {"GRAHAM_MINI_HEATWAVE", "GRAHAM_MINI_FREEZEFIELD", "GRAHAM_MINI_DISSOLVEPOWDERS", "GRAHAM_MINI_ATTRACTGOLD", "GRAHAM_MINI_ELECTRICITY", "GRAHAM_MINI_NOKNOCKBACK", "GRAHAM_MINI_MIDASMEAT"})
-- coffee: movement related stuff for spells and player
   new_spell_material("graham_coffee", {"LONG_DISTANCE_CAST", "LASER_LUMINOUS_DRILL", "TELEPORT_PROJECTILE", "TELEPORT_PROJECTILE_SHORT", "GRAHAM_BREADCRUMB"})
-- statium: protection-related stuff
   new_spell_material("graham_statium", {"GRAHAM_GUARDIAN_SHOT", "GRAHAM_UMBRELLA", "GRAHAM_UNBRELLA", "ENERGY_SHIELD", "ENERGY_SHIELD_SECTOR", "GRAHAM_WOOD"})
-- brine: snub
   new_spell_material("brine", {"GRAHAM_SNUB"})