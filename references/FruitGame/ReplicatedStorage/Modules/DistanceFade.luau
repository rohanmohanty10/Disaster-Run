 

local u1 = {}
u1.__index = u1
local u2 = {
    ["DistanceOuter"] = 16,
    ["DistanceInner"] = 4,
    ["EffectRadius"] = 16,
    ["EffectRadiusMin"] = 0,
    ["EdgeDistanceCalculations"] = false,
    ["Texture"] = "rbxassetid://18838056070",
    ["TextureTransparency"] = 0,
    ["TextureTransparencyMin"] = 1,
    ["BackgroundTransparency"] = 1,
    ["BackgroundTransparencyMin"] = 1,
    ["TextureColor"] = Color3.fromRGB(255, 255, 255),
    ["BackgroundColor"] = Color3.fromRGB(255, 255, 255),
    ["TextureSize"] = Vector2.new(8, 8),
    ["TextureOffset"] = Vector2.new(0, 0),
    ["ZOffset"] = 0,
    ["AlwaysOnTop"] = false,
    ["Brightness"] = 1,
    ["LightInfluence"] = 0,
    ["MaxDistance"] = 1000,
    ["PixelsPerStud"] = 100,
    ["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud
}
function u1.new() --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v3 = {
        ["Settings"] = {},
        ["FaceSettings"] = {},
        ["TargetParts"] = {},
        ["WorkspaceFolder"] = nil
    }
    local v4 = u1
    setmetatable(v3, v4)
    v3.Settings = {}
    for v5, v6 in u2 do
        v3.Settings[v5] = v6
    end
    if v3.WorkspaceFolder == nil then
        local v7 = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts")
        if v7 ~= nil then
            v3.WorkspaceFolder = v7
            return v3
        end
        v3.WorkspaceFolder = Instance.new("Folder")
        v3.WorkspaceFolder.Name = "DistanceFade_SurfaceParts"
        v3.WorkspaceFolder.Parent = workspace
    end
    return v3
end
function u1.UpdateSettings(p8, p9) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p8.Settings == nil then
        p8.Settings = {}
    end
    if p9 == nil then
        for v10, v11 in u2 do
            p8.Settings[v10] = v11
        end
    else
        local v12 = type(p9) == "table"
        assert(v12, "Expected table as parameter")
        for v13, v14 in u2 do
            if p9[v13] == nil then
                if p8.Settings[v13] == nil then
                    p8.Settings[v13] = v14
                end
            else
                p8.Settings[v13] = p9[v13]
            end
        end
    end
end
function u1.UpdateFaceSettings(p15, p16, p17, p18) --[[ Line: 124 ]]
    if p15.FaceSettings[p16] == nil then
        p15.FaceSettings[p16] = {}
    end
    if p15.FaceSettings[p16][p17] == nil then
        p15.FaceSettings[p16][p17] = {}
    end
    if p18 == nil then
        p15.FaceSettings[p16][p17] = nil
    else
        local v19 = type(p18) == "table"
        assert(v19, "Expected table as parameter")
        for v20, v21 in pairs(p18) do
            p15.FaceSettings[p16][p17][v20] = v21
        end
    end
end
local function u25(p22, p23) --[[ Line: 147 ]]
    local v24 = nil
    if p22 == Enum.NormalId.Front then
        return p23.CFrame.LookVector
    end
    if p22 == Enum.NormalId.Back then
        return -p23.CFrame.LookVector
    end
    if p22 == Enum.NormalId.Left then
        return -p23.CFrame.RightVector
    end
    if p22 == Enum.NormalId.Right then
        return p23.CFrame.RightVector
    end
    if p22 == Enum.NormalId.Top then
        return p23.CFrame.UpVector
    end
    if p22 == Enum.NormalId.Bottom then
        v24 = -p23.CFrame.UpVector
    end
    return v24
end
local function u30(p26, p27) --[[ Line: 168 ]]
    local v28 = Vector3.new()
    local v29 = CFrame.new()
    if p26 == Enum.NormalId.Front then
        return p27.Size.Z / 2 * p27.CFrame.LookVector, CFrame.Angles(0, 0, 0)
    end
    if p26 == Enum.NormalId.Back then
        return p27.Size.Z / 2 * -p27.CFrame.LookVector, CFrame.Angles(0, 3.141592653589793, 0)
    end
    if p26 == Enum.NormalId.Left then
        return p27.Size.X / 2 * -p27.CFrame.RightVector, CFrame.Angles(0, 1.5707963267948966, 0)
    end
    if p26 == Enum.NormalId.Right then
        return p27.Size.X / 2 * p27.CFrame.RightVector, CFrame.Angles(0, -1.5707963267948966, 0)
    end
    if p26 == Enum.NormalId.Top then
        return p27.Size.Y / 2 * p27.CFrame.UpVector, CFrame.Angles(1.5707963267948966, 0, 0)
    end
    if p26 == Enum.NormalId.Bottom then
        v28 = p27.Size.Y / 2 * -p27.CFrame.UpVector
        v29 = CFrame.Angles(-1.5707963267948966, 0, 0)
    end
    return v28, v29
end
local function u44(p31, p32, p33, p34) --[[ Line: 196 ]]
    local v35 = nil
    local v36 = nil
    local v37 = nil
    local v38 = nil
    local v39 = nil
    if p33 == Enum.NormalId.Front or p33 == Enum.NormalId.Back then
        v35 = p34.X / 2
        v36 = p34.Y / 2
        local v40 = p34.Z / 2
        v37 = p33 == Enum.NormalId.Front and p32.RightVector or -p32.RightVector
        v38 = p32.UpVector
        v39 = p33 == Enum.NormalId.Front and p32.LookVector * v40 or -p32.LookVector * v40
    elseif p33 == Enum.NormalId.Left or p33 == Enum.NormalId.Right then
        v35 = p34.Z / 2
        v36 = p34.Y / 2
        local v41 = p34.X / 2
        v37 = p33 == Enum.NormalId.Left and p32.LookVector or -p32.LookVector
        v38 = p32.UpVector
        v39 = p33 == Enum.NormalId.Left and -p32.RightVector * v41 or p32.RightVector * v41
    elseif p33 == Enum.NormalId.Top or p33 == Enum.NormalId.Bottom then
        v35 = p34.X / 2
        v36 = p34.Z / 2
        local v42 = p34.Y / 2
        v37 = p32.RightVector
        v38 = p33 == Enum.NormalId.Top and -p32.LookVector or p32.LookVector
        v39 = p33 == Enum.NormalId.Top and p32.UpVector * v42 or -p32.UpVector * v42
    end
    local v43 = p31 + v39
    return {
        ["Left"] = v43 - v37 * v35,
        ["Right"] = v43 + v37 * v35,
        ["Top"] = v43 + v38 * v36,
        ["Bottom"] = v43 - v38 * v36
    }
end
local function u64(p45, p46, p47) --[[ Line: 242 ]]
    local v48 = p45:PointToObjectSpace(p46)
    if p47 == Enum.NormalId.Front then
        return v48
    elseif p47 == Enum.NormalId.Back then
        local v49 = -v48.X
        local v50 = v48.Y
        local v51 = v48.Z
        return Vector3.new(v49, v50, v51)
    elseif p47 == Enum.NormalId.Left then
        local v52 = -v48.Z
        local v53 = v48.Y
        local v54 = v48.X
        return Vector3.new(v52, v53, v54)
    elseif p47 == Enum.NormalId.Right then
        local v55 = v48.Z
        local v56 = v48.Y
        local v57 = v48.X
        return Vector3.new(v55, v56, v57)
    elseif p47 == Enum.NormalId.Top then
        local v58 = v48.X
        local v59 = v48.Z
        local v60 = v48.Y
        return Vector3.new(v58, v59, v60)
    else
        local v61 = v48.X
        local v62 = -v48.Z
        local v63 = v48.Y
        return Vector3.new(v61, v62, v63)
    end
end
local function u68() --[[ Line: 267 ]]
    local v65 = Instance.new("Frame")
    v65.BackgroundTransparency = 1
    local v66 = Instance.new("Frame")
    v66.BackgroundTransparency = 1
    v66.ClipsDescendants = true
    v66.AnchorPoint = Vector2.new(0.5, 0.5)
    v66.Position = UDim2.new(0.5, 0, 0.5, 0)
    v66.Size = UDim2.new(1, 0, 1, 0)
    v66.Name = "ScaleFrame"
    v66.Parent = v65
    local v67 = Instance.new("ImageLabel")
    v67.BackgroundTransparency = 1
    v67.Parent = v66
    v67.AnchorPoint = Vector2.new(0.5, 0.5)
    v67.Position = UDim2.new(0.5, 0, 0.5, 0)
    v67.Size = UDim2.new(9, 0, 9, 0)
    v67.ScaleType = Enum.ScaleType.Tile
    v67.TileSize = UDim2.new(0.111, 0, 0.111, 0)
    return v65
end
local function u75(_, p69) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u68
    --]]
    local v70 = {}
    for v71 = 1, 4 do
        for v72 = 1, 4 do
            local v73 = u68()
            v73.Parent = p69.ScaleFrame
            v73.Size = UDim2.new(0.25, 0, 0.25, 0)
            v73.Position = UDim2.new((v72 - 1) * 0.25, 0, (v71 - 1) * 0.25, 0)
            v73.BorderSizePixel = 0
            table.insert(v70, v73)
            local v74 = #v70
            v73.Name = tostring(v74)
        end
    end
    return v70
end
local function u88(p76) --[[ Line: 309 ]]
    local v77 = {
        [1] = 45,
        [4] = 135,
        [13] = -45,
        [16] = -135
    }
    local v78 = {
        [2] = 75,
        [3] = 105,
        [5] = 15,
        [8] = 165,
        [9] = -15,
        [12] = -165,
        [14] = -75,
        [15] = -105
    }
    for v79 = 1, #p76 do
        local v80 = p76[v79]
        local v81 = false
        for v82, v83 in v77 do
            if v82 == v79 then
                local v84 = Instance.new("UIGradient")
                v84.Parent = v80.ScaleFrame.ImageLabel
                v84.Rotation = v83
                v81 = true
                break
            end
        end
        if not v81 then
            for v85, v86 in v78 do
                if v85 == v79 then
                    local v87 = Instance.new("UIGradient")
                    v87.Parent = v80.ScaleFrame.ImageLabel
                    v87.Rotation = v86
                    break
                end
            end
        end
    end
end
local function u98(p89, p90, p91) --[[ Line: 352 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u75
        [3] = u88
    --]]
    local v92 = Instance.new("Part")
    v92.Transparency = 1
    v92.Parent = p91.WorkspaceFolder
    v92.Size = Vector3.new(0, 0, 0)
    v92.Anchored = true
    v92.CanCollide = false
    v92.CanTouch = false
    v92.CanQuery = false
    v92.Locked = true
    local v93, v94 = u30(p90, p89)
    v92.CFrame = p89.CFrame * CFrame.new(v93) * v94
    local v95 = Instance.new("SurfaceGui")
    v95.ResetOnSpawn = false
    v95.ClipsDescendants = true
    v95.Parent = game.Players.LocalPlayer.PlayerGui
    v95.Adornee = v92
    v95.Face = Enum.NormalId.Front
    v95.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    v95.PixelsPerStud = 1000
    local v96 = Instance.new("Frame")
    v96.Size = UDim2.new(1, 0, 1, 0)
    v96.AnchorPoint = Vector2.new(0.5, 0.5)
    v96.Position = UDim2.new(0.5, 0, 0.5, 0)
    v96.BackgroundTransparency = 1
    v96.Name = "ScaleFrame"
    v96.Parent = v95
    v95.Enabled = false
    local v97 = p91.Settings.EffectResolution
    u88(u75(v97, v95), v97)
    return v92, v95
end
function u1.AddFace(p99, p100, p101) --[[ Line: 389 ]]
    --[[
    Upvalues:
        [1] = u98
    --]]
    if p101 == nil then
        p101 = Enum.NormalId.Front
    end
    local v102, v103 = u98(p100, p101, p99)
    local v104 = {
        ["SurfaceNormal"] = p101,
        ["SurfacePart"] = v102,
        ["SurfaceGui"] = v103
    }
    if p99.TargetParts[p100] == nil then
        p99.TargetParts[p100] = {}
    end
    p99.TargetParts[p100][p101] = v104
end
function u1.RemoveFace(p105, p106, p107) --[[ Line: 406 ]]
    if p107 == nil then
        p107 = Enum.NormalId.Front
    end
    if p105.TargetParts[p106] == nil then
        return
    else
        local v108 = p105.TargetParts[p106][p107]
        if v108 ~= nil then
            v108.SurfacePart:Destroy()
            v108.SurfaceGui:Destroy()
            p105.TargetParts[p106][p107] = nil
            if next(p105.TargetParts[p106]) == nil then
                p105.TargetParts[p106] = nil
                if p105.WorkspaceFolder ~= nil and #p105.WorkspaceFolder:GetChildren() == 0 then
                    p105.WorkspaceFolder:Destroy()
                    p105.WorkspaceFolder = nil
                end
            end
        end
    end
end
function u1.Clear(p109) --[[ Line: 432 ]]
    for _, v110 in p109.TargetParts do
        for _, v111 in v110 do
            v111.SurfacePart:Destroy()
            v111.SurfaceGui:Destroy()
        end
    end
    if p109.WorkspaceFolder ~= nil and #p109.WorkspaceFolder:GetChildren() == 0 then
        p109.WorkspaceFolder:Destroy()
        p109.WorkspaceFolder = nil
    end
    table.clear(p109.TargetParts)
end
local u112 = {
    {
        ["OffsetX"] = 3,
        ["OffsetY"] = 3
    },
    {
        ["OffsetX"] = 2,
        ["OffsetY"] = 3
    },
    {
        ["OffsetX"] = 1,
        ["OffsetY"] = 3
    },
    {
        ["OffsetX"] = 0,
        ["OffsetY"] = 3
    },
    {
        ["OffsetX"] = 3,
        ["OffsetY"] = 2
    },
    {
        ["OffsetX"] = 2,
        ["OffsetY"] = 2
    },
    {
        ["OffsetX"] = 1,
        ["OffsetY"] = 2
    },
    {
        ["OffsetX"] = 0,
        ["OffsetY"] = 2
    },
    {
        ["OffsetX"] = 3,
        ["OffsetY"] = 1
    },
    {
        ["OffsetX"] = 2,
        ["OffsetY"] = 1
    },
    {
        ["OffsetX"] = 1,
        ["OffsetY"] = 1
    },
    {
        ["OffsetX"] = 0,
        ["OffsetY"] = 1
    },
    {
        ["OffsetX"] = 3,
        ["OffsetY"] = 0
    },
    {
        ["OffsetX"] = 2,
        ["OffsetY"] = 0
    },
    {
        ["OffsetX"] = 1,
        ["OffsetY"] = 0
    },
    {
        ["OffsetX"] = 0,
        ["OffsetY"] = 0
    }
}
local function u119(p113, p114, p115, p116) --[[ Line: 524 ]]
    local v117 = math.abs(p113) / p115 % 1
    if p113 < 0 then
        v117 = -v117
    end
    local v118 = math.abs(p114) / p116 % 1
    if p114 < 0 then
        v118 = -v118
    end
    return UDim2.new(0.5 + v117 * p115, 0, 0.5 + v118 * p116, 0)
end
function UpdateSideGradient(p120)
    local v121 = p120.ScaleFrame.ImageLabel.UIGradient
    local _ = p120.ScaleFrame.Size
    local v122 = p120.ScaleFrame.ImageLabel.Position
    local v123 = -(v122.X.Scale + 0.5) / 200
    local v124 = (p120.Name == "2" or (p120.Name == "3" or (p120.Name == "14" or p120.Name == "15"))) and 0 or v123
    local v125 = -(v122.Y.Scale + 0.5) / 200
    local v126 = (p120.Name == "5" or (p120.Name == "8" or (p120.Name == "9" or p120.Name == "12"))) and 0 or v125
    if p120.Name == "5" or p120.Name == "9" then
        v124 = v124 + 0.01
    end
    if p120.Name == "2" or p120.Name == "3" then
        v126 = v126 + 0.01
    end
    local v127 = (v122.X.Scale - 0.5) / 9 + v124
    local v128 = (v122.Y.Scale - 0.5) / 9 + v126
    if p120.Name == "12" or (p120.Name == "9" or (p120.Name == "2" or p120.Name == "3")) then
        v128 = -v128
    end
    if p120.Name == "5" or (p120.Name == "9" or (p120.Name == "15" or p120.Name == "3")) then
        v127 = -v127
    end
    if p120.Name ~= "2" and (p120.Name ~= "3" and (p120.Name ~= "14" and p120.Name ~= "15")) then
        local v129 = v127
        v127 = v128
        v128 = v129
    end
    local v130 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.466, 1),
        NumberSequenceKeypoint.new(0.555, 0),
        NumberSequenceKeypoint.new(1, 0)
    }
    local v131 = {}
    for v132 = 1, #v130 do
        local v133 = v130[v132]
        local v134 = v133.Time + v128
        v131[v132] = NumberSequenceKeypoint.new(math.clamp(v134, 0, 1), v133.Value)
    end
    if v131[1].Time > 0 then
        local v135 = NumberSequenceKeypoint.new
        local v136 = v131[1].Value
        table.insert(v131, 1, v135(0, v136))
    end
    if v131[#v131].Time < 1 then
        local v137 = NumberSequenceKeypoint.new
        local v138 = v131[#v131].Value
        table.insert(v131, v137(1, v138))
    end
    for _, v139 in v131 do
        if v139.Time < 0 then
            v139.Time = 0
        elseif v139.Time > 1 then
            v139.Time = 1
        end
    end
    v121.Transparency = NumberSequence.new(v131)
    local v140 = Vector2.new(-v127 / 4, 0)
    local v141 = v121.Rotation
    local v142 = math.rad(v141)
    local v143 = math.cos(v142)
    local v144 = math.sin(v142)
    local v145 = v140.X * v143 - v140.Y * v144
    local v146 = v140.X * v144 + v140.Y * v143
    v121.Offset = Vector2.new(v145, v146)
end
function UpdateCornerGradient(p147)
    local v148 = p147.ScaleFrame.ImageLabel.UIGradient
    local _ = p147.ScaleFrame.Size
    local v149 = p147.ScaleFrame.ImageLabel.Position
    local v150 = -(v149.X.Scale + 0.5) / 75
    local v151 = -(v149.Y.Scale + 0.5) / 75
    local v152 = (v149.X.Scale - 0.5) / 9 + v150
    local v153 = (v149.Y.Scale - 0.5) / 9 + v151
    if p147.Name == "13" or p147.Name == "1" then
        v152 = -v152
    end
    if p147.Name == "1" or p147.Name == "4" then
        v153 = -v153
    end
    local v154 = p147.Name == "1" and -0.015 or (p147.Name == "4" and 0.0025 or (p147.Name == "16" and 0.02 or (p147.Name == "13" and 0.0025 or 0)))
    local v155 = (v152 + v153) / 1.4142135623730951 + v154
    local v156 = (v152 + v153) / 1.4142135623730951 + v154
    local v157 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.51, 1),
        NumberSequenceKeypoint.new(0.555, 0.2),
        NumberSequenceKeypoint.new(1, 0.2)
    }
    local v158 = {}
    for v159 = 1, #v157 do
        local v160 = v157[v159]
        local v161 = v160.Time + v155
        v158[v159] = NumberSequenceKeypoint.new(math.clamp(v161, 0, 1), v160.Value)
    end
    if v158[1].Time > 0 then
        local v162 = NumberSequenceKeypoint.new
        local v163 = v158[1].Value
        table.insert(v158, 1, v162(0, v163))
    end
    if v158[#v158].Time < 1 then
        local v164 = NumberSequenceKeypoint.new
        local v165 = v158[#v158].Value
        table.insert(v158, v164(1, v165))
    end
    if p147.Name == "1" or p147.Name == "4" then
        local v166 = {}
        for v167, v168 in v158 do
            if v168.Time == 1 then
                v158 = v166
                for v169 = 1, v167 do
                    local v170 = v158[v169]
                    table.insert(v158, v170)
                    v166 = v158
                    v158 = v166
                end
                break
            end
        end
    end
    for _, v171 in v158 do
        if v171.Time < 0 then
            v171.Time = 0
        elseif v171.Time > 1 then
            v171.Time = 1
        end
    end
    v148.Transparency = NumberSequence.new(v158)
    local v172 = Vector2.new(-v156 / 4, 0)
    local v173 = v148.Rotation
    local v174 = math.rad(v173)
    local v175 = math.cos(v174)
    local v176 = math.sin(v174)
    local v177 = v172.X * v175 - v172.Y * v176
    local v178 = v172.X * v176 + v172.Y * v175
    v148.Offset = Vector2.new(v177, v178)
end
function u1.Step(p179, p180) --[[ Line: 697 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u25
        [3] = u44
        [4] = u64
        [5] = u112
        [6] = u119
    --]]
    if p179.WorkspaceFolder == nil then
        local v181 = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts")
        if v181 == nil then
            p179.WorkspaceFolder = Instance.new("Folder")
            p179.WorkspaceFolder.Name = "DistanceFade_SurfaceParts"
            p179.WorkspaceFolder.Parent = workspace
        else
            p179.WorkspaceFolder = v181
        end
    end
    local v182 = p179.Settings
    if v182.EffectRadiusMin > v182.EffectRadius then
        v182.EffectRadiusMin = v182.EffectRadius
    end
    if v182.DistanceInner > v182.DistanceOuter then
        v182.DistanceInner = v182.DistanceOuter
    end
    if p180 == nil then
        local v183 = game.Players.LocalPlayer.Character
        if v183 == nil then
            return
        end
        if v183.PrimaryPart == nil then
            return
        end
        p180 = v183.HumanoidRootPart.Position
    end
    for v184, v185 in p179.TargetParts do
        for v186, v187 in v185 do
            local v188 = {}
            if p179.FaceSettings[v184] ~= nil and p179.FaceSettings[v184][v186] ~= nil then
                for v189, v190 in v182 do
                    v188[v189] = v190
                    if p179.FaceSettings[v184][v186][v189] ~= nil then
                        v188[v189] = p179.FaceSettings[v184][v186][v189]
                    end
                end
            end
            if next(v188) == nil then
                v188 = v182
            end
            local v191 = v187.SurfacePart
            local v192 = v187.SurfaceGui
            v192.ZOffset = v188.ZOffset
            v192.AlwaysOnTop = v188.AlwaysOnTop
            v192.Brightness = v188.Brightness
            v192.LightInfluence = v188.LightInfluence
            v192.MaxDistance = v188.MaxDistance
            v192.PixelsPerStud = v188.PixelsPerStud
            v192.SizingMode = v188.SizingMode
            local _ = v184.CFrame
            local v193, v194 = u30(v187.SurfaceNormal, v184)
            local v195 = u25(v187.SurfaceNormal, v184)
            local v196 = p180 - (v184.Position + v193)
            local v197 = v196 - v195 * v196:Dot(v195)
            local v198 = v184.Position + v197 + v193
            local v199 = v184.CFrame * CFrame.new(v193) * v194
            v191.CFrame = CFrame.new(v198) * CFrame.fromMatrix(Vector3.new(), v199.RightVector, v199.UpVector)
            local v200 = (p180 - v191.Position).Magnitude
            local v201 = u44(v184.Position, v184.CFrame, v187.SurfaceNormal, v184.Size)
            local v202
            if v188.EdgeDistanceCalculations then
                local v203 = (1 / 0)
                local v204 = u64(CFrame.new(v201.Top) * (v184.CFrame - v184.CFrame.Position), p180, v187.SurfaceNormal)
                local v205 = v204.Y
                local v206 = v204.Z
                local v207 = Vector3.new(0, v205, v206).Magnitude
                if v207 >= v203 then
                    v207 = v203
                end
                local v208 = u64(CFrame.new(v201.Bottom) * (v184.CFrame - v184.CFrame.Position), p180, v187.SurfaceNormal)
                local v209 = v208.Y
                local v210 = v208.Z
                local v211 = Vector3.new(0, v209, v210).Magnitude
                if v211 >= v207 then
                    v211 = v207
                end
                local v212 = u64(CFrame.new(v201.Left) * (v184.CFrame - v184.CFrame.Position), p180, v187.SurfaceNormal)
                local v213 = v212.X
                local v214 = v212.Z
                local v215 = Vector3.new(v213, 0, v214).Magnitude
                if v215 >= v211 then
                    v215 = v211
                end
                local v216 = u64(CFrame.new(v201.Right) * (v184.CFrame - v184.CFrame.Position), p180, v187.SurfaceNormal)
                local v217 = v216.X
                local v218 = v216.Z
                v202 = Vector3.new(v217, 0, v218).Magnitude
                if v202 >= v215 then
                    v202 = v215
                end
                if v202 >= v200 then
                    v202 = v200
                end
            else
                v202 = v200
            end
            local v219 = 1 / (v188.TextureSize.X * 2 / v188.EffectRadius)
            local v220
            if v202 < v188.DistanceInner then
                v192.Enabled = true
                v220 = v219
                ::l41::
                local v221 = v188.EffectRadius / v219
                local v222 = v188.TextureSize.X * 2 / v188.EffectRadius
                local v223 = (v188.EffectRadiusMin + (v188.EffectRadius - v188.EffectRadiusMin) * v220 * v222) * 2
                local v224 = v191.Size.Z
                v191.Size = Vector3.new(v223, v223, v224)
                local v225 = u44(v191.Position, v191.CFrame, Enum.NormalId.Front, v191.Size)
                local v226 = {
                    ["Left"] = u64(v184.CFrame, v201.Left, v187.SurfaceNormal),
                    ["Right"] = u64(v184.CFrame, v201.Right, v187.SurfaceNormal),
                    ["Top"] = u64(v184.CFrame, v201.Top, v187.SurfaceNormal),
                    ["Bottom"] = u64(v184.CFrame, v201.Bottom, v187.SurfaceNormal)
                }
                local v227 = {
                    ["Left"] = u64(v184.CFrame, v225.Left, v187.SurfaceNormal),
                    ["Right"] = u64(v184.CFrame, v225.Right, v187.SurfaceNormal),
                    ["Top"] = u64(v184.CFrame, v225.Top, v187.SurfaceNormal),
                    ["Bottom"] = u64(v184.CFrame, v225.Bottom, v187.SurfaceNormal)
                }
                local v228 = v227.Left.X >= v226.Left.X and 1 or 1 - (v226.Left.X - v227.Left.X) / v191.Size.X
                local v229 = v227.Right.X <= v226.Right.X and 1 or 1 - (v227.Right.X - v226.Right.X) / v191.Size.X
                local v230 = v227.Bottom.Y >= v226.Bottom.Y and 1 or 1 - (v226.Bottom.Y - v227.Bottom.Y) / v191.Size.Y
                local v231 = v227.Top.Y <= v226.Top.Y and 1 or 1 - (v227.Top.Y - v226.Top.Y) / v191.Size.Y
                if v231 < 0 or (v230 < 0 or (v228 < 0 or v229 < 0)) then
                    v192.Enabled = false
                else
                    local v232 = 1 - (1 - v228 + (1 - v229))
                    local v233 = 1 - (1 - v231 + (1 - v230))
                    local v234 = v228 <= v229 and 1 or -1
                    local v235 = v230 <= v231 and 1 or -1
                    local v236 = v191.Size * Vector3.new(v232, v233, 1)
                    local v237
                    if v229 < 1 and v228 < 1 then
                        local v238 = (v229 - v228) * 2
                        local v239 = (v191.Size.X - v236.X) / 2 * v238
                        local v240 = (v227.Right.X + v227.Left.X) / 2
                        local v241 = (v226.Right.X + v226.Left.X) / 2
                        local v242 = v226.Right.X - v226.Left.X
                        local v243 = math.abs(v242)
                        v237 = v239 - (v240 + v239 + v236.X - (v241 + v243))
                        v234 = v238 / ((1 - (v229 + v228 - 1)) * 2)
                    else
                        v237 = (v191.Size.X - v236.X) / 2 * v234
                    end
                    local v244
                    if v231 < 1 and v230 < 1 then
                        local v245 = (v231 - v230) * 2
                        local v246 = (v191.Size.Y - v236.Y) / 2 * v245
                        local v247 = (v227.Top.Y + v227.Bottom.Y) / 2
                        local v248 = (v226.Top.Y + v226.Bottom.Y) / 2
                        local v249 = v226.Top.Y - v226.Bottom.Y
                        local v250 = math.abs(v249)
                        v244 = v246 - (v247 + v246 + v236.Y - (v248 + v250))
                        v235 = v245 / ((1 - (v231 + v230 - 1)) * 2)
                    else
                        v244 = (v191.Size.Y - v236.Y) / 2 * v235
                    end
                    v191.CFrame = v191.CFrame * CFrame.new(v237, v244, 0)
                    v191.Size = v236
                    v192.ScaleFrame.Size = UDim2.new(1 / v232, 0, 1 / v233, 0)
                    v192.ScaleFrame.Position = UDim2.new(0.5 - (1 - 1 / v232) / 2 * v234, 0, 0.5 - (1 - 1 / v233) / 2 * v235, 0)
                    local v251 = v219 <= 1 and 1 or v219
                    local v252 = (1 - (v220 + (1 - v219))) / (0.8 - (1 - v219))
                    local v253 = math.min(v252, 1) * v251
                    local v254 = v253 < 0 and 1 or v253
                    local v255 = v188.TextureTransparency + (v188.TextureTransparencyMin - v188.TextureTransparency) * v254
                    local v256 = v188.BackgroundTransparency + (v188.BackgroundTransparencyMin - v188.BackgroundTransparency) * v254
                    local v257 = 1 / (v220 + (v219 - v220) * (v188.EffectRadiusMin / v188.EffectRadius))
                    local v258 = v191.Position
                    local v259 = v258 - v195 * v258:Dot(v195)
                    local v260 = u64(v184.CFrame, v259, v187.SurfaceNormal)
                    local v261 = (1 / v257 - 1) * 3 * v257
                    local v262 = -(1 - v232) / 0.5 * v234
                    local v263 = -(1 - v233) / 0.5 * v235
                    local v264 = -v188.TextureOffset.X / v188.TextureSize.X * v257
                    local v265 = v188.TextureSize.Y / v188.TextureSize.X
                    local v266 = v265 - 1
                    local v267 = -v188.TextureOffset.Y / v188.TextureSize.X * v257
                    for _, u268 in v192.ScaleFrame:GetChildren() do
                        local v269 = u268.ScaleFrame.ImageLabel
                        v269.Image = v188.Texture
                        v269.ImageTransparency = v255
                        v269.ImageColor3 = v188.TextureColor
                        v269.BackgroundTransparency = v256
                        v269.BackgroundColor3 = v188.BackgroundColor
                        local v270 = u112
                        local v271 = u268.Name
                        local v272 = v270[tonumber(v271)]
                        local v273 = (1 / v257 - 1) * v257 * v272.OffsetX
                        local v274 = (1 / v257 - 1) * v257 * v272.OffsetY
                        local v275 = v264 + v273 + v262 + v261 + v260.X / (v221 / 2) * v257
                        local v276 = v267 + v274 + v263 + v261 + v260.Y / (v221 / 2) * v257
                        local v277 = UDim2.new
                        local v278 = 0.111 * v257
                        local v279 = math.max(v278, 0.001)
                        local v280 = 0.111 * v257 * v265
                        v269.TileSize = v277(v279, 0, math.max(v280, 0.001), 0)
                        if u268.Name == "1" or (u268.Name == "2" or (u268.Name == "3" or u268.Name == "4")) then
                            v276 = v276 - v266 * v257
                        elseif u268.Name == "9" or (u268.Name == "10" or (u268.Name == "11" or u268.Name == "12")) then
                            v276 = v276 + v266 * v257
                        elseif u268.Name == "13" or (u268.Name == "14" or (u268.Name == "15" or u268.Name == "16")) then
                            v276 = v276 + v266 * v257 * 2
                        end
                        local v281 = u119(v275, v276, v257, v257 * v265)
                        local v282 = 0
                        local v283 = 0
                        if v281.X.Scale > 4.5 then
                            v282 = v281.X.Scale - 4.5
                        elseif v281.X.Scale < -3.5 then
                            v282 = v281.X.Scale + 3.5
                        end
                        if v281.Y.Scale > 4.5 then
                            v283 = v281.Y.Scale - 4.5
                        elseif v281.Y.Scale < -3.5 then
                            v283 = v281.Y.Scale + 3.5
                        end
                        local v284 = Vector2.new(-v282, -v283)
                        if v283 < 0 then
                            if v220 < 0.125 then
                                v284 = Vector2.new(v284.X, -v283)
                            else
                                v284 = Vector2.new(v284.X, 1 * v257)
                            end
                        end
                        if v282 < 0 then
                            if v220 < 0.125 then
                                v284 = Vector2.new(-v282, v284.Y)
                            else
                                v284 = Vector2.new(1 * v257, v284.Y)
                            end
                        end
                        v269.Position = UDim2.new(v281.X.Scale + v284.X, 0, v281.Y.Scale + v284.Y, 0)
                        local v285 = {
                            1,
                            4,
                            13,
                            16
                        }
                        local v286 = table.find
                        local v287 = u268.Name
                        if v286({
                            2,
                            3,
                            5,
                            9,
                            8,
                            12,
                            14,
                            15
                        }, (tonumber(v287))) then
                            local _, _ = pcall(function() --[[ Line: 975 ]]
                                --[[
                                Upvalues:
                                    [1] = u268
                                --]]
                                UpdateSideGradient(u268)
                            end)
                        else
                            local v288 = table.find
                            local v289 = u268.Name
                            if v288(v285, (tonumber(v289))) then
                                local _, _ = pcall(function() --[[ Line: 979 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u268
                                    --]]
                                    UpdateCornerGradient(u268)
                                end)
                            end
                        end
                    end
                end
            else
                if v202 < v188.DistanceOuter then
                    v192.Enabled = true
                    local v290 = (v202 - v188.DistanceInner) / (v188.DistanceOuter - v188.DistanceInner)
                    v220 = v219 - math.clamp(v290, 0, 1)
                    goto l41
                end
                v192.Enabled = false
            end
        end
    end
end
return u1