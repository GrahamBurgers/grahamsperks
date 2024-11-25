local translations = ModTextFileGetContent( "data/translations/common.csv" ) or ""
-- always load english first as a fallback in case something is missing
translations = translations .. ModTextFileGetContent( "mods/grahamsperks/files/translations/en.csv" )
if ModSettingGet("grahamsperks.Language") == 2 then
	if ModIsEnabled("better_chinese") then
		translations = translations .. ModTextFileGetContent( "mods/grahamsperks/files/translations/zh_books.csv")
	else
		translations = translations .. ModTextFileGetContent( "mods/grahamsperks/files/translations/zh.csv")
	end
elseif ModSettingGet("grahamsperks.Language") == 3 then
	translations = translations .. ModTextFileGetContent( "mods/grahamsperks/files/translations/ru.csv" )
end
translations = translations:gsub("\r",""):gsub("\n\n","\n")
ModTextFileSetContent( "data/translations/common.csv", translations )

ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials.xml")
ModMaterialsFileAdd("mods/grahamsperks/files/materials/materials_reactions.xml")
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_append.lua" )
ModLuaFileAppend( "data/scripts/items/potion_aggressive.lua", "mods/grahamsperks/files/materials/potion_aggressive.lua" )

-- Extra mod compatibility
if ModIsEnabled("more-stuff") then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_morestuff.xml")
end
if ModIsEnabled("anvil_of_destiny") then
	ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/grahamsperks/files/scripts/aod_compat.lua")
end
if ModIsEnabled("raksa") then
	ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/entity_categories.lua",
		"mods/grahamsperks/files/conjurer/entities.lua"
	)
	ModLuaFileAppend(
		"mods/raksa/files/scripts/lists/entity_categories.lua",
		"mods/grahamsperks/files/conjurer/materials.lua"
	)
end

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/grahamsperks/files/spells/actions.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/grahamsperks/files/perks/perk_list.lua")

if not ModSettingGet("grahamsperks.Creepy") == true then
	ModMaterialsFileAdd("mods/grahamsperks/files/materials/reactions_creepy.xml")
end

-- 9/9/24: stop silly errors in dev exe by replacing some of these with manual appends

-- ModLuaFileAppend( "data/scripts/items/heart.lua", "mods/grahamsperks/files/healthyheart.lua" )
-- ModLuaFileAppend( "data/scripts/items/heart_evil.lua", "mods/grahamsperks/files/healthyheart.lua" )
-- ModLuaFileAppend( "data/scripts/items/heart_better.lua", "mods/grahamsperks/files/healthyheart_better.lua" )
-- ModLuaFileAppend( "data/scripts/items/spell_refresh.lua", "mods/grahamsperks/files/scripts/spell_refresh_append.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/grahamsperks/files/effects/status_effects.lua" )
-- ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/grahamsperks/files/bloodybonus_check.lua" )
ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/grahamsperks/files/add_oneoffs.lua" )
ModLuaFileAppend( "data/scripts/biomes/temple_altar.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/biomes/boss_arena.lua", "mods/grahamsperks/files/scripts/temple_altar_append.lua")
ModLuaFileAppend( "data/scripts/buildings/forge_item_convert.lua", "mods/grahamsperks/files/scripts/anvil_append.lua")
-- ModLuaFileAppend( "data/scripts/items/heart_fullhp.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")
-- ModLuaFileAppend( "data/scripts/items/heart_fullhp_temple.lua", "mods/grahamsperks/files/scripts/blood_orb_fullheal.lua")
ModLuaFileAppend( "data/scripts/magic/fungal_shift.lua", "mods/grahamsperks/files/scripts/fungal_shift_append.lua")
ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/grahamsperks/files/streaming/_streaming_events.lua" )
ModLuaFileAppend( "data/scripts/biomes/boss_arena.lua", "mods/grahamsperks/files/scripts/final_mountain_missing.lua")

local thingy = ModTextFileGetContent("data/scripts/items/drop_money.lua")
ModTextFileSetContent("data/scripts/items/drop_money.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/bloodybonus_check.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/heart.lua")
ModTextFileSetContent("data/scripts/items/heart.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/healthyheart.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/heart_evil.lua")
ModTextFileSetContent("data/scripts/items/heart_evil.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/healthyheart.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/heart_better.lua")
ModTextFileSetContent("data/scripts/items/heart_better.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/healthyheart_better.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/spell_refresh.lua")
ModTextFileSetContent("data/scripts/items/spell_refresh.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/scripts/spell_refresh_append.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/heart_fullhp.lua")
ModTextFileSetContent("data/scripts/items/heart_fullhp.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/scripts/blood_orb_fullheal.lua\")")
thingy = ModTextFileGetContent("data/scripts/items/heart_fullhp_temple.lua")
ModTextFileSetContent("data/scripts/items/heart_fullhp_temple.lua", thingy .. "\n" .. "dofile_once(\"mods/grahamsperks/files/scripts/blood_orb_fullheal.lua\")")

if ModSettingGet("grahamsperks.Enemies") ~= false then
	-- enemies
	local enemies = {"coalmine_alt", "excavationsite", "snowcave", "snowcastle", "sandcave", "vault", "meat"}
	for i = 1, #enemies do
		if ModTextFileGetContent( "data/scripts/biomes/" .. enemies[i] .. ".lua") ~= nil then
			ModLuaFileAppend( "data/scripts/biomes/" .. enemies[i] .. ".lua", "mods/grahamsperks/files/scripts/enemies_" .. enemies[i] .. ".lua" )
		end
	end

	if ModIsEnabled("biome-plus") then
		-- vanilla biomes
		local input = {"excavationsite", "snowcave", "snowcastle", "sandcave", "vault"}
		-- alternate biomes
		local output = {"blast_pit", "frozen_passages", "snowvillage", "tomb", "robofactory"}
		for i = 1, #input do
			ModLuaFileAppend( "data/scripts/biomes/mod/" .. output[i] .. ".lua", "mods/grahamsperks/files/scripts/enemies_" .. input[i] .. ".lua" )
		end
	end

	if PolymorphTableAddEntity ~= nil then
		PolymorphTableAddEntity( "data/entities/animals/graham_miner_gasser.xml", false )
		PolymorphTableAddEntity( "data/entities/animals/graham_fuzz.xml", false )
		PolymorphTableAddEntity( "data/entities/animals/graham_gasser_hell.xml", false )
		PolymorphTableAddEntity( "data/entities/animals/graham_wizard_familiar.xml", false )
		if HasFlagPersistent("graham_minimimic_killed") then PolymorphTableAddEntity( "data/entities/animals/mini_mimic.xml", false ) end
		if HasFlagPersistent("graham_bloodymimic_killed") then PolymorphTableAddEntity( "data/entities/animals/bloody_mimic.xml", false ) end
	end
end

local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	local worldsize = tonumber(ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or "35840") or 35840
	for i = 1, #table do
		if table[i][5] ~= false then
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			if table[i][4] then
				-- make things show up in first 2 parallel worlds
				-- hopefully this won't cause too much lag when starting a run
				string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
				string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
				string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
				string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			end
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end

dofile_once("data/scripts/perks/perk.lua")

local patches = {
    {
        path    = "data/entities/misc/hitfx_toxic_charm.xml",
        from    = "condition_status",
        to      = "condition_effect",
    },
    {
        path    = "data/entities/projectiles/deck/xray.xml",
        from    = "tags=\"projectile_player\"",
        to      = "tags=\"projectile_player,graham_ase\"",
    },
    {
        path    = "data/entities/items/pickup/moon.xml",
        from    = "tags=\"hittable,",
        to      = "tags=\"hittable,forgeable,bloodmoon_forgeable,",
    },
    {
        path    = "data/entities/items/pickup/evil_eye.xml",
        from    = "tags=\"hittable,",
        to      = "tags=\"hittable,forgeable,cybereye_forgeable,",
    },
    {
        path    = "data/entities/items/pickup/physics_die.xml",
        from    = "tags=\"hittable,",
        to      = "tags=\"hittable,forgeable,lovelydie_forgeable,",
    },
	{
        path    = "data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent 
				_enabled="1" 
				execute_every_n_frame="240"
				script_source_file="mods/grahamsperks/files/scripts/altar_append.lua" 
			>
			</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/entities/base_humanoid.xml",
        from    = "<GameStatsComponent />",
        to      = [[
			<GameStatsComponent />
			<LuaComponent
			execute_on_added="0"
			execute_every_n_frame="2"
			remove_after_executed="1"
			script_source_file="mods/grahamsperks/files/scripts/midas_kill.lua"
			></LuaComponent>
		]],
    },
	{
        path    = "data/entities/items/books/base_book.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent
			execute_on_added="1"
			execute_every_n_frame="-1"
			remove_after_executed="1"
			script_source_file="mods/grahamsperks/files/scripts/book.lua"
			></LuaComponent>
			</Entity>
		]],
    },
	{
        path    = "data/entities/items/pickup/potion.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent 
				_enabled="1" 
				remove_after_executed="1"
				script_source_file="mods/grahamsperks/files/scripts/angry.lua" 
			>
			</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/entities/items/pickup/physics_die.xml",
        from    = "</Entity>",
        to      = [[
			<LuaComponent 
				_enabled="1"
				execute_on_added="1"
				remove_after_executed="1"
				script_source_file="mods/grahamsperks/files/scripts/lovely_die.lua" 
			>
			</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/scripts/biome_scripts.lua",
        from    = [[elseif %(r > 0.3%) then]],
        to      = [[elseif %(r > 0.3%) or %(r > 0.1 and GameHasFlagRun%("PERK_PICKED_GRAHAM_LUCKY_CLOVER"%)%) then]],
    },
	{
        path    = "data/scripts/biome_scripts.lua",
        from    = [[if %(r > heart_spawn_percent%) then]],
        to      = [[if GameHasFlagRun%("PERK_PICKED_GRAHAM_LUCKY_CLOVER"%) then heart_spawn_percent = heart_spawn_percent - 0.1 end
		if %(r > heart_spawn_percent%) then]],
    },
	{
        path    = "data/scripts/biome_scripts.lua",
        from    = [[local entity = EntityLoad%( "data/entities/items/pickup/chest_random.xml", x, y%)]],
        to      = [[
			if GameHasFlagRun%("PERK_PICKED_GRAHAM_LUCKY_CLOVER"%) then rnd = rnd + %(%(1000 - rnd%) * 0.3%) end
			if %(rnd >= 900 %) then
				local entity = EntityLoad%( "mods/grahamsperks/files/pickups/chest_lost.xml", x, y%)
			elseif %(rnd >= 850 %) then
				SetRandomSeed%( GameGetFrameNum%(%), GameGetFrameNum%(%) %)
				if Random%(1, 3%) == 3 then
					local entity = EntityLoad%( "data/entities/animals/mini_mimic.xml", x, y%)
				else
					local entity = EntityLoad%( "mods/grahamsperks/files/pickups/chest_mini.xml", x, y%)
				end
			elseif %(rnd >= 775 %) or %(rnd >= 725 and %(BiomeMapGetName%(x, y%):gsub%("$biome_", ""%) == "vault"%)%) then
				local entity = EntityLoad%( "mods/grahamsperks/files/pickups/safe.xml", x, y%)
			else
				local entity = EntityLoad%( "data/entities/items/pickup/chest_random.xml", x, y%)
			end
		]],
    },
	{
        path    = "data/scripts/items/chest_random.lua",
        from    = "\"metal\"",
        to      = "\"metal\", \"graham_phase\"",
    },
	{
        path    = "data/scripts/items/utility_box.lua",
        from    = "\"metal\"",
        to      = "\"metal\", \"graham_phase\"",
    },
	{
        path    = "data/scripts/item_spawnlists.lua",
        from    = "\"metal\"",
        to      = "\"metal\", \"graham_phase\"",
    },
	{
        path    = "data/entities/items/pickup/runestones/runestone_base.xml",
        from    = "item_physics,",
        to      = "graham_runestone,item_physics,",
    },
	{
        path    = "data/scripts/buildings/workshop_trigger_check_stats.lua",
        from    = [[local eid = EntityLoad%( "data/entities/items/pickup/chest_random.xml", sx, sy %)]],
        to      = [[local eid
		SetRandomSeed%( sx + 894524, sy - 137501 %)
        if %(ModSettingGet%("grahamsperks.PacifistChest"%) or true%) ~= false then
        	if Random%(1, 12%) == 12 then
				eid = EntityLoad%("data/entities/animals/mini_mimic.xml", sx, sy%)
       		else
				eid = EntityLoad%("mods/grahamsperks/files/pickups/chest_mini.xml", sx, sy%)
			end
        else
			eid = EntityLoad%("data/entities/items/pickup/chest_random.xml", sx, sy%)
		end]],
    },
	{
        path    = "data/scripts/buildings/workshop_trigger_check_stats.lua",
        from    = [[print%("KILLED ALL"%)]],
        to      = [[print%("KILLED ALL"%)
		if GlobalsGetValue%("GRAHAM_SPAWN_BLOODY_CHEST", "0"%) == "1" then
			GlobalsSetValue%("GRAHAM_SPAWN_BLOODY_CHEST", "0"%)
			local sx, sy = x, y

			if %(reference_id ~= NULL_ENTITY%) then
				sx, sy = EntityGetTransform%(reference_id%)
			end
			local kills_needed = 14 + math.floor(sy / 200)

			GlobalsSetValue%("GRAHAM_BLOODY_BONUS_KILLS", tostring%(kills_needed%)%)
			local chance = 15
			if HasFlagPersistent%("graham_bloodymimic_killed"%) == false then
				chance = 5
			end
			SetRandomSeed%( sx - 2594884, sy - 485398 %)
			if Random%(1, chance%) == chance then local eid = EntityLoad%("data/entities/animals/bloody_mimic.xml", sx, sy%)
			else local eid = EntityLoad%("mods/grahamsperks/files/pickups/chest_bloody.xml", sx, sy + 7%) end

			local perk = EntityGetWithTag%("perk_entity"%)
			for i = 1, #perk do
				local ui = EntityGetFirstComponent%(perk[i], "UIIconComponent"%)
				if ui then
					local current = ComponentGetValue2%(ui, "icon_sprite_file"%)
					if current == "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus_on.png" then
						ComponentSetValue2%(ui, "icon_sprite_file", "mods/grahamsperks/files/perks/perks_gfx/gui/bloodybonus.png"%)
					end
				end
			end
        end]],
    },
	{
        path    = "data/entities/buildings/teleport_hourglass.xml",
        from    = [[</Entity>]],
        to      = [[
		<MaterialAreaCheckerComponent
			_tags="disabled_by_liquid"
			area_aabb.min_x="-16" 
			area_aabb.max_x="16" 
			area_aabb.min_y="110"   
			area_aabb.max_y="115"
			update_every_x_frame="1"
			material="graham_tele_chaotic"
			material2="graham_tele_chaotic"
			look_for_failure="0"
			kill_after_message="0">
		</MaterialAreaCheckerComponent>
		</Entity>
		]],
    },
	{
        path    = "data/entities/items/pickup/heart.xml",
        from    = [[</Entity>]],
        to      = [[
		<LuaComponent
			script_source_file="mods/grahamsperks/files/scripts/healthyheart_check.lua">
		</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/entities/items/pickup/heart_better.xml",
        from    = [[</Entity>]],
        to      = [[
		<LuaComponent
			script_source_file="mods/grahamsperks/files/scripts/healthyheart_check.lua">
		</LuaComponent>
		</Entity>
		]],
    },
	{
        path    = "data/shaders/post_final.frag",
        from    = [[varying vec2 tex_coord_fogofwar;]], -- mit licensed simplex noise so this is ok to be using, technically don't need to credit but that would be unfriendly.
        to      = [[varying vec2 tex_coord_fogofwar; uniform vec4 grahams_perks_distortion_strength;
		//	Simplex 3D Noise 
		//	by Ian McEwan, Ashima Arts
		//  https://github.com/ashima/webgl-noise/blob/master/LICENSE
		vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
		vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

		float snoise(vec3 v){ 
		const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
		const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

		// First corner
		vec3 i  = floor(v + dot(v, C.yyy) );
		vec3 x0 =   v - i + dot(i, C.xxx) ;

		// Other corners
		vec3 g = step(x0.yzx, x0.xyz);
		vec3 l = 1.0 - g;
		vec3 i1 = min( g.xyz, l.zxy );
		vec3 i2 = max( g.xyz, l.zxy );

		//  x0 = x0 - 0. + 0.0 * C 
		vec3 x1 = x0 - i1 + 1.0 * C.xxx;
		vec3 x2 = x0 - i2 + 2.0 * C.xxx;
		vec3 x3 = x0 - 1. + 3.0 * C.xxx;

		// Permutations
		i = mod(i, 289.0 ); 
		vec4 p = permute( permute( permute( 
					i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
				+ i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
				+ i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

		// Gradients
		// ( N*N points uniformly over a square, mapped onto an octahedron.)
		float n_ = 1.0/7.0; // N=7
		vec3  ns = n_ * D.wyz - D.xzx;

		vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)

		vec4 x_ = floor(j * ns.z);
		vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

		vec4 x = x_ *ns.x + ns.yyyy;
		vec4 y = y_ *ns.x + ns.yyyy;
		vec4 h = 1.0 - abs(x) - abs(y);

		vec4 b0 = vec4( x.xy, y.xy );
		vec4 b1 = vec4( x.zw, y.zw );

		vec4 s0 = floor(b0)*2.0 + 1.0;
		vec4 s1 = floor(b1)*2.0 + 1.0;
		vec4 sh = -step(h, vec4(0.0));

		vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
		vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

		vec3 p0 = vec3(a0.xy,h.x);
		vec3 p1 = vec3(a0.zw,h.y);
		vec3 p2 = vec3(a1.xy,h.z);
		vec3 p3 = vec3(a1.zw,h.w);

		//Normalise gradients
		vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
		p0 *= norm.x;
		p1 *= norm.y;
		p2 *= norm.z;
		p3 *= norm.w;

		// Mix final noise value
		vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
		m = m * m;
		return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), 
										dot(p2,x2), dot(p3,x3) ) );
		}]],
    },
	{
        path    = "data/shaders/post_final.frag",
        from    = [[vec2 tex_coord = tex_coord_;]],
        to      = [[vec2 tex_coord = tex_coord_;
		tex_coord -= vec2(0.5);
		tex_coord *= 2.0;
		float grahams_perks_effect_strength = grahams_perks_distortion_strength.x * 1.5; 
		float grahams_perks_time_scale = 0.15;
		float grahams_perks_distance_weight = (length(tex_coord) * length(tex_coord)) * grahams_perks_effect_strength; 
		for (int i = 0; i < 3; i++) // layer multiple simplex passes
		{
			float grahams_perks_sine_scale_inverse = float(i) + 5.0;
			/*
				sum 5-8
					simplex(n*p)/n
			*/
			tex_coord += vec2(snoise(vec3(tex_coord,time * grahams_perks_time_scale + grahams_perks_sine_scale_inverse) * grahams_perks_sine_scale_inverse),snoise(vec3(tex_coord,time * grahams_perks_time_scale + 10.0 + grahams_perks_sine_scale_inverse) * grahams_perks_sine_scale_inverse)) / grahams_perks_sine_scale_inverse / grahams_perks_sine_scale_inverse;
		}
		tex_coord /= 2.0;
		tex_coord += vec2(0.5);
		tex_coord = (grahams_perks_distance_weight * grahams_perks_effect_strength * tex_coord + tex_coord_)/(1.0 + grahams_perks_distance_weight * grahams_perks_effect_strength);]],
    },
	{
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = "EntityKill%( entity_id %)",
        to      = [[CreateItemActionEntity%( "GRAHAM_GOLDEN", x + 128, y - 16%)
		EntityKill%( entity_id %)]],
    },
	{ -- Make glimmer spells work with plasma emitters. Thank you Conga Lyne!!! (and Sharpy796!)
		path    = "data/scripts/projectiles/colour_spell.lua",
		from    = "comps %= EntityGetComponent%( entity_id, \"ParticleEmitterComponent\" %)",
		to      = [[comps = EntityGetComponent( entity_id, "LaserEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
		-- for k=1,#comps do
			-- local v = comps[k]
			if ( particle ~= nil ) then
				ComponentObjectSetValue2( v, "laser", "beam_particle_type", CellFactory_GetType(particle))
				ComponentObjectSetValue2( v, "laser", "beam_particle_chance", 90)
			else
				ComponentObjectSetValue2( v, "laser", "beam_particle_chance", 0)
			end
		end
	end
		
	comps = EntityGetComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" )]],
	},
	-- 11/25/24: stupid silly stupid hardcoded freezy effects
	{
        path    = "data/entities/misc/material_converter_freeze.xml",
        from    = "radioactive_liquid,",
        to      = [[radioactive_liquid,graham_creepypoly,]],
    },
	{
        path    = "data/entities/misc/material_converter_freeze.xml",
        from    = "ice_radioactive_static,",
        to      = [[ice_radioactive_static,graham_creepypoly_frozen,]],
    },
	{
        path    = "data/entities/particles/freeze_charge.xml",
        from    = "radioactive_liquid,",
        to      = [[radioactive_liquid,graham_creepypoly,]],
    },
	{
        path    = "data/entities/particles/freeze_charge.xml",
        from    = "ice_radioactive_static,",
        to      = [[ice_radioactive_static,graham_creepypoly_frozen,]],
    },
	{
        path    = "data/entities/projectiles/deck/freeze_field.xml",
        from    = "radioactive_liquid,",
        to      = [[radioactive_liquid,graham_creepypoly,]],
    },
	{
		path    = "data/entities/projectiles/deck/freeze_field.xml",
        from    = "ice_radioactive_static,",
        to      = [[ice_radioactive_static,graham_creepypoly_frozen,]],
    },
	{
        path    = "data/entities/projectiles/deck/freezing_gaze_beam.xml",
        from    = "radioactive_liquid,",
        to      = [[radioactive_liquid,graham_creepypoly,]],
    },
	{
		path    = "data/entities/projectiles/deck/freezing_gaze_beam.xml",
        from    = "ice_radioactive_static,",
        to      = [[ice_radioactive_static,graham_creepypoly_frozen,]],
    },
}

if ModSettingGet("grahamsperks.StartingItems") ~= false then
	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/grahamsperks/files/scripts/potion_starting_append.lua")
	table.insert(patches, {
		path    = "data/scripts/gun/procedural/starting_wand.lua",
        from    = "\"SPITTER\"",
        to      = "\"SPITTER\",\"GRAHAM_GLOW_DART\",\"GRAHAM_BRAMBALL\"",
	})
	table.insert(patches, {
        path    = "data/scripts/gun/procedural/starting_bomb_wand.lua",
        from    = "\"GRENADE\"",
        to      = "\"GRENADE\",\"GRAHAM_BARREL\",\"GRAHAM_PANIC_BOMB\"",
	})
end

--[[ retired for now. should probably get this working one day
if ModIsEnabled("noita-together") then
	table.insert(patches, {
        path    = "mods/noita-together/files/scripts/perks.lua",
        from    = "EXTRA_MONEY=true,",
        to      = "EXTRA_MONEY=true,GRAHAM_HEALTHY_HEARTS=true,GRAHAM_LUCKY_CLOVER=true,GRAHAM_CAMPFIRE=true,GRAHAM_REFRESHER=true,GRAHAM_EXTRA_SLOTS=true,GRAHAM_REFRESHER=true,",
	})
end
]]--

if HasFlagPersistent("graham_death_hp_boost") then
	table.insert(patches, {
        path    = "data/items_gfx/bomb_wand.xml",
        from    = "data/items_gfx/bomb_wand.png",
        to      = "mods/grahamsperks/files/wands/bomb_wand.png",
    })
	table.insert(patches, {
        path    = "data/items_gfx/handgun.xml",
        from    = "data/items_gfx/handgun.png",
        to      = "mods/grahamsperks/files/wands/handgun.png",
    })
end

local event_patches = {}
local events = {
	["10/31"] = function()
		event_patches = {
			{
			path    = "data/enemies_gfx/graham_fuzz.xml",
			from    = "data/enemies_gfx/graham_fuzz.png",
			to      = "mods/grahamsperks/files/seasonal/halloween_fuzz.png",
		},
			{
			path    = "data/enemies_gfx/graham_fuzzzap.xml",
			from    = "data/enemies_gfx/graham_fuzzzap.png",
			to      = "mods/grahamsperks/files/seasonal/halloween_fuzzzap.png",
		},
			{
			path    = "data/entities/animals/graham_fuzz.xml",
			from    = "emitted_material_name=\"blood_cold\"",
			to      = "emitted_material_name=\"magic_liquid_protection_all\"",
		},
			{
			path    = "data/entities/animals/graham_fuzz.xml",
			from    = "rock_box2d",
			to      = "meat_pumpkin",
		},
			{
			path    = "mods/grahamsperks/files/entities/cold_dart.xml",
			from    = "magic_liquid_mana_regeneration",
			to      = "magic_liquid_protection_all",
		},
			{
			path    = "data/entities/animals/bloody_mimic.xml",
			from    = "data/enemies_gfx/bloody_mimic.xml",
			to      = "mods/grahamsperks/files/seasonal/halloween_bloody_mimic.xml",
		},
			{
			path    = "data/entities/animals/mini_mimic.xml",
			from    = "data/enemies_gfx/mini_mimic.xml",
			to      = "mods/grahamsperks/files/seasonal/halloween_mini_mimic.xml",
		},
			{
			path    = "data/entities/animals/graham_wizard_familiar.xml",
			from    = "data/enemies_gfx/graham_wizard_familiar.xml",
			to      = "mods/grahamsperks/files/seasonal/halloween_graham_wizard_familiar.xml",
		},
			{
			path    = "data/entities/animals/graham_wizard_familiar.xml",
			from    = "data/enemies_gfx/graham_wizard_familiar_emissive.xml",
			to      = "mods/grahamsperks/files/seasonal/halloween_graham_wizard_familiar_emissive.xml", -- that's a mouthful
		},
			{
			path    = "data/entities/animals/graham_miner_gasser.xml",
			from    = "data/enemies_gfx/graham_miner_gasser.xml",
			to      = "mods/grahamsperks/files/seasonal/halloween_graham_miner_gasser.xml",
		},
			{
			path    = "data/entities/animals/graham_wizard_familiar.xml",
			from    = "<VerletPhysicsComponent",
			to      = [[<VerletPhysicsComponent _enabled="0"]],
		},
		}
		ModTextFileSetContent("data/ragdolls/graham_fuzz/filenames.txt", "data/ragdolls/graham_fuzz/halloween_body.png")
		ModTextFileSetContent("data/ragdolls/graham_wizard_familiar/filenames.txt", ModTextFileGetContent("data/ragdolls/graham_wizard_familiar/filenames_halloween.txt"))
	end,
	["11/11"] = function()
		-- todo: add more to this?
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
		event_patches = {
			{
			path    = "mods/grahamsperks/files/scripts/shiny.lua",
			from    = "-- dummy",
			to      = "threshold = threshold * 64",
		},
		{
			path    = "mods/grahamsperks/files/scripts/book.lua",
			from    = "= 500",
			to      = "= 50",
		},
			{
			path    = "mods/grahamsperks/files/scripts/book.lua",
			from    = "= 5000",
			to      = "= 500",
		},
		}
	end,
	["12/25"] = function()
		event_patches = {
			{
				path    = "data/entities/animals/bloody_mimic.xml",
				from    = "data/enemies_gfx/bloody_mimic.xml",
				to      = "mods/grahamsperks/files/seasonal/christmas_bloody_mimic.xml",
		},
			{
				path    = "data/entities/animals/mini_mimic.xml",
				from    = "data/enemies_gfx/mini_mimic.xml",
				to      = "mods/grahamsperks/files/seasonal/christmas_mini_mimic.xml",
		},
			{
				path    = "data/enemies_gfx/graham_fuzz.xml",
				from    = "data/enemies_gfx/graham_fuzz.png",
				to      = "mods/grahamsperks/files/seasonal/christmas_fuzz.png",
		},
			{
				path    = "data/enemies_gfx/graham_fuzzzap.xml",
				from    = "data/enemies_gfx/graham_fuzzzap.png",
				to      = "mods/grahamsperks/files/seasonal/christmas_fuzzzap.png",
		},
			{
				path    = "data/entities/animals/graham_fuzz.xml",
				from    = "emitted_material_name=\"blood_cold\"",
				to      = "emitted_material_name=\"midas\"",
		},
			{
			path    = "mods/grahamsperks/files/entities/cold_dart.xml",
			from    = "magic_liquid_mana_regeneration",
			to      = "midas",
		},
			{
			path    = "data/entities/animals/graham_fuzz.xml",
			from    = "rock_box2d",
			to      = "gold_b2",
		},
		}
		ModTextFileSetContent("data/ragdolls/graham_fuzz/filenames.txt", "data/ragdolls/graham_fuzz/christmas_body.png")
	end
}
local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()
local event = month .. "/" .. day
if event == "10/30" or event == "11/1" then event = "10/31" end -- too lazy to figure out how to simplify this
if event == "11/10" or event == "11/12" then event = "11/11" end
if event == "12/24" or event == "12/26" then event = "12/25" end
if events[event] ~= nil then
	events[event]()
end

for i=1, #patches do
    local patch = patches[i]
    local content = ModTextFileGetContent(patch.path)
	if content ~= nil then
		content = content:gsub(patch.from, patch.to)
		ModTextFileSetContent(patch.path, content)
	end
end
for i=1, #event_patches do
    local patch = event_patches[i]
    local content = ModTextFileGetContent(patch.path)
	if content ~= nil then
		content = content:gsub(patch.from, patch.to)
		ModTextFileSetContent(patch.path, content)
	end
end

function OnPlayerSpawned(player)
	-- EntitySetDamageFromMaterial(player, "graham_purplebrick_lessglow", 0.00012)
	local x, y = EntityGetTransform(player)

	GlobalsSetValue( "GRAHAM_TOGGLE", "null" )
	GlobalsSetValue( "GRAHAM_TOGGLE2", "null" )

	if ModSettingGet("grahamsperks.SettingsReminder") ~= false then
	    GamePrint("$graham_settings_check")
	end

	if GameHasFlagRun("spawned_lifelottery") == false then
		if PolymorphTableAddEntity == nil then
			EntityLoad("mods/grahamsperks/files/entities/books/bigbook.xml", x + 200, y)
		end

		GlobalsSetValue( "GRAHAM_ONEOFFS", "0" )
		GameAddFlagRun("spawned_lifelottery")

		if HasFlagPersistent("graham_death_hp_boost") then
			dofile_once("data/scripts/perks/perk.lua")
			RemoveFlagPersistent("graham_death_hp_boost")
			local dmg = EntityGetFirstComponent(player, "DamageModelComponent")
			if dmg then
				ComponentSetValue2(dmg, "hp", ComponentGetValue2(dmg, "hp") * 1.5)
				ComponentSetValue2(dmg, "max_hp", ComponentGetValue2(dmg, "max_hp") * 1.5)
			end
			local eid = perk_spawn_random(x, y)
			perk_pickup(eid, player, EntityGetName(eid), true, false)
		end

		local eid = EntityCreateNew()
		EntityAddTag(eid, "graham_midas_curse")
		EntityAddChild(GameGetWorldStateEntity(), eid)

		EntityAddComponent2(player, "LuaComponent", {
			script_source_file="mods/grahamsperks/files/entities/unlockcheck.lua",
			execute_every_n_frame=5,
		})
		EntityAddComponent2(player, "LuaComponent", {
			script_source_file="mods/grahamsperks/files/scripts/immunity_aura_vfx.lua",
			execute_every_n_frame=1,
		})
		EntityAddComponent2(player, "LuaComponent", {
			script_death="mods/grahamsperks/files/scripts/death.lua",
			execute_every_n_frame=-1,
		})
		EntityAddComponent2(player, "VariableStorageComponent", {
			_tags="graham_flum_shader",
			value_int=0,
		})

		if not HasFlagPersistent("graham_death_is_ok") or HasFlagPersistent("fury_secret_funny") then
			RemoveFlagPersistent("graham_deathquest_01")
			RemoveFlagPersistent("graham_deathquest_02")
			RemoveFlagPersistent("graham_deathquest_03")
		end
		RemoveFlagPersistent("graham_death_is_ok")

		if HasFlagPersistent("graham_deathquest_03") then
			-- death quest complete
			EntityAddTag(player, "polymorphable_NOT")
			local comp = EntityGetComponent(player, "DamageModelComponent") or {}
			for i = 1, #comp do
				EntitySetComponentIsEnabled(player, comp[i], false)
			end
			comp = EntityGetComponent(player, "CharacterDataComponent") or {}
			for i = 1, #comp do
				ComponentSetValue2(comp[i], "flying_needs_recharge", false)
			end
			comp = EntityGetComponent(player, "WalletComponent") or {}
			for i = 1, #comp do
				EntityRemoveComponent(player, comp[i])
			end

			EntityAddComponent2(player, "CellEaterComponent", {
				radius=8,
				eat_probability=1,
			})

			local worldstate = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
			ComponentSetValue2(worldstate, "global_genome_relations_modifier", 200)
			ComponentSetValue2(worldstate, "intro_weather", true)
			GameAddFlagRun("graham_gold_all_enemies")

			EntityAddComponent2(player, "LuaComponent", {
				script_source_file="mods/grahamsperks/files/scripts/delete_all.lua",
				execute_every_n_frame=5,
			})
		end
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	SetRandomSeed(13548, 195430)
	if ModSettingGet("grahamsperks.birthday") == true and event ~= "11/11" then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_birthday.lua" )
	end
	if (Random(1, 15) == 1) then
		ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/grahamsperks/files/materials/potion_secret.lua" )
	end

	-- this is going to look really stupid
	local tech_chest_shuffle = {
		true, true, true, true, true, false, false, false, false, false
	}
	local chest = {}
	for i = 1, #tech_chest_shuffle do
		local number = Random(1, #tech_chest_shuffle)
		chest[#chest+1] = tech_chest_shuffle[number]
		table.remove(tech_chest_shuffle, number)
	end

	add_scene({
		{-2379, 6646, "mods/grahamsperks/files/entities/books/cookbook.xml", true},
		{9953, -1167, "mods/grahamsperks/files/entities/books/polybook.xml", true},
		{-3811, 10113, "mods/grahamsperks/files/entities/books/lonelybook.xml", true},
		{-16268, -7093, "mods/grahamsperks/files/entities/books/timebook.xml", true},
		{-1933, -59, "mods/grahamsperks/files/entities/books/anvilbook.xml"},
		{4379, 895, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[1]},
		{-12340, 420, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[2]},
		{-3367, 3346, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[3]},
		{2945, 12316, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[4]},
		{12336, -4642, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[5]},
		{-1707, -742, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[6]},
		{9654, 9186, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[7]},
		{3372, 1876, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[8]},
		{-4324, 3968, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[9]},
		{4413, 13087, "mods/grahamsperks/files/pickups/chest_tech.xml", true, chest[10]},
		{11480, -4864, "mods/grahamsperks/files/wands/candyheart.xml", true},
		{10050, -736, "mods/grahamsperks/files/wands/rotting.xml", true},
		{16090, 10000, "mods/grahamsperks/files/wands/coffee.xml", true},
		{2520, 7440, "mods/grahamsperks/files/wands/petworm.xml", true},
		{4135, 12964, "mods/grahamsperks/files/wands/gluestick.xml", true},
		{16161, 3333, "mods/grahamsperks/files/wands/experimental.xml", true},
		{1487, 6085, "mods/grahamsperks/files/entities/books/unlockbook.xml", true},
		{3435, 936, "mods/grahamsperks/files/pickups/vial.xml", true},
		{-2111, 2722, "mods/grahamsperks/files/pickups/balloon.xml", true},
		{-1908, -56, "mods/grahamsperks/files/pixelscenes/text.xml"},
		{-1864, -53, "data/entities/items/pickup/moon.xml"},
		{2372, 530, "mods/grahamsperks/files/pixelscenes/hands.xml"},
		{2382, 550, "mods/grahamsperks/files/entities/goldblood.xml"},
		{-2221, 2564, "mods/grahamsperks/files/pixelscenes/hellblood.xml", true},
		{-2490, 6480, "mods/grahamsperks/files/pixelscenes/transmutatium.xml", true},
		{3921, 3100, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
		{3951, 3140, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
		{-14638, 13031, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
		{-14608, 13071, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
		{2318, 1870, "mods/grahamsperks/files/entities/eyechecker.xml", true},
		{4573, 528, "mods/grahamsperks/files/pixelscenes/eye.xml", true},
		{2000, 1735, "mods/grahamsperks/files/pixelscenes/closedeye.xml", true},
		{-5302, 575, "mods/grahamsperks/files/pixelscenes/materials.xml"},
		{-6760, 7424, "mods/grahamsperks/files/pixelscenes/yinyang.xml", true},
		{-6693, 7515, "mods/grahamsperks/files/entities/halo_checker.xml", true},
		{11537, 9956, "mods/grahamsperks/files/pixelscenes/water.xml"},
		{11537, 9986, "mods/grahamsperks/files/pickups/chest_immunity.xml"},
		{-317, -1673, "mods/grahamsperks/files/pixelscenes/island.xml"},
		{-278, -1580, "mods/grahamsperks/files/entities/fireplace_worse.xml"},
		{-46, -1550, "mods/grahamsperks/files/entities/books/cozybook.xml"},
		{4046, 12977, "mods/grahamsperks/files/pixelscenes/secret.xml", true},
		{4532, 13081, "mods/grahamsperks/files/entities/perk_spawners/map_spawner.xml"},
		{785, -1231, "mods/grahamsperks/files/entities/perk_spawners/map2_spawner.xml"},
		{3546, 13100, "mods/grahamsperks/files/entities/perk_spawners/slots_spawner.xml"},
		{14241, 16284, "mods/grahamsperks/files/entities/forge_item_check.xml", true},
		{4692, 652, "mods/grahamsperks/files/entities/tear_secret.xml", true},
		{14271, 16324, "mods/grahamsperks/files/pixelscenes/hand.xml", true},
		{-16295, -7140, "mods/grahamsperks/files/pixelscenes/home.xml"},
		{-16238, -6987, "data/entities/props/furniture_bed.xml"},
		{-16116, -7004, "data/entities/props/furniture_wood_table.xml"},
		{-16016, -7068, "mods/grahamsperks/files/pickups/chest_lost.xml"},
		{-16117, -7015, "mods/grahamsperks/files/pickups/chest_mini.xml"},
		{-16038, -7010, "mods/grahamsperks/files/entities/fireplace_worse.xml"},
		{7412, 6175, "mods/grahamsperks/files/pixelscenes/heart.xml", true},
		{12055, 2700, "mods/grahamsperks/files/pixelscenes/wealth.xml"},
		{12055, 2730, "mods/grahamsperks/files/entities/midas_curse.xml"},
		{1800, 6600, "mods/grahamsperks/files/pixelscenes/egg.xml", true},
		{1800, 6600, "mods/grahamsperks/files/pickups/egg.xml", true},
		{1800, 6600, "mods/grahamsperks/files/entities/books/eggbook.xml", true},
		{-11695, 600, "mods/grahamsperks/files/pixelscenes/stargazer.xml", true},
		{0, 60000, "mods/grahamsperks/files/pixelscenes/cat.xml", true},
		{0, -60000, "mods/grahamsperks/files/pixelscenes/cat2.xml", true},
		{3331, 1616, "mods/grahamsperks/files/entities/progress/progress.xml", true},
	})
	if ModIsEnabled("Apotheosis") then
		add_scene({{22770, -3333, "mods/grahamsperks/files/entities/perk_spawners/ll_spawner.xml"}})
	else
		add_scene({{15090, -3333, "mods/grahamsperks/files/entities/perk_spawners/ll_spawner.xml"}})
	end
end
