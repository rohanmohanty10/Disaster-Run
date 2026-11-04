 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local u2 = game:GetService("Players").LocalPlayer
function v1.start(_, u3, p4, p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    print("ae")
    if u3 == nil then
        return
    else
        local v6 = u3:FindFirstChild("Humanoid")
        local v7 = v6:FindFirstChild("Animator") or v6
        local v8 = u3:FindFirstChild("HumanoidRootPart")
        if v8 ~= nil then
            _G.PlayEffect("CameraHideUI", nil, true)
            _G.PlayEffect("ScreenFade", nil, 1, true)
            task.wait(0.5)
            local u9 = true
            local u10 = workspace.CurrentCamera
            local v11 = workspace.CurrentCamera.CFrame
            local v12 = script.BaalEvolveFullCutscene:Clone()
            v12.Parent = workspace
            v12:Play()
            _G.destroy(v12, 20)
            local v13 = v7:LoadAnimation(script.CharacterAnimation)
            v13.Looped = false
            v13:Play()
            v13.Priority = Enum.AnimationPriority.Action4
            v13:AdjustWeight(5)
            local v14 = p4.AnimationController:LoadAnimation(script.CameraAnimation)
            v14.Looped = false
            v14:Play()
            v14.Priority = Enum.AnimationPriority.Action4
            v14:AdjustWeight(5)
            u2.Character.HumanoidRootPart.Anchored = true
            v6.AutoRotate = false
            local u15 = p4:FindFirstChild("Cam")
            u10.CameraType = Enum.CameraType.Scriptable
            u10.CFrame = u15.CFrame
            v8.Anchored = true
            task.delay(2.25, function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                local v16 = script.Smoke:Clone()
                v16.CFrame = u3.RightFoot.CFrame * CFrame.new(-0.5, 0, 0)
                v16.Parent = workspace.Effects
                local v17 = Instance.new("WeldConstraint")
                v17.Part0 = v16
                v17.Part1 = u3.RightFoot
                v17.Parent = v16
                task.wait(0.75)
                _G.particleEnabled(v16, false)
                _G.destroy(v16, 3)
            end)
            task.spawn(function() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u10
                    [3] = u15
                --]]
                while u9 == true do
                    u10.CFrame = u15.CFrame
                    game["Run Service"].RenderStepped:Wait()
                end
            end)
            task.wait(3.8)
            u9 = false
            _G.PlayEffect("ScreenFade", nil, 1, true)
            table.insert(p5, v11)
            v8.Anchored = false
            v6.AutoRotate = true
            u2.Character.HumanoidRootPart.Anchored = false
            p4:Destroy()
            u3:Destroy()
            _G.PlayEffect("ResBa\'alAwaken2", nil, unpack(p5))
        end
    end
end
return v1