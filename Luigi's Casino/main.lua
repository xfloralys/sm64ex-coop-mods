-- name: Luigi's Casino
-- description: \\#007700\\Luigi's Casino\\#ffffff\\\n\nWelcome to Luigi's Casino, hosted by Luigi himself and featuring the nostalgic Picture Poker game! It's time to test your gambling skills (or luck)... but remember, don't gamble in real life! That's a really bad idea. No, seriously. This version includes the base game and a shop with customizable cloth colors.\n\nMod by \\#2b0013\\Floralys\\#ffffff\\, submitted for the August 2023 Gamemode Competition.

for m, n in pairs(gActiveMods) do
    if m > 0 then
        djui_popup_create("\\#ff0000\\Luigi's Casino can only be played on its own. Please disable every other mod.", 2)
        return 0
    end
end

if mod_storage_load("Coins") == nil then
	mod_storage_save("Coins", "100")
end
if mod_storage_load("Level") == nil then
    mod_storage_save("Level", "1")
end
if mod_storage_load("AlltimeLevels") == nil then
    mod_storage_save("AlltimeLevels", "1")
end
if mod_storage_load("PlayerTitle1") == nil then
    mod_storage_save("PlayerTitle1", "0")
end
if mod_storage_load("PlayerTitle2") == nil then
    mod_storage_save("PlayerTitle2", "0")
end
if mod_storage_load("BGBluePurchased") == nil then
    mod_storage_save("BGBluePurchased", "0")
end
if mod_storage_load("BGBrownPurchased") == nil then
    mod_storage_save("BGBrownPurchased", "0")
end
if mod_storage_load("BGCyanPurchased") == nil then
    mod_storage_save("BGCyanPurchased", "0")
end
if mod_storage_load("BGGrayPurchased") == nil then
    mod_storage_save("BGGrayPurchased", "0")
end
if mod_storage_load("BGOrangePurchased") == nil then
    mod_storage_save("BGOrangePurchased", "0")
end
if mod_storage_load("BGPinkPurchased") == nil then
    mod_storage_save("BGPinkPurchased", "0")
end
if mod_storage_load("BGPurplePurchased") == nil then
    mod_storage_save("BGPurplePurchased", "0")
end
if mod_storage_load("BGRedPurchased") == nil then
    mod_storage_save("BGRedPurchased", "0")
end
if mod_storage_load("BGYellowPurchased") == nil then
    mod_storage_save("BGYellowPurchased", "0")
end

local coins = tonumber(mod_storage_load("Coins"))
local level = tonumber(mod_storage_load("Level"))
local alltime_levels = tonumber(mod_storage_load("AlltimeLevels"))
local player_title1 = tonumber(mod_storage_load("PlayerTitle1"))
local player_title2 = tonumber(mod_storage_load("PlayerTitle2"))
local bought_bg_blue = tonumber(mod_storage_load("BGBluePurchased"))
local bought_bg_brown = tonumber(mod_storage_load("BGBrownPurchased"))
local bought_bg_cyan = tonumber(mod_storage_load("BGCyanPurchased"))
local bought_bg_gray = tonumber(mod_storage_load("BGGrayPurchased"))
local bought_bg_orange = tonumber(mod_storage_load("BGOrangePurchased"))
local bought_bg_pink = tonumber(mod_storage_load("BGPinkPurchased"))
local bought_bg_purple = tonumber(mod_storage_load("BGPurplePurchased"))
local bought_bg_red = tonumber(mod_storage_load("BGRedPurchased"))
local bought_bg_yellow = tonumber(mod_storage_load("BGYellowPurchased"))
gPlayerSyncTable[gMarioStates[0].playerIndex].is_dev = false
gPlayerSyncTable[gMarioStates[0].playerIndex].is_contributor = false
local dev = "\\#00ffff\\[Dev] \\#ffffff\\"
local contributor = "\\#7f0037\\[Contributor] \\#ffffff\\"
local rendered_luigi = math.random(1, 20)
local show_saved_data = true
local first_popup = false

local casino_green = get_texture_info("LCrender6")
local music = audio_stream_load("Music.mp3")
local canvas = get_texture_info("cards")
local luigi_texture = get_texture_info("ohmygodluigi")
local luigi_texture2 = get_texture_info("luigi2")
local arrow = get_texture_info("arrow")
local cloth = get_texture_info("cloth")

local cutscene_timer = 0
--local cutscene_drawing_timer = 0
local luigi_timer = 0
local end_timer = 0
--local cutscene_drawing = false
local has_drawn = false
local has_held = false
local selected_card = 1
local outline_posx = 6
local level_x = 0
local show_info = true
local menu_created = false
local menu_selected = 1
local actual_bg_selection = 1
local update_timer = 0

local cloud = 0
local mushroom = 0
local flower = 0
local luigi = 0
local mario = 0
local star = 0
local checked_player_cards = false
local checked_luigi_cards = false
local player_rank = 0
local luigi_rank = 0
local ranked = false
local victory = false
local tie = false
local loss = false
local forced_bet = 0
local additional_bets = 0
local first_bet = false
local warped = false
local total_bet = 0
local coin_multiplier = 0
local awarded_coins = false
local amount_chosen = false
local given_coins = 0
local play_win_fanfare = false
local played_loss_sound = false
local played_tie_sound = false

local player_deck = {}
local selected = {false, false, false, false, false}
local luigi_deck = {}
local player_deck_created = false
local show_luigi_cards = false

local bought_bgs = {1, bought_bg_blue, bought_bg_brown, bought_bg_cyan, bought_bg_gray, bought_bg_orange, bought_bg_pink, bought_bg_purple, bought_bg_red, bought_bg_yellow}
local cards_x = {0, 64, 128, 192, 0, 64}
local cards_y = {0, 0, 0, 0, 64, 64}
local cards_height = {40, 40, 40, 40, 40}
local titles = {"\\#dcdcdc\\[Newbie]\\#ffffff\\", "\\#00ff00\\[Beginner]\\#ffffff\\", "\\#777777\\[Novice]\\#ffffff\\", "\\#7777ff\\[Hobbyist]\\#ffffff\\", "\\#ff7777\\[Advanced Gambler]\\#ffffff\\",
                "\\#ff2222\\[Professional Gambler]\\#ffffff\\", "\\#ff00ff\\[Master Gambler]\\#ffffff\\", "\\#7700ff\\[Expert Gambler]\\#ffffff\\",
                "\\#121212\\[Broke]\\#ffffff\\", "\\#aaaaaa\\[Poor]\\#ffffff\\", "\\#ffff77\\[Middle Class]\\#ffffff\\", "\\#00ff33\\[Rich]\\#ffffff\\",
                "\\#ff7700\\[Economy Crusher]\\#ffffff\\", "\\#ffff00\\[Wario's Greed]\\#ffffff\\", "\\#ff7700\\[Gambling Addict]\\#ffffff\\", "\\#0000ff\\[Luxurious Player]\\#ffffff\\",
                "\\#ffff00\\[Made Out Of Gold]\\#ffffff\\", "\\#00ffff\\[Made Out Of Diamonds!]\\#ffffff\\", "\\#007700\\[Foreshadowed Millionaire]\\#ffffff\\", "\\#ff77ff\\[Financial Disaster]\\#ffffff\\",
                "\\#77ff00\\[Simply Too Rich]\\#ffffff\\", "\\#00ff77\\[Wildest Dreams]\\#ffffff\\", "\\#ff0000\\[Cause For Bankruptcy]\\#ffffff\\", "\\#ff0000\\[Number One Player]\\#ffffff\\",
                "\\#770077\\[Gambling Champion]\\#ffffff\\", "\\#991e51\\[Worldwide Champion]\\#ffffff\\", "\\#770000\\[Unstoppable]\\#ffffff\\", "\\#333333\\[Clinically Insane]\\#ffffff\\",
                "\\#009954\\[Not Enough Stars!]\\#ffffff\\", "\\#30003d\\[Broke The Game]\\#ffffff\\", "\\#111111\\[Seriously Needs A Break]\\#ffffff\\"}
local shop_products = {"Green Cloth", "Blue Cloth", "Brown Cloth", "Cyan Cloth", "Gray Cloth", "Orange Cloth", "Pink Cloth", "Purple Cloth", "Red Cloth", "Yellow Cloth"}
local r = {0, 0, 104, 0, 255, 255, 255, 128, 255, 255}
local g = {255, 0, 52, 255, 255, 128, 100, 0, 0, 255}
local b = {32, 255, 0, 255, 255, 0, 100, 128, 0, 0}

local function on_hud_render()
    update_timer = update_timer + 1
    if update_timer % 1800 == 0 then
        mod_storage_save("Coins", tostring(coins))
        mod_storage_save("Level", tostring(level))
        mod_storage_save("AlltimeLevels", tostring(alltime_levels))
        mod_storage_save("PlayerTitle1", tostring(gPlayerSyncTable[0].rank1))
        mod_storage_save("PlayerTitle2", tostring(gPlayerSyncTable[0].rank2))
        mod_storage_save("BGBluePurchased", tostring(bought_bgs[2]))
        mod_storage_save("BGBrownPurchased", tostring(bought_bgs[3]))
        mod_storage_save("BGCyanPurchased", tostring(bought_bgs[4]))
        mod_storage_save("BGGrayPurchased", tostring(bought_bgs[5]))
        mod_storage_save("BGOrangePurchased", tostring(bought_bgs[6]))
        mod_storage_save("BGPinkPurchased", tostring(bought_bgs[7]))
        mod_storage_save("BGPurplePurchased", tostring(bought_bgs[8]))
        mod_storage_save("BGRedPurchased", tostring(bought_bgs[9]))
        mod_storage_save("BGYellowPurchased", tostring(bought_bgs[10]))
        if show_saved_data then
            if not first_popup then
                djui_popup_create("\\#00ff00\\Data saved!\\#ffffff\\\nYou can turn these pop-ups off by\ntyping '/popups off'.", 3)
                first_popup = true
            else
                djui_popup_create("\\#00ff00\\Data saved!\\#ffffff\\", 1)
            end
        end
        update_timer = 0
    end
    play_music(0, 0, 0)
    if not warped then
        warp_to_level(6, 1, 0)
        warped = true
    end
    audio_stream_play(music, false, 1)
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(0, 0, 0, 255)
    djui_hud_render_rect(0, 0, 3000, 3000)
    djui_hud_set_color(255, 255, 255, 255)
    --djui_hud_render_texture(casino_bgs[actual_bg_selection], 0, 0, djui_hud_get_screen_width() / 1024, djui_hud_get_screen_height() / 1024)
    djui_hud_render_texture(casino_green, 0, 0, djui_hud_get_screen_width() / 1024, djui_hud_get_screen_height() / 1024)
    djui_hud_set_color(r[actual_bg_selection], g[actual_bg_selection], b[actual_bg_selection], 255)
    djui_hud_render_texture(cloth, 0, 0, djui_hud_get_screen_width() / 1024, djui_hud_get_screen_height() / 1024)
    djui_hud_set_color(255, 255, 255, 255)
    if rendered_luigi == 15 then
        djui_hud_render_texture(luigi_texture2, djui_hud_get_screen_width() / 3 + 25, 13.8, 0.2, 0.2)
    else
        djui_hud_render_texture(luigi_texture, djui_hud_get_screen_width() / 3 + 25, 13.8, 0.2, 0.2)
    end
    djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width()/2 - 85, djui_hud_get_screen_height()/2 + 0.5, 0.5, 0.5)
    djui_hud_render_texture(gTextures.star, djui_hud_get_screen_width()/2 + 68, djui_hud_get_screen_height()/2 - 30.5, 1, 1)
    djui_hud_set_font(FONT_HUD)
    if level < 10 then
        level_x = 0
    elseif level >= 10 and level < 100 then
        level_x = 4
    elseif level == 100 then
        level = 0
    end
    djui_hud_set_color(0, 255, 255, 255)
    local check_100s = alltime_levels
    local count = 0
    for i = 1, 8 do
        if check_100s >= 100 then
            check_100s = check_100s - 100
            count = count + 1
        end
    end
    for i = 1, count do
        djui_hud_render_texture(gTextures.star, djui_hud_get_screen_width()/2 + 72, djui_hud_get_screen_height()/2 - 30.5 - (i * 10), 0.5, 0.5)
    end
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(tostring(coins), djui_hud_get_screen_width()/2 - 76, djui_hud_get_screen_height()/2 + 0.5, 0.5)
    djui_hud_print_text(tostring(level), (djui_hud_get_screen_width()/2 + 71) - level_x, djui_hud_get_screen_height()/2 - 27, 0.65)
    gMarioStates[0].action = ACT_IDLE
    gMarioStates[0].freeze = 1

    if show_info then
        djui_hud_set_font(FONT_NORMAL)
        djui_hud_set_color(0, 128, 0, 255)
        djui_hud_print_text("Luigi's Casino", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 235, 0.35)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("Here are some instructions on how to play.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 215, 0.25)
        djui_hud_print_text("Once your cards are visible, you can select them using the", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 207.5, 0.25)
        djui_hud_print_text("D-Pad and by pressing A afterwards. You can deselect them", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 200, 0.25)
        djui_hud_print_text("by pressing A again.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 192.5, 0.25)
        djui_hud_print_text("You can hold your current cards by pressing Y, or you can", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 177.5, 0.25)
        djui_hud_print_text("draw new ones by pressing Y after selecting the cards you", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 170, 0.25)
        djui_hud_print_text("wish to replace.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 162.5, 0.25)
        djui_hud_print_text("Each card has its own value in order from weakest to", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 147.5, 0.25)
        djui_hud_print_text("strongest; cloud, mushroom, fire flower, Luigi, Mario, star.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 140, 0.25)
        djui_hud_print_text("They will often determine whether you win or lose.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 132.5, 0.25)
        djui_hud_print_text("You can bet up to 5 coins using the L trigger. If you win,", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 117.5, 0.25)
        djui_hud_print_text("they will be multiplied by how much your hand is worth.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 110, 0.25)
        djui_hud_print_text("The higher your level is, the more you'll be forced to bet.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 102.5, 0.25)
        djui_hud_print_text("You can hide this menu by typing '/hide_info'.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 87.5, 0.25)
        djui_hud_print_text("You can also show it again by typing '/show_info'.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 80, 0.25)
        djui_hud_print_text("You can manually save data by typing '/save'.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 72.5, 0.25)
        djui_hud_print_text("The player list shows everyone's coin count.", (djui_hud_get_screen_width()/3)*2.10, djui_hud_get_screen_height() - 57.5, 0.25)
    end

    if gMarioStates[0].controller.buttonPressed & R_TRIG ~= 0 then
        if not menu_created then
            menu_created = true
            play_sound(SOUND_MENU_PAUSE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        else
            menu_created = false
            play_sound(SOUND_MENU_PAUSE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        end
    end
    if not menu_created then
        djui_hud_set_color(0, 255, 255, 255)
        djui_hud_print_text("Press the R button to open the shop.", (djui_hud_get_screen_width()/3)*0.15, djui_hud_get_screen_height() - 235, 0.3)
        djui_hud_set_color(255, 255, 255, 255)
    elseif menu_created then
        djui_hud_set_color(0, 255, 255, 255)
        djui_hud_print_text("Press the R button to close the shop.", (djui_hud_get_screen_width()/3)*0.15 - 1, djui_hud_get_screen_height() - 235, 0.3)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("Move the cursor up and down using the D-Pad. You will then", (djui_hud_get_screen_width()/3)*0.05 - 2, djui_hud_get_screen_height() - 65, 0.25)
        djui_hud_print_text("be able to purchase what you selected by pressing A.", (djui_hud_get_screen_width()/3)*0.05 + 3, djui_hud_get_screen_height() - 57.5, 0.25)
        djui_hud_render_texture(arrow, (djui_hud_get_screen_width()/3)*0.1, djui_hud_get_screen_height() - (215 - (10*menu_selected)), 1, 1)
        for i = 1, 10 do
            if bought_bgs[i] == 0 then
                djui_hud_render_texture(gTextures.coin, (djui_hud_get_screen_width()/3)*0.6, djui_hud_get_screen_height() - (215 - (i*10)), 0.5, 0.5)
                djui_hud_set_font(FONT_HUD)
                djui_hud_print_text("300", (djui_hud_get_screen_width()/3)*0.65 + 2, djui_hud_get_screen_height() - (215 - (i*10)), 0.5)
                djui_hud_set_font(FONT_NORMAL)
            else
                if i == actual_bg_selection then
                    djui_hud_set_color(0, 255, 0, 255)
                    djui_hud_print_text("Selected", (djui_hud_get_screen_width()/3)*0.6, djui_hud_get_screen_height() - (215 - (i*10)), 0.25)
                    djui_hud_set_color(255, 255, 255, 255)
                else
                    djui_hud_print_text("Select", (djui_hud_get_screen_width()/3)*0.6, djui_hud_get_screen_height() - (215 - (i*10)), 0.25)
                end
            end
            djui_hud_print_text(shop_products[i], (djui_hud_get_screen_width()/3)*0.3, djui_hud_get_screen_height() - (215 - ((i)*10)), 0.25)
        end
        if gMarioStates[0].controller.buttonPressed & U_JPAD ~= 0 then
            if menu_selected > 1 then
                menu_selected = menu_selected - 1
                play_sound(SOUND_MENU_CHANGE_SELECT, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            end
        end
        if gMarioStates[0].controller.buttonPressed & D_JPAD ~= 0 then
            if menu_selected < 10 then
                menu_selected = menu_selected + 1
                play_sound(SOUND_MENU_CHANGE_SELECT, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            end
        end
        if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 then
            for i = 1, 10 do
                if i == menu_selected then
                    if coins >= 300 then
                        if bought_bgs[i] == 0 then
                            coins = coins - 300
                            bought_bgs[i] = 1
                        end
                    end
                    if bought_bgs[i] == 1 then
                        actual_bg_selection = i
                        play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                    else
                        play_sound(SOUND_MENU_CAMERA_BUZZ, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                    end
                end
            end
        end
    end

    if alltime_levels < 5 then
        player_title1 = 0
    elseif alltime_levels >= 5 and alltime_levels < 10 then
        player_title1 = 1
    elseif alltime_levels >= 10 and alltime_levels < 25 then
        player_title1 = 2
    elseif alltime_levels >= 25 and alltime_levels < 50 then
        player_title1 = 3
    elseif alltime_levels >= 50 and alltime_levels < 75 then
        player_title1 = 4
    elseif alltime_levels >= 75 and alltime_levels < 100 then
        player_title1 = 5
    elseif alltime_levels >= 100 and alltime_levels < 150 then
        player_title1 = 6
    elseif alltime_levels >= 150 and alltime_levels < 200 then
        player_title1 = 7
    elseif alltime_levels >= 200 and alltime_levels < 300 then
        player_title1 = 14
    elseif alltime_levels >= 300 and alltime_levels < 400 then
        player_title1 = 23
    elseif alltime_levels >= 400 and alltime_levels < 500 then
        player_title1 = 24
    elseif alltime_levels >= 500 and alltime_levels < 600 then
        player_title1 = 25
    elseif alltime_levels >= 600 and alltime_levels < 700 then
        player_title1 = 26
    elseif alltime_levels >= 700 and alltime_levels < 800 then
        player_title1 = 27
    elseif alltime_levels >= 800 and alltime_levels < 900 then
        player_title1 = 28
    elseif alltime_levels >= 900 and alltime_levels < 1000 then
        player_title1 = 29
    elseif alltime_levels >= 1000 then
        player_title1 = 30
    end
    if coins < 75 then
        player_title2 = 8
    elseif coins >= 75 and coins < 150 then
        player_title2 = 9
    elseif coins >= 150 and coins < 500 then
        player_title2 = 10
    elseif coins >= 500 and coins < 1000 then
        player_title2 = 11
    elseif coins >= 1000 and coins < 2500 then
        player_title2 = 12
    elseif coins >= 2500 and coins < 5000 then
        player_title2 = 13
    elseif coins >= 5000 and coins < 7500 then
        player_title2 = 15
    elseif coins >= 7500 and coins < 10000 then
        player_title2 = 16
    elseif coins >= 10000 and coins < 15000 then
        player_title2 = 17
    elseif coins >= 15000 and coins < 20000 then
        player_title2 = 18
    elseif coins >= 20000 and coins < 35000 then
        player_title2 = 19
    elseif coins >= 35000 and coins < 50000 then
        player_title2 = 20
    elseif coins >= 50000 and coins < 100000 then
        player_title2 = 21
    elseif coins >= 100000 then
        player_title2 = 22
    end

    if alltime_levels < 10 then
        forced_bet = 1
    elseif alltime_levels >= 10 and alltime_levels < 15 then
        forced_bet = 2
    elseif alltime_levels >= 15 and alltime_levels < 20 then
        forced_bet = 3
    elseif alltime_levels >= 20 and alltime_levels < 30 then
        forced_bet = 4
    elseif alltime_levels >= 30 then
        forced_bet = 5
    end

    local posx = 6
    local coin_posx = 15

    if not player_deck_created then
        if cutscene_timer < 100 then
            cutscene_timer = cutscene_timer + 1
        end
        for i = 1, (forced_bet + additional_bets) do
            djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width()/48 * coin_posx, djui_hud_get_screen_height()/2 - 10, 0.5, 0.5)
            coin_posx = coin_posx + 1
            if not first_bet then
                if alltime_levels < 10 then
                    coins = coins - 1
                elseif alltime_levels >= 10 and alltime_levels < 15 then
                    coins = coins - 2
                elseif alltime_levels >= 15 and alltime_levels < 20 then
                    coins = coins - 3
                elseif alltime_levels >= 20 and alltime_levels < 30 then
                    coins = coins - 4
                elseif alltime_levels >= 30 then
                    coins = coins - 5
                end
                play_sound(SOUND_GENERAL_COIN_DROP, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                first_bet = true
            end
        end
        if cutscene_timer < 80 then
            for i = 0,4 do
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 40), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                posx = posx + 1
            end
        end
        posx = 6
        if cutscene_timer >= 80 and cutscene_timer < 88 then
            for i = 0,4 do
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 40), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 192, 65, 64, 64)
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                posx = posx + 1
            end
            posx = 6
        end
        if cutscene_timer >= 88 and cutscene_timer < 96 then
            for i = 0,4 do
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 40), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 0, 129, 64, 64)
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                posx = posx + 1
            end
            posx = 6
        end
        if cutscene_timer >= 96 then
            for i = 0,4 do
                local c = math.random(1,6)
                local d = math.random(1,6)
                table.insert(player_deck, c)
                table.insert(luigi_deck, d)
                posx = posx + 1
            end
            player_deck_created = true
        end
    end

    posx = 6
    coin_posx = 15
    if player_deck_created then
        total_bet = forced_bet + additional_bets
        for i = 1, (forced_bet + additional_bets) do
            djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width()/48 * coin_posx, djui_hud_get_screen_height()/2 - 10, 0.5, 0.5)
            coin_posx = coin_posx + 1
        end
        if not show_luigi_cards then
            for i, j in ipairs(luigi_deck) do
                djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                posx = posx + 1
            end
        end
        posx = 6
        for i, j in ipairs(player_deck) do
            djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - cards_height[i]), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, cards_x[j], cards_y[j], 64, 64)
            posx = posx + 1
        end
        if not has_drawn and not menu_created then
            if gMarioStates[0].controller.buttonPressed & L_TRIG ~= 0 then
                if total_bet < 5 and coins > 0 then
                    additional_bets = additional_bets + 1
                    coins = coins - 1
                    play_sound(SOUND_GENERAL_COIN_DROP, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                end
            end
            if gMarioStates[0].controller.buttonPressed & R_JPAD ~= 0 then
                if selected_card < 5 then
                    selected_card = selected_card + 1
                    outline_posx = outline_posx + 1
                    play_sound(SOUND_TERRAIN_GRASS, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                end
            end
            if gMarioStates[0].controller.buttonPressed & L_JPAD ~= 0 then
                if selected_card > 1 then
                    selected_card = selected_card - 1
                    outline_posx = outline_posx - 1
                    play_sound(SOUND_TERRAIN_GRASS, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                end
            end
            djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*outline_posx),(djui_hud_get_screen_height() - cards_height[selected_card]), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 64, 128, 64, 64)
            if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 then
                if cards_height[selected_card] ~= 50 then
                    cards_height[selected_card] = 50
                    selected[selected_card] = true
                    play_sound(SOUND_MENU_MESSAGE_APPEAR, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                else
                    cards_height[selected_card] = 40
                    selected[selected_card] = false
                    play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                end
            end
            if gMarioStates[0].controller.buttonPressed & Y_BUTTON ~= 0 then
                local check = 0
                play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                for i, j in ipairs(selected) do
                    if selected[i] then
                        player_deck[i] = math.random(1,6)
                        selected[i] = false
                        cards_height[i] = 40
                    else
                        check = check + 1
                    end
                end
                if check == 5 then
                    has_held = true
                end
                has_drawn = true
            end
        end
        if has_drawn then
            if luigi_timer < 50 then
                luigi_timer = luigi_timer + 1
            end
            show_luigi_cards = true
            posx = 6
            if luigi_timer < 32 then
                for i = 0,4 do
                    djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 128, 64, 64, 64)
                    posx = posx + 1
                end
            end
            posx = 6
            if luigi_timer >= 32 and luigi_timer < 40 then
                for i = 0,4 do
                    djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 192, 64, 64, 64)
                    posx = posx + 1
                end
            end
            posx = 6
            if luigi_timer >= 40 and luigi_timer < 48 then
                for i = 0,4 do
                    djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, 0, 128, 64, 64)
                    posx = posx + 1
                end
            end
            posx = 6
            if luigi_timer >= 48 then
                for i, j in ipairs(luigi_deck) do
                    djui_hud_render_texture_tile(canvas, ((djui_hud_get_screen_width()/16)*posx),(djui_hud_get_screen_height() - 110), djui_hud_get_screen_width()/1024, djui_hud_get_screen_height()/512, cards_x[j], cards_y[j], 64, 64)
                    posx = posx + 1
                end
            end
            if luigi_timer >= 49 then
                if not ranked then
                    cloud, mushroom, flower, luigi, mario, star = 0, 0, 0, 0, 0, 0
                    if not checked_player_cards then
                        for j, i in ipairs(player_deck) do
                            if player_deck[j] == 1 then
                                cloud = cloud + 1
                            elseif player_deck[j] == 2 then
                                mushroom = mushroom + 1
                            elseif player_deck[j] == 3 then
                                flower = flower + 1
                            elseif player_deck[j] == 4 then
                                luigi = luigi + 1
                            elseif player_deck[j] == 5 then
                                mario = mario + 1
                            elseif player_deck[j] == 6 then
                                star = star + 1
                            end
                        end
                        checked_player_cards = true
                    end

                    if cloud == 2 then
                        player_rank = 1
                    end
                    if mushroom == 2 then
                        player_rank = 2
                    end
                    if flower == 2 then
                        player_rank = 3
                    end
                    if luigi == 2 then
                        player_rank = 4
                    end
                    if mario == 2 then
                        player_rank = 5
                    end
                    if star == 2 then
                        player_rank = 6
                    end

                    if cloud == 2 and mushroom == 2 then
                        player_rank = 7
                    end
                    if cloud == 2 and flower == 2 then
                        player_rank = 8
                    end
                    if cloud == 2 and luigi == 2 then
                        player_rank = 10
                    end
                    if cloud == 2 and mario == 2 then
                        player_rank = 13
                    end
                    if cloud == 2 and star == 2 then
                        player_rank = 17
                    end
                    if mushroom == 2 and flower == 2 then
                        player_rank = 9
                    end
                    if mushroom == 2 and luigi == 2 then
                        player_rank = 11
                    end
                    if mushroom == 2 and mario == 2 then
                        player_rank = 14
                    end
                    if mushroom == 2 and star == 2 then
                        player_rank = 18
                    end
                    if flower == 2 and luigi == 2 then
                        player_rank = 12
                    end
                    if flower == 2 and mario == 2 then
                        player_rank = 15
                    end
                    if flower == 2 and star == 2 then
                        player_rank = 19
                    end
                    if luigi == 2 and mario == 2 then
                        player_rank = 16
                    end
                    if luigi == 2 and star == 2 then
                        player_rank = 20
                    end
                    if mario == 2 and star == 2 then
                        player_rank = 21
                    end

                    if cloud == 3 then
                        player_rank = 22
                    end
                    if mushroom == 3 then
                        player_rank = 23
                    end
                    if flower == 3 then
                        player_rank = 24
                    end
                    if luigi == 3 then
                        player_rank = 25
                    end
                    if mario == 3 then
                        player_rank = 26
                    end
                    if star == 3 then
                        player_rank = 27
                    end

                    if cloud == 3 and mushroom == 2 then
                        player_rank = 28
                    end
                    if cloud == 3 and flower == 2 then
                        player_rank = 29
                    end
                    if cloud == 3 and luigi == 2 then
                        player_rank = 30
                    end
                    if cloud == 3 and mario == 2 then
                        player_rank = 31
                    end
                    if cloud == 3 and star == 2 then
                        player_rank = 32
                    end
                    if mushroom == 3 and cloud == 2 then
                        player_rank = 33
                    end
                    if mushroom == 3 and flower == 2 then
                        player_rank = 34
                    end
                    if mushroom == 3 and luigi == 2 then
                        player_rank = 35
                    end
                    if mushroom == 3 and mario == 2 then
                        player_rank = 36
                    end
                    if mushroom == 3 and star == 2 then
                        player_rank = 37
                    end
                    if flower == 3 and cloud == 2 then
                        player_rank = 38
                    end
                    if flower == 3 and mushroom == 2 then
                        player_rank = 39
                    end
                    if flower == 3 and luigi == 2 then
                        player_rank = 40
                    end
                    if flower == 3 and mario == 2 then
                        player_rank = 41
                    end
                    if flower == 3 and star == 2 then
                        player_rank = 42
                    end
                    if luigi == 3 and cloud == 2 then
                        player_rank = 43
                    end
                    if luigi == 3 and mushroom == 2 then
                        player_rank = 44
                    end
                    if luigi == 3 and flower == 2 then
                        player_rank = 45
                    end
                    if luigi == 3 and mario == 2 then
                        player_rank = 46
                    end
                    if luigi == 3 and star == 2 then
                        player_rank = 47
                    end
                    if mario == 3 and cloud == 2 then
                        player_rank = 48
                    end
                    if mario == 3 and mushroom == 2 then
                        player_rank = 49
                    end
                    if mario == 3 and flower == 2 then
                        player_rank = 50
                    end
                    if mario == 3 and luigi == 2 then
                        player_rank = 51
                    end
                    if mario == 3 and star == 2 then
                        player_rank = 52
                    end
                    if star == 3 and cloud == 2 then
                        player_rank = 53
                    end
                    if star == 3 and mushroom == 2 then
                        player_rank = 54
                    end
                    if star == 3 and flower == 2 then
                        player_rank = 55
                    end
                    if star == 3 and luigi == 2 then
                        player_rank = 56
                    end
                    if star == 3 and mario == 2 then
                        player_rank = 57
                    end

                    if cloud == 4 and mushroom == 1 then
                        player_rank = 58
                    end
                    if cloud == 4 and flower == 1 then
                        player_rank = 59
                    end
                    if cloud == 4 and luigi == 1 then
                        player_rank = 60
                    end
                    if cloud == 4 and mario == 1 then
                        player_rank = 61
                    end
                    if cloud == 4 and star == 1 then
                        player_rank = 62
                    end
                    if mushroom == 4 and cloud == 1 then
                        player_rank = 63
                    end
                    if mushroom == 4 and flower == 1 then
                        player_rank = 64
                    end
                    if mushroom == 4 and luigi == 1 then
                        player_rank = 65
                    end
                    if mushroom == 4 and mario == 1 then
                        player_rank = 66
                    end
                    if mushroom == 4 and star == 1 then
                        player_rank = 67
                    end
                    if flower == 4 and cloud == 1 then
                        player_rank = 68
                    end
                    if flower == 4 and mushroom == 1 then
                        player_rank = 69
                    end
                    if flower == 4 and luigi == 1 then
                        player_rank = 70
                    end
                    if flower == 4 and mario == 1 then
                        player_rank = 71
                    end
                    if flower == 4 and star == 1 then
                        player_rank = 72
                    end
                    if luigi == 4 and cloud == 1 then
                        player_rank = 73
                    end
                    if luigi == 4 and mushroom == 1 then
                        player_rank = 74
                    end
                    if luigi == 4 and flower == 1 then
                        player_rank = 75
                    end
                    if luigi == 4 and mario == 1 then
                        player_rank = 76
                    end
                    if luigi == 4 and star == 1 then
                        player_rank = 77
                    end
                    if mario == 4 and cloud == 1 then
                        player_rank = 78
                    end
                    if mario == 4 and mushroom == 1 then
                        player_rank = 79
                    end
                    if mario == 4 and flower == 1 then
                        player_rank = 80
                    end
                    if mario == 4 and luigi == 1 then
                        player_rank = 81
                    end
                    if mario == 4 and star == 1 then
                        player_rank = 82
                    end
                    if star == 4 and cloud == 1 then
                        player_rank = 83
                    end
                    if star == 4 and mushroom == 1 then
                        player_rank = 84
                    end
                    if star == 4 and flower == 1 then
                        player_rank = 85
                    end
                    if star == 4 and luigi == 1 then
                        player_rank = 86
                    end
                    if star == 4 and mario == 1 then
                        player_rank = 87
                    end

                    if cloud == 5 then
                        player_rank = 88
                    end
                    if mushroom == 5 then
                        player_rank = 89
                    end
                    if flower == 5 then
                        player_rank = 90
                    end
                    if luigi == 5 then
                        player_rank = 91
                    end
                    if mario == 5 then
                        player_rank = 92
                    end
                    if star == 5 then
                        player_rank = 93
                    end

                    cloud, mushroom, flower, luigi, mario, star = 0, 0, 0, 0, 0, 0

                    if not checked_luigi_cards then
                        for i, j in ipairs(luigi_deck) do
                            if luigi_deck[i] == 1 then
                                cloud = cloud + 1
                            elseif luigi_deck[i] == 2 then
                                mushroom = mushroom + 1
                            elseif luigi_deck[i] == 3 then
                                flower = flower + 1
                            elseif luigi_deck[i] == 4 then
                                luigi = luigi + 1
                            elseif luigi_deck[i] == 5 then
                                mario = mario + 1
                            elseif luigi_deck[i] == 6 then
                                star = star + 1
                            end
                        end
                        checked_luigi_cards = true
                    end

                    if cloud == 2 then
                        luigi_rank = 1
                    end
                    if mushroom == 2 then
                        luigi_rank = 2
                    end
                    if flower == 2 then
                        luigi_rank = 3
                    end
                    if luigi == 2 then
                        luigi_rank = 4
                    end
                    if mario == 2 then
                        luigi_rank = 5
                    end
                    if star == 2 then
                        luigi_rank = 6
                    end

                    if cloud == 2 and mushroom == 2 then
                        luigi_rank = 7
                    end
                    if cloud == 2 and flower == 2 then
                        luigi_rank = 8
                    end
                    if cloud == 2 and luigi == 2 then
                        luigi_rank = 10
                    end
                    if cloud == 2 and mario == 2 then
                        luigi_rank = 13
                    end
                    if cloud == 2 and star == 2 then
                        luigi_rank = 17
                    end
                    if mushroom == 2 and flower == 2 then
                        luigi_rank = 9
                    end
                    if mushroom == 2 and luigi == 2 then
                        luigi_rank = 11
                    end
                    if mushroom == 2 and mario == 2 then
                        luigi_rank = 14
                    end
                    if mushroom == 2 and star == 2 then
                        luigi_rank = 18
                    end
                    if flower == 2 and luigi == 2 then
                        luigi_rank = 12
                    end
                    if flower == 2 and mario == 2 then
                        luigi_rank = 15
                    end
                    if flower == 2 and star == 2 then
                        luigi_rank = 19
                    end
                    if luigi == 2 and mario == 2 then
                        luigi_rank = 16
                    end
                    if luigi == 2 and star == 2 then
                        luigi_rank = 20
                    end
                    if mario == 2 and star == 2 then
                        luigi_rank = 21
                    end

                    if cloud == 3 then
                        luigi_rank = 22
                    end
                    if mushroom == 3 then
                        luigi_rank = 23
                    end
                    if flower == 3 then
                        luigi_rank = 24
                    end
                    if luigi == 3 then
                        luigi_rank = 25
                    end
                    if mario == 3 then
                        luigi_rank = 26
                    end
                    if star == 3 then
                        luigi_rank = 27
                    end

                    if cloud == 3 and mushroom == 2 then
                        luigi_rank = 28
                    end
                    if cloud == 3 and flower == 2 then
                        luigi_rank = 29
                    end
                    if cloud == 3 and luigi == 2 then
                        luigi_rank = 30
                    end
                    if cloud == 3 and mario == 2 then
                        luigi_rank = 31
                    end
                    if cloud == 3 and star == 2 then
                        luigi_rank = 32
                    end
                    if mushroom == 3 and cloud == 2 then
                        luigi_rank = 33
                    end
                    if mushroom == 3 and flower == 2 then
                        luigi_rank = 34
                    end
                    if mushroom == 3 and luigi == 2 then
                        luigi_rank = 35
                    end
                    if mushroom == 3 and mario == 2 then
                        luigi_rank = 36
                    end
                    if mushroom == 3 and star == 2 then
                        luigi_rank = 37
                    end
                    if flower == 3 and cloud == 2 then
                        luigi_rank = 38
                    end
                    if flower == 3 and mushroom == 2 then
                        luigi_rank = 39
                    end
                    if flower == 3 and luigi == 2 then
                        luigi_rank = 40
                    end
                    if flower == 3 and mario == 2 then
                        luigi_rank = 41
                    end
                    if flower == 3 and star == 2 then
                        luigi_rank = 42
                    end
                    if luigi == 3 and cloud == 2 then
                        luigi_rank = 43
                    end
                    if luigi == 3 and mushroom == 2 then
                        luigi_rank = 44
                    end
                    if luigi == 3 and flower == 2 then
                        luigi_rank = 45
                    end
                    if luigi == 3 and mario == 2 then
                        luigi_rank = 46
                    end
                    if luigi == 3 and star == 2 then
                        luigi_rank = 47
                    end
                    if mario == 3 and cloud == 2 then
                        luigi_rank = 48
                    end
                    if mario == 3 and mushroom == 2 then
                        luigi_rank = 49
                    end
                    if mario == 3 and flower == 2 then
                        luigi_rank = 50
                    end
                    if mario == 3 and luigi == 2 then
                        luigi_rank = 51
                    end
                    if mario == 3 and star == 2 then
                        luigi_rank = 52
                    end
                    if star == 3 and cloud == 2 then
                        luigi_rank = 53
                    end
                    if star == 3 and mushroom == 2 then
                        luigi_rank = 54
                    end
                    if star == 3 and flower == 2 then
                        luigi_rank= 55
                    end
                    if star == 3 and luigi == 2 then
                        luigi_rank = 56
                    end
                    if star == 3 and mario == 2 then
                        luigi_rank = 57
                    end

                    if cloud == 4 and mushroom == 1 then
                        luigi_rank = 58
                    end
                    if cloud == 4 and flower == 1 then
                        luigi_rank = 59
                    end
                    if cloud == 4 and luigi == 1 then
                        luigi_rank = 60
                    end
                    if cloud == 4 and mario == 1 then
                        luigi_rank = 61
                    end
                    if cloud == 4 and star == 1 then
                        luigi_rank = 62
                    end
                    if mushroom == 4 and cloud == 1 then
                        luigi_rank = 63
                    end
                    if mushroom == 4 and flower == 1 then
                        luigi_rank = 64
                    end
                    if mushroom == 4 and luigi == 1 then
                        luigi_rank = 65
                    end
                    if mushroom == 4 and mario == 1 then
                        luigi_rank = 66
                    end
                    if mushroom == 4 and star == 1 then
                        luigi_rank = 67
                    end
                    if flower == 4 and cloud == 1 then
                        luigi_rank = 68
                    end
                    if flower == 4 and mushroom == 1 then
                        luigi_rank = 69
                    end
                    if flower == 4 and luigi == 1 then
                        luigi_rank = 70
                    end
                    if flower == 4 and mario == 1 then
                        luigi_rank = 71
                    end
                    if flower == 4 and star == 1 then
                        luigi_rank = 72
                    end
                    if luigi == 4 and cloud == 1 then
                        luigi_rank = 73
                    end
                    if luigi == 4 and mushroom == 1 then
                        luigi_rank = 74
                    end
                    if luigi == 4 and flower == 1 then
                        luigi_rank = 75
                    end
                    if luigi == 4 and mario == 1 then
                        luigi_rank = 76
                    end
                    if luigi == 4 and star == 1 then
                        luigi_rank = 77
                    end
                    if mario == 4 and cloud == 1 then
                        luigi_rank = 78
                    end
                    if mario == 4 and mushroom == 1 then
                        luigi_rank = 79
                    end
                    if mario == 4 and flower == 1 then
                        luigi_rank = 80
                    end
                    if mario == 4 and luigi == 1 then
                        luigi_rank = 81
                    end
                    if mario == 4 and star == 1 then
                        luigi_rank = 82
                    end
                    if star == 4 and cloud == 1 then
                        luigi_rank = 83
                    end
                    if star == 4 and mushroom == 1 then
                        luigi_rank = 84
                    end
                    if star == 4 and flower == 1 then
                        luigi_rank = 85
                    end
                    if star == 4 and luigi == 1 then
                        luigi_rank = 86
                    end
                    if star == 4 and mario == 1 then
                        luigi_rank = 87
                    end

                    if cloud == 5 then
                        luigi_rank = 88
                    end
                    if mushroom == 5 then
                        luigi_rank = 89
                    end
                    if flower == 5 then
                        luigi_rank = 90
                    end
                    if luigi == 5 then
                        luigi_rank = 91
                    end
                    if mario == 5 then
                        luigi_rank = 92
                    end
                    if star == 5 then
                        luigi_rank = 93
                    end

                    ranked = true
                end
                if ranked then
                    end_timer = end_timer + 1
                    if player_rank > luigi_rank then
                        victory = true
                    elseif player_rank == luigi_rank then
                        tie = true
                    elseif player_rank < luigi_rank then
                        loss = true
                    end
                    
                    if end_timer >= 32 then
                        djui_hud_set_font(FONT_HUD)
                        djui_hud_set_color(0, 255, 255, 255)
                        if player_rank == 0 then
                            djui_hud_print_text("JUNK", (djui_hud_get_screen_width()/2) + 2, (djui_hud_get_screen_height()/2) + 70, 0.5)
                        end
                        if luigi_rank == 0 then
                            djui_hud_print_text("JUNK", (djui_hud_get_screen_width()/2) + 2, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 1 and player_rank < 7 then
                            djui_hud_print_text("ONE PAIR", (djui_hud_get_screen_width()/2) - 10, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 2
                        end
                        if luigi_rank >= 1 and luigi_rank < 7 then
                            djui_hud_print_text("ONE PAIR", (djui_hud_get_screen_width()/2) - 10, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 7 and player_rank < 22 then
                            djui_hud_print_text("TWO PAIRS", (djui_hud_get_screen_width()/2) - 13, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 3
                        end
                        if luigi_rank >= 7 and luigi_rank < 22 then
                            djui_hud_print_text("TWO PAIRS", (djui_hud_get_screen_width()/2) - 13, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 22 and player_rank < 28 then
                            djui_hud_print_text("THREE OF A KIND", (djui_hud_get_screen_width()/2) - 28, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 4
                        end
                        if luigi_rank >= 22 and luigi_rank < 28 then
                            djui_hud_print_text("THREE OF A KIND", (djui_hud_get_screen_width()/2) - 28, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 28 and player_rank < 58 then
                            djui_hud_print_text("FULL HOUSE", (djui_hud_get_screen_width()/2) - 15, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 6
                        end
                        if luigi_rank >= 28 and luigi_rank < 58 then
                            djui_hud_print_text("FULL HOUSE", (djui_hud_get_screen_width()/2) - 15, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 58 and player_rank < 88 then
                            djui_hud_print_text("FOUR OF A KIND", (djui_hud_get_screen_width()/2) - 26, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 8
                        end
                        if luigi_rank >= 58 and luigi_rank < 88 then
                            djui_hud_print_text("FOUR OF A KIND", (djui_hud_get_screen_width()/2) - 26, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                        if player_rank >= 88 and player_rank <= 93 then
                            djui_hud_print_text("FIVE OF A KIND", (djui_hud_get_screen_width()/2) - 26, (djui_hud_get_screen_height()/2) + 70, 0.5)
                            coin_multiplier = 16
                        end
                        if luigi_rank >= 88 and luigi_rank <= 93 then
                            djui_hud_print_text("FIVE OF A KIND", (djui_hud_get_screen_width()/2) - 26, (djui_hud_get_screen_height()/2) + 42, 0.5)
                        end
                    end

                    if victory then
                        if end_timer >= 80 then
                            djui_hud_set_color(0, 255, 0, 255)
                            djui_hud_print_text("YOU WIN", (djui_hud_get_screen_width()/2) - 40, (djui_hud_get_screen_height()/2) - 50, 1)
                            if not play_win_fanfare then
                                play_music(0, 18, 0)
                                play_sound(SOUND_MARIO_HERE_WE_GO, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                                play_win_fanfare = true
                                level = level + 1
                                alltime_levels = alltime_levels + 1
                            end
                            djui_hud_set_color(255, 255, 255, 255)
                            if end_timer >= 128 then
                                if not amount_chosen then
                                    given_coins = coin_multiplier * total_bet
                                    amount_chosen = true
                                end
                                djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width()/2 - 10, djui_hud_get_screen_height()/2 - 10, 0.5, 0.5)
                                djui_hud_print_text("+"..tostring(given_coins), djui_hud_get_screen_width()/2, djui_hud_get_screen_height()/2 - 10, 0.5)
                                if not awarded_coins and given_coins > 0 then
                                    if end_timer % 3 == 0 then
                                        coins = coins + 1
                                        given_coins = given_coins - 1
                                        play_sound(SOUND_GENERAL_COIN, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                                    end
                                    if given_coins == 0 then
                                        awarded_coins = true
                                        victory = false
                                        play_win_fanfare = false
                                    end
                                end
                            end
                        end
                    end
                    if tie then
                        if end_timer >= 80 then
                            djui_hud_set_color(0, 255, 255, 255)
                            djui_hud_print_text("IT'S A TIE", (djui_hud_get_screen_width()/2) - 55, (djui_hud_get_screen_height()/2) - 50, 1)
                            if not played_tie_sound then
                                play_sound(SOUND_MARIO_OKEY_DOKEY, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                                played_tie_sound = true
                                coins = coins + total_bet
                            end
                            tie = false
                        end
                    end
                    if loss then
                        if end_timer >= 80 then
                            djui_hud_set_color(255, 0, 0, 255)
                            djui_hud_print_text("YOU LOSE", (djui_hud_get_screen_width()/2) - 45, (djui_hud_get_screen_height()/2) - 50, 1)
                            if not played_loss_sound then
                                play_sound(SOUND_MARIO_MAMA_MIA, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                                played_loss_sound = true
                                if alltime_levels > 0 then
                                    if alltime_levels > 0 then
                                        if alltime_levels % 100 ~= 0 then
                                            level = level - 1
                                        else
                                            level = 99
                                        end
                                    end
                                    alltime_levels = alltime_levels - 1
                                end
                            end
                            loss = false
                        end
                    end
                    if end_timer >= 128 and given_coins == 0 then
                        for i = 0,4 do
                            table.remove(luigi_deck)
                            table.remove(player_deck)
                        end
                        end_timer = 0
                        player_rank = 0
                        luigi_rank = 0
                        coin_multiplier = 0
                        additional_bets = 0
                        has_drawn = false
                        has_held = false
                        show_luigi_cards = false
                        player_deck_created = false
                        luigi_timer = 0
                        cutscene_timer = 0
                        total_bet = 0
                        first_bet = false
                        ranked = false
                        checked_luigi_cards = false
                        checked_player_cards = false
                        awarded_coins = false
                        amount_chosen = false
                        played_loss_sound = false
                        played_tie_sound = false
                        gPlayerSyncTable[gMarioStates[0].playerIndex].score = coins - forced_bet
                        gPlayerSyncTable[gMarioStates[0].playerIndex].rank1 = player_title1
                        gPlayerSyncTable[gMarioStates[0].playerIndex].rank2 = player_title2
                    end
                end
            end
        end
    end
end

local function server_update()
    for i = 0, MAX_PLAYERS - 1 do
        local m = gMarioStates[i]
        if not gNetworkPlayers[m.playerIndex].connected then return end
        network_player_set_description(gNetworkPlayers[m.playerIndex], tostring(gPlayerSyncTable[m.playerIndex].score), 255, 255, 0, 255)
    end
end

local function hide_info_command(msg)
    msg = string.lower(msg)
    if show_info then
        show_info = false
    end
    return true
end

local function show_info_command(msg)
    msg = string.lower(msg)
    if not show_info then
        show_info = true
    end
    return true
end

local function show_popups(msg)
    msg = string.lower(msg)
    if msg == "off" then
        show_saved_data = false
        return true
    end
    if msg == "on" then
        show_saved_data = true
        return true
    end
end

local function save_data(msg)
    msg = string.lower(msg)
    mod_storage_save("Coins", tostring(coins))
    mod_storage_save("Level", tostring(level))
    mod_storage_save("AlltimeLevels", tostring(alltime_levels))
    mod_storage_save("PlayerTitle1", tostring(gPlayerSyncTable[0].rank1))
    mod_storage_save("PlayerTitle2", tostring(gPlayerSyncTable[0].rank2))
    mod_storage_save("BGBluePurchased", tostring(bought_bgs[2]))
    mod_storage_save("BGBrownPurchased", tostring(bought_bgs[3]))
    mod_storage_save("BGCyanPurchased", tostring(bought_bgs[4]))
    mod_storage_save("BGGrayPurchased", tostring(bought_bgs[5]))
    mod_storage_save("BGOrangePurchased", tostring(bought_bgs[6]))
    mod_storage_save("BGPinkPurchased", tostring(bought_bgs[7]))
    mod_storage_save("BGPurplePurchased", tostring(bought_bgs[8]))
    mod_storage_save("BGRedPurchased", tostring(bought_bgs[9]))
    mod_storage_save("BGYellowPurchased", tostring(bought_bgs[10]))
    gPlayerSyncTable[gMarioStates[0].playerIndex].score = coins
    gPlayerSyncTable[gMarioStates[0].playerIndex].rank1 = player_title1
    gPlayerSyncTable[gMarioStates[0].playerIndex].rank2 = player_title2
    djui_chat_message_create("Data saved!")
    return true
end

local function on_chat_message(m, msg)
    local color = network_get_player_text_color_string(m.playerIndex)
    local name = gNetworkPlayers[m.playerIndex].name
    local rank1 = gPlayerSyncTable[m.playerIndex].rank1
    local rank2 = gPlayerSyncTable[m.playerIndex].rank2
    for i = 0, MAX_PLAYERS - 1 do
        if not gNetworkPlayers[m.playerIndex].connected then return end
        if network_discord_id_from_local_index(m.playerIndex) == "542676894244536350" then
            gPlayerSyncTable[m.playerIndex].is_dev = true
        end
        if network_discord_id_from_local_index(m.playerIndex) == "678794043018182675" then
            gPlayerSyncTable[m.playerIndex].is_contributor = true
        end
        if gPlayerSyncTable[m.playerIndex].is_dev then
            djui_chat_message_create(dev..color..name.." "..titles[rank1 + 1].." "..titles[rank2 + 1]..": \\#ffffff\\"..msg)
            return false
        end
        if gPlayerSyncTable[m.playerIndex].is_contributor then
            djui_chat_message_create(contributor..color..name.." "..titles[rank1 + 1].." "..titles[rank2 + 1]..": \\#ffffff\\"..msg)
            return false
        end
    end
    djui_chat_message_create(color..name.." "..titles[rank1 + 1].." "..titles[rank2 + 1]..": \\#ffffff\\"..msg)
    for i = 0, MAX_PLAYERS - 1 do
        gPlayerSyncTable[m.playerIndex].is_dev = false
        gPlayerSyncTable[m.playerIndex].is_contributor = false
    end
    return false
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_MARIO_UPDATE, server_update)
hook_event(HOOK_ON_CHAT_MESSAGE, on_chat_message)
hook_chat_command("hide_info", "- \\#00ff00\\[Luigi's Casino]\\#ffffff\\ Hides the wall of text on the right.", hide_info_command)
hook_chat_command("show_info", "- \\#00ff00\\[Luigi's Casino]\\#ffffff\\ Shows the wall of text on the right.", show_info_command)
hook_chat_command("popups", "- [on/off] \\#00ff00\\[Luigi's Casino]\\#ffffff\\ Hides the popups when data is saved.", show_popups)
hook_chat_command("save", "- \\#00ff00\\[Luigi's Casino]\\#ffffff\\ Manually saves data.", save_data)

for i = 0, MAX_PLAYERS - 1 do
    gPlayerSyncTable[i].score = tonumber(mod_storage_load("Coins")) or 0
    gPlayerSyncTable[i].rank1 = tonumber(mod_storage_load("PlayerTitle1")) or 0
    gPlayerSyncTable[i].rank2 = tonumber(mod_storage_load("PlayerTitle2")) or 0
    if i == 0 then
        gPlayerSyncTable[0].score = tonumber(mod_storage_load("Coins")) or 0
        gPlayerSyncTable[0].rank1 = tonumber(mod_storage_load("PlayerTitle1")) or 0
        gPlayerSyncTable[0].rank2 = tonumber(mod_storage_load("PlayerTitle2")) or 0
    end
end