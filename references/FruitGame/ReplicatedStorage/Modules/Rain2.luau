 

local v1 = Color3.new(1, 1, 1)
local v2 = NumberSequence.new(10)
local v3 = NumberRange.new(0.8)
local v4 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5.33, 2.75), NumberSequenceKeypoint.new(1, 5.33, 2.75) })
local v5 = NumberRange.new(0.8)
local v6 = NumberRange.new(0, 360)
local v7 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 3), NumberSequenceKeypoint.new(1, 0) })
local v8 = NumberRange.new(0.1, 0.15)
local v9 = NumberRange.new(0, 360)
local v10 = Vector2.new(10, 10)
local u11 = {
    ["None"] = 0,
    ["Whitelist"] = 1,
    ["Blacklist"] = 2,
    ["Function"] = 3
}
local u12 = game:GetService("Players")
local u13 = game:GetService("TweenService")
local u14 = game:GetService("RunService")
local u15 = Instance.new("NumberValue")
u15.Value = 1
local u16 = u11.Whitelist
local u17 = { workspace.Islands, workspace.Ships, workspace.Env }
local u18 = Vector3.new
local u19 = NumberSequenceKeypoint.new(0, 1, 0)
local u20 = NumberSequenceKeypoint.new(1, 1, 0)
local u21 = {}
local u22 = 0
local u23 = 0
local u24 = nil
local u25 = true
local u26 = false
local u27 = 1
local u28 = 0
local u29 = Vector3.new(0, -1, 0)
local u30 = nil
local u31 = {}
local u32 = 1
for _, v33 in pairs({
    Vector3.new(0.14142136, 0, 0.14142136),
    Vector3.new(-0.14142136, 0, 0.14142136),
    Vector3.new(-0.14142136, 0, -0.14142136),
    Vector3.new(0.14142136, 0, -0.14142136),
    Vector3.new(0.4, 0, 0),
    Vector3.new(0.28284273, 0, 0.28284273),
    Vector3.new(0.000000000000000024492937, 0, 0.4),
    Vector3.new(-0.28284273, 0, 0.28284273),
    Vector3.new(-0.4, 0, 0.000000000000000048985874),
    Vector3.new(-0.28284273, 0, -0.28284273),
    Vector3.new(-0.000000000000000073478805, 0, -0.4),
    Vector3.new(0.28284273, 0, -0.28284273),
    Vector3.new(0.6, 0, 0),
    Vector3.new(0.4854102, 0, 0.35267115),
    Vector3.new(0.1854102, 0, 0.57063395),
    Vector3.new(-0.1854102, 0, 0.57063395),
    Vector3.new(-0.4854102, 0, 0.35267115),
    Vector3.new(-0.6, 0, 0.00000000000000007347881),
    Vector3.new(-0.4854102, 0, -0.35267115),
    Vector3.new(-0.1854102, 0, -0.57063395),
    Vector3.new(0.1854102, 0, -0.57063395),
    Vector3.new(0.4854102, 0, -0.35267115),
    Vector3.new(0.77274066, 0, 0.20705524),
    Vector3.new(0.56568545, 0, 0.56568545),
    Vector3.new(0.20705524, 0, 0.77274066),
    Vector3.new(-0.20705524, 0, 0.77274066),
    Vector3.new(-0.56568545, 0, 0.56568545),
    Vector3.new(-0.77274066, 0, 0.20705524),
    Vector3.new(-0.77274066, 0, -0.20705524),
    Vector3.new(-0.56568545, 0, -0.56568545),
    Vector3.new(-0.20705524, 0, -0.77274066),
    Vector3.new(0.20705524, 0, -0.77274066),
    Vector3.new(0.56568545, 0, -0.56568545),
    Vector3.new(0.77274066, 0, -0.20705524)
}) do
    local v34 = v33 * 35
    table.insert(u21, v34)
end
table.sort(u21, function(p35, p36) --[[ Line: 269 ]]
    return p35.magnitude < p36.magnitude
end)
local u37 = Instance.new("SoundGroup")
u37.Name = "__RainSoundGroup"
u37.Volume = 0.2
u37.Archivable = false
local u38 = Instance.new("Sound")
u38.Name = "RainSound"
u38.Volume = u22
u38.SoundId = "rbxassetid://1516791621"
u38.Looped = true
u38.SoundGroup = u37
u38.Parent = u37
u38.Archivable = false
local u39 = Instance.new("Part")
u39.Transparency = 1
u39.Anchored = true
u39.CanCollide = false
u39.Locked = false
u39.Archivable = false
u39.TopSurface = Enum.SurfaceType.Smooth
u39.BottomSurface = Enum.SurfaceType.Smooth
u39.Name = "__RainEmitter"
u39.Size = Vector3.new(0.05, 0.05, 0.05)
u39.Archivable = false
local v40 = Instance.new("ParticleEmitter")
v40.Name = "RainStraight"
v40.LightEmission = 0.05
v40.LightInfluence = 0.9
v40.Size = v2
v40.Texture = "rbxassetid://1822883048"
v40.LockedToPart = true
v40.Enabled = false
v40.Lifetime = v3
v40.Rate = 150
v40.Speed = NumberRange.new(60)
v40.EmissionDirection = Enum.NormalId.Bottom
v40.Parent = u39
v40.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
local v41 = Instance.new("ParticleEmitter")
v41.Name = "RainTopDown"
v41.LightEmission = 0.05
v41.LightInfluence = 0.9
v41.Size = v4
v41.Texture = "rbxassetid://1822856633"
v41.LockedToPart = true
v41.Enabled = false
v41.Rotation = v6
v41.Lifetime = v5
v41.Rate = 100
v41.Speed = NumberRange.new(60)
v41.EmissionDirection = Enum.NormalId.Bottom
v41.Parent = u39
local u42 = {}
local u43 = {}
for _ = 1, 20 do
    local v44 = Instance.new("Attachment")
    v44.Name = "__RainSplashAttachment"
    local v45 = Instance.new("ParticleEmitter")
    v45.LightEmission = 0.05
    v45.LightInfluence = 0.9
    v45.Size = v7
    v45.Texture = "rbxassetid://1822856633"
    v45.Rotation = v9
    v45.Lifetime = v8
    v45.Transparency = NumberSequence.new({
        u19,
        NumberSequenceKeypoint.new(0.25, 0.6, 0),
        NumberSequenceKeypoint.new(0.75, 0.6, 0),
        u20
    })
    v45.Enabled = false
    v45.Rate = 0
    v45.Speed = NumberRange.new(0)
    v45.Name = "RainSplash"
    v45.Parent = v44
    v44.Archivable = false
    table.insert(u43, v44)
    local v46 = Instance.new("Attachment")
    v46.Name = "__RainOccludedAttachment"
    local v47 = u39.RainStraight:Clone()
    v47.Speed = NumberRange.new(70, 100)
    v47.SpreadAngle = v10
    v47.LockedToPart = false
    v47.Enabled = false
    v47.Parent = v46
    local v48 = u39.RainTopDown:Clone()
    v48.Speed = NumberRange.new(70, 100)
    v48.SpreadAngle = v10
    v48.LockedToPart = false
    v48.Enabled = false
    v48.Parent = v46
    v46.Archivable = false
    table.insert(u42, v46)
end
local u49 = { u39 }
local u65 = {
    [u11.None] = function(p50, p51) --[[ Line: 394 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u12
            [3] = u49
        --]]
        local v52 = _G.raycastIgnoreList
        if p51 then
            v55 = {}
            local v53 = u39
            local v54 = u12.LocalPlayer
            if v54 then
                v54 = u12.LocalPlayer.Character
            end
            __set_list(v55, 1, {v53, v54})
            if v55 then
                ::l5::
                return v52(p50, v55)
            end
        end
        local v55 = u49
        goto l5
    end,
    [u11.Blacklist] = function(p56) --[[ Line: 397 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        return _G.raycastIgnoreList(p56, u17)
    end,
    [u11.Whitelist] = function(p57) --[[ Line: 400 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        return _G.raycastWhitelist(p57, u17)
    end,
    [u11.Function] = function(p58) --[[ Line: 403 ]]
        --[[
        Upvalues:
            [1] = u49
            [2] = u30
        --]]
        local v59 = p58.Origin + p58.Direction
        while p58.Direction.magnitude > 0.001 do
            local v60, v61, v62, v63 = _G.raycastIgnoreList(p58, u49)
            if not v60 or u30(v60) then
                return v60, v61, v62, v63
            end
            local v64 = v61 + p58.Direction.Unit * 0.001
            p58 = Ray.new(v64, v59 - v64)
        end
    end
}
local u66 = u65[u16]
local function u116() --[[ Line: 418 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u14
        [3] = u66
        [4] = u29
        [5] = u24
        [6] = u22
        [7] = u25
        [8] = u13
        [9] = u38
        [10] = u39
        [11] = u18
        [12] = u26
        [13] = u19
        [14] = u32
        [15] = u20
        [16] = u27
        [17] = u42
        [18] = u21
        [19] = u28
        [20] = u43
        [21] = u23
    --]]
    local u67 = Random.new()
    local u68 = true
    local u69 = 12
    local v70 = u31
    local v71 = u14.Heartbeat
    local function v79() --[[ Line: 426 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u29
            [3] = u24
            [4] = u22
            [5] = u25
            [6] = u13
            [7] = u38
            [8] = u69
            [9] = u39
            [10] = u18
            [11] = u68
            [12] = u26
        --]]
        local v72, _ = u66(Ray.new(workspace.CurrentCamera.CFrame.p, -u29 * 1000), true)
        if u24 and workspace.CurrentCamera.CFrame.p.y > u24 or v72 then
            if u39 and u39:FindFirstChild("RainStraight") then
                u39.RainStraight.Enabled = false
                u39.RainTopDown.Enabled = false
            end
            u68 = true
        else
            if u22 < 1 and not u25 then
                u22 = 1
                u13:Create(u38, TweenInfo.new(0.5), {
                    ["Volume"] = 1
                }):Play()
            end
            u69 = 12
            local v73 = workspace.CurrentCamera.CFrame.lookVector:Dot(u29)
            local v74 = math.abs(v73)
            local v75 = workspace.CurrentCamera.CFrame.p
            local v76 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u29)
            local v77 = v76.magnitude > 0.001 and v76.unit or -u29
            local v78 = u29:Cross(v77).unit
            u39.Size = u18(40, 40, (1 - v74) * 60 + 40)
            u39.CFrame = CFrame.new(v75.x, v75.y, v75.z, v77.x, -u29.x, v78.x, v77.y, -u29.y, v78.y, v77.z, -u29.z, v78.z) + (1 - v74) * workspace.CurrentCamera.CFrame.lookVector * u39.Size.Z / 3 - v74 * u29 * 20
            if u39:FindFirstChild("RainTopDown") then
                u39.RainStraight.Enabled = true
                u39.RainTopDown.Enabled = true
            end
            u68 = false
        end
        u26 = u68
    end
    table.insert(v70, v71:connect(v79))
    local v80 = u14:IsRunning()
    if v80 then
        v80 = u14.Heartbeat
    end
    local v81 = u31
    local function v115() --[[ Line: 488 ]]
        --[[
        Upvalues:
            [1] = u69
            [2] = u29
            [3] = u19
            [4] = u32
            [5] = u20
            [6] = u27
            [7] = u68
            [8] = u42
            [9] = u25
            [10] = u24
            [11] = u21
            [12] = u66
            [13] = u22
            [14] = u13
            [15] = u38
            [16] = u39
            [17] = u28
            [18] = u43
            [19] = u67
            [20] = u18
            [21] = u23
        --]]
        u69 = u69 + 1
        if u69 >= 12 then
            local v82 = workspace.CurrentCamera.CFrame.lookVector:Dot(u29)
            local v83 = math.abs(v82)
            local v84 = NumberSequence.new({
                u19,
                NumberSequenceKeypoint.new(0.25, (1 - v83) * u32 + v83, 0),
                NumberSequenceKeypoint.new(0.75, (1 - v83) * u32 + v83, 0),
                u20
            })
            local v85 = NumberSequence.new({
                u19,
                NumberSequenceKeypoint.new(0.25, v83 * u27 + (1 - v83), 0),
                NumberSequenceKeypoint.new(0.75, v83 * u27 + (1 - v83), 0),
                u20
            })
            local v86 = workspace.Camera.CFrame:inverse() * (workspace.Camera.CFrame.p - u29)
            local v87 = NumberRange.new
            local v88 = -v86.x
            local v89 = v86.y
            local v90 = math.atan2(v88, v89)
            local v91 = v87((math.deg(v90)))
            if u68 then
                for _, v92 in pairs(u42) do
                    v92.RainStraight.Transparency = v84
                    v92.RainStraight.Rotation = v91
                    v92.RainTopDown.Transparency = v85
                end
                if not u25 then
                    local v93
                    if u24 and workspace.CurrentCamera.CFrame.p.y > u24 then
                        v93 = 0
                    else
                        local v94 = -u29 * 1000
                        local v95 = 35
                        for v96 = 1, #u21 do
                            if not u66(Ray.new(workspace.CurrentCamera.CFrame * u21[v96], v94), true) then
                                v95 = u21[v96].magnitude
                                break
                            end
                        end
                        v93 = 1 - v95 / 35
                    end
                    local v97 = v93 - u22
                    if math.abs(v97) > 0.01 then
                        u22 = v93
                        local v98 = {
                            ["Volume"] = u22
                        }
                        u13:Create(u38, TweenInfo.new(1), v98):Play()
                    end
                end
            elseif u39 and u39:FindFirstChild("RainStraight") then
                u39.RainStraight.Transparency = v84
                u39.RainStraight.Rotation = v91
                u39.RainTopDown.Transparency = v85
            end
            u69 = 0
        end
        local v99 = workspace.CurrentCamera.CFrame.p
        local v100 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u29)
        local v101 = v100.magnitude > 0.001 and v100.unit or -u29
        local v102 = u29:Cross(v101).unit
        local v103 = CFrame.new(v99.x, v99.y, v99.z, v101.x, -u29.x, v102.x, v101.y, -u29.y, v102.y, v101.z, -u29.z, v102.z)
        local v104 = u29 * 550
        for v105 = 1, u28 do
            local v106 = u43[v105]
            local v107 = u42[v105]
            local v108 = u67:NextNumber(-100, 100)
            local v109 = u67:NextNumber(-100, 100)
            local v110, v111, v112 = u66(Ray.new(v103 * u18(v108, 500, v109), v104))
            if v110 then
                v106.Position = v111 + v112 * 0.5
                v106.RainSplash:Emit(1)
                if u68 then
                    local v113 = v111 - u29 * 50
                    if u24 and (u24 < v113.Y and u29.Y < 0) then
                        v113 = v113 + u29 * (u24 - v113.Y) / u29.Y
                    end
                    v107.CFrame = v103 - v103.p + v113
                    v107.RainStraight:Emit(u23)
                    v107.RainTopDown:Emit(u23)
                end
            elseif u68 then
                local v114 = v103 * u18(v108, u67:NextNumber(20, 100), v109)
                if u24 and (u24 < v114.Y and u29.Y < 0) then
                    v114 = v114 + u29 * (u24 - v114.Y) / u29.Y
                end
                v107.CFrame = v103 - v103.p + v114
                v107.RainStraight:Emit(u23)
                v107.RainTopDown:Emit(u23)
            end
        end
    end
    table.insert(v81, v80:connect(v115))
end
local function u118() --[[ Line: 634 ]]
    --[[
    Upvalues:
        [1] = u31
    --]]
    if #u31 > 0 then
        for _, v117 in pairs(u31) do
            v117:disconnect()
        end
        u31 = {}
    end
end
local function u122(p119) --[[ Line: 644 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u13
        [3] = u38
    --]]
    u22 = 0
    local u120 = u13:Create(u38, p119, {
        ["Volume"] = 0
    })
    u120.Completed:connect(function(p121) --[[ Line: 649 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u120
        --]]
        if p121 == Enum.PlaybackState.Completed then
            u38:Stop()
        end
        u120:Destroy()
    end)
    u120:Play()
end
local function v127(p123) --[[ Line: 686 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u43
        [3] = u42
    --]]
    local v124 = ColorSequence.new(p123)
    u39.RainStraight.Color = v124
    u39.RainTopDown.Color = v124
    for _, v125 in pairs(u43) do
        v125.RainSplash.Color = v124
    end
    for _, v126 in pairs(u42) do
        v126.RainStraight.Color = v124
        v126.RainTopDown.Color = v124
    end
end
local u128 = Instance.new("Color3Value")
if v1 then
    u128.Value = v1
end
u128.Changed:connect(v127)
v127(u128.Value)
local function v134(p129) --[[ Line: 703 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u32
        [3] = u27
        [4] = u19
        [5] = u20
        [6] = u43
    --]]
    local v130 = (1 - p129) * (1 - u15.Value)
    local v131 = 1 - v130
    u32 = 0.7 * v130 + v131
    u27 = 0.85 * v130 + v131
    local v132 = NumberSequence.new({
        u19,
        NumberSequenceKeypoint.new(0.25, v130 * 0.6 + v131, 0),
        NumberSequenceKeypoint.new(0.75, v130 * 0.6 + v131, 0),
        u20
    })
    for _, v133 in pairs(u43) do
        v133.RainSplash.Transparency = v132
    end
end
local u135 = Instance.new("NumberValue")
u135.Value = 0
u135.Changed:connect(v134)
v134(u135.Value)
u15.Changed:connect(v134)
local u136 = Instance.new("NumberValue")
u136.Value = 1
u136.Changed:connect(function(p137) --[[ Line: 726 ]]
    --[[
    Upvalues:
        [1] = u39
    --]]
    u39.RainStraight.Speed = NumberRange.new(p137 * 60)
    u39.RainTopDown.Speed = NumberRange.new(p137 * 60)
end)
local v138 = u136.Value
u39.RainStraight.Speed = NumberRange.new(v138 * 60)
u39.RainTopDown.Speed = NumberRange.new(v138 * 60)
local u139 = Instance.new("NumberValue")
u139.Value = 1
u139.Changed:connect(function(p140) --[[ Line: 733 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u23
        [3] = u28
    --]]
    u39.RainStraight.Rate = 150 * p140
    u39.RainTopDown.Rate = 100 * p140
    local v141 = 1 * p140
    u23 = math.ceil(v141)
    u28 = 20 * p140
end)
local v142 = u139.Value
u39.RainStraight.Rate = 150 * v142
u39.RainTopDown.Rate = 100 * v142
local v143 = 1 * v142
local _ = math.ceil(v143)
local _ = 20 * v142
local function v147(p144) --[[ Line: 743 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u42
        [3] = u43
    --]]
    u39.RainStraight.LightEmission = p144
    u39.RainTopDown.LightEmission = p144
    for _, v145 in pairs(u42) do
        v145.RainStraight.LightEmission = p144
        v145.RainTopDown.LightEmission = p144
    end
    for _, v146 in pairs(u43) do
        v146.RainSplash.LightEmission = p144
    end
end
local u148 = Instance.new("NumberValue")
u148.Value = 0.05
u148.Changed:connect(v147)
v147(u148.Value)
local function v152(p149) --[[ Line: 758 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u42
        [3] = u43
    --]]
    u39.RainStraight.LightInfluence = p149
    u39.RainTopDown.LightInfluence = p149
    for _, v150 in pairs(u42) do
        v150.RainStraight.LightInfluence = p149
        v150.RainTopDown.LightInfluence = p149
    end
    for _, v151 in pairs(u43) do
        v151.RainSplash.LightInfluence = p149
    end
end
local u153 = Instance.new("NumberValue")
u153.Value = 0.9
u153.Changed:connect(v152)
v152(u153.Value)
local u154 = Instance.new("Vector3Value")
u154.Value = Vector3.new(0, -1, 0)
u154.Changed:connect(function(p155) --[[ Line: 773 ]]
    --[[
    Upvalues:
        [1] = u29
    --]]
    if p155.magnitude > 0.001 then
        u29 = p155.unit
    end
end)
local v156 = u154.Value
if v156.magnitude > 0.001 then
    local _ = v156.unit
end
local v164 = {
    ["CollisionMode"] = u11,
    ["Enable"] = function(_, p157) --[[ Name: Enable, Line 786 ]]
        --[[
        Upvalues:
            [1] = u118
            [2] = u39
            [3] = u43
            [4] = u42
            [5] = u14
            [6] = u37
            [7] = u116
            [8] = u13
            [9] = u15
            [10] = u38
            [11] = u25
        --]]
        if p157 ~= nil and typeof(p157) ~= "TweenInfo" then
            error("bad argument #1 to \'Enable\' (TweenInfo expected, got " .. typeof(p157) .. ")", 2)
        end
        u118()
        if u39:FindFirstChild("RainStraight") then
            u39.RainStraight.Enabled = true
            u39.RainTopDown.Enabled = true
            u39.Parent = workspace.CurrentCamera
        end
        for v158 = 1, 20 do
            u43[v158].Parent = workspace.Terrain
            u42[v158].Parent = workspace.Terrain
        end
        if u14:IsRunning() then
            u37.Parent = game:GetService("SoundService")
        end
        u116()
        if p157 then
            u13:Create(u15, p157, {
                ["Value"] = 0
            }):Play()
        else
            u15.Value = 0
        end
        if not u38.Playing then
            u38:Play()
            u38.TimePosition = math.random() * u38.TimeLength
        end
        u25 = false
    end,
    ["Disable"] = function(_, p159) --[[ Name: Disable, Line 826 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u15
            [3] = u118
            [4] = u39
            [5] = u25
            [6] = u122
        --]]
        if p159 ~= nil and typeof(p159) ~= "TweenInfo" then
            error("bad argument #1 to \'Disable\' (TweenInfo expected, got " .. typeof(p159) .. ")", 2)
        end
        if p159 then
            local u160 = u13:Create(u15, p159, {
                ["Value"] = 1
            })
            u160.Completed:connect(function(p161) --[[ Line: 834 ]]
                --[[
                Upvalues:
                    [1] = u118
                    [2] = u39
                    [3] = u25
                    [4] = u122
                    [5] = u160
                --]]
                if p161 == Enum.PlaybackState.Completed then
                    u118()
                    u39.RainStraight.Enabled = false
                    u39.RainTopDown.Enabled = false
                    u39.Size = Vector3.new(0.05, 0.05, 0.05)
                    if not u25 then
                        u122(TweenInfo.new(1))
                    end
                end
                u160:Destroy()
            end)
            u160:Play()
            u122(p159)
        else
            u15.Value = 1
            u118()
            u39.RainStraight.Enabled = false
            u39.RainTopDown.Enabled = false
            u39.Size = Vector3.new(0.05, 0.05, 0.05)
            if not u25 then
                u122(TweenInfo.new(1))
            end
        end
        u25 = true
    end,
    ["SetColor"] = function(_, p162, p163) --[[ Name: SetColor, Line 853 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u128
        --]]
        if typeof(p162) == "Color3" then
            if p163 ~= nil and typeof(p163) ~= "TweenInfo" then
                error("bad argument #2 to \'SetColor\' (TweenInfo expected, got " .. typeof(p163) .. ")", 2)
            end
        else
            error("bad argument #1 to \'SetColor\' (Color3 expected, got " .. typeof(p162) .. ")", 2)
        end
        if p163 then
            u13:Create(u128, p163, {
                ["Value"] = p162
            }):Play()
        else
            u128.Value = p162
        end
    end
}
local u165 = "SetTransparency"
function v164.SetTransparency(_, p166, p167) --[[ Line: 871 ]]
    --[[
    Upvalues:
        [1] = u165
        [2] = u13
        [3] = u135
    --]]
    if typeof(p166) == "number" then
        if p167 ~= nil and typeof(p167) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u165 .. "\' (TweenInfo expected, got " .. typeof(p167) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u165 .. "\' (number expected, got " .. typeof(p166) .. ")", 2)
    end
    local v168 = math.clamp(p166, 0, 1)
    if p167 then
        u13:Create(u135, p167, {
            ["Value"] = v168
        }):Play()
    else
        u135.Value = v168
    end
end
local u169 = "SetSpeedRatio"
function v164.SetSpeedRatio(_, p170, p171) --[[ Line: 871 ]]
    --[[
    Upvalues:
        [1] = u169
        [2] = u13
        [3] = u136
    --]]
    if typeof(p170) == "number" then
        if p171 ~= nil and typeof(p171) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u169 .. "\' (TweenInfo expected, got " .. typeof(p171) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u169 .. "\' (number expected, got " .. typeof(p170) .. ")", 2)
    end
    local v172 = math.clamp(p170, 0, 1)
    if p171 then
        u13:Create(u136, p171, {
            ["Value"] = v172
        }):Play()
    else
        u136.Value = v172
    end
end
local u173 = "SetIntensityRatio"
function v164.SetIntensityRatio(_, p174, p175) --[[ Line: 871 ]]
    --[[
    Upvalues:
        [1] = u173
        [2] = u13
        [3] = u139
    --]]
    if typeof(p174) == "number" then
        if p175 ~= nil and typeof(p175) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u173 .. "\' (TweenInfo expected, got " .. typeof(p175) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u173 .. "\' (number expected, got " .. typeof(p174) .. ")", 2)
    end
    local v176 = math.clamp(p174, 0, 1)
    if p175 then
        u13:Create(u139, p175, {
            ["Value"] = v176
        }):Play()
    else
        u139.Value = v176
    end
end
local u177 = "SetLightEmission"
function v164.SetLightEmission(_, p178, p179) --[[ Line: 871 ]]
    --[[
    Upvalues:
        [1] = u177
        [2] = u13
        [3] = u148
    --]]
    if typeof(p178) == "number" then
        if p179 ~= nil and typeof(p179) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u177 .. "\' (TweenInfo expected, got " .. typeof(p179) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u177 .. "\' (number expected, got " .. typeof(p178) .. ")", 2)
    end
    local v180 = math.clamp(p178, 0, 1)
    if p179 then
        u13:Create(u148, p179, {
            ["Value"] = v180
        }):Play()
    else
        u148.Value = v180
    end
end
local u181 = "SetLightInfluence"
function v164.SetLightInfluence(_, p182, p183) --[[ Line: 871 ]]
    --[[
    Upvalues:
        [1] = u181
        [2] = u13
        [3] = u153
    --]]
    if typeof(p182) == "number" then
        if p183 ~= nil and typeof(p183) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u181 .. "\' (TweenInfo expected, got " .. typeof(p183) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u181 .. "\' (number expected, got " .. typeof(p182) .. ")", 2)
    end
    local v184 = math.clamp(p182, 0, 1)
    if p183 then
        u13:Create(u153, p183, {
            ["Value"] = v184
        }):Play()
    else
        u153.Value = v184
    end
end
function v164.SetVolume(_, p185, p186) --[[ Line: 896 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u37
    --]]
    if typeof(p185) == "number" then
        if p186 ~= nil and typeof(p186) ~= "TweenInfo" then
            error("bad argument #2 to \'SetVolume\' (TweenInfo expected, got " .. typeof(p186) .. ")", 2)
        end
    else
        error("bad argument #1 to \'SetVolume\' (number expected, got " .. typeof(p185) .. ")", 2)
    end
    if p186 then
        u13:Create(u37, p186, {
            ["Volume"] = p185
        }):Play()
    else
        u37.Volume = p185
    end
end
function v164.SetDirection(_, p187, p188) --[[ Line: 912 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u154
    --]]
    if typeof(p187) == "Vector3" then
        if p188 ~= nil and typeof(p188) ~= "TweenInfo" then
            error("bad argument #2 to \'SetDirection\' (TweenInfo expected, got " .. typeof(p188) .. ")", 2)
        end
    else
        error("bad argument #1 to \'SetDirection\' (Vector3 expected, got " .. typeof(p187) .. ")", 2)
    end
    if p187.unit.magnitude <= 0 then
        warn("Attempt to set rain direction to a zero-length vector, falling back on default direction = (" .. tostring(Vector3.new(0, -1, 0)) .. ")")
        p187 = Vector3.new(0, -1, 0)
    end
    if p188 then
        u13:Create(u154, p188, {
            ["Value"] = p187
        }):Play()
    else
        u154.Value = p187
    end
end
function v164.SetCeiling(_, p189) --[[ Line: 933 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if p189 ~= nil and typeof(p189) ~= "number" then
        error("bad argument #1 to \'SetCeiling\' (number expected, got " .. typeof(p189) .. ")", 2)
    end
    u24 = p189
end
function v164.SetStraightTexture(_, p190) --[[ Line: 943 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u42
    --]]
    if typeof(p190) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p190) .. ")", 2)
    end
    if u39 and u39:FindFirstChild("RainStraight") then
        u39.RainStraight.Texture = p190
        for _, v191 in pairs(u42) do
            v191.RainStraight.Texture = p190
        end
    end
end
function v164.SetTopDownTexture(_, p192) --[[ Line: 960 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u42
    --]]
    if typeof(p192) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p192) .. ")", 2)
    end
    if u39 and u39:FindFirstChild("RainTopDown") then
        u39.RainTopDown.Texture = p192
    end
    for _, v193 in pairs(u42) do
        v193.RainTopDown.Texture = p192
    end
end
function v164.SetSplashTexture(_, p194) --[[ Line: 975 ]]
    --[[
    Upvalues:
        [1] = u43
    --]]
    if typeof(p194) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p194) .. ")", 2)
    end
    for _, v195 in pairs(u43) do
        v195.RainSplash.Texture = p194
    end
end
function v164.SetSoundId(_, p196) --[[ Line: 987 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    if typeof(p196) ~= "string" then
        error("bad argument #1 to \'SetSoundId\' (string expected, got " .. typeof(p196) .. ")", 2)
    end
    u38.SoundId = p196
end
function v164.inside(_) --[[ Line: 997 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    return u26
end
function v164.SetCollisionMode(_, p197, p198) --[[ Line: 1001 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u17
        [3] = u30
        [4] = u39
        [5] = u16
        [6] = u66
        [7] = u65
    --]]
    if p197 == u11.None then
        u17 = nil
        u30 = nil
    elseif p197 == u11.Blacklist then
        if typeof(p198) == "Instance" then
            u17 = { p198, u39 }
        elseif typeof(p198) == "table" then
            for v199 = 1, #p198 do
                local v200 = p198[v199]
                if typeof(v200) ~= "Instance" then
                    local v201 = error
                    local v202 = p198[v199]
                    v201("bad argument #2 to \'SetCollisionMode\' (blacklist contained a " .. typeof(v202) .. " on index " .. tostring(v199) .. " which is not an Instance)", 2)
                end
            end
            u17 = { u39 }
            for v203 = 1, #p198 do
                local v204 = u17
                local v205 = p198[v203]
                table.insert(v204, v205)
            end
        else
            error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p198) .. ")\'", 2)
        end
        u30 = nil
    elseif p197 == u11.Whitelist then
        if typeof(p198) == "Instance" then
            u17 = { p198 }
        elseif typeof(p198) == "table" then
            for v206 = 1, #p198 do
                local v207 = p198[v206]
                if typeof(v207) ~= "Instance" then
                    local v208 = error
                    local v209 = p198[v206]
                    v208("bad argument #2 to \'SetCollisionMode\' (whitelist contained a " .. typeof(v209) .. " on index " .. tostring(v206) .. " which is not an Instance)", 2)
                end
            end
            u17 = {}
            for v210 = 1, #p198 do
                local v211 = u17
                local v212 = p198[v210]
                table.insert(v211, v212)
            end
        else
            error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p198) .. ")\'", 2)
        end
        u30 = nil
    elseif p197 == u11.Function then
        if typeof(p198) ~= "function" then
            error("bad argument #2 to \'SetCollisionMode\' (function expected, got " .. typeof(p198) .. ")", 2)
        end
        u17 = nil
        u30 = p198
    else
        error("bad argument #1 to \'SetCollisionMode (Rain.CollisionMode expected, got " .. typeof(p198) .. ")\'", 2)
    end
    u16 = p197
    u66 = u65[p197]
end
return v164