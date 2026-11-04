 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local _ = workspace.Env.WaterStuff.Falls.Position.Y - 1
local v3 = {}
local function u7(p4, p5) --[[ Line: 9 ]]
    for _, v6 in p4:GetChildren() do
        if v6:IsA("Beam") or v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
function v3.start(_, _, p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u1
        [3] = u2
    --]]
    local u9 = p8.Character
    if not u9 or _G.checkRenderDistance(u9.PrimaryPart.Position) ~= false then
        local u10 = p8.Duration
        local u11 = p8.Potion
        local v12 = p8.Color
        local u13 = u11.Handle.Bottom
        local u14 = u11.Handle.Top
        if v12 then
            for _, v15 in u11.Handle.Beams:GetChildren() do
                v15.Color = v12
            end
        end
        u7(u11.Handle.Beams, true)
        local u16 = false
        local u17 = os.clock()
        local u18 = nil
        _G.tween(u11.Part.Mesh, {
            u10,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(1, 0, 1),
            ["Offset"] = Vector3.new(0, 0.605, 0)
        })
        _G.destroy(u11.Part, 5)
        u11.Part.Parent = workspace.Effects
        u13.Parent = workspace.Terrain
        u18 = u1.Heartbeat:Connect(function(_) --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u18
                [3] = u17
                [4] = u10
                [5] = u9
                [6] = u7
                [7] = u13
                [8] = u2
                [9] = u14
                [10] = u16
            --]]
            if u11:FindFirstChild("Handle") then
                local v19 = u11.Handle.Position
                if os.clock() - u17 >= u10 - 0.5 or u11.Parent ~= u9 then
                    u18:Disconnect()
                    u18 = nil
                    local v20 = u11.Handle.Beams:GetChildren()
                    for v21 = 1, #v20 do
                        _G.tween(v20[v21], {
                            0.25,
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.InOut,
                            0,
                            false,
                            0
                        }, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        })
                    end
                    u7(u13, false)
                    u2:Create(u14, TweenInfo.new(0.5), {
                        ["WorldPosition"] = u13.WorldPosition
                    }):Play()
                    _G.destroy(u13, 3)
                else
                    local v22 = _G.getWavePosition(v19)
                    if v19.Y < v22 then
                        local _, v23, _ = _G.getRayFloor(CFrame.new(v19), 100)
                        v22 = v23.Y
                    end
                    local v24 = (os.clock() - u17) / 0.5
                    local v25 = math.min(v24, 1)
                    u13.WorldCFrame = CFrame.new((CFrame.Angles(0, 1.5707963267948966, 0) + u14.WorldPosition - Vector3.new(0, 1, 0) * (u14.WorldPosition.Y - v22) * v25 + Vector3.new(0, 1, 0)).Position)
                    if v25 == 1 then
                        u16 = true
                        u7(u13, true)
                        u13.WorldCFrame = CFrame.new(u13.WorldCFrame.X, v22, u13.WorldCFrame.Z)
                    end
                end
            else
                u18:Disconnect()
                u18 = nil
                return
            end
        end)
    end
end
return v3