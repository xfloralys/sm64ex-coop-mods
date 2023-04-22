-- name: Star Display
-- description: \\#ffff00\\Star Display\\#ffffff\\\n\nDisplays the stars you've collected during your adventure.\n\nspecial thanks to agent x for existing\n\nMod created by Ðvk, originally made by Caec, fixed by Sunk, and optimized by Agent X.

local djui_hud_set_resolution = djui_hud_set_resolution
local djui_hud_set_font = djui_hud_set_font
local djui_hud_set_color = djui_hud_set_color
local djui_hud_print_text = djui_hud_print_text
local save_file_get_star_flags = save_file_get_star_flags
local get_current_save_file_num = get_current_save_file_num
local djui_hud_render_texture = djui_hud_render_texture

local adaptx = 0
local adapted = false

local function format_number(number)
    local string = tostring(number)
    if number < 10 then
        string = "0" .. string
    end
    return string
end

local function adapt_to_devices(msg)
    if not adapted then
        adaptx = 30
        adapted = true
    elseif adapted then
        adaptx = 0
        adapted = false
    end
    djui_chat_message_create("Star Display has been adjusted.")
    return true
end

local function on_hud_render()
    if not djui_hud_is_pause_menu_created() then confirm = 0 return end

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)

    djui_hud_set_color(255, 255, 255, 255)

    for i = COURSE_BOB, COURSE_RR do
        local scale = 0.75
        local x = 140 + adaptx
        local y = (19 * scale) * i
        djui_hud_print_text(format_number(i), x, y, scale)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end

    djui_hud_set_font(FONT_MENU)
    djui_hud_set_color(255, 100, 0, 255)

    djui_hud_print_text("BOWSER COURSES", 250 + adaptx, 11.5, 0.275)

    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_print_text("B1", 250 + adaptx, (19 * 0.75 * 2), 0.75)
    djui_hud_print_text("B2", 250 + adaptx, (19 * 0.75 * 3), 0.75)
    djui_hud_print_text("B3", 250 + adaptx, (19 * 0.75 * 4), 0.75)

    for i = COURSE_BITDW, COURSE_BITS do
        local scale = 0.75
        local x = 250 + adaptx
        local y = (19 * scale) * (i - 14)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end

    djui_hud_set_font(FONT_MENU)
    djui_hud_set_color(100, 0, 255, 255)

    djui_hud_print_text("CAP COURSES", 250 + adaptx, 68, 0.275)

    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_print_text("MC", 250 + adaptx, (19 * 0.75 * 6), 0.75)
    djui_hud_print_text("WC", 250 + adaptx, (19 * 0.75 * 7), 0.75)
    djui_hud_print_text("VC", 250 + adaptx, (19 * 0.75 * 8), 0.75)

    for i = COURSE_COTMC, COURSE_VCUTM do
        local scale = 0.75
        local x = 250 + adaptx
        local y = (19 * scale) * (i - 14)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end

    djui_hud_set_font(FONT_MENU)
    djui_hud_set_color(0, 255, 255, 255)

    djui_hud_print_text("SECRET COURSES", 250 + adaptx, 125, 0.275)

    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_print_text("SS", 250 + adaptx, (19 * 0.75 * 10), 0.75)
    djui_hud_print_text("WM", 250 + adaptx, (19 * 0.75 * 11), 0.75)
    djui_hud_print_text("SA", 250 + adaptx, (19 * 0.75 * 12), 0.75)

    for i = COURSE_WMOTR, COURSE_SA do
        local scale = 0.75
        local x = 250 + adaptx
        local y = (19 * scale) * (i - 12)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end

    i = COURSE_PSS

    if i == COURSE_PSS then
        local scale = 0.75
        local x = 250 + adaptx
        local y = (19 * scale) * (i - 9)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end

    djui_hud_set_font(FONT_MENU)
    djui_hud_set_color(255, 100, 100, 255)

    djui_hud_print_text("OVERWORLD STARS", 250 + adaptx, 182.5, 0.275)

    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_print_text("OW", 250 + adaptx, (19 * 0.75 * 14), 0.75)

    i = COURSE_NONE

    if i == COURSE_NONE then
        local scale = 0.75
        local x = 250 + adaptx
        local y = (19 * scale) * (i + 14)
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, i - 1)
        for s = 0, 6 do
            if starFlags & (1 << s) ~= 0 then
                djui_hud_render_texture(gTextures.star, x + 10 + ((s + 1) * (15 * scale)), y, scale, scale)
            else
                djui_hud_print_text("x", x + 10 + ((s + 1) * (15 * scale)), y, scale)
            end
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_chat_command('adapt', "- \\#ffff00\\[Star Display]\\#ffffff\\ Moves Star Display further to the right in case you're on mobile or using a 720p monitor.", adapt_to_devices)