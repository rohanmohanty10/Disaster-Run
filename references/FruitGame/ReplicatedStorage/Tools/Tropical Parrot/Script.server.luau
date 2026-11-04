 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(u2.Modules.ToolDesc)
local u4 = require(u2.Modules.Leveling).MaxPeli
local u5 = v1.LocalPlayer
local u6 = script.Parent
local u7 = game.ReplicatedStorage:FindFirstChild("Stats" .. u6.Parent.Name)
if u7 then
    local u8 = Random.new()
    local v9 = u6:WaitForChild("RootPart")
    local v10 = u7.Customization.Height.Value
    local _ = v10 / 10
    local v11 = v9:WaitForChild("Bone")
    function GetOffset(p12)
        return p12 <= 10 and -0.273 or -0.273 * ((p12 - 10) * 0.05)
    end
    if v11 then
        local v13 = -GetOffset(v10)
        v11.Position = Vector3.new(0, v13, 0)
    end
    local u14 = {
        ["LowHealth"] = {
            "{PLAYER}, you\'re looking mighty rough!",
            "Time to find a doctor, {PLAYER}!",
            "Your health is running low!",
            "Better grab some grub, {PLAYER}!",
            "Take cover, {PLAYER}!",
            "We need some bandages!",
            "Heal up before it\'s too late!",
            "You\'re in bad shape, matey!",
            "This isn\'t looking good, {PLAYER}!",
            "Time to retreat and recover!",
            "Get to safety, {PLAYER}!",
            "You need medical attention!",
            "Don\'t push yourself too hard!",
            "Rest up, {PLAYER}!",
            "Your wounds need tending!",
            "Time to fall back and regroup!"
        },
        ["Combat"] = {
            "Show them what you\'ve got, {PLAYER}!",
            "Let\'s finish this fight!",
            "Keep your guard up!",
            "Don\'t let them get the upper hand!",
            "You\'ve got this, {PLAYER}!",
            "Time to turn the tide!",
            "Watch your back, {PLAYER}!",
            "Stay focused on the fight!",
            "Give them everything you\'ve got!",
            "Victory is within reach!",
            "Keep the pressure on!",
            "They\'re on the ropes now!",
            "Finish them off, {PLAYER}!",
            "Show no mercy!",
            "Fight with all your might!",
            "We\'re in this together, {PLAYER}!",
            "You\'re doing great, keep it up!",
            "They don\'t stand a chance!",
            "Let\'s take them down!",
            "Press the attack, {PLAYER}!"
        },
        ["Idle"] = {
            ["General"] = {
                "Fine day for sailing, {PLAYER}!",
                "What\'s the plan, {PLAYER}?",
                "Adventure is calling our names!",
                "I\'m quite the pretty bird!",
                "Ready for action, {PLAYER}!",
                "Where are we headed next, matey?",
                "The wind is in our favor!",
                "Another day, another adventure!",
                "Keep your eyes on the horizon!",
                "Life on the seas is the best!",
                "Smooth sailing ahead, {PLAYER}!",
                "The ocean is beautiful today!",
                "What a lovely view from up here!",
                "I love being a bird, {PLAYER}!",
                "The sun feels nice today!",
                "Feeling good today, {PLAYER}!",
                "Ready for whatever comes next!",
                "The world is full of possibilities!",
                "Can\'t wait to see what happens!",
                "This is the life, {PLAYER}!",
                "Every day is an adventure with you!",
                "Where to next, {PLAYER}?",
                "I\'m ready when you are!",
                "Let\'s make today count!",
                "The seas are ours to explore!"
            },
            ["RichPlayer"] = {
                "Look at all that Peli, {PLAYER}!",
                "We\'re swimming in treasure!",
                "You\'re quite wealthy, {PLAYER}!",
                "All that Peli is impressive!",
                "Rich as can be, {PLAYER}!",
                "We\'ve got more than enough Peli!",
                "You\'re doing well for yourself!",
                "That\'s a fortune you\'ve got there!",
                "Living the good life, {PLAYER}!",
                "Money isn\'t a problem for us!",
                "We\'re set for life, {PLAYER}!"
            },
            ["PoorPlayer"] = {
                "Our pockets are looking empty, {PLAYER}!",
                "Time to earn some Peli!",
                "We could use more treasure!",
                "Barely a berry to our name!",
                "Let\'s go make some money, {PLAYER}!",
                "The coffers are running dry!",
                "We need to find some work!",
                "Time to take on some quests!",
                "A little Peli would help right now!",
                "We\'re running on fumes, {PLAYER}!",
                "Better start saving up!",
                "Every bit of Peli counts!"
            },
            ["ModeratePeli"] = {
                "Decent amount of Peli we\'ve got!",
                "Not bad, but we could always use more!",
                "Our funds are looking alright!",
                "We\'re doing okay, {PLAYER}!",
                "Comfortable amount of Peli!",
                "We\'re neither rich nor poor!",
                "Could be worse, could be better!",
                "A respectable amount, {PLAYER}!",
                "We\'re managing just fine!",
                "Enough to get by comfortably!"
            },
            ["FishingRod"] = {
                "Time to catch some fish!",
                "Let\'s see what\'s biting today!",
                "Hope we catch a big one, {PLAYER}!",
                "Fishing time, {PLAYER}!",
                "What will we reel in today?",
                "The fish are calling!",
                "Perfect weather for fishing!",
                "I wonder what\'s under the water!",
                "Maybe we\'ll catch something rare!",
                "Patience is key with fishing!",
                "The water looks promising today!",
                "Let\'s fill our nets, {PLAYER}!",
                "Hope the fish are hungry today!"
            },
            ["Katana"] = {
                "That\'s a fine blade, {PLAYER}!",
                "Ready to slice through anything!",
                "Sharp as can be!",
                "Time to show them your skills!",
                "Looking sharp today, {PLAYER}!",
                "Swift and deadly, just like you!",
                "That blade looks fearsome!",
                "A warrior\'s weapon!",
                "Perfect for close combat!",
                "Your swordsmanship is impressive!",
                "That edge looks razor sharp!",
                "A blade fit for a master!"
            },
            ["Weapon"] = {
                "Armed and ready, {PLAYER}!",
                "Time to put that weapon to use!",
                "Looking dangerous today!",
                "Ready for battle, {PLAYER}!",
                "That\'s a mighty fine weapon!",
                "Let\'s show them what we\'ve got!",
                "You\'re well equipped!",
                "That\'ll strike fear in them!",
                "A formidable choice, {PLAYER}!",
                "Ready to defend ourselves!",
                "That weapon suits you well!",
                "Prepared for anything!"
            },
            ["TradeHub"] = {
                "Time to make some deals, {PLAYER}!",
                "Let\'s see what\'s for trade today!",
                "Maybe we\'ll find a good bargain!",
                "Trading time, {PLAYER}!",
                "What treasures can we trade for?",
                "Let\'s see what they\'re offering!",
                "The market is open for business!",
                "Time to browse the wares!",
                "Perhaps we\'ll find something useful!",
                "Let\'s see if anyone has what we need!",
                "Good place to do business!",
                "Wonder what deals are available today!",
                "Dont get scammed, {PLAYER}!"
            }
        }
    }
    local u15 = {}
    local u16 = nil
    function GetRandomVoiceline(p17)
        --[[
        Upvalues:
            [1] = u15
            [2] = u16
            [3] = u8
        --]]
        if not p17 or #p17 == 0 then
            return nil
        end
        if not u15[p17] then
            u15[p17] = {}
        end
        local v18 = {}
        for _, v19 in ipairs(p17) do
            if not table.find(u15[p17], v19) and v19 ~= u16 then
                table.insert(v18, v19)
            end
        end
        local v20
        if #v18 == 0 then
            u15[p17] = {}
            for _, v21 in ipairs(p17) do
                if v21 ~= u16 then
                    table.insert(v18, v21)
                end
            end
            if #v18 == 0 then
                v20 = p17
            else
                v20 = p17
                p17 = v18
            end
        else
            v20 = p17
            p17 = v18
        end
        local v22 = p17[u8:NextInteger(1, #p17)]
        local v23 = u15[v20]
        table.insert(v23, v22)
        u16 = v22
        return v22
    end
    function GetIdleVoiceline()
        --[[
        Upvalues:
            [1] = u5
            [2] = u14
            [3] = u2
            [4] = u8
            [5] = u3
            [6] = u7
            [7] = u4
        --]]
        local v24 = u5.Character
        if v24 then
            if u2:FindFirstChild("tradingHUB") and u8:NextInteger(1, 100) <= 50 then
                return GetRandomVoiceline(u14.Idle.TradeHub)
            else
                local v25 = v24:FindFirstChildOfClass("Tool")
                if v25 and u3[v25.Name] then
                    local v26 = u3[v25.Name].Type
                    if u8:NextInteger(1, 100) <= 60 then
                        if v26 == "Fishing Rod" and u14.Idle.FishingRod then
                            return GetRandomVoiceline(u14.Idle.FishingRod)
                        end
                        if v26 == "Katana" and u14.Idle.Katana then
                            return GetRandomVoiceline(u14.Idle.Katana)
                        end
                    end
                end
                local v27 = u7.Stats.Peli.Value / u4 * 100
                local v28 = u8:NextInteger(1, 100)
                if v27 >= 75 and v28 <= 40 then
                    return GetRandomVoiceline(u14.Idle.RichPlayer)
                elseif v27 <= 10 and v28 <= 40 then
                    return GetRandomVoiceline(u14.Idle.PoorPlayer)
                elseif v27 > 10 and (v27 < 75 and v28 <= 30) then
                    return GetRandomVoiceline(u14.Idle.ModeratePeli)
                else
                    return GetRandomVoiceline(u14.Idle.General)
                end
            end
        else
            return GetRandomVoiceline(u14.Idle.General)
        end
    end
    local u29 = 0
    function PlayParrotVoiceline(p30)
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
        --]]
        local v31 = u5.DisplayName
        local v32 = string.gsub(p30, "{PLAYER}", v31)
        _G.PlayEffect("TTSMessage", nil, {
            ["CFrame"] = u6.PrimaryPart.CFrame,
            ["Text"] = v32,
            ["VoiceId"] = 4,
            ["Pitch"] = 4,
            ["Speed"] = 1
        })
    end
    local u33 = u6:WaitForChild("Character", 3)
    local u34 = u6:WaitForChild("AnimationController")
    u34:LoadAnimation(script.Idle):Play()
    local u35 = 0
    if u33 and u33.Value == u5.Character then
        local u36 = u5.Character:WaitForChild("Humanoid")
        task.spawn(function() --[[ Line: 321 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u5
                [3] = u6
                [4] = u29
                [5] = u36
                [6] = u35
                [7] = u34
                [8] = u14
            --]]
            while u33.Value == u5.Character and u6:IsDescendantOf(workspace) do
                local v37 = tick()
                if v37 - u29 >= 5 then
                    local v38 = u5.Character
                    local v39 = u36.Health / u36.MaxHealth * 100
                    if v38 then
                        v38 = v38:FindFirstChild("inCombat")
                    end
                    u35 = u35 + 1
                    if u35 > 3 then
                        u35 = 1
                    end
                    u34:LoadAnimation(script.Talks["Talk" .. u35]):Play()
                    if v39 <= 25 and v39 > 0 then
                        local v40 = GetRandomVoiceline(u14.LowHealth)
                        if v40 then
                            PlayParrotVoiceline(v40)
                            u29 = v37
                        end
                    elseif v38 then
                        local v41 = GetRandomVoiceline(u14.Combat)
                        if v41 then
                            PlayParrotVoiceline(v41)
                            u29 = v37
                        end
                    else
                        local v42 = GetIdleVoiceline()
                        if v42 then
                            PlayParrotVoiceline(v42)
                            u29 = v37
                        end
                    end
                end
                task.wait(15)
            end
        end)
    end
end