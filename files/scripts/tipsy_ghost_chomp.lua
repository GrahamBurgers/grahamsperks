dofile_once( "data/scripts/lib/utilities.lua" )
local ghost = GetUpdatedEntityID()
local x, y = EntityGetTransform(ghost)

-- thanks to Wondible for this potion searching script!!

for _,id in pairs(EntityGetInRadiusWithTag(x, y, 15, "item_pickup")) do
    if EntityGetRootEntity(id) == id and EntityGetComponent( id, "PotionComponent" ) then
        local matid = GetMaterialInventoryMainMaterial( id )
        if matid == CellFactory_GetType("alcohol") or matid == CellFactory_GetType("sima") or matid == CellFactory_GetType("beer") or matid == CellFactory_GetType("molut") then
            local inv = EntityGetFirstComponentIncludingDisabled( id, "MaterialInventoryComponent" )
            if inv then
                local counts = ComponentGetValue2( inv, "count_per_material_type" )
                if counts then
                    local amount = counts[ matid+1 ]
                    local bar = 500
                    if amount >= bar then
                        -- spawn a new potion (33%)
                        SetRandomSeed(x, y)
                        if Random(1, 3) == 1 or GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then
                            EntityKill( id )
                            EntityLoad("data/entities/items/pickup/potion_empty.xml", x, y)
                        else
                            EntityKill( id )
                        end
                        -- burp
                        EntityLoad("mods/grahamsperks/files/entities/tipsy_ghost/circle_tipsy.xml", x, y)

                        ----- TIPSY GHOST REWARDS HERE -----

                        local player = EntityGetRootEntity(GetUpdatedEntityID())
                        local px, py = EntityGetTransform(player)
                        local damagemodels = EntityGetComponent( player, "DamageModelComponent" )
                        local health
                        local max_health
                        if( damagemodels ~= nil ) then
                            for i,v in ipairs(damagemodels) do
                                health = tonumber( ComponentGetValue2( v, "hp" ) )
                                max_health = tonumber( ComponentGetValue2 (v, "max_hp" ) )
                                break
                            end
                        end

                        local nearby_enemies = EntityGetInRadiusWithTag(x, y, 200, "destruction_target")
                        SetRandomSeed(x, y)
                        if health * 25 < 20 then
                            EntityLoad("data/entities/buildings/safe_haven_building.xml", px, py)
                            EntityLoad("data/entities/items/pickup/gourd.xml", px, py)
                        elseif #nearby_enemies > 2 then

                            for i in ipairs(nearby_enemies) do
                                local x2, y2 = EntityGetTransform(nearby_enemies[i])
                                local dir_x = x - x2
                                local dir_y = y - y2
                                shoot_projectile( player, "mods/grahamsperks/files/entities/tipsy_ghost/tipsy_shot.xml", x, y, dir_x * -4, dir_y * -4)
                            end

                        elseif max_health * 25 < 400 and Random(1, 6) == 1 then
                            EntityLoad("data/entities/items/pickup/heart.xml", x, y)
                        elseif #nearby_enemies > 0 then
                            shoot_projectile( player, "mods/grahamsperks/files/spells/circle_sweet.xml", x, y, 0, 0 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, 90, 120 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, 60, 170 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, -90, 120 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, -60, 170 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, -30, 210 )
                            shoot_projectile( player, "mods/grahamsperks/files/spells/rainbow.xml", x, y, 30, 210 )
                        else
                            local rnd = Random(1, 5)
                            if rnd == 1 then
                                EntityAddComponent2(ghost,"LuaComponent",
                                {
                                    _enabled = 1,
                                    script_source_file="mods/grahamsperks/files/scripts/tipsy_barrage.lua",
                                    execute_every_n_frame= 25,
                                    execute_times= 20,
                                })
                            elseif rnd == 2 then
                                EntityLoad("data/entities/projectiles/deck/xray.xml", x, y)
                            elseif rnd == 3 then
                                EntityLoad("mods/grahamsperks/files/entities/coffee.xml", x, y)
                            elseif rnd == 4 then
                                EntityLoad("data/entities/items/pickup/goldnugget_200.xml", x, y)
                            elseif rnd == 5 then
                                EntityLoad("data/entities/projectiles/egg_red.xml", x+10, y+10)
                                EntityLoad("data/entities/projectiles/egg_red.xml", x+10, y-10)
                                EntityLoad("data/entities/projectiles/egg_red.xml", x-10, y+10)
                                EntityLoad("data/entities/projectiles/egg_slime.xml", x-10, y-10)
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end