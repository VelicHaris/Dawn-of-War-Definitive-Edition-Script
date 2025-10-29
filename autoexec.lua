-- === Key Bindings ===
bind("F1", "toggle_fog()")
bind("F2", "give_resources()")
bind("F3", "switch_player_control()")
bind("F4", "toggle_instant_build()")
bind("F5", "setsimrate(5)")
bind("F6", "setsimrate(8)")
bind("F7", "setsimrate(40)")
bind("F8", "toggle_fow()")
bind("F9", "toggle_screenmode()")

-- === State Variables ===
instant_build = false
fow_mode = 0
screen_mode_switch = true

-- === Functions ===

-- F1: Toggle Fog
function toggle_fog()
    fog_toggle()
end

-- F2: Give resources to the local player
function give_resources()
    local local_player_index = Tut_GetLocalPlayerIndex()
    local player = World_GetPlayerAt(local_player_index)
    if player then
        local player_race = Player_GetRaceName(player)
        if player_race == "necron_race" then
            Player_SetResource(player, RT_Power, 100000)
        else
            Player_SetResource(player, RT_Requisition, 100000)
            Player_SetResource(player, RT_Power, 100000)
        end
    end
end

-- F3: Switch player control between CPU and player
function switch_player_control()
    local player = World_GetPlayerAt(Tut_GetLocalPlayerIndex())
    if Cpu_IsCpuPlayer(player) then
        W40k_SwitchToPlayer(player, true)
    else
        Cpu_ControlLocalPlayer()
    end
end

-- F4: Toggle Instant Build
function toggle_instant_build()
    if instant_build then
        sd_instant_build = 0
        instant_build = false
    else
        sd_instant_build = 1
        instant_build = true
    end
end

-- F8: Toggle Fog of War
function toggle_fow()
    if fow_mode == 0 then
        FOW_RevealAll()
        fow_mode = 1
    else
        FOW_Reset()
        fow_mode = 0
    end
end

-- F9: Toggle Screen Mode (hide/show UI)
function toggle_screenmode()
    if screen_mode_switch then
        screen_mode_switch = false
        taskbar_hide()
    else
        screen_mode_switch = true
        taskbar_show()
        message_hide()
    end
end