 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
u4.FilterType = Enum.RaycastFilterType.Include
local u5 = _G.tween
function v1.start(_, p6, _) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
        [4] = u3
    --]]
    local v7 = p6:FindFirstChild("HumanoidRootPart")
    if v7 then
        local v8 = v7.CFrame
        local v9 = workspace:Raycast(v8.Position, Vector3.new(0, -100, 0), u4)
        local u10 = v9 and (v9.Instance and v9.Instance.Color) or Color3.fromRGB(255, 255, 255)
        local v11 = script.Tree:Clone()
        v11:PivotTo(v8 * CFrame.new(0, -16.5, 0))
        local function v16(p12) --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            if p12 then
                local v13 = p12:FindFirstChild("Dust")
                if v13 then
                    local v14 = ColorSequence.new({ ColorSequenceKeypoint.new(0, u10), ColorSequenceKeypoint.new(1, u10) })
                    for _, v15 in ipairs(v13:GetChildren()) do
                        v15.Color = v14
                    end
                end
            else
                return
            end
        end
        for _, u17 in ipairs(v11:GetChildren()) do
            if u17:IsA("MeshPart") and u17.Material == Enum.Material.Neon then
                local u18 = u17.Color
                local u19 = u17:FindFirstChildOfClass("PointLight")
                u17.Color = Color3.fromRGB(25, 25, 25)
                if u19 then
                    u19.Enabled = false
                end
                task.delay(0.8, function() --[[ Line: 61 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u18
                        [3] = u19
                    --]]
                    if u17.Parent then
                        u17.Color = u18
                        if u19 and u19.Parent then
                            u19.Enabled = true
                            local v20 = u19
                            v20.Range = v20.Range / 2
                        end
                    end
                end)
            end
        end
        v11.Parent = workspace.Effects
        local v21 = script.Appear:Clone()
        v21:PivotTo(v8 * CFrame.new(0, -3, 0))
        v16(v21)
        v21.Parent = workspace.Effects
        _G.customEmit(v21)
        _G.destroy(v21, 3)
        _G.PlaySound(v8, script.XmasTreeGrip2)
        local u22 = v11:FindFirstChild("Root")
        if u22 then
            local u23 = u22.CFrame
            local u24 = script.Shaking:Clone()
            u24:PivotTo(v8)
            v16(u24)
            u24.Parent = workspace.Effects
            _G.destroy(u24, 3)
            local v25 = {}
            for _, v26 in ipairs(p6:GetDescendants()) do
                if (v26:IsA("BasePart") or v26:IsA("Decal")) and v26.Transparency ~= 1 then
                    v25[v26] = v26.Transparency
                    u5(v26, {
                        0.1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Transparency"] = 1
                    })
                end
            end
            task.delay(0.5, function() --[[ Line: 113 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u2
                --]]
                for _, v27 in ipairs(u24:GetDescendants()) do
                    if v27:IsA("ParticleEmitter") then
                        u2:Create(v27, TweenInfo.new(0.4), {
                            ["Rate"] = 0
                        }):Play()
                    end
                end
            end)
            local u28 = Instance.new("NumberValue")
            u28.Value = 0
            u2:Create(u28, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Value"] = 1
            }):Play()
            local u29 = os.clock()
            local u30 = nil
            u30 = u3.RenderStepped:Connect(function() --[[ Line: 133 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u30
                    [3] = u28
                    [4] = u29
                    [5] = u23
                --]]
                if u22.Parent then
                    local v31 = os.clock() - u29
                    local v32 = u28.Value
                    local v33 = u23 * CFrame.new(0, 13.15 * v32, 0)
                    local v34 = 1 - v32 * 0.6
                    local v35 = v31 * 3.141592653589793 * 2 * 18
                    local v36 = math.sin(v35)
                    local v37 = v31 * 3.141592653589793 * 2 * 13.86
                    local v38 = math.cos(v37)
                    local v39 = v36 * 0.4 * v34
                    local v40 = v38 * 0.4 * v34
                    local v41 = v36 * 0.03490658503988659 * v34
                    local v42 = 2.792526803190927 * v32 ^ 1
                    u22.CFrame = v33 * CFrame.Angles(0, v42, 0) * CFrame.new(v39, 0, v40) * CFrame.Angles(0, v41, 0)
                    if v32 >= 0.999 then
                        u30:Disconnect()
                        u28:Destroy()
                    end
                else
                    u30:Disconnect()
                    u28:Destroy()
                end
            end)
            task.wait(0.8)
            local v43 = v11:FindFirstChild("tree")
            if v43 then
                v43 = v43:FindFirstChildOfClass("SurfaceAppearance")
            end
            if v43 then
                u2:Create(v43, TweenInfo.new(0.3), {
                    ["Color"] = Color3.fromRGB(250, 250, 325)
                }):Play()
            end
            local v44 = script.Burst:Clone()
            v44.CFrame = v8 * CFrame.new(0, -2.5, 0)
            v44.Parent = workspace.Effects
            _G.customEmit(v44)
            _G.destroy(v44, 3)
            for _, v45 in ipairs(v11.Folder:GetDescendants()) do
                if v45:IsA("MeshPart") or v45:IsA("Part") then
                    v45.Transparency = 0
                    v45.CollisionGroup = "player"
                elseif v45:IsA("Texture") then
                    v45.Transparency = 0.6
                end
            end
            task.wait(6)
            _G.destroy(v11, 1)
            for _, v46 in v11:GetDescendants() do
                if v46:IsA("MeshPart") or v46:IsA("Texture") then
                    u2:Create(v46, TweenInfo.new(0.5), {
                        ["Transparency"] = 1
                    }):Play()
                elseif v46:IsA("PointLight") then
                    u2:Create(v46, TweenInfo.new(0.5), {
                        ["Brightness"] = 0
                    }):Play()
                end
            end
        else
            v11:Destroy()
            if v21 then
                v21:Destroy()
            end
        end
    else
        return
    end
end
return v1