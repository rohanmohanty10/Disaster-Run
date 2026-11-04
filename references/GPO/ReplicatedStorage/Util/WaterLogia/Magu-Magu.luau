 

local v1 = {}
local u2 = workspace.Env.WaterStuff.Falls.Position.Y
local function u6(p3) --[[ Line: 3 ]]
    local v4 = script.ball:GetChildren()
    for v5 = 1, #v4 do
        v4[v5]:Clone().Parent = p3
    end
end
local u7 = require(script.Parent.rougelineage)
function v1.start(_, p8, p9) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u2
    --]]
    if p8 ~= game.Players.LocalPlayer or u7:solans(script.Name) ~= false then
        local u10 = _G.clientEffectsFolder.DevilFruits.Magu.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
        u10:ClearAllChildren()
        u6(u10)
        u10.Parent = workspace.Env
        u10.CanCollide = true
        local v11 = CFrame.new(p9.X, u2, p9.Z)
        local v12 = CFrame.Angles
        local v13 = math.random(-360, 360)
        u10.CFrame = v11 * v12(0, math.rad(v13), 0)
        _G.destroy(u10, 2.5)
        local v14 = math.random(100, 200) / 100
        u10.Size = Vector3.new(7.5, v14, 7.5)
        _G.tween(u10, {
            1,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(15, v14, 15)
        })
        _G.PlaySound(u10, script["MaguStep" .. math.random(1, 3)])
        u10.CollisionGroup = "waterLogia"
        _G.destroy(u10, 4)
        task.spawn(function() --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            task.wait(0.1)
            u10.sm2:Emit(10)
        end)
        task.spawn(function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            task.wait(2)
            _G.tween(u10, {
                0.5,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Color"] = Color3.fromRGB(0, 0, 0)
            })
            task.wait(0.475)
            pcall(function() --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                u10.Parent = workspace.Effects
            end)
        end)
        if p8 == game.Players.LocalPlayer then
            game.ReplicatedStorage.Events.fruitFloor:FireServer(u10.CFrame, Vector3.new(15, v14, 15), BrickColor.new("Medium red").Color)
        end
    end
end
return v1