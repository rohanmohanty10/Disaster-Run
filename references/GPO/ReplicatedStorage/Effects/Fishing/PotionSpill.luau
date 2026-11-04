 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = {}
local function u7(p4, p5) --[[ Line: 7 ]]
    for _, v6 in ipairs(p4:GetChildren()) do
        if v6:IsA("Beam") or v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
function v3.start(_, p8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u1
        [3] = u2
    --]]
    local v9 = p8.Character
    if not v9 or _G.checkRenderDistance(v9.PrimaryPart.Position) then
        local u10 = p8.Tool
        local u11 = p8.Duration
        local u12 = u10.Handle
        local u13 = u12.Beams
        for _, v14 in ipairs(u13:GetChildren()) do
            v14.Width0 = 0.4
            v14.Width1 = 1
        end
        u7(u13, true)
        local u15 = u12.Bottom
        local u16 = u12.Top
        u15.CFrame = u15:GetAttribute("OriginalCFrame")
        u16.CFrame = u16:GetAttribute("OriginalCFrame")
        local u17 = os.clock()
        local u18 = nil
        u18 = u1.Heartbeat:Connect(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u11
                [3] = u10
                [4] = u18
                [5] = u13
                [6] = u7
                [7] = u15
                [8] = u2
                [9] = u16
                [10] = u12
            --]]
            local v19 = os.clock() - u17
            local v20 = v19 / u11
            math.min(1, v20)
            if u11 - 0.5 <= v19 or not u10:GetAttribute("Pouring") then
                u18:Disconnect()
                for _, v21 in u13:GetChildren() do
                    _G.tween(v21, { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
                u7(u15, false)
                u2:Create(u16, TweenInfo.new(0.5), {
                    ["WorldPosition"] = u15.WorldPosition
                }):Play()
            else
                local v22 = _G.getWavePosition(u12.Position) + 0.1
                local v23 = v19 / 0.5
                local v24 = math.min(1, v23)
                u15.WorldCFrame = CFrame.new((CFrame.Angles(0, 1.5707963267948966, 0) + u16.WorldPosition - Vector3.new(0, 1, 0) * (u16.WorldPosition.Y - v22) * v24 + Vector3.new(0, 1, 0)).Position)
                if v24 == 1 then
                    u7(u15, true)
                    u15.WorldCFrame = CFrame.new(u15.WorldCFrame.X, v22, u15.WorldCFrame.Z)
                end
            end
        end)
    end
end
return v3