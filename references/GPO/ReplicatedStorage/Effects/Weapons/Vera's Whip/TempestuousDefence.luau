 

local u1 = {
    "rbxassetid://14567978693",
    "rbxassetid://14567978402",
    "rbxassetid://14567978162",
    "rbxassetid://14567977948",
    "rbxassetid://14567970410",
    "rbxassetid://14567970206",
    "rbxassetid://14567970009",
    "rbxassetid://14567969816",
    "rbxassetid://14567969816",
    "rbxassetid://14567969453",
    "rbxassetid://14567961946",
    "rbxassetid://14567961739",
    "rbxassetid://14567961557",
    "rbxassetid://14567961329",
    "rbxassetid://14567961018",
    "rbxassetid://14567960747",
    ""
}
local u2 = script
local v3 = {}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
local u6 = false
local function u11(p7, p8) --[[ Line: 36 ]]
    local v9 = script.BlockEffect:Clone()
    v9.CFrame = p7 * CFrame.new(0, 0, -4)
    v9.Parent = p8
    for _, v10 in pairs(v9:GetDescendants()) do
        if v10:IsA("ParticleEmitter") then
            _G.customEmit(v10)
        end
    end
end
function v3.start(_, p12, p13) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
        [4] = u4
        [5] = u1
        [6] = u11
    --]]
    local u14 = p12.PrimaryPart
    if u14 then
        local u15 = Instance.new("Folder")
        u15.Parent = workspace.Effects
        u15.Name = "EffectsFolder"
        local v16 = u2.ParticlesForWhip:Clone()
        v16.Weld.Part0 = u14
        v16.Parent = u15
        local v17 = u2.CircleParticles:Clone()
        v17.Weld.Part0 = u14
        v17.Parent = u15
        u6 = true
        local v18 = tick()
        while p13 and p13:IsDescendantOf(game) do
            v17.Weld.C1 = v17.Weld.C1 * CFrame.Angles(0, 0, -0.15707963267948966)
            if tick() - v18 >= 0.03 then
                task.spawn(function() --[[ Line: 72 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u5
                        [3] = u4
                        [4] = u14
                        [5] = u15
                        [6] = u1
                    --]]
                    local v19 = u2.MeshWind:Clone()
                    if math.random(1, 2) == 1 then
                        v19.Decal.Color3 = Color3.new(0, 0, 0)
                        v19.Decal.Transparency = 0.8
                    else
                        v19.Decal.Color3 = Color3.new(250, 250, 250)
                        v19.Decal.Transparency = 0.96
                    end
                    local v20 = u5:NextNumber(-1, 10)
                    local v21 = u5:NextNumber(1, 12)
                    local v22 = u5:NextNumber(0, 6.283185307179586)
                    u4:Create(v19.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["Scale"] = v19.Mesh.Scale + Vector3.new(v20, v20, v21)
                    }):Play()
                    u4:Create(v19.Weld, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["C1"] = v19.Weld.C1 * CFrame.Angles(0, 0, v22) * CFrame.new(0, 0, -v21 * 0.5)
                    }):Play()
                    v19.Weld.C1 = v19.Weld.C1 * CFrame.Angles(0, 0, v22)
                    v19.Weld.Part0 = u14
                    v19.Parent = u15
                    for v23 = 1, #u1 do
                        v19.Decal.Texture = u1[v23]
                        local v24 = #u1 * 0.6
                        if v23 == math.round(v24) then
                            u4:Create(v19.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                        task.wait(0.01)
                    end
                    task.wait(1)
                    v19:Destroy()
                end)
                v18 = tick()
            end
            task.wait()
        end
        u11(u14.CFrame, u15)
        v17.Anchored = true
        v17.Weld:Destroy()
        u4:Create(v17, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Orientation"] = v17.Orientation + Vector3.new(0, 0, 90)
        }):Play()
        _G.particleEnabled(v16, false)
        _G.particleEnabled(v17, false)
    end
end
return v3