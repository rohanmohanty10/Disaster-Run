 

local v1 = {}
local v2 = script.RigInfo.Frame.CFrame
local v3 = script.RigInfo.H.CFrame
local u4 = v2:Inverse() * v3
function v1.start(_, p5, p6, u7, p8, p9) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if _G.checkRenderDistance(p5.PrimaryPart.CFrame, 150) == false then
        return
    elseif p5.PrimaryPart == nil then
        return
    elseif p5:IsDescendantOf(workspace) ~= false and u7:IsDescendantOf(workspace) ~= false then
        local _ = workspace:GetServerTimeNow() - p8
        local v10 = game.Players.LocalPlayer.Character == u7
        local u11 = p5.AnimationController:LoadAnimation(script.doorAnim)
        u11:Play()
        local u12 = u7.Humanoid:LoadAnimation(script.victimAnim)
        u12:Play()
        local u13 = p6.Humanoid:LoadAnimation(script.dummyAnim)
        u13:Play()
        local u14 = script.Frame:Clone()
        u14.CFrame = p5.PrimaryPart.CFrame
        u14.Parent = workspace.Effects
        local u15 = script.Silly:Clone()
        u15.CFrame = p5.PrimaryPart.CFrame * CFrame.new(0, 0, -0.5)
        u15.Parent = workspace.Effects
        _G.PlaySound(p5.PrimaryPart, script.sfx)
        tick()
        u11:GetMarkerReachedSignal("doorAction"):Connect(function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            _G.customEmit(u14)
        end)
        u11:GetMarkerReachedSignal("stun"):Connect(function() --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            local v16 = script.Head.Alert:Clone()
            v16.Parent = u7.Head
            _G.customEmit(v16)
            _G.destroy(v16, 5)
        end)
        u11:GetMarkerReachedSignal("beatDown"):Connect(function() --[[ Line: 56 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.particleEnabled(u15, true)
        end)
        u11:GetMarkerReachedSignal("throwOut"):Connect(function() --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.particleEnabled(u15, false)
            _G.destroy(u15, 3)
        end)
        u11.Stopped:Connect(function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
                [3] = u12
                [4] = u13
            --]]
            _G.destroy(u14, 4)
            u11:Destroy()
            u12:Stop()
            u12:Destroy()
            u13:Stop()
            u13:Destroy()
        end)
        if v10 == true then
            local u17 = script.CamReAdd:Clone()
            u17:SetPrimaryPartCFrame(p5.PrimaryPart.CFrame * u4)
            u17.Parent = workspace.Effects
            u17.AnimationController:LoadAnimation(script.cameraAnim):Play()
            local u18 = nil
            local u19 = tick()
            local u20 = workspace.CurrentCamera.CFrame
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            _G.PlayEffect("CameraHideUI", nil, true)
            _G.PlayEffect("ScreenFade", nil, 0.25, true)
            task.wait(0.125)
            u7:SetPrimaryPartCFrame(p9)
            local u21 = false
            u18 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u21
                    [3] = u20
                    [4] = u18
                    [5] = u17
                --]]
                if tick() - u19 >= 6.3 and u21 == false then
                    u21 = true
                    task.spawn(function() --[[ Line: 100 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u18
                            [3] = u17
                        --]]
                        task.wait(0.25)
                        _G.PlayEffect("CameraHideUI", nil, false)
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                        workspace.CurrentCamera.CFrame = u20
                        u18:Disconnect()
                        u18 = nil
                        u17:Destroy()
                    end)
                end
                workspace.CurrentCamera.CFrame = u17.Cam.CFrame
            end)
        end
    end
end
return v1