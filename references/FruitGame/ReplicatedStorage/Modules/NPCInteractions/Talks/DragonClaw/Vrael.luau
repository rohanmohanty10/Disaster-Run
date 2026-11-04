 

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
    ["NPC"] = "Musashi",
    ["Talk1"] = {
        ["Text"] = "Hello there, im a former marine and a master at dragon claw.",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I know many people want to be taught by me, but only few are actually qualified.",
        ["go"] = "...",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "My teachings require no money, however they do require you to prove your self worthy.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "For each <Color=Orange>battle royale<Color=/> you come out victorious, i\'ll teach you one skill.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk5"] = {
        ["Text"] = "If you fully prove your self worthy, i will also award you with a <Color=Orange>special weapon<Color=/> i used to use during my marine days.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 42 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("DragonClaw")
        end
    },
    ["notReq"] = {
        ["Text"] = "Remeber for each <Color=Orange>battle royale/arena battle<Color=/> you come out victorious, i\'ll teach you one skill. After you learn all the skills ill award you with a weapon i used to use.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["maxed"] = {
        ["Text"] = "<Color=Red>I\'ve taught you all that you need to learn, and that pipe, use it wisely \240\159\152\136",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["getpipe"] = {
        ["Text"] = "Heres the pipe i promised you, glad you remembered. Its a powerful weapon alone, but if you combine it with the power of the <Color=Orange>Mera<Color=/> fruit it becomes a beast.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 69 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("getPipe")
        end
    },
    ["learnDragon Fist"] = {
        ["Text"] = "<Color=Green>Dragon Fist<Color=/> is a Dragon Claw technique capable of breaking blocks and knocking enemies back.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Breath"] = {
        ["Text"] = "<Color=Green>Dragon Breath<Color=/> is a Dragon Claw technique capable of destroying the ground under you, breaking blocks and knocking enemies airbrone.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Claw Stance"] = {
        ["Text"] = "<Color=Green>Dragon Claw Stance<Color=/> is a Dragon Claw technique that will enhance your strength damage and giving you the ability to attack logia users.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Claw Slash"] = {
        ["Text"] = "<Color=Green>Dragon Claw Slash<Color=/> is a Dragon Claw technique that does 3 slashes while moving foward.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Rush"] = {
        ["Text"] = "<Color=Green>Dragon Rush<Color=/> is a Dragon Claw technique that drags your enemies by the head and slams them into the ground while dashing foward.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnReverse Dragon"] = {
        ["Text"] = "<Color=Green>Reverse Dragon<Color=/> is a Dragon Claw technique capable of countering short ranage attacks, enemies that try attacking you will be thrown backwards.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnDragon Skull Crusher"] = {
        ["Text"] = "<Color=Red>Dragon Skull Crusher<Color=/> is the ULTIMATE Dragon Claw technique, emulating the claws of a dragon grab an enemy by the head,crush their skull, and finally send them flying with a punch.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnedSkill"] = {
        ["Text"] = "Ok ive taught you the skill.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 129 ]]
            warn("fired learn skill")
            game.ReplicatedStorage.Events.learnSkill:FireServer("DragonClaw")
        end
    }
}
return v2