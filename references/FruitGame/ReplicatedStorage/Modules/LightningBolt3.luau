 

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
local u22 = Instance.new("Part")
u22.TopSurface = 0
u22.BottomSurface = 0
u22.Anchored = true
u22.CanCollide = false
u22.Shape = "Cylinder"
u22.Name = "BoltPart"
u22.Material = Enum.Material.Neon
u22.Color = Color3.new(1, 1, 1)
u22.Transparency = 1
u22.CastShadow = false
u22.CanQuery = false
u22.CanTouch = false
Random.new()
local u23 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()
local u24 = {}
local u25 = {}
u25.__index = u25
function u25.new(p26, p27, p28) --[[ Line: 54 ]]
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
    v30.Parts = {}
    local v31 = workspace.Effects
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
    local v40 = {}
    local v41 = {}
    for v42 = 1, v36 do
        local v43 = v42 / v36
        local v44 = CubicBezier(v32, v33, v34, v35, v43)
        local v45
        if v42 == v36 then
            v45 = v44
        else
            v45 = CFrame.lookAt(v37, v44).Position or v44
        end
        local v46 = u22:Clone()
        local v47 = (v45 - v38).Magnitude
        v46.Size = Vector3.new(v47, 0, 0)
        v46.CastShadow = false
        v46.Parent = v31
        v46.Locked = true
        v30.Parts[v42] = v46
        table.insert(v41, v46)
        local v48 = CFrame.lookAt(0.5 * (v45 + v45), v45) * u23
        table.insert(v40, v48)
        v37 = v44
        v38 = v45
    end
    workspace:BulkMoveTo(v41, v40)
    v30.PartsHidden = false
    v30.DisabledTransparency = 1
    v30.StartT = u1()
    v30.RanNum = math.random() * 100
    v30.RefIndex = #u24 + 1
    u24[v30.RefIndex] = v30
    return v30
end
function u25.Destroy(p49) --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    u24[p49.RefIndex] = nil
    for v50 = 1, #p49.Parts do
        p49.Parts[v50]:Destroy()
        if v50 % 100 == 0 then
            game["Run Service"].Heartbeat:Wait()
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function() --[[ Name: loop, Line 139 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u1
        [3] = u23
    --]]
    for _, v51 in u24 do
        if v51.Enabled == true then
            v51.PartsHidden = false
            local v52 = 1 - v51.MaxTransparency
            local v53 = 1 - v51.MinTransparency
            local v54 = v51.MinRadius
            local v55 = v51.MaxRadius
            local v56 = v51.Thickness
            local v57 = v51.Parts
            local v58 = #v57
            local v59 = v51.RanNum
            local v60 = v51.StartT
            local v61 = v51.AnimationSpeed
            local v62 = v51.Frequency
            local v63 = v51.MinThicknessMultiplier
            local v64 = v51.MaxThicknessMultiplier
            local v65 = v51.Attachment0
            local v66 = v51.Attachment1
            local v67 = v51.CurveSize0
            local v68 = v51.CurveSize1
            local v69 = v65.WorldPosition
            local v70 = v65.WorldPosition + v65.WorldAxis * v67
            local v71 = v66.WorldPosition - v66.WorldAxis * v68
            local v72 = v66.WorldPosition
            local v73 = u1() - v60
            local v74 = v51.PulseLength
            local v75 = v51.PulseSpeed
            local v76 = v51.FadeLength
            local v77 = v51.Color
            local v78 = v51.ColorOffsetSpeed
            local v79 = 1 - v51.ContractFrom
            if v73 < (v74 + 1) / v75 then
                local v80 = v69
                local v81 = v80
                local v82 = v80
                v80 = v81
                v82 = v81
                local v83 = {}
                local v84 = {}
                for v85 = 1, v58 do
                    local v86 = v57[v85]
                    local v87 = v85 / v58
                    local v88 = DiscretePulse(v87, v75, v74, v76, v73, v52, v53)
                    local v89 = CubicBezier(v69, v70, v71, v72, v87)
                    local v90 = -v73
                    local v91 = v61 * v90 + v62 * 10 * v87 - 0.2 + v59 * 4
                    local v92 = 5 * (v61 * 0.01 * v90 / 10 + v62 * v87) + v59 * 4
                    local v93 = NoiseBetween(5 * v91, 1.5, 1 * v92, 0, 0.6283185307179586) + NoiseBetween(0.5 * v91, 1.5, 0.1 * v92, 0, 5.654866776461628)
                    local v94 = NoiseBetween(3.4, v92, v91, v54, v55)
                    local v95 = (v87 - 0.5) ^ 10 * -5000
                    local v96 = v94 * math.exp(v95)
                    local v97 = NoiseBetween(2.3, v92, v91, v63, v64)
                    local v98
                    if v85 == v58 then
                        v98 = v89
                    else
                        local v99 = CFrame.new(v80, v89) * CFrame.Angles(0, 0, v93)
                        local v100 = CFrame.Angles
                        local v101 = NoiseBetween(v92, v91, 2.7, 6.123233995736766e-17, 1)
                        local v102 = math.clamp(v101, -1, 1)
                        v98 = (v99 * v100(math.acos(v102), 0, 0) * CFrame.new(0, 0, -v96)).Position or v89
                    end
                    local v103 = nil
                    if v79 < v88 then
                        local v104 = (v98 - v81).Magnitude
                        local v105 = v56 * v97 * v88
                        local v106 = v56 * v97 * v88
                        v86.Size = Vector3.new(v104, v105, v106)
                        v103 = CFrame.lookAt(0.5 * (v81 + v98), v98) * u23
                        v86.Transparency = 1 - v88
                    elseif v79 - 1 / (v58 * v76) < v88 then
                        local v107 = (1 - (v88 - (v79 - 1 / (v58 * v76))) * v58 * v76) * (v87 < v73 * v75 - 0.5 * v74 and 1 or -1)
                        local v108 = (1 - math.abs(v107)) * (v98 - v81).Magnitude
                        local v109 = v56 * v97 * v88
                        local v110 = v56 * v97 * v88
                        v86.Size = Vector3.new(v108, v109, v110)
                        v103 = CFrame.lookAt(v81 + (v98 - v81) * (math.max(0, v107) + (1 - math.abs(v107)) * 0.5), v98) * u23
                        v86.Transparency = 1 - v88
                    else
                        v86.Transparency = 1
                    end
                    if v103 ~= nil then
                        table.insert(v84, v86)
                        table.insert(v83, v103)
                    end
                    if typeof(v77) == "Color3" then
                        v86.Color = v77
                    else
                        local v111 = (v59 + v87 - v73 * v78) % 1
                        local v112 = v77.Keypoints
                        for v113 = 1, #v112 - 1 do
                            if v112[v113].Time < v111 and v111 < v112[v113 + 1].Time then
                                v86.Color = v112[v113].Value:Lerp(v112[v113 + 1].Value, (v111 - v112[v113].Time) / (v112[v113 + 1].Time - v112[v113].Time))
                                break
                            end
                        end
                    end
                    v80 = v89
                    v81 = v98
                end
                workspace:BulkMoveTo(v84, v83)
            else
                v51:Destroy()
            end
        elseif v51.PartsHidden == false then
            v51.PartsHidden = true
            local v114 = v51.DisabledTransparency
            for v115 = 1, #v51.Parts do
                v51.Parts[v115].Transparency = v114
            end
        end
    end
end)
return u25