 

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
    ["NPC"] = "Recruiter",
    ["Team"] = "Marine",
    ["Talk1"] = {
        ["Text"] = "Greetings, traveler.<AnimateYield=.25> I am a member of the <AnimateStyle=Fade><Color=Cyan>Marines!<Color=/><AnimateYield=.25><AnimateStyle=/>",
        ["go"] = "What do you guys do?",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "The Marines are enforcers of <Color=Cyan>justice<Color=/>.<AnimateYield=.25> We sail the seas to aid the weak and smite the <Color=Red>evil<Color=/>.",
        ["go"] = "Cool",
        ["stop"] = "Not intrested",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Are you interested in joining us?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Great!<AnimateYield=.25> I wish you the best of luck in our fight against pirates.<AnimateYield=.25>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function(_) --[[ Name: excu, Line 36 ]]
            game.ReplicatedStorage.Events.Team:FireServer("Marine")
        end
    },
    ["InCrew"] = {
        ["Text"] = "<Color=Red>Your currently in a crew please leave it before joining us...<Color=/><AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["TalkTeam"] = {
        ["Text"] = "Hello fellow marine...",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2