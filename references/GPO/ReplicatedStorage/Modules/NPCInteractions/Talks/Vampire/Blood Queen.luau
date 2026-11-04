 

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
    ["NPC"] = "Lord Cartier the 5th",
    ["Talk1"] = {
        ["Text"] = "Another one of my kind, how good it is to see you!",
        ["go"] = "Can you teach me the Vampire fighting style?",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Hmm, I mean... I guess I could teach you... for a small fee of.. let\'s say... 50,000 Peli?",
        ["go"] = "...",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Talk to me aigan to learn the skills!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Vampire")
        end
    },
    ["notRace"] = {
        ["Text"] = "<Color=Red>Back away your not one of my kind!",
        ["go"] = "My bad",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["max"] = {
        ["Text"] = "<Color=Red>Unequaled, Unriva- I mean... Nice you learned everything! \240\159\152\136",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "You already learned everthing I have to offer...",
        ["endtext"] = true
    },
    ["dontMeet"] = {
        ["Text"] = "You dont have enough peli...",
        ["go"] = "My bad",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnVampire Bite"] = {
        ["Text"] = "<Color=Red>Vampire bite<Color=/> is a Vampire technique that lets you leap and bite, replenishing your health and blood bar. This will cost you and a bag of <Color=Yellow>5000<Color=/> peli and 25 mastery.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnBlood Dash"] = {
        ["Text"] = "<Color=Red>Blood Dash<Color=/> is a Vampire technique technique covers you in blood as you dash forward. This will cost you and a bag of <Color=Yellow>1000<Color=/> peli and 35 mastery.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnBlood Chain"] = {
        ["Text"] = "<Color=Red>Blood Chain<Color=/> is a Vampire technique that will impale opponents with a blood chain, before crushing them beneath you. This will cost you and a bag of <Color=Yellow>15000<Color=/> peli and 55 mastery.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnBlood Aura"] = {
        ["Text"] = "<Color=Red>Blood Aura<Color=/> is a Vampire technique that will enhance all your abilities with life steal. This will cost you and a bag of <Color=Yellow>25000<Color=/> peli and 65 mastery.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnBlood Dragon"] = {
        ["Text"] = "<Color=Red>Blood Dragon<Color=/> is the ultimate Vampire technique that allows you to create four blood dragons that destroy your enemies. This will cost you and a bag of <Color=Yellow>50000<Color=/> peli and 125 mastery.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnedSkill"] = {
        ["Text"] = "I\'ve taught you the skill...",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 99 ]]
            warn("fired learn skill")
            game.ReplicatedStorage.Events.learnSkill:FireServer("Vampire")
        end
    }
}
return v2