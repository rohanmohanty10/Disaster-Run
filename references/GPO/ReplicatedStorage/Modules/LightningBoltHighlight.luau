 

local u1 = os.clock
function DiscretePulse(p2, p3, p4, p5, p6, p7, p8)
    local v9 = p4 / (2 * p5)
    local v10 = (p2 - p6 * p3 + 0.5 * p4) / p5
    local v11 = v9 - math.abs(v10)
    return math.clamp(v11, p7, p8)
end
function NoiseBetween(p12, p13, p14, p15, p16)
    return p15 + (p16 - p15) * (math.noise(p12, p13, p14) + 0.5)
end
function CubicBezier(p17, p18, p19, p20, p21)
    return p17 * (1 - p21) ^ 3 + p18 * 3 * p21 * (1 - p21) ^ 2 + p19 * 3 * (1 - p21) * p21 ^ 2 + p20 * p21 ^ 3
end
local u22 = script.BoltPart:Clone()
u22.TopSurface = 0
u22.BottomSurface = 0
u22.Anchored = true
u22.CanCollide = false
u22.Name = "BoltPart"
u22.Color = Color3.new(1, 1, 1)
u22.Transparency = 1
Random.new()
local u23 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()
local u24 = {}
local u25 = {}
u25.__index = u25
function u25.new(p26, p27, p28) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u22
        [3] = u23
        [4] = u1
        [5] = u24
    --]]
    local v29 = u25
    local v30 = setmetatable({}, v29)
    v30.Enabled = true
    v30.Attachment0 = p26
    v30.Attachment1 = p27
    v30.CurveSize0 = 0
    v30.CurveSize1 = 0
    v30.MinRadius = 0
    v30.MaxRadius = 2.4
    v30.Frequency = 1
    v30.AnimationSpeed = 7
    v30.Thickness = 1
    v30.MinThicknessMultiplier = 0.2
    v30.MaxThicknessMultiplier = 1
    v30.MinTransparency = 0
    v30.MaxTransparency = 1
    v30.PulseSpeed = 2
    v30.PulseLength = 1000000
    v30.FadeLength = 0.2
    v30.ContractFrom = 0.5
    v30.Color = Color3.new(1, 1, 1)
    v30.ColorOffsetSpeed = 3
    v30.OuterColor = Color3.new(0, 0.984314, 1)
    v30.Parts = {}
    local v31 = workspace.CurrentCamera
    local v32 = p26.WorldPosition
    local v33 = p26.WorldPosition + p26.WorldAxis * v30.CurveSize0
    local v34 = p27.WorldPosition - p27.WorldAxis * v30.CurveSize1
    local v35 = p27.WorldPosition
    local v36 = p28 or 30
    local v37 = v32
    local v38 = v37
    local v39 = v37
    v37 = v38
    v39 = v38
    for v40 = 1, v36 do
        local v41 = v40 / v36
        local v42 = CubicBezier(v32, v33, v34, v35, v41)
        local v43
        if v40 == v36 then
            v43 = v42
        else
            v43 = CFrame.lookAt(v37, v42).Position or v42
        end
        local v44 = u22:Clone()
        local v45 = (v43 - v38).Magnitude
        v44.Size = Vector3.new(v45, 0, 0)
        v44.CFrame = CFrame.lookAt(0.5 * (v38 + v43), v43) * u23
        v44.Parent = v31
        v44.Locked = true
        v44.CastShadow = false
        v30.Parts[v40] = v44
        v37 = v42
        v38 = v43
    end
    v30.PartsHidden = false
    v30.DisabledTransparency = 1
    v30.StartT = u1()
    v30.RanNum = math.random() * 100
    v30.RefIndex = #u24 + 1
    u24[v30.RefIndex] = v30
    return v30
end
function u25.Destroy(p46) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    u24[p46.RefIndex] = nil
    for v47 = 1, #p46.Parts do
        p46.Parts[v47]:Destroy()
        if v47 % 100 == 0 then
            wait()
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u1
        [3] = u23
    --]]
    for _, v48 in u24 do
        if v48.Enabled == true then
            v48.PartsHidden = false
            local v49 = 1 - v48.MaxTransparency
            local v50 = 1 - v48.MinTransparency
            local v51 = v48.MinRadius
            local v52 = v48.MaxRadius
            local v53 = v48.Thickness
            local v54 = v48.Parts
            local v55 = #v54
            local v56 = v48.RanNum
            local v57 = v48.StartT
            local v58 = v48.AnimationSpeed
            local v59 = v48.Frequency
            local v60 = v48.MinThicknessMultiplier
            local v61 = v48.MaxThicknessMultiplier
            local v62 = v48.Attachment0
            local v63 = v48.Attachment1
            local v64 = v48.CurveSize0
            local v65 = v48.CurveSize1
            local v66 = v62.WorldPosition
            local v67 = v62.WorldPosition + v62.WorldAxis * v64
            local v68 = v63.WorldPosition - v63.WorldAxis * v65
            local v69 = v63.WorldPosition
            local v70 = u1() - v57
            local v71 = v48.PulseLength
            local v72 = v48.PulseSpeed
            local v73 = v48.FadeLength
            local v74 = v48.Color
            local v75 = v48.ColorOffsetSpeed
            local v76 = 1 - v48.ContractFrom
            if v70 < (v71 + 1) / v72 then
                local v77 = v66
                local v78 = v77
                local v79 = v77
                v77 = v78
                v79 = v78
                local v80 = {}
                local v81 = {}
                for v82 = 1, v55 do
                    local v83 = v54[v82]
                    local v84 = v82 / v55
                    local v85 = DiscretePulse(v84, v72, v71, v73, v70, v49, v50)
                    local v86 = CubicBezier(v66, v67, v68, v69, v84)
                    local v87 = -v70
                    local v88 = v58 * v87 + v59 * 10 * v84 - 0.2 + v56 * 4
                    local v89 = 5 * (v58 * 0.01 * v87 / 10 + v59 * v84) + v56 * 4
                    local v90 = NoiseBetween(5 * v88, 1.5, 1 * v89, 0, 0.6283185307179586) + NoiseBetween(0.5 * v88, 1.5, 0.1 * v89, 0, 5.654866776461628)
                    local v91 = NoiseBetween(3.4, v89, v88, v51, v52)
                    local v92 = (v84 - 0.5) ^ 10 * -5000
                    local v93 = v91 * math.exp(v92)
                    local v94 = NoiseBetween(2.3, v89, v88, v60, v61)
                    local v95
                    if v82 == v55 then
                        v95 = v86
                    else
                        local v96 = CFrame.new(v77, v86) * CFrame.Angles(0, 0, v90)
                        local v97 = CFrame.Angles
                        local v98 = NoiseBetween(v89, v88, 2.7, 6.123233995736766e-17, 1)
                        local v99 = math.clamp(v98, -1, 1)
                        v95 = (v96 * v97(math.acos(v99), 0, 0) * CFrame.new(0, 0, -v93)).Position or v86
                    end
                    local v100 = nil
                    if v76 < v85 then
                        local v101 = (v95 - v78).Magnitude
                        local v102 = v53 * v94 * v85
                        local v103 = v53 * v94 * v85
                        v83.Size = Vector3.new(v101, v102, v103)
                        v100 = CFrame.lookAt(0.5 * (v78 + v95), v95) * u23
                        v83.Transparency = 1 - v85
                    elseif v76 - 1 / (v55 * v73) < v85 then
                        local v104 = (1 - (v85 - (v76 - 1 / (v55 * v73))) * v55 * v73) * (v84 < v70 * v72 - 0.5 * v71 and 1 or -1)
                        local v105 = (1 - math.abs(v104)) * (v95 - v78).Magnitude
                        local v106 = v53 * v94 * v85
                        local v107 = v53 * v94 * v85
                        v83.Size = Vector3.new(v105, v106, v107)
                        v100 = CFrame.lookAt(v78 + (v95 - v78) * (math.max(0, v104) + (1 - math.abs(v104)) * 0.5), v95) * u23
                        v83.Transparency = 1 - v85
                    else
                        v83.Transparency = 1
                    end
                    if typeof(v74) == "Color3" then
                        v83.Color = v74
                    else
                        local v108 = (v56 + v84 - v70 * v75) % 1
                        local v109 = v74.Keypoints
                        for v110 = 1, #v109 - 1 do
                            if v109[v110].Time < v108 and v108 < v109[v110 + 1].Time then
                                v83.Color = v109[v110].Value:lerp(v109[v110 + 1].Value, (v108 - v109[v110].Time) / (v109[v110 + 1].Time - v109[v110].Time))
                                break
                            end
                        end
                    end
                    local v111 = v83.InnerBolt
                    local v112 = v83.Size.X
                    local v113 = v83.Size.Y * 0.625
                    local v114 = v83.Size.Z * 0.625
                    v111.Size = Vector3.new(v112, v113, v114)
                    v83.InnerBolt.Transparency = v83.Transparency - 0.425
                    v83.InnerBolt.Color = v83.Color
                    v83.Color = v48.OuterColor
                    if v100 ~= nil then
                        table.insert(v81, v83)
                        table.insert(v80, v100)
                        local v115 = v83.InnerBolt
                        table.insert(v81, v115)
                        table.insert(v80, v100)
                    end
                    v77 = v86
                    v78 = v95
                end
                workspace:BulkMoveTo(v81, v80)
            else
                v48:Destroy()
            end
        elseif v48.PartsHidden == false then
            v48.PartsHidden = true
            local v116 = v48.DisabledTransparency
            for v117 = 1, #v48.Parts do
                v48.Parts[v117].Transparency = v116
            end
        end
    end
end)
return u25