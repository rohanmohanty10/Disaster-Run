 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 5,
    ["NPC"] = "Jin",
    ["Talk1"] = {
        ["Text"] = "Im a master at fishman karate, ive been practicing for many years..",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "My old age will eventually get me, i want to pass down my techniques to youngsters like you before its too late...",
        ["go"] = "...",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "I\'ll be willing to teach you if you can prove that your worthy by bringing me the teeth of <Color=Red>75<Color=/> slan sharks and a bag of <Color=Yellow>30000<Color=/> peli",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Do you have these on you?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk5"] = {
        ["Text"] = "Very well, i\'ve passed down my techniques to you, train well!<AnimateYield=2>",
        ["go"] = "yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 44 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("FishmanKarate")
        end
    },
    ["notRace"] = {
        ["Text"] = "<Color=Red>You are not capable of learning my techniques!<AnimateYield=1>",
        ["go"] = "yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>You either dont have enough money or dont have the teeth of 75 slan sharks!<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnFive Thousand Brick Fist"] = {
        ["Text"] = "<Color=Green>Five Thousand Brick Fist<Color=/> is a punch capable of shattering 5,000 brick tiles. Learning it requires at least <Color=Blue>0<Color=/> mastery and will cost you<Color=Yellow> 0 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnWater Prison"] = {
        ["Text"] = "<Color=Green>Water Prison<Color=/> is a fishman technique used for trapping and disorienting enemies. Learning it requires at least <Color=Blue>25<Color=/> mastery and will cost you<Color=Yellow> 2000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnShark Barrage"] = {
        ["Text"] = "<Color=Green>Shark Barrage<Color=/> is a fishman technique capable of firing dozens of projectiles in succession. Learning it requires at least <Color=Blue>50<Color=/> mastery and will cost you<Color=Yellow> 4000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnWater Serpent"] = {
        ["Text"] = "<Color=Green>Water Serpent<Color=/> is a torpedo-like projectile maneuvered at the user\'s will. Learning it requires at least <Color=Blue>75<Color=/> mastery and will cost you<Color=Yellow> 6000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnWater Bomb"] = {
        ["Text"] = "<AnimateStyle=Rainbow><Color=180,128,255>Water Bomb<Color=/><AnimateStyle=/> is a technique available only to the most tenacious of water benders. Learning it requires at least <Color=Blue>125<Color=/> mastery and will cost you<Color=Yellow> 12000 Peli<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnedSkill"] = {
        ["Text"] = "Ok i\'ve passed down this technique to you.<AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 106 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("FishmanKarate")
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
        ["Text"] = "I\'ve passed down all the technique i can, you\'ve mastered fishman karate!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["swap1"] = {
        ["Text"] = "Would you like to switch to <Color=Blue>Fishman Karate<Color=/>?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["swap2"] = {
        ["Text"] = "There you go!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 138 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("FishmanKarate")
        end
    }
}
return v2