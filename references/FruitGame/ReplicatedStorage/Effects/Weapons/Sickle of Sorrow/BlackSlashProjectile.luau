 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
    --]]
    local u6 = p5.StartTime
    local u7 = p5.Start
    local u8 = p5.Goal
    local v9 = p5.Speed
    local v10 = p5.Size
    local v11 = p5.FilterDescendants
    local u12 = p5.Character
    local u13 = p5.Scale
    local u14 = p5.ServerProjectile
    local v15 = CFrame.lookAt(u7, u8)
    local u16 = RaycastParams.new()
    u16.FilterType = Enum.RaycastFilterType.Include
    u16.FilterDescendantsInstances = v11
    local v17 = OverlapParams.new()
    v17.FilterType = Enum.RaycastFilterType.Include
    v17.FilterDescendantsInstances = v11
    local v18 = RaycastParams.new()
    v18.FilterType = Enum.RaycastFilterType.Include
    v18.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    local v19 = script.SlashModel:Clone()
    u4.apply(v19, u12)
    local u20 = v19.PrimaryPart
    u20.CFrame = v15 * CFrame.Angles(0, 0, 0.08726646259971647)
    local u21 = {
        ["Range"] = u20.PointLight.Range
    }
    if u13 then
        v19:ScaleTo(u13)
    end
    u20.Size = v10
    u20.PointLight.Range = 0
    u20.Parent = workspace.Effects
    local u22
    if u13 then
        u22 = _G.PlaySound(u20, script.chargedSlashSFX)
        u22.Parent = u20
    else
        u22 = _G.PlaySound(u20, script.slashSFX)
        u22.Parent = u20
    end
    local v23 = TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, false, 0)
    local v24 = u20:GetDescendants()
    for _, v25 in v24 do
        if v25:IsA("Beam") then
            local _ = v25.Width0
            local _ = v25.Width1
            local v26 = v25.CurveSize0
            local v27 = v25.CurveSize1
            v25.CurveSize0 = 0
            v25.CurveSize1 = 0
            u2:Create(v25, v23, {
                ["CurveSize0"] = v26,
                ["CurveSize1"] = v27
            }):Play()
        end
    end
    for _, v28 in v24 do
        if v28:IsA("Attachment") then
            local v29 = v28.CFrame
            v28.CFrame = CFrame.new(0, 0, 0) * v29.Rotation
            u2:Create(v28, v23, {
                ["CFrame"] = v29
            }):Play()
        end
    end
    local u30 = u2:Create(u20.PointLight, v23, u21)
    u30:Play()
    local u31 = u20.CFrame.Rotation
    local u32 = nil
    local u33 = nil
    local u34 = nil
    local u35 = {}
    local function u39() --[[ Line: 95 ]]
        --[[
        Upvalues:
            [1] = u32
            [2] = u20
            [3] = u12
            [4] = u13
            [5] = u33
            [6] = u35
            [7] = u30
            [8] = u21
            [9] = u22
        --]]
        u32:Disconnect()
        _G.destroy(u20, 5)
        _G.particleEnabled(u20, false)
        for _, v36 in pairs(u20:GetDescendants()) do
            if v36:IsA("Beam") then
                _G.tween(v36, {
                    0.2,
                    "Quart",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CurveSize0"] = 0,
                    ["CurveSize1"] = 0,
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
        end
        for _, v37 in pairs(u20:GetDescendants()) do
            if v37:IsA("Attachment") then
                _G.tween(v37, {
                    0.2,
                    "Quart",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = CFrame.new(0, 0, 0) * v37.CFrame.Rotation
                })
            end
        end
        _G.PlayEffect("BlackSlashHit", nil, u20.CFrame, u12, u13)
        if u33 and u33.Parent then
            _G.particleEnabled(u33, false)
        end
        for _, v38 in u35 do
            _G.destroy(v38, 2)
        end
        u30:Pause()
        u30:Destroy()
        u20.PointLight.Range = u21.Range
        u20.PointLight.Brightness = 8
        _G.tween(u20.PointLight, {
            0.3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 5 + u20.PointLight.Range * 1.5,
            ["Brightness"] = 0
        })
        _G.tween(u22, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
    end
    local function u44() --[[ Line: 133 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u16
            [3] = u34
            [4] = u33
            [5] = u35
            [6] = u13
            [7] = u4
            [8] = u12
        --]]
        local v40 = workspace:Raycast(u20.Position, Vector3.new(0, -25, 0), u16)
        if v40 then
            local v41 = v40.Instance.Color
            local v42 = tostring(v41)
            if u34 ~= v42 then
                u34 = v42
                if u33 then
                    _G.particleEnabled(u33, false)
                end
                u33 = u35[v42]
                if not u33 then
                    u33 = script.GroundModel:Clone()
                    if u13 then
                        u33:ScaleTo(u13)
                    end
                    u4.apply(u33, u12)
                    u35[v42] = u33
                end
                _G.customEmit(u33)
                u33.PrimaryPart.CFrame = CFrame.fromMatrix(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(u20.CFrame.LookVector), v40.Normal)
                u33.Parent = workspace.Effects
            end
            u33.PrimaryPart.Position = v40.Position
            for _, v43 in u33.PrimaryPart:GetChildren() do
                v43.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v40.Instance.Color), ColorSequenceKeypoint.new(1, v40.Instance.Color) })
            end
            _G.particleEnabled(u33, true)
        elseif u33 then
            _G.particleEnabled(u33, false)
        end
    end
    local u45 = (u8 - u7).Magnitude / v9
    u32 = u3.Heartbeat:Connect(function(p46) --[[ Line: 180 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u45
            [3] = u7
            [4] = u8
            [5] = u20
            [6] = u31
            [7] = u16
            [8] = u14
            [9] = u39
            [10] = u44
        --]]
        local v47 = (workspace:GetServerTimeNow() - u6) / u45
        local v48 = math.min(1, v47)
        local v49 = u7:Lerp(u8, v48)
        local v50 = u7:Lerp(u8, v48 + p46)
        u20.CFrame = u31 + v49
        local v51 = workspace:Blockcast(u20.CFrame, u20.Size, v50 - v49, u16)
        if u14 and u14:GetAttribute("exploded") then
            u39()
            return
        elseif v51 or v48 >= 1 then
            u39()
        else
            u44()
        end
    end)
end
return v1