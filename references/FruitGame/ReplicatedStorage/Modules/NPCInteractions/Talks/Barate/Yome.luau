 

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
    ["NPC"] = "Yome",
    ["Talk1"] = {
        ["Text"] = "A real man never kicks a woman, a cook never uses his hands to fight people.",
        ["go"] = "yeyeye",
        ["stop"] = "nooo",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = " Say, would you like to learn Black-leg? It\'s a unique fighting style focusing only on kicks, keeping you away from damaging your hands. I\'ll teach you it for <Color=Yellow>9000<Color=/> peli.",
        ["go"] = "yeye i have ur money",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Come back to learn the skills!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("BlackLeg")
        end
    },
    ["nomoney"] = {
        ["Text"] = "... <Color=Red>u dont have enough money<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnB-Shot"] = {
        ["Text"] = "<Color=Green>B-Shot<Color=/> is a short-ranged blackleg technique capable of knocking back foes. Learning it requires at least <Color=Blue>1<Color=/> mastery and will cost you <Color=Yellow>0 Peli<Color=/>.",
        ["stop"] = "...",
        ["go"] = "Teach me.",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnCoiller"] = {
        ["Text"] = "<Color=Green>Collier<Color=/> is a short-ranged blackleg technique capable of temporarily incapacitating a target. Learning it requires at least <Color=Blue>10<Color=/> mastery and will cost you <Color=Yellow>500 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnSky Walk"] = {
        ["Text"] = "<Color=Green>Sky Walk<Color=/> is a dynamic blackleg technique that enables aerial maneuvers. Learning it requires at least <Color=Blue>20<Color=/> mastery and will cost you <Color=Yellow>750 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnParty Table Kick Course"] = {
        ["Text"] = "<Color=Green>Party Table Kick Course<Color=/> is a short-ranged blackleg technique that continuously staggers opponents with a flurry of kicks. Learning it requires at least <Color=Blue>30<Color=/> mastery and will cost you <Color=Yellow>1800 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnConcasser"] = {
        ["Text"] = "<Color=Green>Concasser<Color=/> is a short to mid-ranged leaping blackleg technique capable of knocking nearby opponents airborne.Learning it requires at least <Color=Blue>30<Color=/> mastery and will cost you <Color=Yellow>1800 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnAnti-Manner Kick Course"] = {
        ["Text"] = "<Color=Green>Anti-Manner Kick Course<Color=/> is an improved blackleg technique boasting heavier hits than its predecessor. Learning it requires at least <Color=Blue>55<Color=/> mastery and will cost you <Color=Yellow>3000 Peli<Color=/>.",
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
            game.ReplicatedStorage.Events.learnSkill:FireServer("BlackLeg")
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
        ["Text"] = "I\'ve taught you all the skills you need to know.<AnimateYield=.45> If you want to learn how to evolve your fighting style go find my master<AnimateYield=.45>, <Color=Green>Puff<Color=/> near sphinx island<AnimateYield=2>.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    }
}
return v2