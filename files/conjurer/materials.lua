if ALL_MATERIALS == nil then return end
table.insert(ALL_MATERIALS, {
    name="Graham's Things materials",
    desc="",
    icon="mods/grahamsperks/files/conjurer/materials/hunger.png",
    icon_off="mods/grahamsperks/files/conjurer/materials_off.png",
    materials={
      {
        image="mods/grahamsperks/files/materials/materials_gfx/mundane.png",
        name=GameTextGetTranslatedOrNot("$material_graham_mundane"):gsub("^%l", string.upper), -- not hax I swear
        id="graham_mundane",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/statium.png",
        name=GameTextGetTranslatedOrNot("$material_graham_statium"):gsub("^%l", string.upper),
        id="graham_statium",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/bubbly.png",
        name=GameTextGetTranslatedOrNot("$material_graham_bubbly"):gsub("^%l", string.upper),
        id="graham_bubbly",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/bubblygas.png",
        name=GameTextGetTranslatedOrNot("$material_graham_bubblygas"):gsub("^%l", string.upper),
        id="graham_bubblygas",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/resist.png",
        name=GameTextGetTranslatedOrNot("$material_graham_resist"):gsub("^%l", string.upper),
        id="graham_resist",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/pureliquid.png",
        name=GameTextGetTranslatedOrNot("$material_graham_pureliquid"):gsub("^%l", string.upper),
        id="graham_pureliquid",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/slush.png",
        name=GameTextGetTranslatedOrNot("$material_graham_slush"):gsub("^%l", string.upper),
        id="graham_slush",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/slush_ice.png",
        name=GameTextGetTranslatedOrNot("$material_graham_slush_ice"):gsub("^%l", string.upper),
        id="graham_slush_ice",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/chaotic_tele.png",
        name=GameTextGetTranslatedOrNot("$material_graham_tele_chaotic"):gsub("^%l", string.upper),
        id="graham_tele_chaotic",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/wormygold.png",
        name=GameTextGetTranslatedOrNot("$material_graham_wormygold"):gsub("^%l", string.upper),
        id="graham_wormygold",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/creepypoly.png",
        name=GameTextGetTranslatedOrNot("$material_graham_creepypoly"):gsub("^%l", string.upper),
        id="graham_creepypoly",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/creepypoly_frozen.png",
        name=GameTextGetTranslatedOrNot("$material_graham_creepypoly_frozen"):gsub("^%l", string.upper),
        id="graham_creepypoly_frozen",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/hellblood.png",
        name=GameTextGetTranslatedOrNot("$material_graham_hellblood"):gsub("^%l", string.upper),
        id="graham_hellblood",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/ascendum.png",
        name=GameTextGetTranslatedOrNot("$material_graham_ascendum"):gsub("^%l", string.upper),
        id="graham_ascendum",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/confusion.png",
        name=GameTextGetTranslatedOrNot("$material_graham_confusion"):gsub("^%l", string.upper),
        id="graham_confuse",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/coffee.png",
        name=GameTextGetTranslatedOrNot("$material_graham_coffee"):gsub("^%l", string.upper),
        id="graham_coffee",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/beans.png",
        name=GameTextGetTranslatedOrNot("$material_graham_beans"):gsub("^%l", string.upper),
        id="graham_beans",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/meatgreedy.png",
        name=GameTextGetTranslatedOrNot("$material_graham_meatgreedy"):gsub("^%l", string.upper),
        id="graham_meatgreedy",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/meathealthy.png",
        name=GameTextGetTranslatedOrNot("$material_graham_meathealthy"):gsub("^%l", string.upper),
        id="graham_meathealthy",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/stickyfungus.png",
        name=GameTextGetTranslatedOrNot("$material_graham_stickyfungus"):gsub("^%l", string.upper),
        id="graham_stickyfungus",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/driedfungus.png",
        name=GameTextGetTranslatedOrNot("$material_graham_driedfungus"):gsub("^%l", string.upper),
        id="graham_driedfungus",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/precursor.png",
        name=GameTextGetTranslatedOrNot("$material_graham_precursor"):gsub("^%l", string.upper),
        id="graham_precursor",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/darkgas.png",
        name=GameTextGetTranslatedOrNot("$material_graham_darkgas"):gsub("^%l", string.upper),
        id="graham_darkgas",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/sweetgas.png",
        name=GameTextGetTranslatedOrNot("$material_graham_sweetgas"):gsub("^%l", string.upper),
        id="graham_sweetgas",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/cloud_angy.png",
        name=GameTextGetTranslatedOrNot("$material_graham_cloud_angy"):gsub("^%l", string.upper),
        id="graham_cloud_angy",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/cloud_sweet.png",
        name=GameTextGetTranslatedOrNot("$material_graham_cloud_sweet"):gsub("^%l", string.upper),
        id="graham_cloud_sweet",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/lavaglass.png",
        name=GameTextGetTranslatedOrNot("$material_graham_lavaglass"):gsub("^%l", string.upper),
        id="graham_lavaglass",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/ash.png",
        name=GameTextGetTranslatedOrNot("$material_graham_ash"):gsub("^%l", string.upper),
        id="graham_ash",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/wood_rot.png",
        name=GameTextGetTranslatedOrNot("$material_graham_wood_rot"):gsub("^%l", string.upper),
        id="graham_wood_rot",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/purplebrick.png",
        name=GameTextGetTranslatedOrNot("$graham_mat_purplebrick"):gsub("^%l", string.upper),
        id="graham_purplebrick",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/love.png",
        name=GameTextGetTranslatedOrNot("$material_graham_love"):gsub("^%l", string.upper),
        id="graham_love",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/hunger.png",
        name=GameTextGetTranslatedOrNot("$material_graham_graymatter_liquid"):gsub("^%l", string.upper),
        desc="Warning: EXTREMELY destructive! Use at your own risk!\nCure with a hamburger.",
        id="graham_graymatter_liquid",
      },
      {
        image="mods/grahamsperks/files/conjurer/materials/yum.png",
        name=GameTextGetTranslatedOrNot("$material_graham_yum"):gsub("^%l", string.upper),
        desc="Mmm... hamburger.",
        id="graham_yum",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/birthday.png",
        name=GameTextGetTranslatedOrNot("$material_graham_birthday"):gsub("^%l", string.upper),
        desc="This is a birthday material. Find it on November 11th!",
        id="graham_birthday",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/copium.png",
        name=GameTextGetTranslatedOrNot("$material_graham_copium"):gsub("^%l", string.upper),
        desc="This is a birthday material. Find it on November 11th!",
        id="graham_copium",
      },
      {
        image="mods/grahamsperks/files/materials/materials_gfx/emptiness.png",
        name=GameTextGetTranslatedOrNot("$material_graham_emptiness"):gsub("^%l", string.upper),
        desc="This material is unused.",
        id="graham_emptiness",
      },
    }
  })