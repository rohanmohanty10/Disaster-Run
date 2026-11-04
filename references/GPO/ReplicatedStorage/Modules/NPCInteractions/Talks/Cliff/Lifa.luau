 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 3,
    ["NPC"] = "Lifa",
    ["Talk1"] = {
        ["Text"] = "Hello there im a PRO at rokushiki...",
        ["go"] = "plz teach me sis..",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Ok ill teach u only if u have <Color=Yellow>10k peli<Color=/> 4 me...",
        ["go"] = "yeye i have ur money",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "thanks for money ive teached u rokushiki<AnimateYield=.45>, come back to learn the skills.<AnimateYield=.5>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Rokushiki")
        end
    },
    ["nomoney"] = {
        ["Text"] = "... <Color=Red>u dont have enough money<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnShigan"] = {
        ["Text"] = "<Color=Green>Shigan<Color=/> is a piercing technique that delivers stabbing attacks through the user\'s finger. Learning it requires at least <Color=Blue>1<Color=/> mastery and will cost you<Color=Yellow> 0 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnSoru"] = {
        ["Text"] = "<Color=Green>Soru<Color=/> is a blitzing technique that enables high-speed manuevers. Learning it requires at least <Color=Blue>5<Color=/> mastery and will cost you<Color=Yellow> 1250 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnTekkai"] = {
        ["Text"] = "<Color=Green>Tekkai<Color=/> is an enhancement technique that hardens one\'s defence. Learning it requires at least <Color=Blue>15<Color=/> mastery and will cost you<Color=Yellow> 1500 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnGeppo"] = {
        ["Text"] = "<Color=Green>Geppo<Color=/> is an evasion technique that enables aerial manuevers. Learning it requires at least <Color=Blue>20<Color=/> mastery and will cost you<Color=Yellow> 1750 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnRankakyu"] = {
        ["Text"] = "<Color=Green>Rankyaku<Color=/> is a ranged cutting technique through accelerated kicks. Learning it requires at least <Color=Blue>25<Color=/> mastery and will cost you<Color=Yellow> 2000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnRokuogan"] = {
        ["Text"] = "<AnimateStyle=Rainbow><Color=180,128,255>Rokuogan<Color=/><AnimateStyle=/> is the ultimate rokushiki assault technique. Learning it requires at least <Color=Blue>95<Color=/> mastery and will cost you<Color=Yellow> 9000 Peli<Color=/>.",
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
        ["excu"] = function() --[[ Name: excu, Line 89 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("Rokushiki")
        end
    },
    ["dontMeet"] = {
        ["Text"] = "<Color=Red>You do not meet the requirements<AnimateYield=.45>, dont waste my time...<Color=/>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["max"] = {
        ["Text"] = "I\'ve taught you all the skills you need to know, your a pro now.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    }
}
return v2