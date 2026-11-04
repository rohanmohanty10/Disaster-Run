 

local v1 = {}
local u2 = workspace.Env.WaterStuff.Falls.Position.Y
local u3 = require(script.Parent.rougelineage)
function v1.start(_, p4, p5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if p4 ~= game.Players.LocalPlayer or u3:solans(script.Name) ~= false then
        local u6 = script.floor:Clone()
        u6.Parent = workspace.Env
        _G.destroy(u6, 2.5)
        local v7 = CFrame.new(p5.X, u2 + 0.1, p5.Z)
        local v8 = CFrame.Angles
        local v9 = math.random(-360, 360)
        u6.CFrame = v7 * v8(0, math.rad(v9), 0)
        u6.Size = Vector3.new(7.5, 1, 7.5)
        _G.tween(u6, {
            0.25,
            Enum.EasingStyle.Circular,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(15, 1, 15),
            ["CFrame"] = u6.CFrame * CFrame.Angles(0, 0.2617993877991494, 0)
        })
        u6.Sound.Pitch = math.random(100, 120) / 100
        u6.Sound:Play()
        u6.sm2:Emit(15)
        u6.CollisionGroup = "waterLogia"
        u6.Name = "iceFloor"
        spawn(function() --[[ Line: 27 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            task.wait(0.3)
            u6.sm3.Enabled = false
        end)
        task.spawn(function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            task.wait(2)
            _G.tween(u6, {
                0.5,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 0, 0)
            })
            task.wait(0.475)
            pcall(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                u6.Parent = workspace.Effects
            end)
        end)
        if p4 == game.Players.LocalPlayer then
            game.ReplicatedStorage.Events.fruitFloor:FireServer(u6.CFrame, Vector3.new(15, 1, 15), script.floor.Color)
        end
    end
end
return v1