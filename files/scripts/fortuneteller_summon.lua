dofile_once("data/scripts/lib/utilities.lua")
function interacting( player, me )
    local price = math.ceil(50 * 0.8 ^ tonumber(GlobalsGetValue( "GRAHAM_FORTUNETELLER_COUNT", "-1" )))
    local x, y = EntityGetTransform(player)
    local wallet = EntityGetFirstComponent(player, "WalletComponent") or 0
    local money = ComponentGetValue2(wallet, "money")
    if money >= price then
        ComponentSetValue2(wallet, "money", money - price)
        EntityLoad("data/entities/particles/poof_blue.xml", x, y)
        shoot_projectile( player, "mods/grahamsperks/files/pickups/crystal_ball.xml", x, y, 0, 0, false )
        GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/goldnugget/create", x, y)
        GamePrint("$graham_fortuneteller_log")
        GlobalsSetValue("graham_fortuneteller_frame", tostring(GameGetFrameNum()))
    else
        GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_denied", x, y)
        GamePrint("$graham_fortuneteller_cant")
    end
end