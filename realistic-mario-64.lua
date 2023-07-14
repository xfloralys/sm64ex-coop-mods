-- name: Realistic Mario 64
-- description: \\#ff0000\\Realistic Mario 64\\#ffffff\\\n\nImagine Mario if he actually adjusted to how real life works, now wouldn't that be crazy\n\nMod by \\#2b0013\\Dvk\\#ffffff\\.

local djui_hud_set_resolution = djui_hud_set_resolution
local djui_hud_set_font = djui_hud_set_font
local djui_hud_set_color = djui_hud_set_color
local djui_hud_print_text = djui_hud_print_text

local thirst = 100
local hunger = 100
local stamina = 100
local energy = 100
local timer = 0
local hurt_timer = 0
local prevLives = gMarioStates[0].numLives

---@param m MarioState
local function mario_update(m)
    if m.playerIndex ~= 0 then return end
    timer = timer + 1
    if timer % 75 == 0 then
        if thirst >= 0 then
            thirst = thirst - 1
        end
    end
    if timer % 200 == 0 then
        if hunger >= 0 then
            hunger = hunger - 1
        end
    end
    if timer % 500 == 0 then
        if energy >= 0 then
            energy = energy - 1
        end
    end
    if timer >= 10000 then
        djui_chat_message_create("Time for taxes! We're taking about 50% of your income.")
        m.numCoins = m.numCoins / 2
        timer = 0
    end
    if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
        if timer % 15 == 0 then
            thirst = thirst + 1
        end
    end
    if m.action == ACT_SLEEPING then
        if timer % 150 == 0 then
            energy = energy + 1
        end
    end
    if (m.action & ACT_FLAG_STATIONARY) == 0 then
        if timer % 15 == 0 then
            stamina = stamina - 1
        end
    else
        if timer % 7 == 0 then
            stamina = stamina + 1
        end
    end
    if m.numLives > prevLives then
        hunger = hunger + 10
        prevLives = m.numLives
    end
    if m.numLives < prevLives then
        prevLives = m.numLives
    end
    if thirst > 100 then
        thirst = 100
    end
    if hunger > 100 then
        hunger = 100
    end
    if stamina > 100 then
        stamina = 100
    end
    if energy > 100 then
        energy = 100
    end
    if thirst < 0 then
        thirst = 0
    end
    if hunger < 0 then
        hunger = 0
    end
    if stamina < 0 then
        stamina = 0
    end
    if energy < 0 then
        energy = 0
    end
    if thirst <= 0 or hunger <= 0 or stamina <= 0 or energy <= 0 then
        hurt_timer = hurt_timer + 1
        if hurt_timer % 30 == 0 then
            m.health = m.health - 256
            play_sound(SOUND_MARIO_ATTACKED, m.marioObj.header.gfx.cameraToObject)
        end
    end
end

local function on_death()
    hurt_timer = 0
    djui_chat_message_create("Well, you died. And guess what? You're dead permanently. At least until you rejoin.")
    repeat until false
end

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)

    djui_hud_set_color(0,0,255,255)
    djui_hud_print_text("THIRST", 10, 80, 0.5)
    djui_hud_print_text("(" .. tostring(thirst) .. " / 100)", 70, 80, 0.5)

    djui_hud_set_color(255,255,0,255)
    djui_hud_print_text("HUNGER", 10, 90, 0.5)
    djui_hud_print_text("(" .. tostring(hunger) .. " / 100)", 70, 90, 0.5)

    djui_hud_set_color(0,255,0,255)
    djui_hud_print_text("STAMINA", 10, 100, 0.5)
    djui_hud_print_text("(" .. tostring(stamina) .. " / 100)", 70, 100, 0.5)

    djui_hud_set_color(255,0,255,255)
    djui_hud_print_text("ENERGY", 10, 110, 0.5)
    djui_hud_print_text("(" .. tostring(energy) .. " / 100)", 70, 110, 0.5)
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_MARIO_UPDATE, mario_update)

if not network_is_server() then
    hook_event(HOOK_ON_DEATH, on_death)
end