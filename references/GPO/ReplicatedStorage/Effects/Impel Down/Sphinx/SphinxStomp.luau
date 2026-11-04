 

local v1 = {}
local u2 = workspace.Effects
local u3 = game:GetService("RunService")
local u4 = game:GetService("TweenService")
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { u2, workspace.PlayerCharacters, workspace.NPCs }
u5.FilterType = Enum.RaycastFilterType.Exclude
local function u9(p6, p7) --[[ Line: 15 ]]
    for _, v8 in pairs(p6:GetDescendants()) do
        if v8:IsA("ParticleEmitter") then
            v8.Enabled = p7
        end
    end
end
local function u13(p10) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v11 = script.FloorStomp:Clone()
    v11.CFrame = CFrame.new(p10.Position, p10.Position + p10.Normal) * CFrame.Angles(-1.5707963267948966, 3.141592653589793 * math.random(), 0)
    v11.Parent = u2
    for _, v12 in pairs(v11:GetDescendants()) do
        if v12:IsA("ParticleEmitter") then
            if v12.Name ~= "Dust" then
                v12.Color = ColorSequence.new(p10.Instance.Color)
            end
            _G.customEmit(v12)
        end
    end
    task.wait(1)
    u4:Create(v11.Decal, TweenInfo.new(1), {
        ["Transparency"] = 1
    }):Play()
    task.wait(1)
    v11:Destroy()
end
function v1.start(_, p14) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u5
        [4] = u9
        [5] = u4
        [6] = u13
    --]]
    local u15 = p14.Character
    if _G.checkRenderDistance(u15.PrimaryPart.Position) ~= false then
        local u16 = p14.Duration
        local _, u17 = u15:GetBoundingBox()
        local u18 = script.HitMesh:Clone()
        u18.CFrame = u15.HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)
        u18.Parent = u2
        _G.destroy(u18, u16)
        local u19 = Instance.new("Weld")
        u19.Part0 = u18
        u19.Part1 = u15.HumanoidRootPart
        u19.C0 = u18.CFrame:Inverse() * u15.HumanoidRootPart.CFrame
        u19.Parent = u18
        local u20 = tick()
        local u21 = tick()
        local u22 = nil
        u22 = u3.Heartbeat:Connect(function(p23) --[[ Line: 75 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u17
                [3] = u5
                [4] = u20
                [5] = u16
                [6] = u22
                [7] = u9
                [8] = u18
                [9] = u4
                [10] = u19
                [11] = u21
                [12] = u13
            --]]
            local v24 = u15.HumanoidRootPart.AssemblyLinearVelocity.Magnitude * p23
            local v25 = u15.HumanoidRootPart.Position
            local v26 = u15.HumanoidRootPart.CFrame.LookVector * (u17.Z / 2 + v24)
            local v27 = workspace:Raycast(v25, v26, u5)
            if u16 <= tick() - u20 or v27 then
                u22:Disconnect()
                u9(u18, false)
                if u18:FindFirstChild("Decal") then
                    u4:Create(u18.Decal, TweenInfo.new(1), {
                        ["Transparency"] = 1
                    }):Play()
                end
            else
                local v28 = u19
                v28.C1 = v28.C1 * CFrame.Angles(0, 0, 3.141592653589793 * math.random())
                if tick() - u21 >= 0.25 then
                    u21 = tick()
                    local v29 = u15.HumanoidRootPart.Position
                    local v30 = workspace:Raycast(v29, Vector3.new(0, -20, 0), u5)
                    if not v30 then
                        return
                    end
                    u13(v30)
                end
                return
            end
        end)
    end
end
return v1