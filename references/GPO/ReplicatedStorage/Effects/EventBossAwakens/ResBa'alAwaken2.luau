 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local u2 = game:GetService("Players").LocalPlayer
function v1.start(_, p3, p4, p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3 == nil then
        return
    else
        local v6 = p3:FindFirstChild("Humanoid")
        local u7 = v6:FindFirstChild("Animator") or v6
        local v8 = p3:FindFirstChild("HumanoidRootPart")
        if v8 ~= nil then
            _G.PlayEffect("ScreenFade", nil, 5, true, true)
            local u9 = workspace.CurrentCamera
            local u10 = p4:FindFirstChild("Cam")
            u9.CFrame = u10.CFrame
            task.wait(2.5)
            local u11 = true
            task.delay(2.4, function() --[[ Line: 30 ]]
                _G.PlayEffect("ScreenFade", nil, 0.4, true)
            end)
            task.delay(4.4, function() --[[ Line: 35 ]]
                _G.PlayEffect("ScreenFade", nil, 0.8, true)
            end)
            task.delay(5.5, function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                local v12 = u7:LoadAnimation(script.CharacterAnimation)
                v12.Looped = false
                v12:Play()
                v12.Priority = Enum.AnimationPriority.Action4
                v12:AdjustWeight(5)
            end)
            local v13 = p4.AnimationController:LoadAnimation(script.CameraAnimation)
            v13.Looped = false
            v13:Play()
            v13.Priority = Enum.AnimationPriority.Action4
            v13:AdjustWeight(5)
            u2.Character.HumanoidRootPart.Anchored = true
            v6.AutoRotate = false
            u9.CameraType = Enum.CameraType.Scriptable
            u9.CFrame = u10.CFrame
            v8.Anchored = true
            task.spawn(function() --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u9
                    [3] = u10
                --]]
                while u11 == true do
                    u9.CFrame = u10.CFrame
                    game["Run Service"].RenderStepped:Wait()
                end
            end)
            task.wait(10.5)
            u11 = false
            _G.PlayEffect("ScreenFade", nil, 0.45, true)
            task.wait(0.225)
            u9.CameraType = Enum.CameraType.Custom
            u9.CFrame = p5
            _G.PlayEffect("CameraHideUI", nil, false)
            v8.Anchored = false
            v6.AutoRotate = true
            u2.Character.HumanoidRootPart.Anchored = false
            p4:Destroy()
            p3:Destroy()
        end
    end
end
return v1