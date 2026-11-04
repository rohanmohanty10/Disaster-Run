 

game:GetService("Lighting")
local u1 = game:GetService("TweenService")
local u2 = Random.new()
local u3 = require(script.Ring)
local u4 = require(script.Beam)
local u5 = require(script.Parent.PillarPhase.SwirlyParticle)
local u6 = require(script.Parent.FloatingRock)
require(script.Parent.Parent.GalaxyImpactLightning)
local v7 = {}
local v8 = RaycastParams.new()
v8.FilterType = Enum.RaycastFilterType.Include
v8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u26(u9, p10) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local u11 = script.ShockwaveBeam:Clone()
    u11.CFrame = u9
    u11.Parent = workspace.Effects
    local u12 = TweenInfo.new(math.random(200, 400) / 1000, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v13 = u2:NextNumber(75, 100)
    local v14 = NumberSequence.new(0)
    local v15 = v13 * 4 / 3
    task.spawn(function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u11
            [3] = u12
            [4] = u1
            [5] = u9
        --]]
        local v16 = u2:NextNumber(1, 2) * 3.141592653589793 * (math.random(2) == 1 and 1 or -1)
        local v17 = 0
        while u11.Parent do
            local v18 = task.wait()
            v17 = v17 + v18 / u12.Time
            u1:Create(u11, TweenInfo.new(v18, Enum.EasingStyle.Linear), {
                ["CFrame"] = u9 * CFrame.Angles(0, v16 * v17, 0)
            }):Play()
        end
    end)
    for _, v19 in u11:GetChildren() do
        local v20 = v19["1"]
        local v21 = v19["2"]
        local v22 = v19.Beam
        v22.Color = ColorSequence.new(p10)
        v22.Width0 = 100
        v22.Width1 = 100
        v22.Transparency = v14
        v22.CurveSize0 = 0
        v22.CurveSize1 = 0
        v22.TextureLength = math.random(4, 8)
        u1:Create(v22, u12, {
            ["CurveSize0"] = -v15,
            ["CurveSize1"] = v15,
            ["Width0"] = 0,
            ["Width1"] = 0,
            ["TextureLength"] = 0
        }):Play()
        local v23 = v19.Name == "Attachment" and Vector3.new(1, 0, 0) or Vector3.new(0, 0, 0)
        v20.Position = v23 + Vector3.new(0, 0, 1) * v13 * 1 / 3
        v21.Position = -(v23 + Vector3.new(0, 0, 1) * v13 * 1 / 3)
        for _, v24 in { v20, v21 } do
            local v25 = v24 == v20 and 1 or -1
            u1:Create(v24, u12, {
                ["Position"] = v23 + Vector3.new(0, 0, 1) * v13 * v25
            }):Play()
        end
    end
    _G.destroy(u11, u12.Time)
end
function v7.Initialize(_, u27, u28) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u5
        [4] = u3
        [5] = u6
        [6] = u2
        [7] = u26
    --]]
    local u29 = Instance.new("Model")
    Instance.new("Highlight", u29).Enabled = false
    u29.Parent = workspace.Effects
    local v30 = script.glass:Clone()
    v30.Size = Vector3.new(30, 30, 30)
    v30.Position = u27
    v30.Parent = u29
    _G.tween(v30, {
        0.3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1,
        ["Size"] = Vector3.new(300, 300, 300)
    })
    _G.destroy(v30, 0.3)
    _G.PlaySound(v30, script.GalaxyImpactPreExplosion)
    local v31 = script.Burst:Clone()
    for _, v32 in v31:GetDescendants() do
        if v32:IsA("ParticleEmitter") and v32:GetAttribute("hakiColor") then
            v32.Color = ColorSequence.new(u28)
        end
    end
    v31:SetPrimaryPartCFrame(CFrame.new(u27))
    v31.Parent = workspace.Effects
    _G.customEmit(v31)
    _G.destroy(v31, 2)
    local u33 = script.Spheres:Clone()
    local u34 = u33.Sphere3.PrimaryPart
    local v35 = Instance.new("Highlight")
    v35.FillColor = Color3.fromRGB(255, 219, 188)
    v35.OutlineColor = Color3.fromRGB(0, 0, 0)
    v35.OutlineTransparency = 1
    v35.FillTransparency = -0.5
    v35.Enabled = true
    v35.DepthMode = Enum.HighlightDepthMode.Occluded
    v35.Parent = u33.Sphere4
    _G.recolorParticles(u33.Sphere4, u28, "hakiColor")
    _G.recolorParticles(u33.Part, u28, "hakiColor")
    local v36, v37, v38 = u28:ToHSV()
    u33.Sphere4.Highlight.FillColor = Color3.fromHSV(v36, v37, v38 + 0.23529411764705882)
    u33:PivotTo(CFrame.new(u27))
    u33.Parent = workspace.Effects
    for _, v39 in u33:GetChildren() do
        if v39:IsA("Model") ~= false then
            v39.Cube.Color = u28
            local v40 = math.random(20, 50) / 100
            local u41 = v40 * 15
            local u42 = v39.AnimationController:LoadAnimation(script.Animation)
            u42:Play()
            u42:AdjustSpeed(v40)
            task.spawn(function() --[[ Line: 164 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u41
                    [3] = u42
                --]]
                local v43 = 0
                while v43 <= 1 do
                    v43 = v43 + task.wait() / 1
                    u42:AdjustSpeed(u1:GetValue(v43, Enum.EasingStyle.Linear, Enum.EasingDirection.Out) * u41)
                end
            end)
        end
    end
    u33.Sphere1.Cube.Color = Color3.new(1, 1, 1)
    local v44 = u33.Sphere4.Cube.Beams:GetDescendants()
    for v45 = 1, #v44 do
        if v44[v45]:IsA("Beam") then
            local v46 = v44[v45].Transparency
            v44[v45].Transparency = NumberSequence.new(1)
            v44[v45].TextureSpeed = 0
            _G.tween(v44[v45], {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = v46,
                ["TextureSpeed"] = 12
            })
        end
    end
    task.spawn(function() --[[ Line: 188 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u1
            [3] = u27
        --]]
        u33:ScaleTo(0.1)
        local v47 = 0
        while v47 <= 1 do
            v47 = v47 + task.wait() / 1
            u33:ScaleTo(u1:GetValue(v47, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) * 4)
            local v48 = u33
            local v49 = CFrame.new
            local v50 = u27
            local v51 = u33.Sphere4.PrimaryPart.Size.Y / 2
            v48:PivotTo(v49(v50 + Vector3.new(0, v51, 0)))
        end
    end)
    local u52 = Instance.new("Model")
    u52.Name = "Ball"
    local v53 = Instance.new("Highlight")
    v53.Parent = u52
    v53.FillColor = Color3.fromRGB(255, 255, 255)
    v53.FillTransparency = -0.5
    v53.OutlineTransparency = 1
    v53.DepthMode = Enum.HighlightDepthMode.Occluded
    u52.Parent = workspace.Effects
    local u54 = {}
    task.spawn(function() --[[ Line: 216 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u34
            [3] = u52
            [4] = u28
            [5] = u5
            [6] = u54
        --]]
        local v55 = os.clock()
        for v56 = 1, 6 do
            local v57 = {
                ["Target"] = u34,
                ["Duration"] = (1 - (os.clock() - v55)) * 1,
                ["Parent"] = u52,
                ["Color"] = u28
            }
            local v58 = u4.new(v57)
            v58:start()
            for _ = 1, 3 do
                u5.new({
                    ["Target"] = u34,
                    ["Duration"] = Random.new():NextNumber(0.3, 1),
                    ["Size"] = Vector3.new(3, 3, 12),
                    ["Mult"] = 1.5,
                    ["HeightMult"] = math.random(50, 100) / 100,
                    ["Parent"] = u52,
                    ["Color"] = u28
                }):start()
            end
            u54[v56] = v58
            task.wait(0.1)
        end
    end)
    local u59 = { u3.new({
            ["Target"] = u34,
            ["Alpha"] = 0,
            ["Duration"] = 0.35,
            ["GoalAlpha"] = 0.65,
            ["Color"] = u28
        }), u3.new({
            ["Target"] = u34,
            ["Alpha"] = 0,
            ["Duration"] = 0.35,
            ["GoalAlpha"] = 0.45,
            ["Color"] = u28
        }), u3.new({
            ["Target"] = u34,
            ["Alpha"] = 0,
            ["Duration"] = 0.35,
            ["GoalAlpha"] = 0.25,
            ["Color"] = u28
        }) }
    task.spawn(function() --[[ Line: 282 ]]
        --[[
        Upvalues:
            [1] = u59
        --]]
        for _, v60 in u59 do
            v60:start()
            task.wait(0.1)
        end
    end)
    task.spawn(function() --[[ Line: 289 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u34
            [3] = u2
        --]]
        for _ = 1, 45 do
            local v61 = math.random(20, 40)
            u6.new({
                ["Position"] = CFrame.Angles(0, 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -u34.Size.Z).Position + u34.Position + Vector3.new(0, 1, 0),
                ["Duration"] = math.random(25, 50) / 100,
                ["Size"] = u2:NextUnitVector():Abs() * v61,
                ["Height"] = u2:NextNumber(25, 80)
            })
            task.wait(0.05)
        end
    end)
    task.spawn(function() --[[ Line: 304 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u34
            [3] = u29
            [4] = u26
            [5] = u27
        --]]
        local v62, v63, v64 = u28:ToHSV()
        local v65 = v63 * 255 + 50
        local v66 = Color3.fromHSV
        local v67 = v65 / 255
        local v68 = v66(v62, math.clamp(v67, 0, 1), v64)
        for _ = 1, 15 do
            local v69 = script.glass:Clone()
            v69.Size = Vector3.new(30, 30, 30)
            v69.Position = u34.Position
            v69.Parent = u29
            _G.tween(v69, {
                0.3,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(200, 200, 200)
            })
            _G.destroy(v69, 0.3)
            local v70 = u26
            local v71 = CFrame.new(u27 + Vector3.new(0, 15, 0))
            local v72 = CFrame.Angles
            local v73 = math.random(-5, 5)
            local v74 = math.rad(v73)
            local v75 = 6.283185307179586 * math.random()
            local v76 = math.random(-5, 5)
            v70(v71 * v72(v74, v75, (math.rad(v76))), v68)
            task.wait(0.1)
        end
        _G.destroy(u29, 0.3)
    end)
    task.wait(1.5)
    for _, v77 in u59 do
        v77.Ring:Destroy()
    end
    u52:Destroy()
    u33:Destroy()
end
return v7