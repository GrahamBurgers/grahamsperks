local to_insert = {
        {
		id="GRAHAM_BLOODBOIL",
		ui_name="$graham_status_bloodboil",
		ui_description="$graham_statusdesc_bloodboil",
		ui_icon="mods/grahamsperks/files/effects/boilingblood.png",
		effect_entity="mods/grahamsperks/files/effects/boilingblood.xml",
	},
	{
		id="GRAHAM_BIRTHDAY",
		ui_name="$graham_status_birthday",
		ui_description="$graham_statusdesc_birthday",
		ui_icon="mods/grahamsperks/files/effects/birthday.png",
		effect_entity="mods/grahamsperks/files/effects/birthday.xml",
	},
	{
		id="GRAHAM_CONSUMED",
		ui_name="$graham_status_consumed",
		ui_description="$graham_statusdesc_consumed",
		ui_icon="mods/grahamsperks/files/effects/consume.png",
		effect_entity="mods/grahamsperks/files/effects/consume.xml",
		is_harmful=true,
	},
	{
		id="GRAHAM_STARVING",
		ui_name="$graham_status_starving",
		ui_description="$graham_statusdesc_starving",
		ui_icon="mods/grahamsperks/files/effects/starving.png",
		effect_entity="mods/grahamsperks/files/effects/starving.xml",
		is_harmful=true,
	},
	{
		id="GRAHAM_CREEPYPOLY",
		ui_name="$graham_status_creepypoly",
		ui_description="$graham_statusdesc_creepypoly",
		ui_icon="mods/grahamsperks/files/effects/ham.png",
		remove_cells_that_cause_when_activated=true,
		effect_entity="mods/grahamsperks/files/effect_polymorph_creepy.xml",
		is_harmful=true,
	},
	{
		id="GRAHAM_HEALTHYMEAL",
		ui_name="$graham_status_healthymeal",
		ui_description="$graham_statusdesc_healthymeal",
		ui_icon="mods/grahamsperks/files/effects/healthymeal.png",
		effect_entity="mods/grahamsperks/files/effects/healthymeal.xml",
	},
	{
		id="GRAHAM_GREEDYMEAL",
		ui_name="$graham_status_greedymeal",
		ui_description="$graham_statusdesc_greedymeal",
		ui_icon="mods/grahamsperks/files/effects/greedymeal.png",
		effect_entity="mods/grahamsperks/files/effects/greedymeal.xml",
	},
	{
		id="GRAHAM_CAFFEINATED",
		ui_name="$graham_status_caffeinated",
		ui_description="$graham_statusdesc_caffeinated",
		ui_icon="mods/grahamsperks/files/effects/caffeinated.png",
		effect_entity="mods/grahamsperks/files/effects/caffeinated.xml",
	},
	{
		id="GRAHAM_MINTY",
		ui_name="$graham_status_minty",
		ui_description="$graham_statusdesc_minty",
		ui_icon="mods/grahamsperks/files/effects/minty.png",
		effect_entity="mods/grahamsperks/files/effects/minty.xml",
	},
	{
		id="GRAHAM_PROTECTION_ALL",
		ui_name="$status_protection_all",
		ui_description="$statusdesc_protection_all",
		ui_icon="data/ui_gfx/status_indicators/protection_all.png",
		effect_entity="mods/grahamsperks/files/effects/effect_protection_all.xml",
		is_harmful=true,
	},
	{
		id="CONFUSION",
		ui_name="$status_confusion",
		ui_description="$statusdesc_confusion",
		ui_icon="data/ui_gfx/status_indicators/confusion.png",
		effect_entity="data/entities/misc/effect_confusion.xml",
		is_harmful=false,
	},
	{
		id="CONFUSION",
		ui_name="$status_confusion",
		ui_description="$graham_statusdesc_confusion",
		ui_icon="data/ui_gfx/status_indicators/confusion.png",
		effect_entity="mods/grahamsperks/files/effects/confusion.xml",
		is_harmful=false,
		min_threshold_normalized="0.6667",
	},
	{
		id="GRAHAM_CHAOTIC_TELEPORTATION",
		ui_name="$status_teleportation",
		ui_description="$statusdesc_teleportation",
		ui_icon="data/ui_gfx/status_indicators/teleportation.png",
		effect_entity="mods/grahamsperks/files/entities/teleportation.xml",
		is_harmful=true,
	},
}

for i, v in ipairs(status_effects) do
	if v.id == "CONFUSION" then
		table.remove(status_effects, i)
		break
	end
end

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end