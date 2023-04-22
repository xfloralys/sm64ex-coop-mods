-- name: Random Events v3.0
-- description: \\#ff00ff\\Random Events \\#ff7f00\\v3.0\n\n\\#ffffff\\Every 30 seconds, something completely random happens, whether it's helpful or painful.\n\nHeavily inspired from SM64 Chaos Edition.\n\nFeatures a grand total of \\#ffff00\\60 events\\#ffffff\\!\n\nMod created by \\#400075\\Dvk (Floralys)\\#ffffff\\.

-- Get ready for the worst code optimization you've ever seen (especially around v1, aka the first 20 events)

local event_timer = 0
local event_timer2 = 0
local event_id = 0
local m = gMarioStates[0]
local base_speed = m.forwardVel

local prevStars = m.numStars
local a = 0
local prevCoins = m.numCoins
local b = 0
local prevStars3 = m.numStars
local prevCoins3 = m.numCoins
local prevLives3 = m.numLives

local confirmbool = false
local starposx = 0
local starposy = 0
local starposz = 0
local id = 0
local starid = 0

local message_confirmation = 0
local dpaddown = false
local dpadtimer = 0
local freefalltimer = 149
local lavatimer = 0
local bowser_timer = 0
local randompeachvoice = 0
local peachvoice = 0
local randombowservoice = 0
local bowservoice = false
local randommariovoice = 0
local mariovoice = false
local gravityflip = false
local flamethrowers = 0
local boss = 0
local floor = 0
local hurttimer = 0

-- Yes, this horrible code is still here. At least it's a good way to keep track of which event does what. Wait, what do you mean "that's basically useless"?

local check = false
local check2 = false -- Faster Running + Insane Speed Jumps
local check3 = false -- High Jumps
local check4 = false -- Moon Jump
local check5 = false -- Epilepsy Health Bar
local check6 = false -- Bouncy Mario
local check7 = false -- Disabled Mario
local check8 = false -- No More Stars, Idiot
local check9 = false -- No More Coins, Idiot
local check10 = false -- Random Quicksand Death
local check11 = false -- 1 Health Mario
local check12 = false -- No Jumps For You
local check13 = false -- Mario Randomly Stops
local check14 = false -- Press D-Pad Down or Die
local check15 = false -- Press D-Pad Down to Die
local check16 = false -- Random Peach Voices
local check17 = false -- Gravity Flip
local check18 = false -- Bonk Upon Long-Jumping
local check19 = false -- Constant Freefalling
local check20 = false -- Crouching Too Hard
local check21 = false -- Dive Only
local check22 = false -- The Floor is Lava
local check23 = false -- Spawn A Random Star
local check24 = false -- Bowser Time
local check25 = false -- I want THAT direction
local check26 = false -- Random Bowser Voices
local check27 = false -- Fiery Punches
local check28 = false -- Annoying Quicksand
local check29 = false -- Merry-Go-Round Mario
local check30 = false -- Drunk HUD
local check31 = false -- Ow, My Ears
local check32 = false -- Random Mario Voices
local check33 = false -- Flaming Breath
local check34 = false -- Spawn A Shell
local check35 = false -- Angry Lakitus
local check36 = false -- Holding A Bomb
local check37 = false -- Spawn 3 Caps
local check38 = false -- Check Out My Pet
local check39 = false -- Explode Upon Bonking Or Crouching
local check40 = false -- Ground Pound = Death
local check41 = false -- Summon A Random Boss
local check42 = false -- Random Floor Types
local check43 = false -- Wario's Greed
local check44 = false -- Piano Jumpscare
local check45 = false -- Chuckya Barrage
local check46 = false -- Green Demon
local check47 = false -- Green Angel
local check48 = false -- Fake IP Adress :trol:
local check49 = false -- Quite A Windy Day Today
local check50 = false -- Tornado Valley
local check51 = false -- War
local check52 = false -- Coin Clouds
local check53 = false -- Angry Stars
local check54 = false -- Uncontrolled Teleportation
local check55 = false -- Random Music And Skybox
local check56 = false -- Flashing Skyboxes
local check57 = false -- Double Damage
local check58 = false -- I'm-a Tired
local check59 = false -- Mario Horde
local check60 = false -- Boulders...?
local check61 = false -- Thwomped

function random()
    if event_timer2 == 0 then
        event_id = math.random(1,60)
    end
end

---@param m MarioState
function events(m)
    if m.playerIndex ~= 0 then return end
    event_timer = event_timer + 1
    if event_timer >= 30 then
        if event_id == 1 and (not check or check2) then -- Faster Running + Insane Speed Jumps
            check = true
            check2 = true
            event_timer2 = event_timer2 + 1
            mario_set_forward_vel(m, 500)
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                mario_set_forward_vel(m, base_speed)
                check = false
                check2 = false
            end
        end
        if event_id == 2 and (not check or check3) then -- High Jumps
            check = true
            check3 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_JUMP or m.action == ACT_SIDE_FLIP or m.action == ACT_LONG_JUMP or m.action == ACT_BACKFLIP then
                set_mario_action(m, ACT_TRIPLE_JUMP, 0)
                m.vel.y = 150
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check3 = false
            end
        end
        if event_id == 3 and (not check or check4) then -- Moon Jump
            check = true
            check4 = true
            event_timer2 = event_timer2 + 1
            if m.controller.buttonDown & A_BUTTON ~= 0 then
                set_mario_action(m, ACT_TRIPLE_JUMP, 0)
                m.vel.y = 50
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check4 = false
            end
        end
        if event_id == 4 and (not check or check5) then -- Epilepsy Health Bar
            check = true
            check5 = true
            event_timer2 = event_timer2 + 1
            m.health = math.random(256,2176)
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check5 = false
            end
        end
        if event_id == 5 and (not check or check6) then -- Bouncy Mario
            check = true
            check6 = true
            event_timer2 = event_timer2 + 1
            if m.action & ACT_LAVA_BOOST == 0 or m.action & ACT_FLAG_IDLE ~= 0 then
                set_mario_action(m, ACT_LAVA_BOOST, 0)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check6 = false
            end
        end
        if event_id == 6 and (not check or check7) then -- Disabled Mario
            check = true
            check7 = true
            event_timer2 = event_timer2 + 1
            set_mario_action(m, ACT_SQUISHED, 0)
            if m.action == ACT_JUMP then
                m.vel.y = m.vel.y - 25
            end
            mario_set_forward_vel(m, 2)
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                mario_set_forward_vel(m, base_speed)
                check = false
                check7 = false
            end
        end
        if event_id == 7 and (not check or check8) then -- No More Stars, Idiot
            check = true
            check8 = true
            event_timer2 = event_timer2 + 1
            m.numStars = 0
            hud_set_value(HUD_DISPLAY_STARS, m.numStars)
            if a == 0 then
                djui_chat_message_create("Thanks for the stars, loser!")
                a = 1
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                a = 0
                m.numStars = prevStars
                hud_set_value(HUD_DISPLAY_STARS, prevStars)
                check = false
                check8 = false
            end
        end
        if event_id == 8 and (not check or check9) then -- No More Coins, Idiot
            check = true
            check9 = true
            event_timer2 = event_timer2 + 1
            m.numCoins = 0
            hud_set_value(HUD_DISPLAY_COINS, m.numCoins)
            if b == 0 then
                djui_chat_message_create("Thanks for the coins, loser!")
                b = 1
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                b = 0
                m.numCoins = prevCoins
                hud_set_value(HUD_DISPLAY_COINS, prevCoins)
                check = false
                check9 = false
            end
        end
        if event_id == 9 and (not check or check10) then -- Random Quicksand Death
            check = true
            check10 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 300 or event_timer2 == 600 or event_timer2 == 900 then
                set_mario_action(m, ACT_QUICKSAND_DEATH, 0)
                m.numLives = m.numLives + 1
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check10 = false
            end
        end
        if event_id == 10 and (not check or check11) then -- 1 Health Mario
            check = true
            check11 = true
            event_timer2 = event_timer2 + 1
            if m.health > 256 then
                m.health = 256
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check11 = false
                m.health = 2176
            end
        end
        if event_id == 11 and (not check or check12) then -- No Jumps For You
            check = true
            check12 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_JUMP or m.action == ACT_LONG_JUMP or m.action == ACT_SIDE_FLIP or m.action == ACT_BACKFLIP then
                set_mario_action(m, ACT_GROUND_POUND, 0)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check12 = false
            end
        end
        if event_id == 12 and (not check or check13) then -- Mario Randomly Stops
            check = true
            check13 = true
            event_timer2 = event_timer2 + 1
            if m.action & ACT_FIRST_PERSON ~= 0 and m.controller.buttonDown & A_BUTTON == 0 then
                set_mario_action(m, ACT_FIRST_PERSON, 0)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check13 = false
            end
        end
        if event_id == 13 and (not check or check14) then -- Press D-Pad Down or Die
            check = true
            check14 = true
            event_timer2 = event_timer2 + 1
            dpadtimer = dpadtimer + 1
            if dpaddown == false then
                if message_confirmation == 0 then
                    djui_chat_message_create("Press D-Pad Down or die!")
                    message_confirmation = 1
                end
                if m.controller.buttonPressed & D_JPAD ~= 0 then
                    dpaddown = true
                    dpadtimer = 0
                end
                if dpadtimer >= 150 then
                    m.health = 0
                    dpaddown = true
                    dpadtimer = 0
                end
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check14 = false
                dpaddown = false
                dpadtimer = 0
                message_confirmation = 0
            end
        end
        if event_id == 14 and (not check or check15) then -- Press D-Pad Down or Die
            check = true
            check15 = true
            event_timer2 = event_timer2 + 1
            dpadtimer = dpadtimer + 1
            if dpaddown == false then
                if message_confirmation == 0 then
                    djui_chat_message_create("Press D-Pad Down to die!")
                    message_confirmation = 1
                end
                if m.controller.buttonPressed & D_JPAD ~= 0 then
                    m.health = 0
                    dpaddown = true
                    dpadtimer = 0
                end
                if dpadtimer >= 150 then
                    dpaddown = true
                    dpadtimer = 0
                end
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check15 = false
                dpaddown = false
                dpadtimer = 0
                message_confirmation = 0
            end
        end
        if event_id == 15 and (not check or check16) then -- Random Peach Voices
            check = true
            check16 = true
            event_timer2 = event_timer2 + 1
            if m.controller.buttonPressed & A_BUTTON ~= 0 or m.controller.buttonPressed & B_BUTTON ~= 0 then
                randompeachvoice = math.random(1,9)
                if randompeachvoice == 1 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_BAKE_A_CAKE, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 2 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_DEAR_MARIO, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 3 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_FOR_MARIO, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 4 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_MARIO, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 5 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_MARIO2, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 6 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_POWER_OF_THE_STARS, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 7 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_SOMETHING_SPECIAL, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 8 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_THANKS_TO_YOU, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
                if randompeachvoice == 9 and peachvoice == 0 then
                    play_sound(SOUND_PEACH_THANK_YOU_MARIO, m.marioObj.header.gfx.cameraToObject)
                    peachvoice = 1
                end
            end
            peachvoice = 0
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check16 = false
                randompeachvoice = 0
                peachvoice = 0
            end
        end
        if event_id == 16 and (not check or check17) then -- Gravity Flip
            check = true
            check17 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("Gravity Flip enabled! Press A to levitate, and press B to stop levitating! Careful though, levitating is quite harmful.")
                message_confirmation = 1
            end
            if m.controller.buttonPressed & A_BUTTON ~= 0 and gravityflip == false then
                gravityflip = true
                m.health = m.health - 256
            end
            if gravityflip == true then
                set_mario_action(m, ACT_JUMP, 0)
                m.vel.y = 75
            end
            if m.controller.buttonPressed & B_BUTTON ~= 0 and gravityflip == true then
                gravityflip = false
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check17 = false
                gravityflip = false
                message_confirmation = 0
            end
        end
        if event_id == 17 and (not check or check18) then -- Bonk Upon Long-Jumping
            check = true
            check18 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_LONG_JUMP then
                set_mario_action(m, ACT_BACKWARD_AIR_KB, 0)
                m.vel.y = 50
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check18 = false
            end
        end
        if event_id == 18 and (not check or check19) then -- Constant Freefalling
            check = true
            check19 = true
            event_timer2 = event_timer2 + 1
            freefalltimer = freefalltimer + 1
            if freefalltimer == 150 then
                m.pos.y = m.pos.y + 7500
                freefalltimer = 0
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check19 = false
                freefalltimer = 0
            end
        end
        if event_id == 19 and (not check or check20) then -- Crouching Too Hard
            check = true
            check20 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_CROUCHING or m.action == ACT_CRAWLING or m.action == ACT_GROUND_POUND or m.action == ACT_CROUCH_SLIDE then
                play_sound(SOUND_MARIO_ATTACKED, m.marioObj.header.gfx.cameraToObject)
                set_mario_action(m, ACT_BACKWARD_GROUND_KB, 0)
                m.health = m.health - 256
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check20 = false
            end
        end
        if event_id == 20 and (not check or check21) then -- Dive Only
            check = true
            check21 = true
            event_timer2 = event_timer2 + 1
            if m.controller.buttonPressed & A_BUTTON ~= 0 and m.action ~= ACT_DIVE then
                set_mario_action(m, ACT_DIVE, 0)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check21 = false
            end
        end

        -- v2 Stuff (Events 21 - 40)

        if event_id == 21 and (not check or check22) then -- The Floor is Lava
            check = true
            check22 = true
            event_timer2 = event_timer2 + 1
            lavatimer = lavatimer + 1
            if message_confirmation == 0 then
                djui_chat_message_create("The floor is \\#ff2500\\lava\\#ffffff\\! You have 5 seconds to stand somewhere safe!")
                message_confirmation = 1
            end
            if lavatimer >= 150 then
                if m.floor.type == SURFACE_NOISE_DEFAULT or m.floor.type == SURFACE_DEFAULT or m.floor.type == SURFACE_CLASS_VERY_SLIPPERY or m.floor.type == SURFACE_CLASS_SLIPPERY or m.floor.type == SURFACE_CLASS_NOT_SLIPPERY then
                    m.floor.type = SURFACE_BURNING
                end
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                lavatimer = 0
                message_confirmation = 0
                check = false
                check22 = false
                djui_chat_message_create("The floor is no longer lava. You're free from the torture!... Or are you?")
            end
        end
        if event_id == 22 and (not check or check23) then -- Spawn A Random Star
            check = true
            check23 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                djui_chat_message_create("A \\#ffff00\\Star\\#ffffff\\ has spawned! If you can, go grab it!")
                play_sound(SOUND_GENERAL2_STAR_APPEARS, m.marioObj.header.gfx.cameraToObject)
                id = math.random(0,6)
                starid = id << 24
                starposx = math.random(-8200,8200)
                starposy = math.random(-8200,8200)
                starposz = math.random(-8200,8200)
                spawn_sync_object(
                    id_bhvStar,
                    E_MODEL_STAR,
                    starposx, starposy, starposz,

                    function(obj)
                        obj.oBehParams = starid
                        -- djui_chat_message_create(tostring(obj.oBehParams))
                        obj.oOpacity = 255
                    end)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check23 = false
                confirmbool = false
            end
        end
        if event_id == 23 and (not check or check24) then -- Bowser Time
            check = true
            check24 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                play_music(0, 25, 0)
                confirmbool = true
            end
            if bowser_timer == 0 or bowser_timer == 150 or bowser_timer == 300 or bowser_timer == 450 or bowser_timer == 600 or bowser_timer == 750 or bowser_timer == 900 then
                spawn_sync_object(
                    id_bhvBowser,
                    E_MODEL_BOWSER,
                    m.pos.x, m.pos.y, m.pos.z,
                    function(obj)
                        obj.oBehParams2ndByte = 0
                        obj.oOpacity = 255
                    end)
                play_sound(SOUND_OBJ_BOWSER_LAUGH, m.marioObj.header.gfx.cameraToObject)
            end
            bowser_timer = bowser_timer + 1
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                bowser_timer = 0
                check = false
                check24 = false
                confirmbool = false
            end
        end
        if event_id == 24 and (not check or check25) then -- I want THAT direction
            check = true
            check25 = true
            event_timer2 = event_timer2 + 1
            m.faceAngle.x = 0
            m.faceAngle.y = 0
            m.faceAngle.z = 0
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check25 = false
            end
        end
        if event_id == 25 and (not check or check26) then -- Random Bowser Voices
            check = true
            check26 = true
            event_timer2 = event_timer2 + 1
            if m.controller.buttonPressed & A_BUTTON ~= 0 or m.controller.buttonPressed & B_BUTTON ~= 0 then
                randombowservoice = math.random(1,7)
                if randombowservoice == 1 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_DEFEATED, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 2 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_INHALING, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 3 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_INTRO_LAUGH, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 4 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_LAUGH, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 5 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_TAIL_PICKUP, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 6 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_SPINNING, m.marioObj.header.gfx.cameraToObject)
                end
                if randombowservoice == 7 and not bowservoice then
                    play_sound(SOUND_OBJ_BOWSER_WALK, m.marioObj.header.gfx.cameraToObject)
                end
                bowservoice = true
            end
            bowservoice = false
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check26 = false
                randombowservoice = 0
                bowservoice = false
            end
        end
        if event_id == 26 and (not check or check27) then -- Fiery Punches
            check = true
            check27 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("You now have fire powers! Simply press B to summon fire... oh but, be careful, you'll burn yourself.")
                message_confirmation = 1
            end
            if m.controller.buttonPressed & B_BUTTON ~= 0 then
                spawn_sync_object(
                    id_bhvFlame,
                    E_MODEL_RED_FLAME,
                    m.pos.x, m.pos.y, m.pos.z,
                    function(obj)
                        obj.oOpacity = 255
                    end)
            end
            if event_timer2 >= 900 then
                check = false
                check27 = false
                event_timer = 0
                event_timer2 = 0
                message_confirmation = 0
            end
        end
        if event_id == 27 and (not check or check28) then -- Annoying Quicksand
            check = true
            check28 = true
            event_timer2 = event_timer2 + 1
            if m.floor.type == SURFACE_NOISE_DEFAULT or m.floor.type == SURFACE_DEFAULT or m.floor.type == SURFACE_CLASS_VERY_SLIPPERY or m.floor.type == SURFACE_CLASS_SLIPPERY or m.floor.type == SURFACE_CLASS_NOT_SLIPPERY then
                m.floor.type = SURFACE_QUICKSAND
            end
            if event_timer2 >= 900 then
                check = false
                check28 = false
                event_timer = 0
                event_timer2 = 0
            end
        end
        if event_id == 28 and (not check or check29) then -- Merry-Go-Round Mario
            check = true
            check29 = true
            event_timer2 = event_timer2 + 1
            m.faceAngle.x = math.random(-65536,65536)
            m.faceAngle.y = math.random(-65536,65536)
            m.faceAngle.z = math.random(-65536,65536)
            if not confirmbool then
                play_music(0, 19, 0)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                check = false
                check29 = false
                event_timer = 0
                event_timer2 = 0
                confirmbool = false
            end
        end
        if event_id == 29 and (not check or check30) then -- Drunk HUD
            check = true
            check30 = true
            event_timer2 = event_timer2 + 1
            m.numLives = math.random(0,999)
            m.numCoins = math.random(0,999)
            m.numStars = math.random(0,999)
            m.health = math.random(256,2176)
            hud_set_value(HUD_DISPLAY_LIVES, m.numLives)
            hud_set_value(HUD_DISPLAY_COINS, m.numCoins)
            hud_set_value(HUD_DISPLAY_STARS, m.numStars)
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check30 = false
                m.numLives = prevLives3
                m.numCoins = prevCoins3
                m.numStars = prevStars3
                m.health = 2176
                hud_set_value(HUD_DISPLAY_LIVES, m.numLives)
                hud_set_value(HUD_DISPLAY_COINS, m.numCoins)
                hud_set_value(HUD_DISPLAY_STARS, m.numStars)
            end
        end
        if event_id == 30 and (not check or check31) then -- Ow, My Ears
            check = true
            check31 = true
            event_timer2 = event_timer2 + 1
            play_sound(SOUND_MARIO_COUGHING2, m.marioObj.header.gfx.cameraToObject)
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check31 = false
            end
        end
        if event_id == 31 and (not check or check32) then -- Random Mario Voices
            check = true
            check32 = true
            event_timer2 = event_timer2 + 1
            if m.controller.buttonPressed & A_BUTTON ~= 0 or m.controller.buttonPressed & B_BUTTON ~= 0 then
                randommariovoice = math.random(1,43)
                if randommariovoice == 1 and not mariovoice then
                    play_sound(SOUND_MARIO_ATTACKED, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 2 and not mariovoice then
                    play_sound(SOUND_MARIO_COUGHING1, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 3 and not mariovoice then
                    play_sound(SOUND_MARIO_COUGHING2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 4 and not mariovoice then
                    play_sound(SOUND_MARIO_COUGHING3, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 5 and not mariovoice then
                    play_sound(SOUND_MARIO_DOH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 6 and not mariovoice then
                    play_sound(SOUND_MARIO_DROWNING, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 7 and not mariovoice then
                    play_sound(SOUND_MARIO_DYING, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 8 and not mariovoice then
                    play_sound(SOUND_MARIO_EEUH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 9 and not mariovoice then
                    play_sound(SOUND_MARIO_GAME_OVER, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 10 and not mariovoice then
                    play_sound(SOUND_MARIO_GROUND_POUND_WAH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 11 and not mariovoice then
                    play_sound(SOUND_MARIO_HAHA, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 12 and not mariovoice then
                    play_sound(SOUND_MARIO_HAHA_2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 13 and not mariovoice then
                    play_sound(SOUND_MARIO_HELLO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 14 and not mariovoice then
                    play_sound(SOUND_MARIO_HERE_WE_GO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 15 and not mariovoice then
                    play_sound(SOUND_MARIO_HOOHOO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 16 and not mariovoice then
                    play_sound(SOUND_MARIO_HRMM, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 17 and not mariovoice then
                    play_sound(SOUND_MARIO_IMA_TIRED, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 18 and not mariovoice then
                    play_sound(SOUND_MARIO_MAMA_MIA, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 19 and not mariovoice then
                    play_sound(SOUND_MARIO_OKEY_DOKEY, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 20 and not mariovoice then
                    play_sound(SOUND_MARIO_ON_FIRE, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 21 and not mariovoice then
                    play_sound(SOUND_MARIO_OOOF, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 22 and not mariovoice then
                    play_sound(SOUND_MARIO_OOOF2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 23 and not mariovoice then
                    play_sound(SOUND_MARIO_PANTING, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 24 and not mariovoice then
                    play_sound(SOUND_MARIO_PANTING_COLD, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 25 and not mariovoice then
                    play_sound(SOUND_MARIO_PRESS_START_TO_PLAY, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 26 and not mariovoice then
                    play_sound(SOUND_MARIO_PUNCH_HOO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 27 and not mariovoice then
                    play_sound(SOUND_MARIO_PUNCH_WAH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 28 and not mariovoice then
                    play_sound(SOUND_MARIO_PUNCH_YAH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 29 and not mariovoice then
                    play_sound(SOUND_MARIO_SNORING1, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 30 and not mariovoice then
                    play_sound(SOUND_MARIO_SNORING2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 31 and not mariovoice then
                    play_sound(SOUND_MARIO_SNORING3, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 32 and not mariovoice then
                    play_sound(SOUND_MARIO_SO_LONGA_BOWSER, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 33 and not mariovoice then
                    play_sound(SOUND_MARIO_TWIRL_BOUNCE, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 34 and not mariovoice then
                    play_sound(SOUND_MARIO_UH, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 35 and not mariovoice then
                    play_sound(SOUND_MARIO_UH2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 36 and not mariovoice then
                    play_sound(SOUND_MARIO_UH2_2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 37 and not mariovoice then
                    play_sound(SOUND_MARIO_WAAAOOOW, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 38 and not mariovoice then
                    play_sound(SOUND_MARIO_WAH2, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 39 and not mariovoice then
                    play_sound(SOUND_MARIO_WHOA, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 40 and not mariovoice then
                    play_sound(SOUND_MARIO_YAHOO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 41 and not mariovoice then
                    play_sound(SOUND_MARIO_YAHOO_WAHA_YIPPEE, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 42 and not mariovoice then
                    play_sound(SOUND_MARIO_YAH_WAH_HOO, m.marioObj.header.gfx.cameraToObject)
                end
                if randommariovoice == 43 and not mariovoice then
                    play_sound(SOUND_MARIO_YAWNING, m.marioObj.header.gfx.cameraToObject)
                end
                mariovoice = true
            end
            mariovoice = false
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check32 = false
                randommariovoice = 0
                mariovoice = false
            end
        end
        if event_id == 32 and (not check or check33) then
            check = true
            check33 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("You ate the spiciest pepper out there, and now you have literal fire breath upon crouching.")
                message_confirmation = 1
            end
            if m.controller.buttonPressed & Z_TRIG ~= 0 and flamethrowers < 25 then
                spawn_sync_object(
                    id_bhvFlamethrower,
                    E_MODEL_NONE,
                    m.pos.x, (m.pos.y + 90), m.pos.z,
                    function(obj)
                        obj.oOpacity = 255
                    end)
                flamethrowers = flamethrowers + 1
            end
            if event_timer2 >= 900 then
                check = false
                check33 = false
                event_timer = 0
                event_timer2 = 0
                message_confirmation = 0
                flamethrowers = 0
            end
        end
        if event_id == 33 and (not check or check34) then -- Spawn A Shell
            check = true
            check34 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                spawn_sync_object(
                    id_bhvKoopaShell,
                    E_MODEL_KOOPA_SHELL,
                    m.pos.x, m.pos.y, m.pos.z,
                    function(obj)
                        obj.oOpacity = 255
                    end
                )
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check34 = false
                confirmbool = false
            end
        end
        if event_id == 34 and (not check or check35) then -- Angry Lakitus
            check = true
            check35 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer2 == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                spawn_sync_object(id_bhvGoomba, E_MODEL_LAKITU, (m.pos.x + 100), m.pos.y, m.pos.z, function(obj) obj.oOpacity = 0 end)
                spawn_sync_object(id_bhvGoomba, E_MODEL_LAKITU, m.pos.x, m.pos.y, (m.pos.z + 100), function(obj) obj.oOpacity = 0 end)
                spawn_sync_object(id_bhvGoomba, E_MODEL_LAKITU, (m.pos.x - 50), m.pos.y, (m.pos.z - 50), function(obj) obj.oOpacity = 0 end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check35 = false
            end
        end
        if event_id == 35 and (not check or check36) then -- Holding A Bomb
            check = true
            check36 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                djui_chat_message_create("You've been given a bomb. Use it wisely. Just kidding, you'll explode yourself. But maybe you can also hit someone else?")
                local obj = spawn_sync_object(id_bhvBowserBomb, E_MODEL_BOWSER_BOMB, (m.pos.x + 100), m.pos.y, m.pos.z, function(obj) 
                                obj.oFlags = OBJ_FLAG_HOLDABLE
                                obj.oInteractType = obj.oInteractType | INTERACT_GRABBABLE
                            end)
                if obj ~= nil then
                    m.usedObj = obj
                    mario_grab_used_object(m)
                    set_mario_action(m, ACT_HOLD_IDLE, 0)
                end
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check36 = false
                confirmbool = false
            end
        end
        if event_id == 36 and (not check or check37) then -- Spawn 3 Caps
            check = true
            check37 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                spawn_sync_object(id_bhvMetalCap, E_MODEL_MARIOS_METAL_CAP, m.pos.x, m.pos.y, m.pos.z, function()end)
                spawn_sync_object(id_bhvVanishCap, E_MODEL_MARIOS_CAP, m.pos.x, m.pos.y, m.pos.z, function()end)
                spawn_sync_object(id_bhvWingCap, E_MODEL_MARIOS_WING_CAP, m.pos.x, m.pos.y, m.pos.z, function()end)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check37 = false
                confirmbool = false
            end
        end
        if event_id == 37 and (not check or check38) then -- Check Out My Pet
            check = true
            check38 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                djui_chat_message_create("Guess you decided to bring your pet with you on that chaotic adventure.")
                local obj2 = spawn_sync_object(id_bhvChainChomp, E_MODEL_CHAIN_CHOMP, m.pos.x, (m.pos.y + 1000), m.pos.z, function()end)
                if obj2 ~= nil then
                    m.usedObj = obj2
                    mario_grab_used_object(m)
                    set_mario_action(m, ACT_HOLD_IDLE, 0)
                end
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check38 = false
                confirmbool = false
            end
        end
        if event_id == 38 and (not check or check39) then -- Explode Upon Bonking Or Crouching
            check = true
            check39 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("Now I don't know what kind of Taco Bell you decided to go to, but you might explode. Literally.")
                message_confirmation = 1
            end
            if m.action == ACT_BACKWARD_AIR_KB or m.action == ACT_HARD_BACKWARD_GROUND_KB or m.action == ACT_BACKWARD_GROUND_KB or m.action == ACT_HARD_BACKWARD_AIR_KB or m.action == ACT_CROUCHING or m.action == ACT_CROUCH_SLIDE or m.action == ACT_GROUND_POUND_LAND then
                spawn_sync_object(id_bhvBowserBomb, E_MODEL_NONE, m.pos.x, m.pos.y, m.pos.z, function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check39 = false
                message_confirmation = 0
            end
        end
        if event_id == 39 and (not check or check40) then -- Ground Pound = Death
            check = true
            check40 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_GROUND_POUND_LAND then
                m.health = 0
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check40 = false
            end
        end
        if event_id == 40 and (not check or check41) then -- Summon A Random Boss
            check = true
            check41 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                boss = math.random(1,4)
                djui_chat_message_create("Boss time! In case you're getting bored, here's a little fight for you. :)")
                if boss == 1 then
                    spawn_sync_object(id_bhvKingBobomb, E_MODEL_KING_BOBOMB, m.pos.x, m.pos.y, m.pos.z, function()end)
                end
                if boss == 2 then
                    spawn_sync_object(id_bhvWhompKingBoss, E_MODEL_WHOMP, m.pos.x, m.pos.y, m.pos.z, function()end)
                end
                if boss == 3 then
                    spawn_sync_object(id_bhvBalconyBigBoo, E_MODEL_BOO, m.pos.x, m.pos.y, m.pos.z, function()end)
                end
                if boss == 4 then
                    spawn_sync_object(id_bhvBigBully, E_MODEL_BULLY_BOSS, m.pos.x, (m.pos.y + 150), m.pos.z, function()end)
                end
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check41 = false
                confirmbool = false
                boss = 0
            end
        end

        -- v3 Stuff (Events 41 - ...)

        if event_id == 41 and (not check or check42) then -- Random Floor Types
            check = true
            check42 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                if not confirmbool then
                    floor = math.random(1,5)
                    if floor == 1 and not confirmbool then
                        m.floor.type = SURFACE_NOISE_DEFAULT
                    end
                    if floor == 2 and not confirmbool then
                        m.floor.type = SURFACE_NOISE_VERY_SLIPPERY
                    end
                    if floor == 3 and not confirmbool then
                        m.floor.type = SURFACE_BURNING
                    end
                    if floor == 4 and not confirmbool then
                        m.floor.type = SURFACE_QUICKSAND
                    end
                    if floor == 5 and not confirmbool then
                        m.floor.type = SURFACE_ICE
                    end
                    confirmbool = true
                end
                confirmbool = false
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check42 = false
                confirmbool = false
            end
        end
        if event_id == 42 and (not check or check43) then -- Wario's Greed
            check = true
            check43 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("You've been cursed with Wario's greed! Stand still, and try to get as many coins as you can before the curse goes away!")
                message_confirmation = 1
            end
            if not confirmbool then
                local money = spawn_sync_object(id_bhvOneCoin, E_MODEL_YELLOW_COIN, m.pos.x, m.pos.y, m.pos.z, function()end)
                if money ~= nil then
                    m.usedObj = money
                    mario_grab_used_object(m)
                    set_mario_action(m, ACT_HOLD_IDLE, 0)
                end
                confirmbool = true
            end
            if m.action == ACT_THROWING then
                confirmbool = false
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check43 = false
                message_confirmation = 0
                confirmbool = false
            end
        end
        if event_id == 43 and (not check or check44) then -- Piano Jumpscare
            check = true
            check44 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                spawn_sync_object(id_bhvMadPiano, E_MODEL_MAD_PIANO, m.pos.x, m.pos.y, m.pos.z, function()end)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check44 = false
                confirmbool = false
            end
        end
        if event_id == 44 and (not check or check45) then -- Chuckya Barrage
            check = true
            check45 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer2 == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                spawn_sync_object(id_bhvChuckya, E_MODEL_CHUCKYA, (m.pos.x + 200), m.pos.y, m.pos.z, function(obj) obj.oOpacity = 255 end)
                spawn_sync_object(id_bhvChuckya, E_MODEL_CHUCKYA, m.pos.x, m.pos.y, (m.pos.z + 200), function(obj) obj.oOpacity = 255 end)
                spawn_sync_object(id_bhvChuckya, E_MODEL_CHUCKYA, (m.pos.x - 150), m.pos.y, (m.pos.z - 150), function(obj) obj.oOpacity = 255 end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check45 = false
            end
        end
        if event_id == 45 and (not check or check46) then -- Green Demon
            check = true
            check46 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                demon = spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_1UP, m.pos.x, m.pos.y, m.pos.z, function()end)
                lives = m.numLives
                confirmbool = true
            end
            if m.numLives > lives then -- This is a very poor attempt at recreating Green Demon; I really couldn't figure it out.
                m.health = 0
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check46 = false
                confirmbool = false
            end
        end
        if event_id == 46 and (not check or check47) then -- Green Angel
            check = true
            check47 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_1UP, m.pos.x, m.pos.y, m.pos.z, function()end)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check47 = false
                confirmbool = false
            end
        end
        if event_id == 47 and (not check or check48) then -- Fake IP Adress :trol:
            check = true
            check48 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                djui_chat_message_create("Your (totally real) IP: "..tostring(math.random(1,255)).."."..tostring(math.random(0,255)).."."..tostring(math.random(0,255)).."."..tostring(math.random(0,255)))
                confirmbool = true
            end
            if event_timer2 >= 900 then
                djui_chat_message_create("If you're concerned, no, that wasn't your real IP, of course.")
                event_timer = 0
                event_timer2 = 0
                check = false
                check48 = false
                confirmbool = false
            end
        end
        if event_id == 48 and (not check or check49) then -- Quite A Windy Day Today
            check = true
            check49 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer2 == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                spawn_sync_object(id_bhvStrongWindParticle, E_MODEL_WHITE_PARTICLE, m.pos.x, m.pos.y, m.pos.z, function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check49 = false
            end
        end
        if event_id == 49 and (not check or check50) then -- Tornado Valley
            check = true
            check50 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer2 == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                spawn_sync_object(id_bhvTweester, E_MODEL_TWEESTER, m.pos.x, m.pos.y, m.pos.z, function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check50 = false
            end
        end
        if event_id == 50 and (not check or check51) then -- War
            check = true
            check51 = true
            event_timer2 = event_timer2 + 1
            set_override_skybox(1)
            spawn_sync_object(id_bhvBowserBombExplosion, E_MODEL_EXPLOSION, math.random(-8200,8200), math.random(-8200,8200), math.random(-8200,8200), function()end)
            spawn_sync_object(id_bhvBowserBombExplosion, E_MODEL_EXPLOSION, math.random(-8200,8200), math.random(-8200,8200), math.random(-8200,8200), function()end)
            if not confirmbool then
                play_music(0,17,0)
                confirmbool = true
            end
            warsound = math.random(1,3)
            if warsound == 1 then
                play_sound(SOUND_GENERAL_BOWSER_BOMB_EXPLOSION, m.marioObj.header.gfx.cameraToObject)
            elseif warsound == 2 then
                play_sound(SOUND_GENERAL_DONUT_PLATFORM_EXPLOSION, m.marioObj.header.gfx.cameraToObject)
            elseif warsound == 3 then
                play_sound(SOUND_GENERAL_EXPLOSION7, m.marioObj.header.gfx.cameraToObject)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check51 = false
                confirmbool = false
                warsound = 0
            end
        end
        if event_id == 51 and (not check or check52) then -- Coin Clouds
            check = true
            check52 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 % 1.25 == 0 then
                spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, math.random(-8200,8200), math.random(-8200,8200), math.random(-8200,8200), function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check52 = false
            end
        end
        if event_id == 52 and (not check or check53) then -- Angry Stars
            check = true
            check53 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 300 or event_timer2 == 600 or event_timer2 == 900 then
                spawn_sync_object(id_bhvFireSpitter, E_MODEL_STAR, m.pos.x, (m.pos.y + 150), m.pos.z, function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check53 = false
            end
        end
        if event_id == 53 and (not check or check54) then -- Uncontrolled Teleportation
            check = true
            check54 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 % 1.75 == 0 then
                play_sound(SOUND_OBJ2_BOWSER_TELEPORT, m.marioObj.header.gfx.cameraToObject)
                m.pos.x = math.random(-8200,8200)
                m.pos.y = math.random(0,8200)
                m.pos.z = math.random(-8200,8200)
                m.faceAngle.x = math.random(-65536,65536)
                m.faceAngle.y = math.random(-65536,65536)
                m.faceAngle.z = math.random(-65536,65536)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check54 = false
            end
        end
        if event_id == 54 and (not check or check55) then -- Random Music And Skybox
            check = true
            check55 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                play_music(0, math.random(1,35), 0)
                set_override_skybox(math.random(1,10))
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check55 = false
                confirmbool = false
            end
        end
        if event_id == 55 and (not check or check56) then -- Flashing Skyboxes
            check = true
            check56 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 % 1.5 == 0 then
                set_override_skybox(math.random(0,10))
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check56 = false
            end
        end
        if event_id == 56 and (not check or check57) then -- Double Damage
            check = true
            check57 = true
            event_timer2 = event_timer2 + 1
            if message_confirmation == 0 then
                djui_chat_message_create("Be careful! The damage you take has been doubled!")
                message_confirmation = 1
            end
            if m.hurtCounter > 0 and hurttimer == 0 then
                hurttimer = hurttimer + 1
                m.hurtCounter = m.hurtCounter * 2
            end
            if hurttimer >= 2 then
                m.hurtCounter = 0
                hurttimer = 0
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check57 = false
                hurttimer = 0
                message_confirmation = 0
            end
        end
        if event_id == 57 and (not check or check58) then -- I'm-a Tired
            check = true
            check58 = true
            event_timer2 = event_timer2 + 1
            if m.action == ACT_IDLE then
                play_sound(SOUND_MARIO_IMA_TIRED, m.marioObj.header.gfx.cameraToObject)
                m.action = ACT_SLEEPING
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check58 = false
            end
        end
        if event_id == 58 and (not check or check59) then -- Mario Horde
            check = true
            check59 = true
            event_timer2 = event_timer2 + 1
            if not confirmbool then
                spawn_sync_object(id_bhv1Up, E_MODEL_MARIO, math.random(-8200,8200), math.random(0,8200), math.random(-8200,8200), function()end)
                spawn_sync_object(id_bhv1Up, E_MODEL_MARIO, math.random(-8200,8200), math.random(0,8200), math.random(-8200,8200), function()end)
                spawn_sync_object(id_bhv1Up, E_MODEL_MARIO, math.random(-8200,8200), math.random(0,8200), math.random(-8200,8200), function()end)
                spawn_sync_object(id_bhv1Up, E_MODEL_MARIO, math.random(-8200,8200), math.random(0,8200), math.random(-8200,8200), function()end)
                spawn_sync_object(id_bhv1Up, E_MODEL_MARIO, math.random(-8200,8200), math.random(0,8200), math.random(-8200,8200), function()end)
                confirmbool = true
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check59 = false
                confirmbool = false
            end
        end
        if event_id == 59 and (not check or check60) then -- Boulders...?
            check = true
            check60 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 150 or event_timer2 == 300 or event_timer2 == 450 or event_timer2 == 600 or event_timer2 == 750 or event_timer2 == 900 then
                spawn_sync_object(id_bhvBigBoulder, E_MODEL_TTC_ROTATING_CUBE, m.pos.x, m.pos.y, m.pos.z, function()end)
                m.health = m.health + 768
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check60 = false
            end
        end
        if event_id == 60 and (not check or check61) then -- Thwomped
            check = true
            check61 = true
            event_timer2 = event_timer2 + 1
            if event_timer2 == 1 or event_timer2 == 300 or event_timer2 == 600 or event_timer2 == 900 then
                spawn_sync_object(id_bhvThwomp, E_MODEL_THWOMP, m.pos.x, m.pos.y, m.pos.z, function()end)
            end
            if event_timer2 >= 900 then
                event_timer = 0
                event_timer2 = 0
                check = false
                check61 = false
            end
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, random)
hook_event(HOOK_MARIO_UPDATE, events)