 

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
local u16 = u11.Function
local u17 = { workspace.Islands, workspace.Env, workspace.Ships }
local u18 = Vector3.new
local u19 = NumberSequenceKeypoint.new(0, 1, 0)
local u20 = NumberSequenceKeypoint.new(1, 1, 0)
local u21 = {}
local u22 = 0
local u23 = false
local u24 = 1
local u25 = 0
local u26 = Vector3.new(0, -1, 0)
local u27 = nil
local u28 = true
local function u30(p29) --[[ Line: 253 ]]
    return p29.CanCollide ~= false
end
local u31 = 1
local u32 = 0
local u33 = {}
for _, v34 in pairs({
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
    local v35 = v34 * 35
    table.insert(u21, v35)
end
table.sort(u21, function(p36, p37) --[[ Line: 278 ]]
    return p36.magnitude < p37.magnitude
end)
local u38 = Instance.new("SoundGroup")
u38.Name = "__RainSoundGroup"
u38.Volume = 0.2
u38.Archivable = false
local u39 = Instance.new("Sound")
u39.Name = "RainSound"
u39.Volume = u22
u39.SoundId = "rbxassetid://1516791621"
u39.Looped = true
u39.SoundGroup = u38
u39.Parent = u38
u39.Archivable = false
local u40 = Instance.new("Part")
u40.Transparency = 1
u40.Anchored = true
u40.CanCollide = false
u40.Locked = false
u40.Archivable = false
u40.TopSurface = Enum.SurfaceType.Smooth
u40.BottomSurface = Enum.SurfaceType.Smooth
u40.Name = "__RainEmitter"
u40.Size = Vector3.new(0.05, 0.05, 0.05)
u40.CanQuery = false
u40.Archivable = false
local v41 = Instance.new("ParticleEmitter")
v41.Name = "RainStraight"
v41.LightEmission = 0.05
v41.LightInfluence = 0.9
v41.Size = v2
v41.Texture = "rbxassetid://1822883048"
v41.LockedToPart = true
v41.Enabled = false
v41.Lifetime = v3
v41.Rate = 600
v41.Speed = NumberRange.new(60)
v41.EmissionDirection = Enum.NormalId.Bottom
v41.Parent = u40
v41.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
local v42 = Instance.new("ParticleEmitter")
v42.Name = "RainTopDown"
v42.LightEmission = 0.05
v42.LightInfluence = 0.9
v42.Size = v4
v42.Texture = "rbxassetid://1822856633"
v42.LockedToPart = true
v42.Enabled = false
v42.Rotation = v6
v42.Lifetime = v5
v42.Rate = 600
v42.Speed = NumberRange.new(60)
v42.EmissionDirection = Enum.NormalId.Bottom
v42.Parent = u40
local u43 = {}
local u44 = {}
for _ = 1, 6 do
    local v45 = Instance.new("Attachment")
    v45.Name = "__RainSplashAttachment"
    local v46 = Instance.new("ParticleEmitter")
    v46.LightEmission = 0.05
    v46.LightInfluence = 0.9
    v46.Size = v7
    v46.Texture = "rbxassetid://1822856633"
    v46.Rotation = v9
    v46.Lifetime = v8
    v46.Transparency = NumberSequence.new({
        u19,
        NumberSequenceKeypoint.new(0.25, 0.6, 0),
        NumberSequenceKeypoint.new(0.75, 0.6, 0),
        u20
    })
    v46.Enabled = false
    v46.Rate = 0
    v46.Speed = NumberRange.new(0)
    v46.Name = "RainSplash"
    v46.Parent = v45
    v45.Archivable = false
    table.insert(u44, v45)
    local v47 = Instance.new("Attachment")
    v47.Name = "__RainOccludedAttachment"
    local v48 = u40.RainStraight:Clone()
    v48.Speed = NumberRange.new(70, 100)
    v48.SpreadAngle = v10
    v48.LockedToPart = false
    v48.Enabled = false
    v48.Parent = v47
    local v49 = u40.RainTopDown:Clone()
    v49.Speed = NumberRange.new(70, 100)
    v49.SpreadAngle = v10
    v49.LockedToPart = false
    v49.Enabled = false
    v49.Parent = v47
    v47.Archivable = false
    table.insert(u43, v47)
end
local u50 = { u40 }
local u66 = {
    [u11.None] = function(p51, p52) --[[ Line: 404 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u12
            [3] = u50
        --]]
        local v53 = workspace
        if p52 then
            v56 = {}
            local v54 = u40
            local v55 = u12.LocalPlayer
            if v55 then
                v55 = u12.LocalPlayer.Character
            end
            __set_list(v56, 1, {v54, v55})
            if v56 then
                ::l5::
                return v53:FindPartOnRayWithIgnoreList(p51, v56)
            end
        end
        local v56 = u50
        goto l5
    end,
    [u11.Blacklist] = function(p57) --[[ Line: 407 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        return workspace:FindPartOnRayWithIgnoreList(p57, u17)
    end,
    [u11.Whitelist] = function(p58) --[[ Line: 410 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        return workspace:FindPartOnRayWithWhitelist(p58, u17)
    end,
    [u11.Function] = function(p59) --[[ Line: 413 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        local v60 = p59.Origin + p59.Direction
        while p59.Direction.magnitude > 0.001 do
            local v61, v62, v63, v64 = workspace:FindPartOnRayWithWhitelist(p59, { workspace.Islands, workspace.Env, workspace.Ships })
            if not v61 or u30(v61) then
                return v61, v62, v63, v64
            end
            local v65 = v62 + p59.Direction.Unit * 0.001
            p59 = Ray.new(v65, v60 - v65)
        end
    end
}
local u67 = u66[u16]
local function u117() --[[ Line: 428 ]]
    --[[
    Upvalues:
        [1] = u33
        [2] = u14
        [3] = u67
        [4] = u26
        [5] = u27
        [6] = u22
        [7] = u28
        [8] = u13
        [9] = u39
        [10] = u40
        [11] = u18
        [12] = u23
        [13] = u19
        [14] = u31
        [15] = u20
        [16] = u24
        [17] = u43
        [18] = u21
        [19] = u32
        [20] = u44
        [21] = u25
    --]]
    local u68 = Random.new()
    local u69 = true
    local u70 = 10
    local v71 = u33
    local v72 = u14.RenderStepped
    local function v80() --[[ Line: 436 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u26
            [3] = u27
            [4] = u22
            [5] = u28
            [6] = u13
            [7] = u39
            [8] = u70
            [9] = u40
            [10] = u18
            [11] = u69
            [12] = u23
        --]]
        local v73, _ = u67(Ray.new(workspace.CurrentCamera.CFrame.p, -u26 * 500), true)
        if u27 and workspace.CurrentCamera.CFrame.p.y > u27 or v73 then
            if u40:FindFirstChild("RainStraight") and u40:FindFirstChild("RainTopDown") then
                u40.RainStraight.Enabled = false
                u40.RainTopDown.Enabled = false
            end
            u69 = true
        else
            if u22 < 1 and not u28 then
                u22 = 1
                u13:Create(u39, TweenInfo.new(0.5), {
                    ["Volume"] = 1
                }):Play()
            end
            u70 = 10
            local v74 = workspace.CurrentCamera.CFrame.lookVector:Dot(u26)
            local v75 = math.abs(v74)
            local v76 = workspace.CurrentCamera.CFrame.p
            local v77 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u26)
            local v78 = v77.magnitude > 0.001 and v77.unit or -u26
            local v79 = u26:Cross(v78).unit
            u40.Size = u18(40, 40, (1 - v75) * 60 + 40)
            u40.CFrame = CFrame.new(v76.x, v76.y, v76.z, v78.x, -u26.x, v79.x, v78.y, -u26.y, v79.y, v78.z, -u26.z, v79.z) + (1 - v75) * workspace.CurrentCamera.CFrame.lookVector * u40.Size.Z / 3 - v75 * u26 * 20
            if u40:FindFirstChild("RainStraight") and u40:FindFirstChild("RainTopDown") then
                u40.RainStraight.Enabled = true
                u40.RainTopDown.Enabled = true
            end
            u69 = false
        end
        u23 = u69
    end
    table.insert(v71, v72:connect(v80))
    local v81 = u14:IsRunning() and u14.Stepped or u14.RenderStepped
    local v82 = u33
    local function v116() --[[ Line: 499 ]]
        --[[
        Upvalues:
            [1] = u70
            [2] = u26
            [3] = u19
            [4] = u31
            [5] = u20
            [6] = u24
            [7] = u69
            [8] = u43
            [9] = u28
            [10] = u27
            [11] = u21
            [12] = u67
            [13] = u22
            [14] = u13
            [15] = u39
            [16] = u40
            [17] = u32
            [18] = u44
            [19] = u68
            [20] = u18
            [21] = u25
        --]]
        u70 = u70 + 1
        if u70 >= 10 then
            local v83 = workspace.CurrentCamera.CFrame.lookVector:Dot(u26)
            local v84 = math.abs(v83)
            local v85 = NumberSequence.new({
                u19,
                NumberSequenceKeypoint.new(0.25, (1 - v84) * u31 + v84, 0),
                NumberSequenceKeypoint.new(0.75, (1 - v84) * u31 + v84, 0),
                u20
            })
            local v86 = NumberSequence.new({
                u19,
                NumberSequenceKeypoint.new(0.25, v84 * u24 + (1 - v84), 0),
                NumberSequenceKeypoint.new(0.75, v84 * u24 + (1 - v84), 0),
                u20
            })
            local v87 = workspace.Camera.CFrame:inverse() * (workspace.Camera.CFrame.p - u26)
            local v88 = NumberRange.new
            local v89 = -v87.x
            local v90 = v87.y
            local v91 = math.atan2(v89, v90)
            local v92 = v88((math.deg(v91)))
            if u69 then
                for _, v93 in pairs(u43) do
                    v93.RainStraight.Transparency = v85
                    v93.RainStraight.Rotation = v92
                    v93.RainTopDown.Transparency = v86
                end
                if not u28 then
                    local v94
                    if u27 and workspace.CurrentCamera.CFrame.p.y > u27 then
                        v94 = 0
                    else
                        local v95 = -u26 * 500
                        local v96 = 35
                        for v97 = 1, #u21 do
                            if not u67(Ray.new(workspace.CurrentCamera.CFrame * u21[v97], v95), true) then
                                v96 = u21[v97].magnitude
                                break
                            end
                        end
                        v94 = 1 - v96 / 35
                    end
                    local v98 = v94 - u22
                    if math.abs(v98) > 0.01 then
                        u22 = v94
                        local v99 = {
                            ["Volume"] = u22
                        }
                        u13:Create(u39, TweenInfo.new(1), v99):Play()
                    end
                end
            else
                u40.RainStraight.Transparency = v85
                u40.RainStraight.Rotation = v92
                u40.RainTopDown.Transparency = v86
            end
            u70 = 0
        end
        local v100 = workspace.CurrentCamera.CFrame.p
        local v101 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u26)
        local v102 = v101.magnitude > 0.001 and v101.unit or -u26
        local v103 = u26:Cross(v102).unit
        local v104 = CFrame.new(v100.x, v100.y, v100.z, v102.x, -u26.x, v103.x, v102.y, -u26.y, v103.y, v102.z, -u26.z, v103.z)
        local v105 = u26 * 550
        for v106 = 1, u32 do
            local v107 = u44[v106]
            local v108 = u43[v106]
            local v109 = u68:NextNumber(-100, 100)
            local v110 = u68:NextNumber(-100, 100)
            local v111, v112, v113 = u67(Ray.new(v104 * u18(v109, 500, v110), v105))
            if v111 then
                v107.Position = v112 + v113 * 0.5
                v107.RainSplash:Emit(1)
                if u69 then
                    local v114 = v112 - u26 * 50
                    if u27 and (u27 < v114.Y and u26.Y < 0) then
                        v114 = v114 + u26 * (u27 - v114.Y) / u26.Y
                    end
                    v108.CFrame = v104 - v104.p + v114
                    v108.RainStraight:Emit(u25)
                    v108.RainTopDown:Emit(u25)
                end
            elseif u69 then
                local v115 = v104 * u18(v109, u68:NextNumber(20, 100), v110)
                if u27 and (u27 < v115.Y and u26.Y < 0) then
                    v115 = v115 + u26 * (u27 - v115.Y) / u26.Y
                end
                v108.CFrame = v104 - v104.p + v115
                v108.RainStraight:Emit(u25)
                v108.RainTopDown:Emit(u25)
            end
        end
    end
    table.insert(v82, v81:connect(v116))
end
local function u119() --[[ Line: 644 ]]
    --[[
    Upvalues:
        [1] = u33
    --]]
    if #u33 > 0 then
        for _, v118 in pairs(u33) do
            v118:Disconnect()
        end
        u33 = {}
    end
end
local function u123(p120) --[[ Line: 654 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u13
        [3] = u39
    --]]
    u22 = 0
    local u121 = u13:Create(u39, p120, {
        ["Volume"] = 0
    })
    u121.Completed:connect(function(p122) --[[ Line: 659 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u121
        --]]
        if p122 == Enum.PlaybackState.Completed then
            u39:Stop()
        end
        u121:Destroy()
    end)
    u121:Play()
end
local function v128(p124) --[[ Line: 696 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u44
        [3] = u43
    --]]
    local v125 = ColorSequence.new(p124)
    u40.RainStraight.Color = v125
    u40.RainTopDown.Color = v125
    for _, v126 in pairs(u44) do
        v126.RainSplash.Color = v125
    end
    for _, v127 in pairs(u43) do
        v127.RainStraight.Color = v125
        v127.RainTopDown.Color = v125
    end
end
local u129 = Instance.new("Color3Value")
if v1 then
    u129.Value = v1
end
u129.Changed:connect(v128)
v128(u129.Value)
local function v135(p130) --[[ Line: 713 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u31
        [3] = u24
        [4] = u19
        [5] = u20
        [6] = u44
    --]]
    local v131 = (1 - p130) * (1 - u15.Value)
    local v132 = 1 - v131
    u31 = 0.7 * v131 + v132
    u24 = 0.85 * v131 + v132
    local v133 = NumberSequence.new({
        u19,
        NumberSequenceKeypoint.new(0.25, v131 * 0.6 + v132, 0),
        NumberSequenceKeypoint.new(0.75, v131 * 0.6 + v132, 0),
        u20
    })
    for _, v134 in pairs(u44) do
        v134.RainSplash.Transparency = v133
    end
end
local u136 = Instance.new("NumberValue")
u136.Value = 0
u136.Changed:connect(v135)
v135(u136.Value)
u15.Changed:connect(v135)
local u137 = Instance.new("NumberValue")
u137.Value = 1
u137.Changed:connect(function(p138) --[[ Line: 736 ]]
    --[[
    Upvalues:
        [1] = u40
    --]]
    u40.RainStraight.Speed = NumberRange.new(p138 * 60)
    u40.RainTopDown.Speed = NumberRange.new(p138 * 60)
end)
local v139 = u137.Value
u40.RainStraight.Speed = NumberRange.new(v139 * 60)
u40.RainTopDown.Speed = NumberRange.new(v139 * 60)
local u140 = Instance.new("NumberValue")
u140.Value = 1
u140.Changed:connect(function(p141) --[[ Line: 743 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u25
        [3] = u32
    --]]
    u40.RainStraight.Rate = 600 * p141
    u40.RainTopDown.Rate = 600 * p141
    local v142 = 2 * p141
    u25 = math.ceil(v142)
    u32 = 6 * p141
end)
local v143 = u140.Value
u40.RainStraight.Rate = 600 * v143
u40.RainTopDown.Rate = 600 * v143
local v144 = 2 * v143
local _ = math.ceil(v144)
local _ = 6 * v143
local function v148(p145) --[[ Line: 753 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u43
        [3] = u44
    --]]
    u40.RainStraight.LightEmission = p145
    u40.RainTopDown.LightEmission = p145
    for _, v146 in pairs(u43) do
        v146.RainStraight.LightEmission = p145
        v146.RainTopDown.LightEmission = p145
    end
    for _, v147 in pairs(u44) do
        v147.RainSplash.LightEmission = p145
    end
end
local u149 = Instance.new("NumberValue")
u149.Value = 0.05
u149.Changed:connect(v148)
v148(u149.Value)
local function v153(p150) --[[ Line: 768 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u43
        [3] = u44
    --]]
    u40.RainStraight.LightInfluence = p150
    u40.RainTopDown.LightInfluence = p150
    for _, v151 in pairs(u43) do
        v151.RainStraight.LightInfluence = p150
        v151.RainTopDown.LightInfluence = p150
    end
    for _, v152 in pairs(u44) do
        v152.RainSplash.LightInfluence = p150
    end
end
local u154 = Instance.new("NumberValue")
u154.Value = 0.9
u154.Changed:connect(v153)
v153(u154.Value)
local u155 = Instance.new("Vector3Value")
u155.Value = Vector3.new(0, -1, 0)
u155.Changed:connect(function(p156) --[[ Line: 783 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if p156.magnitude > 0.001 then
        u26 = p156.unit
    end
end)
local v157 = u155.Value
if v157.magnitude > 0.001 then
    local _ = v157.unit
end
local v165 = {
    ["CollisionMode"] = u11,
    ["Enable"] = function(_, p158) --[[ Name: Enable, Line 796 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u119
            [3] = u40
            [4] = u44
            [5] = u43
            [6] = u14
            [7] = u38
            [8] = u117
            [9] = u13
            [10] = u15
            [11] = u39
        --]]
        if u28 ~= false then
            if p158 ~= nil and typeof(p158) ~= "TweenInfo" then
                error("bad argument #1 to \'Enable\' (TweenInfo expected, got " .. typeof(p158) .. ")", 2)
            end
            u119()
            u40.RainStraight.Enabled = true
            u40.RainTopDown.Enabled = true
            u40.Parent = workspace.Effects
            for v159 = 1, 6 do
                u44[v159].Parent = workspace.Terrain
                u43[v159].Parent = workspace.Terrain
            end
            if u14:IsRunning() then
                u38.Parent = game:GetService("SoundService")
            end
            u117()
            if p158 then
                u13:Create(u15, p158, {
                    ["Value"] = 0
                }):Play()
            else
                u15.Value = 0
            end
            if not u39.Playing then
                u39:Play()
                u39.TimePosition = math.random() * u39.TimeLength
            end
            u28 = false
        end
    end,
    ["Disable"] = function(_, p160) --[[ Name: Disable, Line 836 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u13
            [3] = u15
            [4] = u119
            [5] = u40
            [6] = u123
        --]]
        if u28 ~= true then
            if p160 ~= nil and typeof(p160) ~= "TweenInfo" then
                error("bad argument #1 to \'Disable\' (TweenInfo expected, got " .. typeof(p160) .. ")", 2)
            end
            if p160 then
                local u161 = u13:Create(u15, p160, {
                    ["Value"] = 1
                })
                u161.Completed:connect(function(p162) --[[ Line: 846 ]]
                    --[[
                    Upvalues:
                        [1] = u119
                        [2] = u40
                        [3] = u28
                        [4] = u123
                        [5] = u161
                    --]]
                    if p162 == Enum.PlaybackState.Completed then
                        u119()
                        u40.RainStraight.Enabled = false
                        u40.RainTopDown.Enabled = false
                        u40.Size = Vector3.new(0.05, 0.05, 0.05)
                        if not u28 then
                            u123(TweenInfo.new(1))
                        end
                    end
                    u161:Destroy()
                end)
                u161:Play()
                u123(p160)
            else
                u15.Value = 1
                u119()
                u40.RainStraight.Enabled = false
                u40.RainTopDown.Enabled = false
                u40.Size = Vector3.new(0.05, 0.05, 0.05)
                if not u28 then
                    u123(TweenInfo.new(1))
                end
            end
            u28 = true
        end
    end,
    ["SetColor"] = function(_, p163, p164) --[[ Name: SetColor, Line 865 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u129
        --]]
        if typeof(p163) == "Color3" then
            if p164 ~= nil and typeof(p164) ~= "TweenInfo" then
                error("bad argument #2 to \'SetColor\' (TweenInfo expected, got " .. typeof(p164) .. ")", 2)
            end
        else
            error("bad argument #1 to \'SetColor\' (Color3 expected, got " .. typeof(p163) .. ")", 2)
        end
        if p164 then
            u13:Create(u129, p164, {
                ["Value"] = p163
            }):Play()
        else
            u129.Value = p163
        end
    end
}
local u166 = "SetTransparency"
function v165.SetTransparency(_, p167, p168) --[[ Line: 883 ]]
    --[[
    Upvalues:
        [1] = u166
        [2] = u13
        [3] = u136
    --]]
    if typeof(p167) == "number" then
        if p168 ~= nil and typeof(p168) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u166 .. "\' (TweenInfo expected, got " .. typeof(p168) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u166 .. "\' (number expected, got " .. typeof(p167) .. ")", 2)
    end
    local v169 = math.clamp(p167, 0, 1)
    if p168 then
        u13:Create(u136, p168, {
            ["Value"] = v169
        }):Play()
    else
        u136.Value = v169
    end
end
local u170 = "SetSpeedRatio"
function v165.SetSpeedRatio(_, p171, p172) --[[ Line: 883 ]]
    --[[
    Upvalues:
        [1] = u170
        [2] = u13
        [3] = u137
    --]]
    if typeof(p171) == "number" then
        if p172 ~= nil and typeof(p172) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u170 .. "\' (TweenInfo expected, got " .. typeof(p172) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u170 .. "\' (number expected, got " .. typeof(p171) .. ")", 2)
    end
    local v173 = math.clamp(p171, 0, 1)
    if p172 then
        u13:Create(u137, p172, {
            ["Value"] = v173
        }):Play()
    else
        u137.Value = v173
    end
end
local u174 = "SetIntensityRatio"
function v165.SetIntensityRatio(_, p175, p176) --[[ Line: 883 ]]
    --[[
    Upvalues:
        [1] = u174
        [2] = u13
        [3] = u140
    --]]
    if typeof(p175) == "number" then
        if p176 ~= nil and typeof(p176) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u174 .. "\' (TweenInfo expected, got " .. typeof(p176) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u174 .. "\' (number expected, got " .. typeof(p175) .. ")", 2)
    end
    local v177 = math.clamp(p175, 0, 1)
    if p176 then
        u13:Create(u140, p176, {
            ["Value"] = v177
        }):Play()
    else
        u140.Value = v177
    end
end
local u178 = "SetLightEmission"
function v165.SetLightEmission(_, p179, p180) --[[ Line: 883 ]]
    --[[
    Upvalues:
        [1] = u178
        [2] = u13
        [3] = u149
    --]]
    if typeof(p179) == "number" then
        if p180 ~= nil and typeof(p180) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u178 .. "\' (TweenInfo expected, got " .. typeof(p180) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u178 .. "\' (number expected, got " .. typeof(p179) .. ")", 2)
    end
    local v181 = math.clamp(p179, 0, 1)
    if p180 then
        u13:Create(u149, p180, {
            ["Value"] = v181
        }):Play()
    else
        u149.Value = v181
    end
end
local u182 = "SetLightInfluence"
function v165.SetLightInfluence(_, p183, p184) --[[ Line: 883 ]]
    --[[
    Upvalues:
        [1] = u182
        [2] = u13
        [3] = u154
    --]]
    if typeof(p183) == "number" then
        if p184 ~= nil and typeof(p184) ~= "TweenInfo" then
            error("bad argument #2 to \'" .. u182 .. "\' (TweenInfo expected, got " .. typeof(p184) .. ")", 2)
        end
    else
        error("bad argument #1 to \'" .. u182 .. "\' (number expected, got " .. typeof(p183) .. ")", 2)
    end
    local v185 = math.clamp(p183, 0, 1)
    if p184 then
        u13:Create(u154, p184, {
            ["Value"] = v185
        }):Play()
    else
        u154.Value = v185
    end
end
function v165.SetVolume(_, p186, p187) --[[ Line: 908 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u38
    --]]
    if typeof(p186) == "number" then
        if p187 ~= nil and typeof(p187) ~= "TweenInfo" then
            error("bad argument #2 to \'SetVolume\' (TweenInfo expected, got " .. typeof(p187) .. ")", 2)
        end
    else
        error("bad argument #1 to \'SetVolume\' (number expected, got " .. typeof(p186) .. ")", 2)
    end
    if p187 then
        u13:Create(u38, p187, {
            ["Volume"] = p186
        }):Play()
    else
        u38.Volume = p186
    end
end
function v165.SetDirection(_, p188, p189) --[[ Line: 924 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u155
    --]]
    if typeof(p188) == "Vector3" then
        if p189 ~= nil and typeof(p189) ~= "TweenInfo" then
            error("bad argument #2 to \'SetDirection\' (TweenInfo expected, got " .. typeof(p189) .. ")", 2)
        end
    else
        error("bad argument #1 to \'SetDirection\' (Vector3 expected, got " .. typeof(p188) .. ")", 2)
    end
    if p188.unit.magnitude <= 0 then
        warn("Attempt to set rain direction to a zero-length vector, falling back on default direction = (" .. tostring(Vector3.new(0, -1, 0)) .. ")")
        p188 = Vector3.new(0, -1, 0)
    end
    if p189 then
        u13:Create(u155, p189, {
            ["Value"] = p188
        }):Play()
    else
        u155.Value = p188
    end
end
function v165.SetCeiling(_, p190) --[[ Line: 945 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    if p190 ~= nil and typeof(p190) ~= "number" then
        error("bad argument #1 to \'SetCeiling\' (number expected, got " .. typeof(p190) .. ")", 2)
    end
    u27 = p190
end
function v165.SetStraightTexture(_, p191) --[[ Line: 955 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u43
    --]]
    if typeof(p191) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p191) .. ")", 2)
    end
    u40.RainStraight.Texture = p191
    for _, v192 in pairs(u43) do
        v192.RainStraight.Texture = p191
    end
end
function v165.SetTopDownTexture(_, p193) --[[ Line: 969 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u43
    --]]
    if typeof(p193) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p193) .. ")", 2)
    end
    u40.RainTopDown.Texture = p193
    for _, v194 in pairs(u43) do
        v194.RainTopDown.Texture = p193
    end
end
function v165.SetSplashTexture(_, p195) --[[ Line: 983 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if typeof(p195) ~= "string" then
        error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p195) .. ")", 2)
    end
    for _, v196 in pairs(u44) do
        v196.RainSplash.Texture = p195
    end
end
function v165.SetSoundId(_, p197) --[[ Line: 995 ]]
    --[[
    Upvalues:
        [1] = u39
    --]]
    if typeof(p197) ~= "string" then
        error("bad argument #1 to \'SetSoundId\' (string expected, got " .. typeof(p197) .. ")", 2)
    end
    u39.SoundId = p197
end
function v165.SetCollisionMode(_, p198, p199) --[[ Line: 1005 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u17
        [3] = u30
        [4] = u40
        [5] = u16
        [6] = u67
        [7] = u66
    --]]
    if p198 == u11.None then
        u17 = nil
        u30 = nil
    elseif p198 == u11.Blacklist then
        if typeof(p199) == "Instance" then
            u17 = { p199, u40 }
        elseif typeof(p199) == "table" then
            for v200 = 1, #p199 do
                local v201 = p199[v200]
                if typeof(v201) ~= "Instance" then
                    local v202 = error
                    local v203 = p199[v200]
                    v202("bad argument #2 to \'SetCollisionMode\' (blacklist contained a " .. typeof(v203) .. " on index " .. tostring(v200) .. " which is not an Instance)", 2)
                end
            end
            u17 = { u40 }
            for v204 = 1, #p199 do
                local v205 = u17
                local v206 = p199[v204]
                table.insert(v205, v206)
            end
        else
            error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p199) .. ")\'", 2)
        end
        u30 = nil
    elseif p198 == u11.Whitelist then
        if typeof(p199) == "Instance" then
            u17 = { p199 }
        elseif typeof(p199) == "table" then
            for v207 = 1, #p199 do
                local v208 = p199[v207]
                if typeof(v208) ~= "Instance" then
                    local v209 = error
                    local v210 = p199[v207]
                    v209("bad argument #2 to \'SetCollisionMode\' (whitelist contained a " .. typeof(v210) .. " on index " .. tostring(v207) .. " which is not an Instance)", 2)
                end
            end
            u17 = {}
            for v211 = 1, #p199 do
                local v212 = u17
                local v213 = p199[v211]
                table.insert(v212, v213)
            end
        else
            error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p199) .. ")\'", 2)
        end
        u30 = nil
    elseif p198 == u11.Function then
        if typeof(p199) ~= "function" then
            error("bad argument #2 to \'SetCollisionMode\' (function expected, got " .. typeof(p199) .. ")", 2)
        end
        u17 = nil
        u30 = p199
    else
        error("bad argument #1 to \'SetCollisionMode (Rain.CollisionMode expected, got " .. typeof(p199) .. ")\'", 2)
    end
    u16 = p198
    u67 = u66[p198]
end
function v165.inside(_) --[[ Line: 1076 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    return u23
end
return v165