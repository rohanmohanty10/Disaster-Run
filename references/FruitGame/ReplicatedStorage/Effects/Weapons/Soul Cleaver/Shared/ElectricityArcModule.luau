 

game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local u1 = Random.new()
local v2 = {}
local u3 = {}
u3.__index = u3
function v2.new(p4) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v5 = {
        ["Type"] = p4.Type,
        ["Name"] = p4.Name,
        ["Parts"] = p4.Parts,
        ["StartPos"] = p4.StartPosition,
        ["TargetPos"] = p4.TargetPosition,
        ["Range"] = p4.Range,
        ["Direction"] = p4.Direction,
        ["RadialRange"] = p4.RadialRange
    }
    if p4.Curve0Range then
        v5.Curve0 = p4.Curve0Range
    else
        v5.Curve1 = NumberRange.new(0, 0)
    end
    if p4.Curve1Range then
        v5.Curve1 = p4.Curve1Range
    else
        v5.Curve1 = NumberRange.new(0, 0)
    end
    v5.TextureTable = p4.TextureTable
    v5.Lifetime = p4.Lifetime
    v5.Width0 = p4.Width0Range
    v5.Width1 = p4.Width1Range
    v5.Color = p4.Color
    v5.Brightness = p4.Brightness
    v5.Emission = p4.Emission
    v5.Rate = p4.Rate
    v5.ArcsPerRate = p4.ArcsPerRate
    v5.BlacklistTable = p4.BlacklistTable
    v5.OnRayHit = p4.OnRayHit
    v5.OnLoopIteration = p4.OnLoopIteration
    v5.Attachment1RotationRange = p4.Attachment1RotationRange
    v5.Enabled = false
    if v5.Emission == nil then
        v5.Emission = 0
    end
    local v6 = u3
    return setmetatable(v5, v6)
end
function u3.Start(u7) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u7.Enabled = true
    local v8 = u7.Parts
    if type(v8) ~= "table" then
        u7.Parts = { u7.Parts }
    end
    local v9 = u7.Lifetime
    if typeof(v9) ~= "NumberRange" then
        u7.Lifetime = NumberRange.new(u7.Lifetime)
    end
    local v10 = u7.TextureTable
    if type(v10) ~= "table" then
        u7.TextureTable = { u7.TextureTable }
    end
    local u11 = RaycastParams.new()
    u11.FilterType = Enum.RaycastFilterType.Include
    u11.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
    task.spawn(function() --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u11
            [3] = u1
        --]]
        while true do
            if u7.OnLoopIteration then
                u7.OnLoopIteration()
            end
            local v12
            if u7.Type == "Radial" or not (u7.TargetPos and u7.StartPos) then
                v12 = nil
            else
                local v13 = u7.TargetPos - u7.StartPos
                v12 = workspace:Raycast(u7.StartPos, v13.Unit * u7.Range, u11)
                if u7.OnRayHit then
                    u7.OnRayHit(v12)
                end
            end
            for v14 = 1, u7.ArcsPerRate or 0 do
                local v15 = u7.Parts[math.random(1, #u7.Parts)]
                local u16 = Instance.new("Attachment")
                if u7.Type == "Radial" then
                    u16.CFrame = v15.CFrame * CFrame.new(u1:NextNumber(-v15.Size.X, v15.Size.X), u1:NextNumber(-v15.Size.Y, v15.Size.Y), u1:NextNumber(-v15.Size.Z, v15.Size.Z)) * CFrame.Angles(0, -1.5707963267948966, 0)
                    u16.Parent = workspace.Terrain
                    local v17 = math.random(-u7.RadialRange, u7.RadialRange)
                    local v18 = math.random(-u7.RadialRange, u7.RadialRange)
                    local v19 = math.random
                    local v20 = -u7.RadialRange
                    local v21 = u7.RadialRange
                    local v22 = Vector3.new(v17, v18, v19(v20, v21))
                    local v23 = workspace:Raycast(u16.WorldPosition, v22, u11)
                    if v23 then
                        if u7.OnRayHit then
                            u7.OnRayHit(v23, v14)
                        end
                        local v24 = u1:NextNumber(u7.Lifetime.Min, u7.Lifetime.Max)
                        local u25 = Instance.new("Attachment")
                        u25.CFrame = CFrame.lookAt(v23.Position, u16.WorldPosition)
                        u25.Parent = workspace.Terrain
                        local v26 = Instance.new("Beam")
                        v26.Attachment0 = u16
                        v26.Attachment1 = u25
                        v26.FaceCamera = true
                        v26.LightEmission = u7.Emission
                        v26.LightInfluence = 0
                        v26.Brightness = u7.Brightness
                        v26.Texture = u7.TextureTable[math.random(1, #u7.TextureTable)]
                        v26.TextureMode = Enum.TextureMode.Wrap
                        v26.TextureSpeed = 0
                        v26.Segments = math.random(1, 5)
                        v26.TextureLength = u1:NextNumber(25, 35)
                        v26.CurveSize0 = u1:NextNumber(u7.Curve0.Min, u7.Curve0.Max)
                        v26.CurveSize1 = u1:NextNumber(u7.Curve1.Min, u7.Curve1.Max) or 0
                        v26.Width0 = u1:NextNumber(u7.Width0.Min, u7.Width0.Max)
                        v26.Width1 = u1:NextNumber(u7.Width1.Min, u7.Width1.Max)
                        v26.Color = u7.Color
                        v26.Transparency = NumberSequence.new(0)
                        v26.Parent = u16
                        _G.tween(v26, { v24, "MozillaCurve", "In" }, {
                            ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                            ["Transparency"] = NumberSequence.new(1, 1),
                            ["CurveSize0"] = v26.CurveSize0 * u1:NextNumber(0.1, 1.5),
                            ["CurveSize1"] = v26.CurveSize1 * u1:NextNumber(0.1, 1.5)
                        })
                        task.delay(v24, function() --[[ Line: 134 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u25
                            --]]
                            u16:Destroy()
                            u25:Destroy()
                        end)
                    elseif math.random(1, 2) == 1 then
                        local v27 = u16.CFrame
                        local v28 = CFrame.Angles
                        local v29 = u1:NextNumber(-45, 45)
                        local v30 = math.rad(v29)
                        local v31 = u1:NextNumber(-180, 180)
                        local v32 = math.rad(v31)
                        local v33 = u1:NextNumber(-45, 45)
                        u16.CFrame = v27 * v28(v30, v32, (math.rad(v33)))
                        local v34 = u1:NextNumber(u7.Lifetime.Min, u7.Lifetime.Max)
                        local u35 = Instance.new("Attachment")
                        u35.Position = u16.WorldPosition + v22.Unit * u1:NextNumber(2, u7.RadialRange)
                        local v36 = u35.CFrame
                        local v37 = CFrame.Angles
                        local v38 = u1:NextNumber(-180, 180)
                        local v39 = math.rad(v38)
                        local v40 = u1:NextNumber(-180, 180)
                        local v41 = math.rad(v40)
                        local v42 = u1:NextNumber(-180, 180)
                        u35.CFrame = v36 * v37(v39, v41, (math.rad(v42)))
                        u35.Parent = workspace.Terrain
                        local v43 = Instance.new("Beam")
                        v43.Attachment0 = u16
                        v43.Attachment1 = u35
                        v43.FaceCamera = true
                        v43.LightEmission = u7.Emission
                        v43.LightInfluence = 0
                        v43.Brightness = u7.Brightness * 2
                        v43.Texture = u7.TextureTable[math.random(1, #u7.TextureTable)]
                        v43.TextureMode = Enum.TextureMode.Wrap
                        v43.TextureSpeed = 200
                        v43.Segments = math.random(1, 5)
                        v43.TextureLength = u1:NextNumber(25, 35)
                        v43.CurveSize0 = u1:NextNumber(u7.Curve0.Min * 2, u7.Curve0.Max * 2)
                        v43.CurveSize1 = u1:NextNumber(v43.CurveSize0, v43.CurveSize0)
                        v43.Width0 = u1:NextNumber(u7.Width0.Min * 1.25, u7.Width0.Max * 1.25)
                        v43.Width1 = u1:NextNumber(u7.Width1.Min, u7.Width1.Max)
                        v43.Color = u7.Color
                        v43.Transparency = NumberSequence.new(0, 0)
                        v43.Parent = u16
                        _G.tween(v43, { v34 + 0.25, "MozillaCurve", "In" }, {
                            ["TextureSpeed"] = 0,
                            ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                            ["Transparency"] = NumberSequence.new(1, 1),
                            ["CurveSize0"] = v43.CurveSize0 * u1:NextNumber(0.1, 1.5),
                            ["CurveSize1"] = v43.CurveSize1 * u1:NextNumber(0.1, 1.5)
                        })
                        task.delay(v34 + 0.25, function() --[[ Line: 170 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u35
                            --]]
                            u16:Destroy()
                            u35:Destroy()
                        end)
                    else
                        u16:Destroy()
                    end
                else
                    local v44 = CFrame.lookAt(u7.StartPos, u7.TargetPos)
                    local v45 = CFrame.Angles
                    local v46 = u1:NextNumber(u7.Attachment1RotationRange.Min or -90, u7.Attachment1RotationRange.Max or 90)
                    local v47 = math.rad(v46)
                    local v48 = u1:NextNumber(-180, 180)
                    local v49 = math.rad(v48)
                    local v50 = u1:NextNumber(u7.Attachment1RotationRange.Min or -90, u7.Attachment1RotationRange.Max or 90)
                    u16.CFrame = v44 * v45(v47, v49, (math.rad(v50)))
                    u16.Parent = workspace.Terrain
                    if v12 then
                        local v51 = u1:NextNumber(u7.Lifetime.Min, u7.Lifetime.Max)
                        local u52 = Instance.new("Attachment")
                        u52.CFrame = CFrame.lookAt(v12.Position, u7.StartPos)
                        u52.Parent = workspace.Terrain
                        local v53 = Instance.new("Beam")
                        v53.Attachment0 = u16
                        v53.Attachment1 = u52
                        v53.FaceCamera = true
                        v53.LightInfluence = 0
                        v53.LightEmission = u7.Emission
                        v53.Brightness = u7.Brightness
                        v53.Texture = u7.TextureTable[math.random(1, #u7.TextureTable)]
                        v53.TextureMode = Enum.TextureMode.Wrap
                        v53.TextureSpeed = 0
                        v53.Segments = math.random(1, 5)
                        v53.TextureLength = u1:NextNumber(25, 35)
                        v53.CurveSize0 = u1:NextNumber(u7.Curve0.Min, u7.Curve0.Max)
                        v53.Width0 = u1:NextNumber(u7.Width0.Min, u7.Width0.Max)
                        v53.Width1 = u1:NextNumber(u7.Width1.Min, u7.Width1.Max)
                        v53.Color = u7.Color
                        v53.Transparency = NumberSequence.new(0)
                        v53.Parent = u16
                        _G.tween(v53, { v51, "MozillaCurve", "In" }, {
                            ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                            ["Transparency"] = NumberSequence.new(1, 1),
                            ["CurveSize0"] = v53.CurveSize0 * u1:NextNumber(0.1, 1.5),
                            ["CurveSize1"] = v53.CurveSize1 * u1:NextNumber(0.1, 1.5)
                        })
                        task.delay(v51, function() --[[ Line: 216 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u52
                            --]]
                            u16:Destroy()
                            u52:Destroy()
                        end)
                    else
                        local v54 = u1:NextNumber(u7.Lifetime.Min, u7.Lifetime.Max)
                        local u55 = Instance.new("Attachment")
                        u55.Position = u7.StartPos + u7.TargetPos.Unit * u7.Range
                        u55.CFrame = CFrame.lookAt(u16.WorldPosition, u55.WorldPosition)
                        u55.Parent = workspace.Terrain
                        local v56 = Instance.new("Beam")
                        v56.Attachment0 = u16
                        v56.Attachment1 = u55
                        v56.FaceCamera = true
                        v56.LightInfluence = 0
                        v56.LightEmission = u7.Emission
                        v56.Brightness = u7.Brightness
                        v56.Texture = u7.TextureTable[math.random(1, #u7.TextureTable)]
                        v56.TextureMode = Enum.TextureMode.Wrap
                        v56.TextureSpeed = 0
                        v56.Segments = math.random(1, 5)
                        v56.TextureLength = u1:NextNumber(25, 35)
                        v56.CurveSize0 = u1:NextNumber(u7.Curve0.Min, u7.Curve0.Max)
                        v56.Width0 = u1:NextNumber(u7.Width0.Min, u7.Width0.Max)
                        v56.Width1 = u1:NextNumber(u7.Width1.Min, u7.Width1.Max)
                        v56.Color = u7.Color
                        v56.Transparency = NumberSequence.new(0)
                        v56.Parent = u16
                        _G.tween(v56, { v54 + 0.25, "MozillaCurve", "In" }, {
                            ["TextureSpeed"] = 0,
                            ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                            ["Transparency"] = NumberSequence.new(1, 1),
                            ["CurveSize0"] = v56.CurveSize0 * u1:NextNumber(0.1, 1.5),
                            ["CurveSize1"] = v56.CurveSize1 * u1:NextNumber(0.1, 1.5)
                        })
                        task.delay(v54 + 0.25, function() --[[ Line: 248 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u55
                            --]]
                            u16:Destroy()
                            u55:Destroy()
                        end)
                    end
                end
            end
            task.wait(1 / (u7.Rate or 1))
            if u7 == nil or u7.Enabled == false then
                return
            end
        end
    end)
end
function u3.Disable(p57) --[[ Line: 260 ]]
    p57.Enabled = false
end
function u3.ChangeProperty(p58, p59, p60) --[[ Line: 264 ]]
    p58[p59] = p60
end
function u3.Emit(p61) --[[ Line: 268 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v62 = RaycastParams.new()
    v62.FilterType = Enum.RaycastFilterType.Include
    v62.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    local v63 = p61.Parts
    if type(v63) ~= "table" then
        p61.Parts = { p61.Parts }
    end
    local v64 = p61.Lifetime
    if typeof(v64) ~= "NumberRange" then
        p61.Lifetime = NumberRange.new(p61.Lifetime)
    end
    local v65 = p61.TextureTable
    if type(v65) ~= "table" then
        p61.TextureTable = { p61.TextureTable }
    end
    for v66 = 1, p61.ArcsPerRate or 0 do
        local u67 = Instance.new("Attachment")
        if p61.Type == "Radial" then
            local v68 = p61.Parts[math.random(1, #p61.Parts)]
            u67.CFrame = v68.CFrame * CFrame.new(u1:NextNumber(-v68.Size.X, v68.Size.X), u1:NextNumber(-v68.Size.Y, v68.Size.Y), u1:NextNumber(-v68.Size.Z, v68.Size.Z)) * CFrame.Angles(0, -1.5707963267948966, 0)
            u67.Parent = workspace.Terrain
            local v69 = math.random(-p61.RadialRange, p61.RadialRange)
            local v70 = math.random(-p61.RadialRange, p61.RadialRange)
            local v71 = math.random
            local v72 = -p61.RadialRange
            local v73 = p61.RadialRange
            local v74 = Vector3.new(v69, v70, v71(v72, v73))
            local v75 = workspace:Raycast(u67.WorldPosition, v74, v62)
            if v75 then
                if p61.OnRayHit then
                    p61.OnRayHit(v75, v66)
                end
                local v76 = u1:NextNumber(p61.Lifetime.Min, p61.Lifetime.Max)
                local u77 = Instance.new("Attachment")
                u77.Position = v75.Position
                u77.CFrame = CFrame.lookAt(u77.Position, u67.WorldPosition)
                u77.Parent = workspace.Terrain
                local v78 = Instance.new("Beam")
                v78.Attachment0 = u67
                v78.Attachment1 = u77
                v78.FaceCamera = true
                v78.LightEmission = p61.Emission
                v78.LightInfluence = 0
                v78.Brightness = p61.Brightness
                v78.Texture = p61.TextureTable[math.random(1, #p61.TextureTable)]
                v78.TextureMode = Enum.TextureMode.Wrap
                v78.TextureSpeed = 0
                v78.Segments = math.random(1, 5)
                v78.TextureLength = u1:NextNumber(25, 35)
                v78.CurveSize0 = u1:NextNumber(p61.Curve0.Min or 0, p61.Curve0.Max or 0)
                v78.CurveSize1 = u1:NextNumber(p61.Curve1.Min or 0, p61.Curve1.Max or 0)
                v78.Width0 = u1:NextNumber(p61.Width0.Min, p61.Width0.Max)
                v78.Width1 = u1:NextNumber(0.5, 2)
                v78.Color = p61.Color
                v78.Transparency = NumberSequence.new(0)
                v78.Parent = u67
                _G.tween(v78, { v76, "MozillaCurve", "In" }, {
                    ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                    ["Transparency"] = NumberSequence.new(1, 1),
                    ["CurveSize0"] = v78.CurveSize0 * u1:NextNumber(0.1, 1.5),
                    ["CurveSize1"] = v78.CurveSize1 * u1:NextNumber(0.1, 1.5)
                })
                task.delay(v76, function() --[[ Line: 331 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u77
                    --]]
                    u67:Destroy()
                    u77:Destroy()
                end)
            elseif math.random(1, 2) == 1 then
                local v79 = u67.CFrame
                local v80 = CFrame.Angles
                local v81 = u1:NextNumber(-45, 45)
                local v82 = math.rad(v81)
                local v83 = u1:NextNumber(-180, 180)
                local v84 = math.rad(v83)
                local v85 = u1:NextNumber(-45, 45)
                u67.CFrame = v79 * v80(v82, v84, (math.rad(v85)))
                local v86 = u1:NextNumber(p61.Lifetime.Min, p61.Lifetime.Max)
                local u87 = Instance.new("Attachment")
                u87.Position = u67.Position + v74.Unit * u1:NextNumber(2, p61.RadialRange)
                local v88 = u87.CFrame
                local v89 = CFrame.Angles
                local v90 = u1:NextNumber(-180, 180)
                local v91 = math.rad(v90)
                local v92 = u1:NextNumber(-180, 180)
                local v93 = math.rad(v92)
                local v94 = u1:NextNumber(-180, 180)
                u87.CFrame = v88 * v89(v91, v93, (math.rad(v94)))
                u87.Parent = workspace.Terrain
                local v95 = Instance.new("Beam")
                v95.Attachment0 = u67
                v95.Attachment1 = u87
                v95.FaceCamera = true
                v95.LightEmission = p61.Emission
                v95.LightInfluence = 0
                v95.Brightness = p61.Brightness * 2
                v95.Texture = p61.TextureTable[math.random(1, #p61.TextureTable)]
                v95.TextureMode = Enum.TextureMode.Wrap
                v95.TextureSpeed = 200
                v95.Segments = math.random(1, 5)
                v95.TextureLength = u1:NextNumber(25, 35)
                v95.CurveSize0 = u1:NextNumber(p61.Curve0.Min * 2, p61.Curve0.Max * 2)
                v95.CurveSize1 = u1:NextNumber(v95.CurveSize0, v95.CurveSize0)
                v95.Width0 = u1:NextNumber(p61.Width0.Min * 1.25, p61.Width0.Max * 1.25)
                v95.Width1 = 0
                v95.Color = p61.Color
                v95.Transparency = NumberSequence.new(0, 0)
                v95.Parent = u67
                _G.tween(v95, { v86 + 0.25, "MozillaCurve", "In" }, {
                    ["TextureSpeed"] = 0,
                    ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                    ["Transparency"] = NumberSequence.new(1, 1),
                    ["CurveSize0"] = v95.CurveSize0 * u1:NextNumber(0.1, 1.5),
                    ["CurveSize1"] = v95.CurveSize1 * u1:NextNumber(0.1, 1.5)
                })
                task.delay(v86 + 0.25, function() --[[ Line: 368 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u87
                    --]]
                    u67:Destroy()
                    u87:Destroy()
                end)
            else
                u67:Destroy()
            end
        else
            u67.CFrame = CFrame.lookAt(p61.StartPos, p61.TargetPos)
            u67.Parent = workspace.Terrain
            if p61.Attachment1RotationRange then
                local v96 = u67.CFrame
                local v97 = CFrame.Angles
                local v98 = u1:NextNumber(p61.Attachment1RotationRange.Min or -90, p61.Attachment1RotationRange.Max or 90)
                local v99 = math.rad(v98)
                local v100 = u1:NextNumber(p61.Attachment1RotationRange.Min or -90, p61.Attachment1RotationRange.Max or 90)
                local v101 = math.rad(v100)
                local v102 = u1:NextNumber(p61.Attachment1RotationRange.Min or -90, p61.Attachment1RotationRange.Max or 90)
                u67.CFrame = v96 * v97(v99, v101, (math.rad(v102)))
            end
            u67.Parent = workspace.Terrain
            local v103 = p61.TargetPos - p61.StartPos
            local v104 = workspace:Raycast(p61.StartPos, v103.Unit * p61.Range, v62)
            if v104 then
                if p61.OnRayHit then
                    p61.OnRayHit(v104, v66)
                end
                local v105 = u1:NextNumber(p61.Lifetime.Min, p61.Lifetime.Max)
                local u106 = Instance.new("Attachment")
                u106.CFrame = CFrame.lookAt(v104.Position, p61.StartPos)
                u106.Parent = workspace.Terrain
                local v107 = Instance.new("Beam")
                v107.Attachment0 = u67
                v107.Attachment1 = u106
                v107.FaceCamera = true
                v107.LightInfluence = 0
                v107.LightEmission = p61.Emission
                v107.Brightness = p61.Brightness
                v107.Texture = p61.TextureTable[math.random(1, #p61.TextureTable)]
                v107.TextureMode = Enum.TextureMode.Wrap
                v107.TextureSpeed = 0
                v107.Segments = math.random(1, 5)
                v107.TextureLength = u1:NextNumber(25, 35)
                v107.CurveSize0 = u1:NextNumber(p61.Curve0.Min, p61.Curve0.Max)
                v107.Width0 = u1:NextNumber(p61.Width0.Min, p61.Width0.Max)
                v107.Width1 = u1:NextNumber(0.5, 2)
                v107.Color = p61.Color
                v107.Transparency = NumberSequence.new(0)
                v107.Parent = u67
                _G.tween(v107, { v105, "MozillaCurve", "In" }, {
                    ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                    ["Transparency"] = NumberSequence.new(1, 1),
                    ["CurveSize0"] = v107.CurveSize0 * u1:NextNumber(0.1, 1.5),
                    ["CurveSize1"] = v107.CurveSize1 * u1:NextNumber(0.1, 1.5)
                })
                task.delay(v105, function() --[[ Line: 420 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u106
                    --]]
                    u67:Destroy()
                    u106:Destroy()
                end)
            else
                local v108 = u1:NextNumber(p61.Lifetime.Min, p61.Lifetime.Max)
                local u109 = Instance.new("Attachment")
                ElectricityHolder.Position = p61.StartPos + p61.TargetPos.Unit * p61.Range
                ElectricityHolder.CFrame = CFrame.lookAt(u109.Position, u67.WorldPosition)
                u109.Parent = workspace.Terrain
                local v110 = Instance.new("Beam")
                v110.Attachment0 = u67
                v110.Attachment1 = u109
                v110.FaceCamera = true
                v110.LightInfluence = 0
                v110.LightEmission = p61.Emission
                v110.Brightness = p61.Brightness
                v110.Texture = p61.TextureTable[math.random(1, #p61.TextureTable)]
                v110.TextureMode = Enum.TextureMode.Wrap
                v110.TextureSpeed = 0
                v110.Segments = math.random(1, 5)
                v110.TextureLength = u1:NextNumber(25, 35)
                v110.CurveSize0 = u1:NextNumber(p61.Curve0.Min, p61.Curve0.Max)
                v110.Width0 = u1:NextNumber(p61.Width0.Min, p61.Width0.Max)
                v110.Width1 = u1:NextNumber(0.5, 2)
                v110.Color = p61.Color
                v110.Transparency = NumberSequence.new(0)
                v110.Parent = u67
                _G.tween(v110, { v108 + 0.25, "MozillaCurve", "In" }, {
                    ["TextureSpeed"] = 0,
                    ["Color"] = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
                    ["Transparency"] = NumberSequence.new(1, 1),
                    ["CurveSize0"] = v110.CurveSize0 * u1:NextNumber(0.1, 1.5),
                    ["CurveSize1"] = v110.CurveSize1 * u1:NextNumber(0.1, 1.5)
                })
                task.delay(v108 + 0.25, function() --[[ Line: 452 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u109
                    --]]
                    u67:Destroy()
                    u109:Destroy()
                end)
            end
        end
    end
end
function u3.Destroy(p111) --[[ Line: 461 ]]
    p111.Enabled = false
    setmetatable(p111, nil)
    table.clear(p111)
end
return v2