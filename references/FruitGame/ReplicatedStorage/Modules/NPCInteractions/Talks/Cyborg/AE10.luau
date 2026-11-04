 

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
    ["NPC"] = "AE10",
    ["Talk1"] = {
        ["Text"] = "Hello there i am AE10 the Cyborg master. Do you need something?",
        ["go"] = "Teach me",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Alright ill download the latest Cyborg tech onto you...",
        ["go"] = "...",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "100% completed, chat with me aigan to learn the skills.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Cyborg")
        end
    },
    ["notCyborg"] = {
        ["Text"] = "<Color=Red>Sorry buddy your not a Cyborg i cant do anything for you<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnMachine Gun Blows"] = {
        ["Text"] = "<Color=Green>Machine Gun Blows<Color=/> is a multi-hit technique with combo potential. Learning it requires at least <Color=Blue>15<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnLaser Pulsar"] = {
        ["Text"] = "<Color=Green>Laser Pulsar<Color=/> is an attack module capable of producing intense energy beams. Learning it requires at least <Color=Blue>25<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnCyborg Flight"] = {
        ["Text"] = "<Color=Green>Cyborg Flight<Color=/> is a transportation module for aerial movement. Learning it requires at least <Color=Blue>45<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnSelf Repair"] = {
        ["Text"] = "<Color=Green>Self Repair<Color=/> is a way to recover from damage gradually. Learning it requires at least <Color=Blue>65<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnMissle Shower"] = {
        ["Text"] = "<Color=Blue>Missile Shower<Color=/> is an advanced attack module that allows projectiles to be fired in rapid succession. Learning it requires at least <Color=Blue>75<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnObliteration Rush"] = {
        ["Text"] = "<Color=Blue>Obliteration Rush<Color=/> is a combo technique that makes use of every destructive capability possessed by cyborgs. Learning it requires at least <Color=Blue>100<Color=/> mastery and will cost you <Color=Yellow>1 Cyborg Gear<Color=/>.",
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
            game.ReplicatedStorage.Events.learnSkill:FireServer("Cyborg")
        end
    },
    ["dontMeet"] = {
        ["Text"] = "<Color=Red>You do not meet the requirements<AnimateYield=.45>, dont waste my time...<Color=/>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["upgrade1"] = {
        ["Text"] = "Looks like i\'ve taught you enough to be able to show you the possible upgrades. You can also have my outfit for free!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["upgrade2"] = {
        ["Text"] = "Ok take a look at these",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 113 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("CyborgUpgrade")
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
return v2