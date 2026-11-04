 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, _, _) --[[ Line: 5 ]]
    game.Lighting.BlurF.Size = 20
    game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        ["Size"] = 0
    }, true):Play()
    local u2 = script.cameraPart:Clone()
    u2.CFrame = game.Workspace.Camera.CFrame
    u2.Parent = workspace.Effects
    _G.destroy(u2, 6.6)
    game:GetService("TweenService"):Create(u2.pulseWave, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        ["Rate"] = 0
    }, true):Play()
    local u3 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1)
    end)
    task.spawn(function() --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        script.OpeInjectionDebuffLoop:Play()
        for v4 = 10, 0, -2 do
            game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                ["FieldOfView"] = 70 - v4 / 20 * 40
            }, true):Play()
            task.wait(1)
        end
        task.wait(1.6)
        script.OpeInjectionDebuffLoop:Stop()
        u3:Disconnect()
    end)
    if _G.cameraShakeEnabled == true then
        task.spawn(function() --[[ Line: 42 ]]
            local v5 = game.Players.LocalPlayer.Character
            for v6 = 10, 0, -1 do
                local v7 = v6 / 30
                local v8 = v5.Humanoid
                local v9 = Random.new():NextNumber(-2, 2) * v7
                local v10 = Random.new():NextNumber(-2, 2) * v7
                local v11 = Random.new():NextNumber(-2, 2) * v7
                v8.CameraOffset = Vector3.new(v9, v10, v11)
                task.wait(0.025)
            end
            v5.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
        end)
    end
end
return v1