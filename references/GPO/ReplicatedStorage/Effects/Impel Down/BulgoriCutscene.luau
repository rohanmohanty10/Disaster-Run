 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
function v1.start(_, p2) --[[ Line: 9 ]]
    if p2 == nil then
        return
    else
        local v3 = p2:FindFirstChild("Humanoid")
        local v4 = v3:FindFirstChild("Animator") or v3
        local v5 = p2:FindFirstChild("HumanoidRootPart")
        if v5 ~= nil then
            _G.PlayEffect("CameraHideUI", nil, true)
            _G.PlayEffect("ScreenFade", nil, 1, true)
            task.wait(0.5)
            _G.PlaySound(p2.HumanoidRootPart, script.CutsceneSFX).Parent = p2.PrimaryPart
            local u6 = true
            local u7 = workspace.CurrentCamera
            local v8 = workspace.CurrentCamera.CFrame
            local u9 = script.CamRig:Clone()
            u9.Parent = workspace.Effects
            u9:PivotTo(p2.PrimaryPart.CFrame * CFrame.new(3.75, -8.507999999999981, -198.9864959716797) * CFrame.Angles(0, 3.141592653589793, 0))
            _G.destroy(u9, 11)
            local v10 = v4:LoadAnimation(script.BulgoriAnim)
            local v11 = u9.AnimationController:LoadAnimation(script.CamAnimation)
            v10.Looped = false
            v10:Play()
            v10.Priority = Enum.AnimationPriority.Action4
            v10:AdjustWeight(5)
            v10.Priority = Enum.AnimationPriority.Action4
            v3.AutoRotate = false
            v11:Play()
            v11:AdjustWeight(5)
            u7.CameraType = Enum.CameraType.Scriptable
            u7.CFrame = u9.CameraPart.CFrame
            v5.Anchored = true
            task.spawn(function() --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                    [3] = u9
                --]]
                while u6 == true do
                    u7.CFrame = u9.CameraPart.CFrame
                    game["Run Service"].RenderStepped:Wait()
                end
            end)
            task.wait(1.3)
            u6 = false
            u9:Destroy()
            _G.PlayEffect("ScreenFade", nil, 0.45, true)
            task.wait(0.225)
            u7.CameraType = Enum.CameraType.Custom
            u7.CFrame = v8
            _G.PlayEffect("CameraHideUI", nil, false)
            v5.Anchored = false
            v3.AutoRotate = true
        end
    end
end
return v1