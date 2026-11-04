 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
local function u9(p2, p3, p4, p5) --[[ Line: 8 ]]
    local v6 = p5 and 1 or 0
    for _, v8 in pairs(p3) do
        if p2 then
            local v8 = p2:FindFirstChild(v8)
        end
        if v8:IsA("BasePart") and not table.find(p4, v8.Name) then
            v8.Transparency = v6
        end
    end
end
return {
    ["start"] = function(_, u10, p11, p12, p13) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u9
        --]]
        Random.new()
        if _G.checkRenderDistance(u10.PrimaryPart.Position) == false then
            return
        else
            local v14
            if p12 == nil then
                v14 = u10:GetAttribute("Transformed")
            else
                v14 = not p12
            end
            if p13 and game.Players.LocalPlayer == p13 then
                return
            else
                local u15 = u10.PrimaryPart
                u10:FindFirstChild("UpperTorso")
                local v16 = u10:FindFirstChild("Humanoid")
                u10:FindFirstChild("CharacterEffects"):FindFirstChild("Transformation")
                local v17 = u15.CFrame
                local v18 = u10:FindFirstChild("PhoenixFullForm")
                local v19 = v18:FindFirstChild("AnimationController").Animator:LoadAnimation(script.Parent.Anims.Full.TransformBurst)
                local v20 = v16.Animator
                local v21 = v18:FindFirstChild("AnimationController").Animator
                local u22 = v16.Animator:LoadAnimation(script.Parent.Anims.Hybrid.HTFCharge)
                local u23 = v16.Animator:LoadAnimation(script.Parent.Anims.Human.HTFCharge)
                local v24 = _G.SoundsFolder.Flames.PhoenixFlamesLoop
                v20:GetPlayingAnimationTracks()
                v21:GetPlayingAnimationTracks()
                if v14 then
                    if v14 then
                        for _, v25 in u15:GetChildren() do
                            if v25:IsA("Sound") and v25.Name:match("PhoenixFlamesLoop") then
                                v25:Stop()
                                v25:Destroy()
                            end
                        end
                        u9(nil, u10:GetChildren(), {
                            "HumanoidRootPart",
                            "TalonRF",
                            "TalonLF",
                            "ToriWings"
                        }, false)
                        if v18.Body.Transparency == 1 then
                            local v26 = u10:WaitForChild("ToriWings")
                            for _, v27 in { v26["Tail.001"], v26["Tail.002"], v26["Tail.003"] } do
                                Emit(v27, false, 0.15)
                            end
                        else
                            for _, v28 in {
                                v18.Body,
                                v18.Left,
                                v18.RightWing,
                                v18.Tail
                            } do
                                Emit(v28, false, 0.15)
                            end
                        end
                        for _, v29 in u10:GetChildren() do
                            if v29:IsA("Model") then
                                for _, v30 in v29:GetChildren() do
                                    if v30:IsA("BasePart") then
                                        v30.Transparency = 1
                                    end
                                end
                            end
                        end
                    end
                    return
                elseif p11 then
                    local u31 = script["Full Form Transformation"]:Clone()
                    if p12 then
                        u31:PivotTo(v17)
                        u22:Play()
                    else
                        u31:PivotTo(v17 * CFrame.new(0, -27, 0))
                        Ess.Destroy(u1.Stepped:Connect(function(_) --[[ Line: 78 ]]
                            --[[
                            Upvalues:
                                [1] = u31
                                [2] = u15
                            --]]
                            u31:PivotTo(u15.CFrame)
                        end), 1.4)
                        u23:Play()
                        task.delay(0.45, function() --[[ Line: 85 ]]
                            --[[
                            Upvalues:
                                [1] = u23
                                [2] = u10
                                [3] = u22
                            --]]
                            u23:Stop(1)
                            task.wait(0.1)
                            _G.PlayEffect("Transform", false, u10, false, true, nil)
                            u22:Play()
                        end)
                    end
                    u31.Parent = workspace.Effects
                    task.wait(0.45)
                    Emit(u31.Pull:GetDescendants(), false, 0.5)
                    task.wait(0.65)
                    v19:Play()
                    Emit(u31.Push.Attachment, true)
                    u9(nil, u10:GetDescendants(), { "HumanoidRootPart" }, true)
                    for _, v32 in v18:GetDescendants() do
                        if v32:IsA("BasePart") and not v32.Name:match("RootPart") then
                            v32.Transparency = 0
                        end
                    end
                    Ess.Destroy(u31, 1.4)
                else
                    local v33 = v24:Clone()
                    v33.Parent = u15
                    v33:Play()
                    v16.Animator:LoadAnimation(script.Parent.Anims.Hybrid.Transform):Play()
                    _G.PlayEffect("Flight", false, u10, nil)
                    u9(u10, {
                        "LeftHand",
                        "RightHand",
                        "LeftUpperArm",
                        "LeftLowerArm",
                        "RightUpperArm",
                        "RightLowerArm",
                        "LeftFoot",
                        "RightFoot"
                    }, {}, true)
                    task.wait()
                    for v34, _ in { "Right", "Left" } do
                        for _, v35 in u10:FindFirstChild(v34 == 1 and "TalonRF" or "TalonLF"):GetDescendants() do
                            if v35:IsA("BasePart") then
                                v35.Transparency = 0
                            end
                        end
                    end
                    for _, v36 in u10:FindFirstChild("ToriWings"):GetDescendants() do
                        if v36:IsA("BasePart") and not v36.Name:match("Centa") then
                            v36.Transparency = 0
                        end
                    end
                    local v37 = script["Hybrid Form Transformation"]:Clone()
                    v37:PivotTo(v17 * CFrame.new(0, -3, 0))
                    v37.Parent = workspace.Effects
                    Emit(v37:GetDescendants(), true)
                    Ess.Destroy(v37, 1.35)
                end
            end
        end
    end
}