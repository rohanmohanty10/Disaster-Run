 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = {}
local u4 = _G.customEmit
function u3.CubicBezier(_, p5, p6, p7, p8, p9) --[[ Line: 17 ]]
    return (1 - p5) ^ 3 * p6 + (1 - p5) ^ 2 * 3 * p5 * p7 + (1 - p5) * 3 * p5 ^ 2 * p8 + p5 ^ 3 * p9
end
function u3.CreateTrail(_, u10, p11, p12, p13, p14) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v15 = p13 or 25
    local u16 = typeof(u10) == "CFrame" and u10 and u10 or u10:GetPivot()
    local v17 = u16 * CFrame.new(0, 1.5, 0)
    local v18 = v17 * CFrame.new(p11:NextNumber(-v15, v15), p11:NextNumber(-v15, v15), p11:NextNumber(-v15, v15))
    local v19 = v15 * 0.6
    local v20 = CFrame.lookAt(v18.Position, v17.Position) * CFrame.new(p11:NextNumber(-v19, v19), p11:NextNumber(-v19, v19), -(v17.Position - v18.Position).Magnitude / 3)
    local v21 = CFrame.lookAt(v18.Position, v17.Position) * CFrame.new(p11:NextNumber(-v19, v19), p11:NextNumber(-v19, v19), -(v17.Position - v18.Position).Magnitude / 1.5)
    local u22 = v20.Position
    local u23 = v21.Position
    local u24 = v17.Position
    local u25 = v18.Position
    local u26 = p12:Clone()
    u26.Position = u25
    u26.Parent = workspace.Effects
    local u27 = p11:NextNumber(0.1, 0.275) * (p14 or 1)
    local u28 = nil
    local u29 = 0
    u28 = u2.Heartbeat:Connect(function(p30) --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u27
            [3] = u10
            [4] = u28
            [5] = u26
            [6] = u24
            [7] = u16
            [8] = u3
            [9] = u25
            [10] = u22
            [11] = u23
        --]]
        u29 = u29 + p30 / u27
        if u29 < 1 then
            local v31 = u10
            if typeof(v31) ~= "Instance" or u10:FindFirstChild("Head") then
                local v32 = u10
                u24 = typeof(v32) == "Instance" and u10:FindFirstChild("Head").Position or u16.Position
                local v33 = u3:CubicBezier(u29, u25, u22, u23, u24)
                local v34 = u3:CubicBezier(u29 + 0.004166666666666667, u25, u22, u23, u24)
                u26.CFrame = CFrame.lookAt(v33, v34)
                return
            end
        end
        u28:Disconnect()
        u28 = nil
        _G.destroy(u26, 0.4)
    end)
    return u26
end
function u3.TweenModel(_, u35, u36, u37, u38, u39, u40) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    task.spawn(function() --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u1
            [3] = u39
            [4] = u40
            [5] = u35
            [6] = u36
            [7] = u37
        --]]
        local v41 = os.clock()
        while os.clock() - v41 <= u38 do
            local v42 = u1:GetValue((os.clock() - v41) / u38, u39 or Enum.EasingStyle.Quad, u40 or Enum.EasingDirection.Out)
            local v43 = u35
            local v44 = u36 + (u37 - u36) * v42
            v43:ScaleTo((math.max(v44, 0.001)))
            task.wait()
        end
    end)
end
function u3.start(_, u45, p46) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u3
    --]]
    local u47 = Random.new()
    if u45:FindFirstChild("Humanoid") then
        local function u53(p48, p49) --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u45
            --]]
            local v50 = p48:LoadAnimation(p49)
            v50:Play(0)
            v50:AdjustSpeed(2.0377358490566038)
            local v51 = u45:FindFirstChild("DragonTailController", true)
            if v51 then
                local v52 = v51:LoadAnimation(p49)
                v52:Play(0)
                v52:AdjustSpeed(2.0377358490566038)
            end
        end
        if p46 == false then
            local u54 = u45:FindFirstChild("HybridDragonRig")
            local u55 = Instance.new("Highlight")
            u55.OutlineColor = Color3.new(1, 1, 1)
            u55.FillColor = Color3.new(1, 1, 1)
            u55.DepthMode = Enum.HighlightDepthMode.Occluded
            u55.FillTransparency = 1
            u55.OutlineTransparency = 1
            u55.Parent = u45
            u1:Create(u55, TweenInfo.new(0.075), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            }):Play()
            if u54 then
                u54.Name = "previousDragonRig"
            end
            _G.PlaySound(u45.PrimaryPart, script.DragonHalfUntransform).Parent = u45.PrimaryPart
            task.delay(0.075, function() --[[ Line: 121 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u4
                    [3] = u55
                    [4] = u54
                --]]
                local v56 = script.Detransform:Clone()
                v56.CFrame = u45:GetPivot()
                v56.Parent = workspace.Effects
                u4(v56)
                _G.destroy(v56, 2.5)
                u55:Destroy()
                if u54 then
                    u54:Destroy()
                end
            end)
        else
            _G.PlaySound(u45.PrimaryPart, script.DragonHalfTransformation).Parent = u45.PrimaryPart
            local v57 = Instance.new("Highlight")
            v57.OutlineColor = Color3.new(1, 1, 1)
            v57.FillColor = Color3.new(1, 1, 1)
            v57.DepthMode = Enum.HighlightDepthMode.Occluded
            v57.FillTransparency = 1
            v57.OutlineTransparency = 1
            v57.Parent = u45
            u1:Create(v57, TweenInfo.new(0.33), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            }):Play()
            local v58 = script.Chargeup:Clone()
            v58.CFrame = u45:GetPivot()
            v58.Parent = workspace.Effects
            u4(v58)
            _G.destroy(v58, 2.5)
            local v59 = u45:GetDescendants()
            local v60 = {}
            for v61 = 1, #v59 do
                if v59[v61]:GetAttribute("DragonHybirdBodyTrans") then
                    v59[v61].Transparency = 0.99
                    v59[v61].Massless = true
                    local v62 = v59[v61]
                    table.insert(v60, v62)
                end
            end
            task.spawn(function() --[[ Line: 169 ]]
                --[[
                Upvalues:
                    [1] = u53
                    [2] = u45
                --]]
                u53(u45.Humanoid, script.Animations.HybirdTransform)
            end)
            for _ = 1, 8 do
                u3:CreateTrail(u45, u47, script.Trail)
                u3:CreateTrail(u45, u47, script.Trail)
                task.wait(0.025)
            end
            task.wait(0.33)
            for v63 = 1, #v60 do
                local v64 = v60[v63]
                if v64 then
                    v64.Transparency = 1
                end
            end
            u1:Create(v57, TweenInfo.new(0.06), {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            }):Play()
            _G.destroy(v57, 0.08)
            local function v78(p65, p66, p67) --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                local v68 = script.Beam:Clone()
                local v69 = 1.5707963267948966 * (p67 - 1)
                local v70 = p66:NextNumber(-0.6283185307179586, 0.6283185307179586)
                local v71 = p66:NextNumber(-0.3141592653589793, 0.3141592653589793)
                v68.CFrame = p65 * CFrame.Angles(0, v69, 0) * CFrame.Angles(v70, 0, v71) * CFrame.new(0, p66:NextNumber(-2, 1), 0)
                v68.Parent = workspace.Effects
                local v72 = p66:NextNumber(0.8, 1.2)
                local v73 = p66:NextNumber(0.45, 0.85)
                local v74 = p66:NextNumber(8, 15) / 2
                u1:Create(v68, TweenInfo.new(v73), {
                    ["CFrame"] = v68.CFrame * CFrame.new(0, p66:NextNumber(2, 5), v74)
                }):Play()
                for _, v75 in v68:GetChildren() do
                    if v75:IsA("Attachment") then
                        local v76 = v75.Position
                        v75.Position = v75.Position * 0.15
                        u1:Create(v75, TweenInfo.new(v73 + p66:NextNumber(-0.1, 0.2)), {
                            ["Position"] = v76 * v72
                        }):Play()
                    elseif v75:IsA("Beam") then
                        local v77 = v75.Name == "fire" and 0 or 0.15
                        u1:Create(v75, TweenInfo.new(v73 + v77, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            ["Width1"] = 0,
                            ["Width0"] = 0
                        }):Play()
                    end
                end
                _G.destroy(v68, v73 + 0.5)
            end
            for v79 = 1, 4 do
                v78(u45:GetPivot(), u47, v79)
            end
            local v80 = script.Transform:Clone()
            v80.CFrame = u45:GetPivot()
            local v81, v82, v83 = _G.getRayFloor(v80.CFrame, 8)
            if v81 then
                v80.Attachment.WorldCFrame = CFrame.new(v82, v82 + v83) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            else
                v80.Attachment:Destroy()
            end
            v80.Parent = workspace.Effects
            u4(v80)
            _G.destroy(v80, 4)
            local u84 = u45:GetPivot()
            for _ = 1, 3 do
                local u85 = u47:NextNumber(1, 3)
                local u86 = u47:NextNumber(-2, -1.5)
                local u87 = u47:NextNumber(0, 6.283185307179586)
                local v88 = u87
                local v89 = math.cos(v88) * u85
                local v90 = u87
                local v91 = math.sin(v90) * u85
                local u92 = script.AfterTrail:Clone()
                u92.CFrame = u84 * CFrame.new(v89, u86, v91)
                u92.Parent = workspace.Effects
                task.spawn(function() --[[ Line: 285 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u87
                        [3] = u85
                        [4] = u86
                        [5] = u84
                        [6] = u92
                    --]]
                    local v93 = os.clock()
                    local v94 = u47:NextNumber(4, 8)
                    local v95 = u47:NextNumber(0.4, 0.8)
                    local v96 = u47:NextNumber(2.5, 3.75)
                    local v97 = u47:NextNumber(2, 6)
                    while os.clock() - v93 <= v95 do
                        local v98 = task.wait()
                        u87 = u87 + v98 * 3.141592653589793 * v96
                        u85 = u85 + v97 * v98
                        u86 = u86 + v94 * v98
                        local v99 = u87
                        local v100 = math.cos(v99) * u85
                        local v101 = u87
                        local v102 = math.sin(v101) * u85
                        local v103 = u87 + 0.002777777777777778
                        local v104 = math.cos(v103) * u85
                        local v105 = u87 + 0.002777777777777778
                        local v106 = math.sin(v105) * u85
                        local v107 = u84 * CFrame.new(v100, u86, v102)
                        local v108 = u84 * CFrame.new(v104, u86 + 0.002777777777777778, v106)
                        u92.CFrame = CFrame.lookAt(v107.Position, v108.Position)
                    end
                    _G.particleEnabled(u92, false, true)
                    _G.destroy(u92, 1)
                end)
            end
        end
    else
        return
    end
end
return u3