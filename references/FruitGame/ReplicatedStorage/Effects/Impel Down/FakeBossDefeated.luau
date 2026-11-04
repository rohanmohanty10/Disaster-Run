 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local u2 = game:GetService("Players").LocalPlayer
function v1.start(_, _) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u3 = u2.Character
    if u3 == nil then
        return
    else
        u3:WaitForChild("HumanoidRootPart")
        _G.PlaySound(u3.HumanoidRootPart, script.ImpelIntroCutscene).Parent = u3.PrimaryPart
        u3:WaitForChild("RightHand", 3)
        local v4 = u3:FindFirstChild("Humanoid")
        local u5 = v4:FindFirstChild("Animator") or v4
        local v6 = u3:FindFirstChild("HumanoidRootPart")
        if v6 ~= nil then
            task.wait(0.45)
            _G.PlayEffect("CameraHideUI", nil, true)
            _G.PlayEffect("ImpelScreenFade", nil, {
                ["FadeType"] = "Out",
                ["FadeTime"] = 0.25
            })
            local u7 = true
            local u8 = workspace.CurrentCamera
            local v9 = workspace.CurrentCamera.CFrame
            local v10 = v6.Size.Y / 2 + v4.HipHeight
            local u11 = CFrame.new(0, -v10, 0)
            local u12 = script.CamRig:Clone()
            u12.Parent = workspace.Effects
            u12:PivotTo(u3:GetPivot() * u11)
            _G.destroy(u12, 11)
            pcall(function() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u5
                --]]
                local v13 = u12:FindFirstChild("AnimationController")
                local v14 = u5:LoadAnimation(script.UserAnimation)
                local v15 = v13:LoadAnimation(script.CamAnimation)
                for _, v16 in pairs(u5:GetPlayingAnimationTracks()) do
                    v16:Stop(0)
                end
                v14:Play()
                v15:Play()
                v14:AdjustWeight(2)
                v14.Priority = Enum.AnimationPriority.Action4
                v15.Priority = Enum.AnimationPriority.Action4
            end)
            v4.AutoRotate = false
            u8.CameraType = Enum.CameraType.Scriptable
            u8.CFrame = u12.Cam.CFrame
            local v17 = u8.FieldOfView
            u8.FieldOfView = 90
            v6.Anchored = true
            task.delay(3.6, function() --[[ Line: 67 ]]
                _G.PlayEffect("ScreenFade", nil, 0.45, true)
            end)
            task.delay(6.85, function() --[[ Line: 71 ]]
                _G.PlayEffect("ScreenFade", nil, 0.45, true)
            end)
            task.spawn(function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u12
                    [3] = u3
                    [4] = u11
                    [5] = u8
                --]]
                while u7 == true do
                    u12:PivotTo(u3:GetPivot() * u11)
                    u8.CFrame = u12.Cam.CFrame
                    task.wait()
                end
            end)
            task.wait(10)
            u8.FieldOfView = v17
            u7 = false
            u12:Destroy()
            u8.CameraType = Enum.CameraType.Custom
            u8.CFrame = v9
            _G.PlayEffect("ScreenFade", nil, 0.45, true)
            task.wait(0.45)
            _G.PlayEffect("CameraHideUI", nil, false)
            v6.Anchored = false
            v4.AutoRotate = true
        end
    end
end
return v1