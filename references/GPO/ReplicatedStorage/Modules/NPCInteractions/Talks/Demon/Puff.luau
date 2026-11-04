 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local function u5(p2) --[[ Line: 6 ]]
    local v3 = script:GetChildren()
    for v4 = 1, #v3 do
        v3[v4]:Stop()
    end
    p2:Play()
end
local v6 = {
    ["TalkAmmount"] = 5,
    ["NPC"] = "Puff",
    ["notMeet"] = {
        ["Text"] = "<Color=Red>Go away i have no intrest in you!",
        ["go"] = "bro teach me!!",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["notWorth"] = {
        ["Text"] = "<Color=Red>You are not worthy of my teachings.",
        ["go"] = "bro teach me!!",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 30 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.notworthy)
        end
    },
    ["notBurn"] = {
        ["Text"] = "<Color=Red>Your heart does not burn hot enough.",
        ["go"] = "bro teach me!!",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 40 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.heartnotready)
        end
    },
    ["Talk1"] = {
        ["Text"] = "Heh, looks like we share the same roots...",
        ["go"] = "yes",
        ["stop"] = "bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false,
        ["excu"] = function() --[[ Name: excu, Line 50 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.root)
        end
    },
    ["Talk2"] = {
        ["Text"] = "Your current way of fighting is still far form complete, those legs of yours are far too weak to compete with the top pirates, but im just looking out for ur safety.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false,
        ["excu"] = function() --[[ Name: excu, Line 60 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.curtway)
        end
    },
    ["Talk3"] = {
        ["Text"] = "I can help evolve your fighting style into <Color=Red>Demon Step<Color=/> which adds flames over your leg, allowing you to deal powerful attacks.",
        ["go"] = "YES",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false,
        ["excu"] = function() --[[ Name: excu, Line 70 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.helpevolve)
        end
    },
    ["Talk4"] = {
        ["Text"] = "My teachings arent free, you have to prove to me that you are worthy by having a <Color=Red>Scorched Heart<Color=/>, <Color=Yellow>125<Color=/> mastery in <Color=Blue>Black Leg<Color=/> and bring me <Color=Yellow>50,000<Color=/> peli.",
        ["go"] = "Yes i meet your worthiness",
        ["stop"] = "bye",
        ["stoptext"] = "...........................",
        ["endtext"] = false,
        ["excu"] = function() --[[ Name: excu, Line 81 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.requirements)
        end
    },
    ["Talk5"] = {
        ["Text"] = "Ok i\'ve evolved your fighting style<AnimateYield=.5>, remember your <Color=Red>heart<Color=/> burns hotter than your <Color=Red><AnimateStyle=Wiggle>flames<AnimateStyle=/><Color=/>.<AnimateYield=3>",
        ["go"] = "...",
        ["stop"] = "bye",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 92 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.evolved)
            game.ReplicatedStorage.Events.learnStyle:FireServer("BlackLeg")
        end
    },
    ["learnDemon Spectrum"] = {
        ["Text"] = "<Color=Green>Demon Spectrum<Color=/> is a kick barrage performed with the demon leg. Learning it requires at least <Color=Blue>75<Color=/> mastery and will cost you<Color=Yellow> 0 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDemon Flash"] = {
        ["Text"] = "<Color=Green>Demon Flash<Color=/> is a short-distance teleportation technique used for punting singular targets. Learning it requires at least <Color=Blue>85<Color=/> mastery and will cost you<Color=Yellow> 3000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDemon Blitz"] = {
        ["Text"] = "<Color=Green>Demon Blitz<Color=/> consists of a series of burning projectiles. Learning it requires at least <Color=Blue>90<Color=/> mastery and will cost you<Color=Yellow> 5000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDemon Axe Drop"] = {
        ["Text"] = "<Color=Green>Demon Axe Drop<Color=/> is a two-stage technique utilizing both the demon spectrum and a devestating drop-kick. Learning it requires at least <Color=Blue>130<Color=/> mastery and will cost you<Color=Yellow> 8000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDemonic Sky Driller"] = {
        ["Text"] = "<AnimateStyle=Rainbow><Color=180,128,255>Demonic Sky Driller<Color=/><AnimateStyle=/> is a long-distance teleportation technique that launches the target airborne. Learning it requires at least <Color=Blue>150<Color=/> mastery and will cost you<Color=Yellow> 12000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnedSkill"] = {
        ["Text"] = "Ok ive taught you the skill.<AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 139 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("BlackLeg")
        end
    },
    ["dontMeet"] = {
        ["Text"] = "<Color=Red>You do not meet the requirements<AnimateYield=.45>, dont waste my time...<Color=/>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 149 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5(script.waste)
        end
    },
    ["max"] = {
        ["Text"] = "I\'ve taught you all the skills you need to know, your a pro now.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    }
}
return v6