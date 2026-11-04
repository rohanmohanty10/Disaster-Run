 

local u1 = game:GetService("TweenService")
local u2 = require(script.SwirlyParticle)
local u3 = Random.new()
local u4 = require(script.Ring)
local u5 = RaycastParams.new()
u5.FilterType = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
require(script.Parent.GalaxyImpactLightning)
local function u19(p6) --[[ Line: 14 ]]
    local v7 = script.SpheresOffCenter:Clone()
    local u8 = v7.Main
    local u9 = u8.Size
    local u10 = {}
    for _, v11 in v7:GetDescendants() do
        if v11:IsA("ParticleEmitter") and v11:GetAttribute("hakiColor") then
            v11.Color = ColorSequence.new(p6)
        end
    end
    local v12, v13, v14 = p6:ToHSV()
    for _, v15 in {
        v7.Sphere1,
        v7.Sphere2,
        v7.Sphere3,
        v7.Main
    } do
        v15.Color = Color3.fromHSV(v12, v13, v14)
        v14 = v14 * 0.85
        if v15 ~= u8 then
            u10[v15] = {
                ["InitialSize"] = v15.Size,
                ["TransparencyRatio"] = v15.Transparency / u8.Transparency,
                ["Ratio"] = v15.Size / u8.Size,
                ["Offset"] = v15.Position - u8.Position
            }
        end
    end
    v7.Sphere1.Color = Color3.new(1, 1, 1)
    u8:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u9
            [3] = u10
        --]]
        task.defer(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u9
                [3] = u10
            --]]
            local v16 = u8.Size / u9
            for v17, v18 in u10 do
                v17.Size = v18.Ratio * u8.Size
                v17.CFrame = u8.CFrame * CFrame.new(v18.Offset * v16)
                v17.Transparency = u8.Transparency
            end
        end)
    end)
    return v7, u8
end
return {
    ["start"] = function(_, u20, u21, p22, p23, u24) --[[ Name: start, Line 124 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u19
            [3] = u1
            [4] = u4
            [5] = u3
            [6] = u2
        --]]
        local u25 = p23 or Color3.new(1, 0, 0)
        local v26 = CFrame.new(u21, p22).LookVector
        local u27 = workspace:Raycast(u21, v26 * 1000, u5)
        local u28 = u27 and (u27.Distance or 1000) or 1000
        local u29 = CFrame.new(Vector3.new(0, 0, 0), v26)
        local u30 = u29 + u21 + u29.LookVector * 12.5
        local u31, u32 = u19(u25)
        u32.Size = Vector3.new(0, 0, 0)
        u32.CFrame = u30 * CFrame.Angles(1.5707963267948966, 0, 0) - u29.LookVector * 25 / 2
        u31.Parent = workspace.Effects
        local v33 = u1:Create(u32, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
            ["Size"] = Vector3.new(25, 25, 25),
            ["Position"] = u29.LookVector * 25 / 2 + u32.Position
        })
        v33:Play()
        task.spawn(function() --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u32
                [3] = u25
            --]]
            for _ = 1, 3 do
                u4.new({
                    ["Target"] = u32,
                    ["Duration"] = 0.1,
                    ["Color"] = u25,
                    ["Scale"] = 0.7,
                    ["CFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0)
                }):start()
                task.wait(0.1)
            end
        end)
        v33.Completed:Connect(function() --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u32
                [3] = u29
                [4] = u21
                [5] = u31
                [6] = u30
                [7] = u28
                [8] = u19
                [9] = u25
                [10] = u3
                [11] = u27
                [12] = u24
                [13] = u20
                [14] = u2
            --]]
            u1:Create(u32, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new(100, 100, 100),
                ["Position"] = u29.LookVector * 100 / 2 + u21
            }):Play()
            task.wait(0.25)
            local v34 = u31:GetChildren()
            for v35 = 1, #v34 do
                if v34[v35]:IsA("BasePart") then
                    v34[v35].Transparency = 1
                end
            end
            _G.particleEnabled(u31, false)
            _G.PlaySound(u30, script["4GalaxyImpactPunchLaserShoot"])
            u31.Sphere1.Star.WorldCFrame = u32.CFrame * CFrame.new(0, u32.Size.Y / 2, 0)
            for _, v36 in u31.Sphere1:GetDescendants() do
                if v36:IsA("ParticleEmitter") then
                    v36:Emit(v36:GetAttribute("EmitCount"))
                end
            end
            _G.destroy(u31, 3)
            local u37 = TweenInfo.new(1, Enum.EasingStyle.Circular)
            local u38 = {
                u37.Time,
                u37.EasingStyle,
                u37.EasingDirection,
                0,
                false,
                0
            }
            task.spawn(function() --[[ Line: 195 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u28
                    [3] = u21
                    [4] = u1
                    [5] = u37
                    [6] = u38
                --]]
                for v39 = 1, 5 do
                    task.wait(0.1)
                    local v40 = v39 / 5 * 50 + 50 + (v39 == 1 and 75 or 0)
                    local v41 = v40 * 4 / 3
                    local v42 = script.Shockwave:Clone()
                    local v43 = u29 * CFrame.new(0, 0, -10 - u28 * v39 / 5)
                    local v44 = CFrame.Angles
                    local v45 = math.random(0, 360)
                    v42:PivotTo(v43 * v44(-1.5707963267948966, math.rad(v45), 0) + u21)
                    v42:ScaleTo(1.1 - v39 / 5)
                    _G.customEmit(v42)
                    v42.Parent = workspace.Effects
                    local v46 = v42.Shockwave
                    for _, v47 in { v46.Ring2.Attachment1, v46.Ring2.Attachment2 } do
                        u1:Create(v47["1"], u37, {
                            ["Position"] = Vector3.new(0, 1, 0) * v40
                        }):Play()
                        u1:Create(v47["2"], u37, {
                            ["Position"] = Vector3.new(0, 1, 0) * -v40
                        }):Play()
                        _G.tween(v47.bf1, u38, {
                            ["Transparency"] = NumberSequence.new(1),
                            ["CurveSize0"] = v41,
                            ["CurveSize1"] = -v41
                        })
                        _G.tween(v47.bf2, u38, {
                            ["Transparency"] = NumberSequence.new(1),
                            ["CurveSize0"] = -v41,
                            ["CurveSize1"] = v41
                        })
                        _G.destroy(v42, 2)
                    end
                end
            end)
            local v48, v49 = u19(u25)
            v49.Size = Vector3.new(0, 0, 0)
            v49.CFrame = u29 * CFrame.new(0, 0, -u28 / 2) + u21
            v48.Parent = workspace.Effects
            local v50 = Vector3.new(0, 1, 0) * u28 + Vector3.new(250, 0, 250)
            local v51 = Vector3.new(0, 1, 0) * u28
            local v52 = Instance.new("Model")
            v52.Name = "Shoot"
            local v53 = Instance.new("Highlight")
            v53.Parent = v52
            v53.FillColor = Color3.fromRGB(255, 255, 255)
            v53.FillTransparency = -0.5
            v53.OutlineTransparency = 1
            v53.DepthMode = Enum.HighlightDepthMode.Occluded
            v52.Parent = workspace.Effects
            local v54 = 0
            for v55 = 1, 5 do
                local v56 = u28 * v55 / 5
                local v57 = Instance.new("Part")
                local v58 = Instance.new("SpecialMesh")
                v58.MeshType = Enum.MeshType.Cylinder
                v58.Parent = v57
                v57.Material = Enum.Material.Neon
                v57.Anchored = true
                v57.Color = u25
                v57.CFrame = u29 * CFrame.Angles(0, 1.5707963267948966, 0) + u29.LookVector * v56 + u30.Position
                local v59 = v56 * u3:NextNumber(0.5, 0.85)
                v57.Size = Vector3.new(v59, 15, 15)
                v57.CanCollide = false
                v57.CastShadow = false
                v57.Parent = v52
                local v60 = u1
                local v61 = TweenInfo.new(0.1)
                local v62 = {}
                local v63 = v57.Size.X
                v62.Size = Vector3.new(v63, 0, 0)
                v60:Create(v57, v61, v62):Play()
                _G.destroy(v57, 0.1)
            end
            for v64 = 1, 15 do
                local v65 = u28 * v64 / 15
                local v66 = Instance.new("Part")
                local v67 = Instance.new("SpecialMesh")
                v67.MeshType = Enum.MeshType.Sphere
                v67.Parent = v66
                v66.Anchored = true
                v66.CanCollide = false
                v66.Material = Enum.Material.Neon
                v66.Color = u25
                v66.CFrame = u29 * CFrame.Angles(0, 1.5707963267948966, 0) + u29.LookVector * v65 + u30.Position + u3:NextUnitVector() * 15
                v66.Size = Vector3.new(1, 1, 1) * u3:NextNumber(40, 60)
                v66.CastShadow = false
                v66.Parent = v52
                u1:Create(v66, TweenInfo.new(0.1), {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Position"] = v66.Position + u29.LookVector * 100
                }):Play()
                _G.destroy(v66, 0.1)
            end
            local v68 = 0
            local v69 = Instance.new("Model")
            local v70 = Instance.new("Highlight")
            v70.Enabled = false
            v70.Parent = v69
            v69.Parent = workspace.Effects
            if u27 then
                task.delay(0.25, function() --[[ Line: 361 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                        [2] = u25
                        [3] = u24
                        [4] = u20
                        [5] = u21
                    --]]
                    _G.PlayEffect("GalaxyImpactStart", nil, u27.Position, u25)
                    if u24 and u20 == game.Players.LocalPlayer.Character then
                        u24:FireServer("pillar", CFrame.new(u21))
                    end
                end)
            end
            while v68 <= 1 do
                v68 = v68 + task.wait() / 0.5
                if v54 <= v68 then
                    v54 = v68 + 0.1
                    u2.new({
                        ["Target"] = {
                            ["CFrame"] = u30 * CFrame.Angles(-1.5707963267948966, 0, 0),
                            ["Size"] = v49.Size
                        },
                        ["Revolutions"] = u3:NextNumber(0.15, 0.75) * 2,
                        ["Y"] = u28 * u3:NextNumber(0.15, 0.85),
                        ["Size"] = Vector3.new(5, 5, 15) * u3:NextNumber(0.7, 1),
                        ["Duration"] = u3:NextNumber(0.5, 0.85),
                        ["Mult"] = u3:NextNumber(1, 1.5),
                        ["Parent"] = v52,
                        ["Color"] = u25
                    }):start()
                end
                v49.Size = (Vector3.new(0, 0, 0)):Lerp(v50, v68):Lerp(v50:Lerp(v51, v68), v68)
                v49.CFrame = u29 * CFrame.new(0, 0, -v49.Size.Y / 2) * CFrame.Angles(1.5707963267948966, 0, 0) + u21
                if tick() - 0 >= 0.2 then
                    local v71 = script.glass:Clone()
                    v71.CFrame = v49.CFrame
                    local v72 = v49.Size.X
                    local v73 = v49.Size.Z
                    v71.Size = Vector3.new(v72, 0, v73) * 1.3
                    local v74 = v71.Size.X
                    local v75 = v49.Size.Y
                    local v76 = v71.Size.Z
                    v71.Size = Vector3.new(v74, v75, v76)
                    v71.Parent = v69
                    local v77 = v49.Size.Y / 2
                    local v78 = _G.tween
                    local v79 = {
                        0.05,
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }
                    local v80 = {
                        ["Transparency"] = 1
                    }
                    local v81 = v71.Size
                    local v82 = -v77
                    v80.Size = v81 + Vector3.new(25, v82, 25)
                    v80.CFrame = v71.CFrame * CFrame.new(0, -v77 / 2, 0)
                    v78(v71, v79, v80)
                    _G.destroy(v71, 0.05)
                end
            end
            local v83 = v48:GetDescendants()
            for v84 = 1, #v83 do
                if v83[v84]:IsA("BasePart") then
                    v83[v84].Transparency = 1
                end
            end
            _G.destroy(v69, 0.1)
            _G.particleEnabled(v48, false)
            _G.customEmit(v49)
            _G.destroy(v48, 3)
            _G.destroy(v52, 2)
        end)
    end
}