 

local v1 = {}
local u2 = script.Move2
local function u8(p3, p4, p5) --[[ Line: 4 ]]
    local v6 = p5 or {}
    local v7 = p3:LoadAnimation(p4)
    v7:Play()
    v7.Priority = v6.Priority or Enum.AnimationPriority.Action
    v7.Looped = v6.Looped or false
    return v7
end
local function u12(p9, p10) --[[ Line: 17 ]]
    for _, v11 in ipairs(p9:GetDescendants()) do
        if v11:IsA("Beam") then
            table.insert(p10, v11)
            v11.Enabled = true
        end
    end
end
function v1.start(_, p13, u14, p15) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u8
        [3] = u12
    --]]
    local u16 = Instance.new("Folder")
    u16.Parent = workspace.Effects
    local u17 = p13 == game.Players.LocalPlayer.Character
    local u18 = p13:WaitForChild("HumanoidRootPart")
    local v19 = p13:WaitForChild("Humanoid")
    local u20 = u2.Parent.WarpIndicatorEffect:Clone()
    local u21 = u2.Explode:Clone()
    local u22 = u2.ImpactGround:Clone()
    local u23 = u2.BeamCrescents:Clone()
    local u24 = u2.SlashUp:Clone()
    local u25 = u8(v19, script.Move2.Anims["Ba\'al Descent"])
    u25.Priority = Enum.AnimationPriority.Action4
    u25:AdjustSpeed(p15)
    u22.Parent = u16
    u23.Parent = u16
    u20.Parent = u16
    u20.CFrame = u18.CFrame
    local u26 = {}
    local u27 = false
    u25.Stopped:Connect(function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        u27 = true
    end)
    _G.PlaySound(u18, script["Audio/BSDownSlashStance"])
    u26[#u26 + 1] = u25:GetMarkerReachedSignal("Skibidi"):Connect(function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u18
        --]]
        _G.customEmit(u20)
        task.wait(0.6)
        _G.PlaySound(u18, script["Audio/BSDownSlashWhoosh1"])
    end)
    u26[#u26 + 1] = u25:GetMarkerReachedSignal("Rizzler"):Connect(function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u18
            [3] = u22
            [4] = u24
            [5] = u16
            [6] = u17
            [7] = u14
            [8] = u26
            [9] = u25
            [10] = u23
            [11] = u12
        --]]
        u21.CFrame = u18.CFrame * CFrame.new(0, -2.5, -8)
        local v28, v29, v30 = _G.getRayFloor(u21.CFrame, 14)
        if v28 then
            local v31 = CFrame.new(v29, v29 + v30)
            local v32 = CFrame.Angles
            local v33 = math.random(0, 360)
            u21.CFrame = v31 * v32(-1.5707963267948966, math.rad(v33), 0)
            _G.recolorParticles(u21, v28.Color)
            _G.recolorParticles(u22, v28.Color)
            _G.recolorParticles(u24, v28.Color)
        end
        u21.Parent = u16
        _G.customEmit(u21)
        _G.PlaySound(u21, script["Audio/BSDownSlashBoom"])
        if u17 then
            u14:FireServer(1, u21.CFrame)
        end
        u26[#u26 + 1] = u25:GetMarkerReachedSignal("Fanum"):Connect(function() --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u18
                [3] = u16
                [4] = u23
                [5] = u22
                [6] = u17
                [7] = u14
                [8] = u12
                [9] = u26
                [10] = u25
            --]]
            local v34 = {}
            u24.CFrame = u18.CFrame
            local v35, v36, v37 = _G.getRayFloor(u24.CFrame, 8)
            if v35 then
                local v38 = u24.VFX2
                local v39 = CFrame.new(v36, v36 + v37)
                local v40 = CFrame.Angles
                local v41 = math.random(0, 360)
                v38.WorldCFrame = v39 * v40(-1.5707963267948966, math.rad(v41), 0)
            end
            u24.Parent = u16
            _G.PlaySound(u18, script.BSPullBackA)
            u23.CFrame = u18.CFrame * CFrame.Angles(0, 0, -1.5707963267948966)
            u22.CFrame = u18.CFrame * CFrame.new(0, -2.5, -15)
            if u17 then
                u14:FireServer(2, u18.CFrame)
            end
            u12(u23, v34)
            _G.customEmit(u24)
            _G.customEmit(u22)
            for _, v42 in ipairs(v34) do
                _G.tween(v42, {
                    0.23,
                    Enum.EasingStyle.Quad,
                    "Out",
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
            _G.tween(u23, {
                0.47,
                Enum.EasingStyle.Quad,
                "Out",
                0,
                false,
                0
            }, {
                ["CFrame"] = u23.CFrame * CFrame.Angles(0, 2.9670597283903604, 0)
            })
            u26[#u26 + 1] = u25:GetMarkerReachedSignal("Spin"):Connect(function() --[[ Line: 117 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                _G.PlaySound(u18, script.BSPullBackSpin)
            end)
        end)
    end)
    task.delay(8, function() --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u26
        --]]
        u16:Destroy()
        for _, v43 in ipairs(u26) do
            v43:Disconnect()
        end
    end)
    local v44 = u27
    while true do
        task.wait()
        if p13:FindFirstChild("PB") then
            u25:Stop(0)
            break
        end
        if v44 == true then
            break
        end
    end
end
return v1