 

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
    ["NPC"] = "Jaggy",
    ["Talk1"] = {
        ["Text"] = "hi there im jaggy the 1 sword style trainer...",
        ["go"] = "bro teach me!!",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "ok i teach u only if have <Color=Yellow>10k peli<Color=/> and u need a katana bro",
        ["go"] = "yeye i have ur money",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "thanks for money ive teached u 1 sword style <AnimateYield=.45>, come back to learn the skills.<AnimateYield=.5>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("1SS")
        end
    },
    ["nomoney"] = {
        ["Text"] = "... <Color=Red>u dont have enough money<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["katana"] = {
        ["Text"] = "... <Color=Red>u a katana buy one form billy which is in one of these houses<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learn36 Caliber Phoenix"] = {
        ["Text"] = "<Color=Green>36 Caliber Phoenix<Color=/> is a Ittoryu technique capable of striking foes from afar. Learning it requires at least <Color=Blue>0<Color=/> mastery and will cost you <Color=Yellow>0 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnRapid Slashes"] = {
        ["Text"] = "<Color=Green>Rapid Slashes<Color=/> is a Ittoryu technique capable of delivering numerous incisions in the span of seconds. Learning it requires at least <Color=Blue>15<Color=/> mastery and will cost you <Color=Yellow>750 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnRaging Serpent"] = {
        ["Text"] = "<Color=Green>Raging Serpent<Color=/> is a Ittoryu technique capable of instantly cutting all enemies within your realm of consciousness. Learning it requires at least <Color=Blue>45<Color=/> mastery and will cost you <Color=Yellow>1999 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnShishi Sonson"] = {
        ["Text"] = "<Color=Green>Shishi Sonson<Color=/> is a Ittoryu Iai technique capable of blitzing enemies in a straight line. Learning it requires at least <Color=Blue>80<Color=/> mastery and will cost you <Color=Yellow>9876 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Blaze"] = {
        ["Text"] = "<Color=Blue>Dragon Blaze<Color=/> is a Ittoryu technique that emulates a flying dragon to strike your foes. Learning it requires at least <Color=Blue>200<Color=/> mastery and will cost you <Color=Yellow>12345 Peli<Color=/>.",
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
        ["excu"] = function() --[[ Name: excu, Line 90 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("1SS")
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