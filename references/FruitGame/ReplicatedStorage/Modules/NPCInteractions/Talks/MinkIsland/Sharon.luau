 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["NPC"] = "Sharon",
    ["NotMink"] = {
        ["Text"] = "Sharon is busy searching for <AnimateStyle=Fade><Img=137510669><AnimateStyle=/>, shoo shoo.<AnimateYield=.45>",
        ["go"] = "No plz help",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["Talk1"] = {
        ["Text"] = "This is strange, I don\'t detect any signs of <AnimateStyle=Wiggle><Color=Blue>electricity<Color=/><AnimateStyle=/> about you.<AnimateYield=.45> Have you not awakened your electro potentials?<AnimateYield=.45>",
        ["go"] = "No",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Ah, you\'re a slow one I see.<AnimateYield=.45> I\'m talking about our natural ability to wield <AnimateStyle=Wiggle><Color=Blue>electricity<Color=/><AnimateStyle=/>.<AnimateYield=.45>",
        ["go"] = "Wha??",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "But this is perfect<AnimateYield=.45>, I was just running out of <AnimateStyle=Fade><Img=137510669><AnimateStyle=/>, so I\'ll get you started if you can find me 25 of them.<AnimateYield=.25> Oh, and also <Color=Yellow>15000<Color=/> peli, just in case.<AnimateYield=.25> ",
        ["go"] = "Yes i have.",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "WOW O_O you actually did it, ok ill teach you when your ready!!",
        ["go"] = "YES",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["excu"] = function() --[[ Name: excu, Line 41 ]]
            warn("trying learn electro")
            game.ReplicatedStorage.Events.learnStyle:FireServer("Electro")
        end,
        ["endtext"] = true
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>omg wheres all the stuff i asked for?????????<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnElectro Fist"] = {
        ["Text"] = "<Color=Green>Electro Fist<Color=/> is an enhancement technique that applies electricity to melee attacks. Learning it requires at least <Color=Blue>0<Color=/> mastery and will cost you <Color=Yellow>0 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnElectro Dash"] = {
        ["Text"] = "<Color=Green>Electro Dash<Color=/> is an enhanced evasion technique that also damages enemies on contact. Learning it requires at least <Color=Blue>15<Color=/> mastery and will cost you <Color=Yellow>750 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnElectro Luna"] = {
        ["Text"] = "<Color=Green>Electro Luna<Color=/> is a mid-ranged AOE technique capable of stunning opponents. Learning it requires at least <Color=Blue>25<Color=/> mastery and will cost you <Color=Yellow>1250 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnElectro Rain"] = {
        ["Text"] = "<Color=Green>Electro Rain<Color=/> is a multi-projectile attack capable of smiting a small area.Learning it requires at least <Color=Blue>40<Color=/> mastery and will cost you <Color=Yellow>3000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnRaiju Punishment"] = {
        ["Text"] = "<Color=Green>Raiju Punishment<Color=/> is a short-ranged AOE technique capable of severely damaging nearby foes. Learning it requires at least <Color=Blue>95<Color=/> mastery and will cost you <Color=Yellow>9999 Peli<Color=/>.",
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
        ["excu"] = function() --[[ Name: excu, Line 95 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("Electro")
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
        ["Text"] = "I\'ve taught you all the skills you need to know, your a pro now. uwu",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["swapElectro1"] = {
        ["Text"] = "Would you like to switch to <Color=Blue>Electro<Color=/>?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["swapElectro2"] = {
        ["Text"] = "There you go!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 127 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Electro")
        end
    }
}
return v2