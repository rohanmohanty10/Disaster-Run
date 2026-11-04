 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local u2 = {}
local function u10(p3, p4) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = p3.Parent.Name == "D2" and -1 or 1
    local v6 = u2[p3]
    local v7 = CFrame.Angles
    local v8 = v5 * -95
    local v9 = v6 * v7(0, math.rad(v8), 0)
    if p4 then
        v9 = u2[p3]
    end
    _G.tween(p3, {
        5.4,
        "Smoother",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v9
    })
end
task.spawn(function() --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v11 = workspace.Islands:WaitForChild("Reverse Mountain")
    local v12 = v11:WaitForChild("Gate")
    v11:WaitForChild("Gate"):WaitForChild("D1"):WaitForChild("Pri")
    v11:WaitForChild("Gate"):WaitForChild("D2"):WaitForChild("Pri")
    if game["Run Service"]:IsClient() then
        local v13 = v12:GetDescendants()
        for v14 = 1, #v13 do
            if v13[v14]:IsA("BasePart") and v13[v14].Parent ~= v12 then
                v13[v14].CanCollide = true
            end
        end
    end
    local v15 = v11.Gate.D1.PrimaryPart
    u2[v15] = v15.CFrame
    local v16 = v11.Gate.D2.PrimaryPart
    u2[v16] = v16.CFrame
    game:GetService("ContentProvider"):PreloadAsync({ script.Animation.AnimationId })
end)
local v21 = {
    ["TalkAmmount"] = 5,
    ["NPC"] = "Gatekeeper Puff",
    ["Talk1"] = {
        ["Text"] = "remember me form <Color=Yellow>Sphix<Color=/> island??",
        ["go"] = "yes...",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "hehe well im also the gatekeeper to the <AnimateStyle=Rainbow>new world<AnimateStyle=/>......",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "since u mentally farmed me for lvls i wont open the gate for free",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "only way to open is for u to <AnimteStyle=Wiggle><Color=Red>suFFER<Color=/><AnimteStyle=/>, i want u go find the <Color=Blue>World Scroll<Color=/>. last time i saw it was near rough waters north form here.",
        ["go"] = "ok i go find for u!!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk5"] = {
        ["Text"] = "hehe ur going be mentally farmed : )",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["opengate"] = {
        ["Text"] = "i see u have been mentally farmed, i will open the gate now : )",
        ["go"] = "yes",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 91 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            local v17 = workspace.Islands:WaitForChild("Reverse Mountain")
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
            local v18 = Instance.new("BoolValue", workspace.NPCs["Gatekeeper Puff"])
            v18.Name = "busy"
            _G.destroy(v18, 10)
            task.wait(2)
            if v17.Gate:FindFirstChild("Open") == nil then
                local v19 = workspace.NPCs["Gatekeeper Puff"].Humanoid:LoadAnimation(script.Animation)
                task.wait(1)
                v19:Play()
                task.spawn(function() --[[ Line: 104 ]]
                    _G.PlayEffect("MonkeyCamera", nil)
                end)
                local v20 = script.MonkeyAlarm:Clone()
                v20.Parent = workspace.NPCs["Gatekeeper Puff"].Head
                v20:Play()
                _G.destroy(v20, 20)
                script.theme:Play()
                _G.PlayEffect("MonkeySmash", nil)
                task.wait(9.38)
                _G.shakenear(v17.Gate.Sound.Position, 400, 800, 60, -0.05)
                v17.Gate.Sound.sfx:Play()
                u10(v17.Gate.D1.PrimaryPart)
                u10(v17.Gate.D2.PrimaryPart)
                v17.Gate.Barrier.CastShadow = false
                task.wait(3)
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end
    },
    ["gateAlreadyOpen"] = {
        ["Text"] = "<Color=Red>bro the gate is already open???",
        ["go"] = "yes",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["notReady"] = {
        ["Text"] = "<Color=Red>ur too weak to explore futher...",
        ["go"] = "yes",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v21