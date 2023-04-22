-- name: \\#ffff00\\Coin Rush Challenge
-- description: You lose coins every second, and if you hit 0 coins, you will start losing health instead.\n\nMod created by \\#400075\\Dvk/Floralys

local first_timer = 0 -- Gives you a 30 seconds head start
local timer = 0 -- Timer used to loop the torture every second
local verif = 0
local death_timer = 0

function messages()
    if verif == 0 then
        if first_timer < 900 then
            djui_chat_message_create("You have 30 seconds to run to the nearest level and get coins. Better hurry up!")
            verif = 1
        end
    end
    if verif == 1 then
        if first_timer >= 900 then
            djui_chat_message_create("Time's up! You better start learning from Wario!")
            verif = 2
        end
    end
end

function coinrush(m)
    if m.playerIndex ~= 0 then return end
    first_timer = first_timer + 1
    if first_timer >= 900 then -- Once the 30 seconds head start ends, begin torture
        timer = timer + 1
        if timer >= 30 then
            if m.numCoins > 0 then -- Drain 1 coin every second
                m.numCoins = m.numCoins - 1
                hud_set_value(HUD_DISPLAY_COINS, m.numCoins)
                timer = 0
            end
            if m.numCoins == 0 then
                m.health = m.health - 256 -- If Mario has no coins left, damage him
                timer = 0
            end
        end
    end
    if m.health < 256 then -- If Mario dies, reset both timers
        timer = 0
        first_timer = 0
        death_timer = death_timer + 1
        if death_timer >= 120 then
            verif = 0
            death_timer = 0
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, messages)
hook_event(HOOK_MARIO_UPDATE, coinrush)