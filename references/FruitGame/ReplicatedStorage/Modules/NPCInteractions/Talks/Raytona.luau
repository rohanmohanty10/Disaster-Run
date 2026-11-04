 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 4,
    ["NPC"] = "Raytona",
    ["Talk1"] = {
        ["Text"] = "Heh, you found me so I\'m guessing you already have what I require?",
        ["go"] = "yes...",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Evolving your spirit will require intense concentration and the <Color=Green>Spirit Essence<Color=/>, score 20 points on my test and ill evolve your spirit.",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "As you score more points the spirit essence will slowly reveal the <AnimateStyle=Rainbow>color<AnimateStyle=/> of your true spirit!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Have a seat on the mat and let\'s begin the test!",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 36 ]]
            task.wait(3)
            local v2 = game.Players.LocalPlayer.Character
            repeat
                game["Run Service"].Heartbeat:Wait()
            until (v2.HumanoidRootPart.Position - (workspace.NPCs.Raytona.Mat.Position + Vector3.new(0, 2, 0))).magnitude <= 3
            v2.HumanoidRootPart.Anchored = true
            v2.HumanoidRootPart.Velocity = Vector3.new()
            game.ReplicatedStorage.Events.Haki:FireServer("trainV2")
        end
    },
    ["donthave"] = {
        ["Text"] = "<Color=Red>your not ready for this yet......",
        ["go"] = "ok i go find for u!!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["alreadyTeached"] = {
        ["Text"] = "<Color=Red>fellow student ive already evlolved your spirt??",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v3