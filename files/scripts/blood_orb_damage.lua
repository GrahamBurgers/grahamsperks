---@diagnostic disable: param-type-mismatch
dofile_once("data/scripts/lib/utilities.lua")

function damage_received( dmg, msg, source )
	local me = GetUpdatedEntityID()
	local x, y = EntityGetTransform(me)
	
	local damage = EntityGetFirstComponentIncludingDisabled(me, "DamageModelComponent")

	if source == EntityGetParent(me) then dmg = 0 end
	if damage ~= nil and dmg > 0 then
		local max_hp = ComponentGetValue2(damage, "max_hp")
		local hp = ComponentGetValue2(damage, "hp") - dmg
		
		if ( source ~= nil ) and ( source ~= NULL_ENTITY ) and ( source ~= me ) and damage > 0 then
			local hm = EntityGetTransform( source )
			
			if ( hm ~= nil ) and (hp > 0) then
				dmg = dmg * 1.5
				EntityInflictDamage( source, dmg, "DAMAGE_CURSE", "$damage_orb_blood", "BLOOD_SPRAY", 0, 0, me )
			end
		end

		-- SPRITE LOGIC

		local spritecomp = EntityGetFirstComponentIncludingDisabled(me, "SpriteComponent")
		if spritecomp ~= nil then
			local current_sprite = ComponentGetValue2(spritecomp, "image_file")
			local to_switch

			EntitySetComponentsWithTagEnabled(me, "graham_bloodorb", true)

			EntityAddChild(EntityGetParent(me), EntityLoad("mods/grahamsperks/files/effects/protection_all_short.xml", x, y))
			if hp > max_hp * 0.75 then
				to_switch = "eye1"
			elseif hp > max_hp * 0.50 then
				to_switch = "eye2"
			elseif hp > max_hp * 0.25 then
				to_switch = "eye3"
			elseif hp > 0 then
				to_switch = "eye4"
			else
				to_switch = "eye5"
				EntitySetComponentsWithTagEnabled(me, "graham_bloodorb", false)
			end

			if GameHasFlagRun("PERK_PICKED_MPP_CYBORG_FRIENDS") then
				to_switch = to_switch .. "_robotic"
			end
			ComponentSetValue2(spritecomp, "image_file", "mods/grahamsperks/files/entities/eye/" .. to_switch .. ".png")
			EntityRefreshSprite(me, spritecomp)
			EntityAddComponent2(me, "LuaComponent", {
				remove_after_executed=true,
				script_source_file="mods/grahamsperks/files/scripts/refresh.lua"
			})
		end
	end
end