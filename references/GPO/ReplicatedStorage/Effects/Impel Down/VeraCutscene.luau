 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local u2 = game:GetService("Players").LocalPlayer
function v1.start(_, p3) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3 == nil then
        return
    else
        local v4 = p3:FindFirstChild("Humanoid")
        local v5 = v4:FindFirstChild("Animator") or v4
        local v6 = p3:FindFirstChild("HumanoidRootPart")
        if v6 ~= nil then
            _G.PlayEffect("CameraHideUI", nil, true)
            _G.PlayEffect("ScreenFade", nil, 1, true)
            task.wait(0.5)
            _G.PlaySound(p3.HumanoidRootPart, script.CutsceneSFX).Parent = p3.UpperTorso
            local u7 = true
            local u8 = workspace.CurrentCamera
            local v9 = workspace.CurrentCamera.CFrame
            local v10 = v5:LoadAnimation(script.CharacterAnimation)
            v10.Looped = false
            v10:Play()
            v10.Priority = Enum.AnimationPriority.Action4
            v10:AdjustWeight(5)
            local v11 = {}
            local v12 = p3:WaitForChild("Vera\'s WhipSword", 3)
            if v12 then
                local v13 = v12.AnimationController:GetPlayingAnimationTracks()
                for v14 = 1, #v13 do
                    local v15 = v13[v14]
                    table.insert(v11, v15)
                    v13[v14]:Stop()
                end
                local v16 = v12.AnimationController:LoadAnimation(script.WhipAnim)
                v16.Looped = false
                v16:Play()
                v16.Priority = Enum.AnimationPriority.Action4
                v16:AdjustWeight(5)
            end
            u2.Character.HumanoidRootPart.Anchored = true
            v4.AutoRotate = false
            local u17 = p3:FindFirstChild("CameraPart")
            u8.CameraType = Enum.CameraType.Scriptable
            u8.CFrame = u17.CFrame
            v6.Anchored = true
            task.spawn(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u8
                    [3] = u17
                --]]
                while u7 == true do
                    u8.CFrame = u17.CFrame
                    game["Run Service"].RenderStepped:Wait()
                end
            end)
            task.wait(4.1)
            u7 = false
            _G.PlayEffect("ScreenFade", nil, 0.45, true)
            task.wait(0.225)
            u8.CameraType = Enum.CameraType.Custom
            u8.CFrame = v9
            _G.PlayEffect("CameraHideUI", nil, false)
            v6.Anchored = false
            v4.AutoRotate = true
            u2.Character.HumanoidRootPart.Anchored = false
            for v18 = 1, #v11 do
                v11[v18]:Play()
            end
            while v4.Health > 0 do
                _G.PlaySound(p3.PrimaryPart, script.Laughs["VenomBossLaugh" .. math.random(1, 6)]).Parent = p3.PrimaryPart
                task.wait(math.random(8, 16))
            end
        end
    end
end
return v1