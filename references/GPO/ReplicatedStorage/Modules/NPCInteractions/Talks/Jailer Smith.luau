 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Jailer",
    ["Talk1"] = {
        ["Text"] = "Would you like to jail that person your carrying?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Ok<AnimateYield=.5> i locked up that stinky pirate in jail<AnimateYield=.5>, heres are your rewards.<AnimateYield=2>",
        ["go"] = "Thanks",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function(p2) --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.Jail:FireServer(p2)
        end
    },
    ["NoWork"] = {
        ["Text"] = "<Color=Red>You need to cuff them before i can jail them properly.<AnimateYield=2><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["NoCarry"] = {
        ["Text"] = "<Color=Red>Your not carrying any pirates for me to jail, come back when you do.<AnimateYield=1><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["JailCD"] = {
        ["Text"] = "<Color=Red>You\'ve have recently jailed this person<AnimateYield=.45>, please wait a while before jailing them agian.<AnimateYield=2><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["IsMarine"] = {
        ["Text"] = "<Color=Red>Silly fool<AnimateYield=.45>, you cant jail your own teammates...<AnimateYield=2><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["PIRATE"] = {
        ["Text"] = "<Color=Red>GO AWAY STINKY<Color=/>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v3