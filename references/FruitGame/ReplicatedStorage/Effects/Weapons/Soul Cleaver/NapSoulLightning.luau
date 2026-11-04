 

game:GetService("ReplicatedStorage")
local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
game:GetService("TweenService")
v1.LocalPlayer:GetMouse()
local _ = workspace.Terrain
local _ = workspace.CurrentCamera
local u3 = Random.new()
local _ = script.Parent
local u4 = {
    "rbxassetid://15950077142",
    "rbxassetid://15950088137",
    "rbxassetid://15950094991",
    "rbxassetid://15950121345"
}
local u5 = require(script.Cleaner)
local u6 = require(script.Signal)
local u7 = {}
u7.__index = u7
function u7.new(p8) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u6
    --]]
    local v9 = u7
    local v10 = setmetatable({}, v9)
    v10.Cleaner = u5.new()
    v10.Destroyed = u6.new()
    v10.Attachment0 = p8.Attachment0
    v10.Attachment1 = p8.Attachment1
    v10.CurveSize0 = p8.CurveSize0 or 0
    v10.CurveSize1 = p8.CurveSize1 or 0
    v10.Rotate0 = p8.Rotate0 or 0
    v10.Rotate1 = p8.Rotate1 or 0
    v10.RadiusOffset = p8.RadiusOffset or NumberRange.new(1, 2)
    v10.Bolts = p8.Bolts or 5
    v10.Segments = p8.Segments or 3
    v10.Width = p8.Width or NumberRange.new(1, 2)
    v10.TextureSpeed = p8.TextureSpeed or 1
    v10.BoltDuration = p8.BoltDuration or 0.15
    v10.Duration = p8.Duration or 0.15
    if p8.BeamColor then
        v10.BeamColor = p8.BeamColor
        if v10.BeamColor == ColorSequence.new(Color3.fromRGB(255, 122, 55)) then
            v10.BeamBrightness = 5
        end
    end
    v10.Started = os.clock()
    v10.Data = v10:_createData()
    v10:_main()
    return v10
end
function u7._createNoiseData(_) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return {
        ["Seed"] = math.random() * 1000,
        ["Frequency"] = u3:NextNumber(35, 50),
        ["Resolution"] = u3:NextNumber(5, 10),
        ["Amplitude"] = u3:NextNumber(5, 10)
    }
end
function u7._createData(p11) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v12 = p11.Bolts
    local v13 = p11.RadiusOffset
    local v14 = p11.Segments
    local v15 = p11.Attachment0
    local v16 = p11.TextureSpeed
    local v17 = p11.Width
    local v18 = v12 * v14
    local v19 = 0
    local v20 = {}
    for v21 = 0, v12 do
        local v22 = v21 / v12
        local v23 = {
            ["Alpha"] = v22,
            ["Offset"] = u3:NextUnitVector() * u3:NextNumber(v13.Min, v13.Max)
        }
        local v24 = v22 * 3.141592653589793
        v23.Weight = math.sin(v24)
        v23.Segments = {}
        ColorSequence.new(Color3.fromRGB(224, 147, 255))
        if v21 - 1 >= 0 then
            local v25 = v20[v21 - 1]
            for v26 = 1, v14 do
                local v27 = v26 / v14
                local v28 = Instance.new("Attachment")
                v28.Parent = workspace.Terrain
                local v29 = script.Beam:Clone()
                v29.Texture = u4[math.random(#u4)]
                v29.Attachment0 = v15
                v29.Attachment1 = v28
                v29.TextureSpeed = v16
                if p11.BeamBrightness then
                    v29.Brightness = p11.BeamBrightness
                end
                if p11.BeamColor then
                    v29.Color = p11.BeamColor
                end
                v29.Parent = workspace.Terrain
                p11.Cleaner:Add(v28, v29)
                local u30 = os.clock()
                local u31 = {
                    ["X"] = p11:_createNoiseData(),
                    ["Y"] = p11:_createNoiseData(),
                    ["Z"] = p11:_createNoiseData()
                }
                local v32 = v25.Segments
                local v33 = {
                    ["SegmentAlpha"] = v19 / v18,
                    ["Alpha"] = v27
                }
                local v34 = v27 * 3.141592653589793
                v33.Weight = math.sin(v34)
                v33.Offset = u3:NextUnitVector() * u3:NextNumber(v13.Min, v13.Max) / 2
                v33.Attachment = v28
                v33.Beam = v29
                v33.Width = u3:NextNumber(v17.Min, v17.Max)
                v33.WidthAlpha = 0
                v33.RenderedWidth = 0
                function v33.Noise() --[[ Line: 140 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u31
                    --]]
                    local v35 = os.clock() - u30
                    local v36 = math.noise(v35 * u31.X.Frequency / u31.X.Resolution, u31.X.Seed)
                    local v37 = math.noise(v35 * u31.Y.Frequency / u31.Y.Resolution, u31.Y.Seed)
                    local v38 = math.noise
                    local v39 = v35 * u31.Z.Frequency / u31.Z.Resolution
                    local v40 = u31.Z.Seed
                    return Vector3.new(v36, v37, v38(v39, v40))
                end
                v32[v26] = v33
                v19 = v19 + 1
                v15 = v28
            end
        end
        v20[v21] = v23
    end
    return v20
end
function u7._cubicBezier(_, p41, p42, p43, p44, p45) --[[ Line: 161 ]]
    local v46 = 1 - p45
    local v47 = p45 * p45
    local v48 = v46 * v46
    local v49 = v48 * v46
    local v50 = v47 * p45
    return v49 * p41 + v48 * 3 * p45 * p42 + v46 * 3 * v47 * p43 + v50 * p44
end
function u7._update(p51, p52) --[[ Line: 174 ]]
    local v53 = p51.Started
    local v54 = p51.Duration
    local v55 = p51.BoltDuration
    local v56 = p51.Segments
    local v57 = p51.Attachment0
    local v58 = p51.Attachment1
    local v59 = p51.Rotate0
    local v60 = p51.Rotate1
    local v61 = p51.CurveSize0
    local v62 = p51.CurveSize1
    local v63 = p51.Data
    local v64 = p51.Bolts
    local v65 = v64 * v56
    local v66 = (os.clock() - v53) / v54
    local v67 = math.min(v66, 1)
    if v63[v64 - 1].Segments[v56].WidthAlpha == 1 or not (v57.Parent and v58.Parent) then
        p51:Destroy()
    else
        local v68 = v57.WorldAxis
        local v69 = v58.WorldAxis
        local v70 = CFrame.fromAxisAngle(v57.WorldSecondaryAxis, v59) * v68
        local v71 = CFrame.fromAxisAngle(v58.WorldSecondaryAxis, v60) * v69
        local v72 = v57.WorldPosition
        local v73 = v57.WorldPosition + v70 * v61
        local v74 = v58.WorldPosition - v71 * v62
        local v75 = v58.WorldPosition
        local v76 = v72
        local v77 = 0
        for v78 = 0, v64 do
            local v79 = v63[v78]
            local v80 = v79.Alpha
            local v81 = v79.Offset
            local v82 = v79.Weight
            local v83 = p51:_cubicBezier(v76, v73, v74, v75, v80) + v81 * v82
            local v84
            if v78 - 1 >= 0 then
                local v85 = v63[v78 - 1]
                local v86 = (v83 - v72) / 2 + v72 + v85.Offset / 2 * v85.Weight
                v84 = v83
                local v87 = v72
                for v88 = 1, v56 do
                    local v89 = v85.Segments[v88]
                    local v90 = v85.Segments[v88 + 1] or v79.Segments[1]
                    local v91 = v89.Alpha
                    local v92 = v72:Lerp(v86, v91):Lerp(v86:Lerp(v83, v91), v91)
                    local _ = v92 - v87
                    local v93 = v89.Attachment
                    local v94 = v67 * v65
                    local v95
                    if v77 <= math.ceil(v94) then
                        local v96 = v89.WidthAlpha + p52 / v55
                        v89.WidthAlpha = math.min(v96, 1)
                        local v97 = v89.Width
                        local v98 = v89.WidthAlpha * 3.141592653589793
                        v89.RenderedWidth = v97 * math.sin(v98)
                        v95 = v92 + (v89.Noise() + Vector3.new(0, 1, 0) * v89.WidthAlpha * v89.WidthAlpha)
                    else
                        v95 = v92
                    end
                    local v99 = v89.Beam
                    v99.Width0 = v89.RenderedWidth
                    v99.Width1 = v78 == v64 and v88 == v56 and 0 or (v90.RenderedWidth or 0)
                    v93.WorldPosition = v95
                    v77 = v77 + 1
                    v87 = v92
                end
            else
                v84 = v83
            end
            v72 = v84
        end
    end
end
function u7._main(p100) --[[ Line: 267 ]]
    p100:Update()
end
function u7.Update(u101) --[[ Line: 271 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u101:_update(0)
    u101.Cleaner.Heartbeat = u2.Heartbeat:Connect(function(p102) --[[ Line: 274 ]]
        --[[
        Upvalues:
            [1] = u101
        --]]
        if u101._update then
            u101:_update(p102)
        else
            u101.Cleaner:Destroy()
            u101.Cleaner.Heartbeat = nil
        end
    end)
end
function u7.CancelUpdate(p103) --[[ Line: 285 ]]
    p103.Cleaner.Heartbeat = nil
end
function u7.Destroy(p104) --[[ Line: 289 ]]
    p104.Destroyed:Fire()
    p104.Cleaner:Destroy()
    table.clear(p104.Data)
    setmetatable(p104, nil)
end
return u7