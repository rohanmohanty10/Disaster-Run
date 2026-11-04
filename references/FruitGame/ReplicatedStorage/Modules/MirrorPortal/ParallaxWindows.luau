 

local u1 = {}
u1.__index = u1
local u2 = {
    ["MaxFramerate"] = 60,
    ["MinFramerate"] = 10,
    ["MaxUpdateDistance"] = 10,
    ["MinUpdateDistance"] = 200,
    ["LazyCheckingModifier"] = 10,
    ["ZOffset"] = 0,
    ["AlwaysOnTop"] = false,
    ["Brightness"] = 1,
    ["LightInfluence"] = 1,
    ["MaxDistance"] = 1000,
    ["PixelsPerStud"] = 100,
    ["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud
}
local u3 = {
    ["UpdateRange"] = 100,
    ["ZIndex"] = 0,
    ["Image"] = "rbxassetid://18838056070",
    ["Rotation"] = 0,
    ["ImageTransparency"] = 0,
    ["BackgroundTransparency"] = 1,
    ["ImageColor3"] = Color3.fromRGB(255, 255, 255),
    ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
    ["ResampleMode"] = Enum.ResamplerMode.Default,
    ["ScaleType"] = Enum.ScaleType.Stretch,
    ["TileSize"] = UDim2.new(1, 0, 1, 0),
    ["Interactable"] = false,
    ["Active"] = false,
    ["ImageSize"] = Vector3.new(8, 8, 0),
    ["PosOffset"] = Vector3.new(),
    ["ExtraOffset"] = UDim2.new()
}
local function u7(p4, p5) --[[ Line: 62 ]]
    if p4.GuiFolder == nil then
        local v6 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ParallaxWindows_SurfaceGuis")
        if v6 == nil then
            if p5 then
                return true
            else
                p4.GuiFolder = Instance.new("Folder")
                p4.GuiFolder.Name = "ParallaxWindows_SurfaceGuis"
                if game:GetService("RunService"):IsRunning() then
                    p4.GuiFolder.Parent = game.Players.LocalPlayer.PlayerGui
                else
                    p4.GuiFolder.Parent = game.StarterGui
                end
            end
        else
            p4.GuiFolder = v6
            return
        end
    else
        return
    end
end
function u1.new() --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u7
    --]]
    local v8 = {
        ["Default_GuiSettings"] = {},
        ["Default_FrameSettings"] = {},
        ["GuiSettings"] = {},
        ["FrameSettings"] = {},
        ["TargetParts"] = {},
        ["GuiFolder"] = nil,
        ["LastStep"] = os.clock(),
        ["MaxUpdates"] = 100
    }
    local v9 = u1
    setmetatable(v8, v9)
    v8.Default_GuiSettings = table.clone(u2)
    v8.Default_FrameSettings = table.clone(u3)
    u7(v8)
    return v8
end
function u1.UpdateSettings(p10, p11, p12) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if p10.Default_GuiSettings == nil then
        p10.Default_GuiSettings = {}
    end
    if p10.Default_FrameSettings == nil then
        p10.Default_FrameSettings = {}
    end
    if p11 then
        local v13 = type(p11) == "table"
        assert(v13, "Expected table as parameter")
        for v14, v15 in u2 do
            if p11[v14] == nil then
                if p10.Default_GuiSettings[v14] == nil then
                    p10.Default_GuiSettings[v14] = v15
                end
            else
                p10.Default_GuiSettings[v14] = p11[v14]
            end
        end
    end
    if p12 then
        local v16 = type(p12) == "table"
        assert(v16, "Expected table as parameter")
        for v17, v18 in u3 do
            if p12[v17] == nil then
                if p10.Default_FrameSettings[v17] == nil then
                    p10.Default_FrameSettings[v17] = v18
                end
            else
                p10.Default_FrameSettings[v17] = p12[v17]
            end
        end
    end
end
function u1.UpdateFaceSettings(p19, p20, p21, p22) --[[ Line: 136 ]]
    local v23 = p19.TargetParts[p20][p21]
    if v23 then
        local v24 = v23.SurfaceGui
        if v24 then
            if p19.GuiSettings[v24] == nil then
                p19.GuiSettings[v24] = {}
            end
            if p22 == nil then
                p19.GuiSettings[v24] = nil
            else
                local v25 = type(p22) == "table"
                assert(v25, "Expected table as parameter")
                for v26, v27 in p22 do
                    p19.GuiSettings[v24][v26] = v27
                end
            end
        else
            return
        end
    else
        return
    end
end
function u1.UpdateFrameSettings(p28, p29, p30) --[[ Line: 157 ]]
    if p28.FrameSettings[p29] == nil then
        p28.FrameSettings[p29] = {}
    end
    if p30 == nil then
        p28.FrameSettings[p29] = nil
    else
        local v31 = type(p30) == "table"
        assert(v31, "Expected table as parameter")
        for v32, v33 in p30 do
            p28.FrameSettings[p29][v32] = v33
        end
    end
end
local function u38(p34, p35) --[[ Line: 176 ]]
    local v36 = Vector3.new()
    local v37 = CFrame.new()
    if p34 == Enum.NormalId.Front then
        return p35.Size.Z / 2 * p35.CFrame.LookVector, CFrame.Angles(0, 0, 0)
    end
    if p34 == Enum.NormalId.Back then
        return p35.Size.Z / 2 * -p35.CFrame.LookVector, CFrame.Angles(0, 3.141592653589793, 0)
    end
    if p34 == Enum.NormalId.Left then
        return p35.Size.X / 2 * -p35.CFrame.RightVector, CFrame.Angles(0, 1.5707963267948966, 0)
    end
    if p34 == Enum.NormalId.Right then
        return p35.Size.X / 2 * p35.CFrame.RightVector, CFrame.Angles(0, -1.5707963267948966, 0)
    end
    if p34 == Enum.NormalId.Top then
        return p35.Size.Y / 2 * p35.CFrame.UpVector, CFrame.Angles(1.5707963267948966, 0, 0)
    end
    if p34 == Enum.NormalId.Bottom then
        v36 = p35.Size.Y / 2 * -p35.CFrame.UpVector
        v37 = CFrame.Angles(-1.5707963267948966, 0, 0)
    end
    return v36, v37
end
function rayToPlaneIntersection(p39, p40, p41, p42)
    return p40 - p39 * ((p40 - p42):Dot(p41) / p39:Dot(p41))
end
function calcParallax(p43, p44, p45)
    local v46 = p44.Position
    local v47 = p45.X
    if math.abs(v47) < 0.05 then
        return {
            ["horOffset"] = -p45.Z,
            ["verOffset"] = -p45.Y,
            ["parimgPoint"] = Vector3.new(),
            ["imgPoint"] = Vector3.new(),
            ["camPos"] = p43
        }
    end
    local v48 = v46 + p44.LookVector * p45.X + p44.UpVector * p45.Y + p44.RightVector * p45.Z
    local v49 = CFrame.lookAt(p43, v48).LookVector
    local v50 = rayToPlaneIntersection(v49, p43, p44.LookVector, v46)
    local v51 = rayToPlaneIntersection(v49, p43, p44.LookVector, v48)
    local v52 = (v50 - v46).Magnitude
    local v53 = rayToPlaneIntersection(p44.UpVector * -v52, v50, p44.UpVector, v46)
    local v54 = (v46 - v53).Magnitude
    if p44.RightVector:Dot(CFrame.lookAt(v46, v53).LookVector) > 0 then
        v54 = v54 * -1
    end
    local v55 = rayToPlaneIntersection(p44.RightVector * -v52, v50, p44.RightVector, v46)
    local v56 = (v46 - v55).Magnitude
    if p44.UpVector:Dot(CFrame.lookAt(v46, v55).LookVector) > 0 then
        v56 = v56 * -1
    end
    return {
        ["horOffset"] = v54,
        ["verOffset"] = v56,
        ["parimgPoint"] = v51,
        ["imgPoint"] = v50,
        ["camPos"] = p43
    }
end
function getSizeAndPosition(p57, p58, p59, p60)
    local v61 = p60.PixelsPerStud
    local v62 = (p57.camPos - p57.imgPoint).Magnitude
    local v63 = (p57.camPos - p57.parimgPoint).Magnitude
    local v64 = p59.ImageSize
    local v65 = Vector2.new(v64.X * v61, v64.Y * v61)
    local v66 = v62 / v63
    local v67
    if p58.SurfaceNormal == Enum.NormalId.Top then
        v67 = UDim2.new(0.5, p57.verOffset * v61, 0.5, -p57.horOffset * v61)
    elseif p58.SurfaceNormal == Enum.NormalId.Bottom then
        v67 = UDim2.new(0.5, -p57.verOffset * v61, 0.5, p57.horOffset * v61)
    else
        v67 = UDim2.new(0.5, p57.horOffset * v61, 0.5, p57.verOffset * v61)
    end
    return v67, UDim2.new(0, v65.X * v66, 0, v65.Y * v66)
end
function getParallax(p68, p69, p70, p71, p72)
    --[[
    Upvalues:
        [1] = u38
    --]]
    if p72 and p68 then
        local v73 = p70 or game.Workspace.CurrentCamera.CFrame.Position
        local v74 = p68.TargetPart
        local _ = p68.SurfaceNormal
        if not p71 then
            local v75, v76 = u38(p68.SurfaceNormal, v74)
            p71 = v74.CFrame * CFrame.new(v75) * v76
        end
        local v77 = calcParallax(v73, p71, p72)
        local v78, v79 = getSizeAndPosition(v77, p68, p69, p68.SurfaceGui)
        return v78, v79
    end
end
function SetUpSurface(p80, p81, p82)
    local v83 = Instance.new("SurfaceGui")
    v83.ResetOnSpawn = false
    v83.ClipsDescendants = true
    v83.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v83.Parent = p82.GuiFolder
    v83.Adornee = p80
    v83.Face = p81
    v83.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    v83.PixelsPerStud = 100
    v83.Enabled = true
    local v84 = Instance.new("CanvasGroup")
    v84.BackgroundTransparency = 1
    v84.Size = UDim2.new(1, 0, 1, 0)
    v84.Parent = v83
    return v83
end
function SetUpFrame(p85)
    local v86 = Instance.new("ImageLabel")
    v86.Size = UDim2.new(1, 0, 1, 0)
    v86.AnchorPoint = Vector2.new(0.5, 0.5)
    v86.Position = UDim2.new(0.5, 0, 0.5, 0)
    v86.BackgroundTransparency = 1
    v86.Name = "ScaleFrame"
    v86.Parent = p85:FindFirstChildWhichIsA("CanvasGroup") or p85
    return v86
end
function u1.AddFace(p87, p88, p89) --[[ Line: 340 ]]
    if p89 == nil then
        p89 = Enum.NormalId.Front
    end
    if p87.TargetParts[p88] == nil then
        p87.TargetParts[p88] = {}
    end
    local v90 = SetUpSurface(p88, p89, p87)
    p87.GuiSettings[v90] = table.clone(p87.Default_GuiSettings)
    local v91 = {
        ["SurfaceNormal"] = p89,
        ["SurfaceGui"] = v90,
        ["TargetPart"] = p88,
        ["Frames"] = {},
        ["LastUpdate"] = 0,
        ["Visible"] = false,
        ["Framerate"] = 1
    }
    if p87.TargetParts[p88][p89] == nil then
        p87.TargetParts[p88][p89] = {}
    end
    p87.TargetParts[p88][p89] = v91
    return v90
end
function u1.AddFrame(p92, p93, p94, p95) --[[ Line: 367 ]]
    if p94 == nil then
        p94 = Enum.NormalId.Front
    end
    if p92.TargetParts[p93] == nil then
        p92.TargetParts[p93] = {}
    end
    local v96 = p92.TargetParts[p93][p94]
    if not v96 then
        p92:AddFace(p93, p94)
        v96 = p92.TargetParts[p93][p94]
    end
    local v97 = v96.SurfaceGui
    local v98 = SetUpFrame(v97, p94, p92)
    p92.FrameSettings[v98] = table.clone(p92.Default_FrameSettings)
    if p95 then
        for _, v99 in p95 do
            v99.Parent = v98
        end
    end
    local v100 = p92.TargetParts[p93][p94].Frames
    table.insert(v100, {
        ["SurfaceNormal"] = p94,
        ["SurfaceGui"] = v97,
        ["TargetPart"] = p93,
        ["Frame"] = v98
    })
    return v98
end
function u1.RemoveFace(p101, p102, p103) --[[ Line: 402 ]]
    if p103 == nil then
        p103 = Enum.NormalId.Front
    end
    if p101.TargetParts[p102] == nil then
        return
    else
        local v104 = p101.TargetParts[p102][p103]
        if v104 ~= nil then
            p101.GuiSettings[v104.SurfaceGui] = nil
            v104.SurfaceGui:Destroy()
            p101.TargetParts[p102][p103] = nil
            if next(p101.TargetParts[p102]) == nil then
                p101.TargetParts[p102] = nil
            end
        end
    end
end
function u1.Clear(p105) --[[ Line: 418 ]]
    for _, v106 in p105.TargetParts do
        for _, v107 in v106 do
            v107.SurfaceGui:Destroy()
        end
    end
    table.clear(p105.GuiSettings)
    table.clear(p105.FrameSettings)
    table.clear(p105.TargetParts)
end
function GetVectorFromNormal(p108, p109)
    if p109 == Enum.NormalId.Front then
        return p108.LookVector
    end
    if p109 == Enum.NormalId.Right then
        return p108.RightVector
    end
    if p109 == Enum.NormalId.Top then
        return p108.UpVector
    end
    if p109 == Enum.NormalId.Back then
        return -p108.LookVector
    end
    if p109 == Enum.NormalId.Left then
        return -p108.RightVector
    end
    if p109 == Enum.NormalId.Bottom then
        return -p108.UpVector
    end
end
function GetCorners(p110, p111, p112)
    local v113 = p110.Size
    local v114 = p110.CFrame
    local v115 = v114.UpVector
    local v116 = v114.RightVector
    local v117 = v114.LookVector
    if p112 == Enum.NormalId.Front or p112 == Enum.NormalId.Back then
        return {
            p111,
            p111 - v115 * v113.Y / 2 - v116 * v113.X / 2,
            p111 - v115 * v113.Y / 2 + v116 * v113.X / 2,
            p111 + v115 * v113.Y / 2 - v116 * v113.X / 2,
            p111 + v115 * v113.Y / 2 + v116 * v113.X / 2
        }
    end
    if p112 == Enum.NormalId.Right or p112 == Enum.NormalId.Left then
        return {
            p111,
            p111 - v115 * v113.Y / 2 - v117 * v113.Z / 2,
            p111 - v115 * v113.Y / 2 + v117 * v113.Z / 2,
            p111 + v115 * v113.Y / 2 - v117 * v113.Z / 2,
            p111 + v115 * v113.Y / 2 + v117 * v113.Z / 2
        }
    end
    if p112 == Enum.NormalId.Top or p112 == Enum.NormalId.Bottom then
        return {
            p111,
            p111 - v116 * v113.X / 2 - v117 * v113.Z / 2,
            p111 - v116 * v113.X / 2 + v117 * v113.Z / 2,
            p111 + v116 * v113.X / 2 - v117 * v113.Z / 2,
            p111 + v116 * v113.X / 2 + v117 * v113.Z / 2
        }
    end
end
function CanSee(p118, p119, p120, p121)
    if GetVectorFromNormal(p119.CFrame, p121):Dot(CFrame.lookAt(p120.Position, p118.CFrame.Position).LookVector) <= 0 then
        return false
    end
    for _, v122 in GetCorners(p119, p120.Position, p121) do
        local _, v123 = p118:WorldToScreenPoint(v122)
        if v123 then
            return true
        end
    end
    return false
end
function u1.Step(p124) --[[ Line: 503 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u38
    --]]
    u7(p124)
    local v125 = os.clock() - p124.LastStep
    p124.LastStep = os.clock()
    local v126 = game.Workspace.CurrentCamera
    local v127 = v126.CFrame.Position
    local v128 = p124.Default_GuiSettings
    local v129 = p124.Default_FrameSettings
    for v130, _ in p124.FrameSettings do
        if not v130:IsDescendantOf(p124.GuiFolder) then
            p124.FrameSettings[v130] = nil
        end
    end
    local v131 = p124.MaxUpdates
    local v132 = {}
    local v133 = 0
    for v134, v135 in p124.TargetParts do
        if not v134:IsDescendantOf(game) then
            for _, v136 in v135 do
                p124.GuiSettings[v136.SurfaceGui] = nil
                v136.SurfaceGui:Destroy()
            end
            p124.TargetParts[v134] = nil
        end
        for _, v137 in v135 do
            local v138 = v137.SurfaceGui
            if v138 then
                local v139, v140 = u38(v137.SurfaceNormal, v134)
                local v141 = (v134.CFrame + v139) * v140
                local v142 = v137.SurfaceNormal
                local v143 = CanSee(v126, v134, v141, v142) or false
                v137.Visible = v143
                if v143 then
                    local v144 = {}
                    if p124.GuiSettings[v138] ~= nil then
                        for v145, v146 in v128 do
                            v144[v145] = p124.GuiSettings[v138][v145] or v146
                        end
                    end
                    local _ = next(v144) == nil
                    local v147 = (v141.Position - v127).Magnitude
                    if (v144.MinUpdateDistance >= v147 or v144.MinFramerate > 0) and v144.MaxDistance >= v147 then
                        local v148 = v144.MinFramerate
                        local v149 = v144.MaxFramerate - v144.MinFramerate
                        local v150 = 1 - (v147 - v144.MaxUpdateDistance) / v144.MinUpdateDistance
                        local v151 = v148 + v149 * math.clamp(v150, 0, 1)
                        if not v137.Visible then
                            v151 = v151 / v144.LazyCheckingModifier
                        end
                        local v152 = 1 / v151
                        local v153 = v144.MaxFramerate < 0 and -1 or v152
                        v137.LastUpdate = v137.LastUpdate + v125
                        table.insert(v132, {
                            v134,
                            v137,
                            v144,
                            {
                                v139,
                                v140,
                                v141,
                                v142,
                                v147
                            },
                            v153
                        })
                    end
                end
            end
        end
    end
    table.sort(v132, function(p154, p155) --[[ Line: 593 ]]
        return p154[2].LastUpdate / p154[5] > p155[2].LastUpdate / p155[5]
    end)
    for _, v156 in v132 do
        local _ = v156[1]
        local v157 = v156[2]
        local v158 = v156[3]
        if v131 <= v133 and v131 >= 0 then
            break
        end
        local v159 = v157.SurfaceGui
        local _ = v156[4][1]
        local _ = v156[4][2]
        local v160 = v156[4][3]
        local _ = v156[4][4]
        local v161 = v156[4][5]
        v157.LastUpdate = 0
        v159.ZOffset = v158.ZOffset
        v159.AlwaysOnTop = v158.AlwaysOnTop
        v159.Brightness = v158.Brightness
        v159.LightInfluence = v158.LightInfluence
        v159.MaxDistance = v158.MaxDistance
        v159.PixelsPerStud = v158.PixelsPerStud
        v159.SizingMode = v158.SizingMode
        if v158.MinUpdateDistance < v161 and v158.MinFramerate <= 0 or v158.MaxDistance < v161 then
            print("Die")
        else
            v133 = v133 + 1
            for v162, v163 in v157.Frames do
                local v164 = v163.Frame
                if v164 and v164:IsDescendantOf(p124.GuiFolder) then
                    local v165 = {}
                    if p124.FrameSettings[v164] ~= nil then
                        for v166, v167 in v129 do
                            v165[v166] = p124.FrameSettings[v164][v166] or v167
                        end
                    end
                    local _ = next(v165) == nil
                    if v165.UpdateRange >= v161 then
                        v164.ZIndex = v165.ZIndex
                        v164.Image = v165.Image
                        v164.Rotation = v165.Rotation
                        v164.ImageTransparency = v165.ImageTransparency
                        v164.BackgroundTransparency = v165.BackgroundTransparency
                        v164.ImageColor3 = v165.ImageColor3
                        v164.BackgroundColor3 = v165.BackgroundColor3
                        v164.ResampleMode = v165.ResampleMode
                        v164.ScaleType = v165.ScaleType
                        v164.TileSize = v165.TileSize
                        v164.Interactable = v165.Interactable
                        v164.Active = v165.Active
                        local v168, v169 = getParallax(v157, v165, v127, v160, v165.PosOffset)
                        v164.Position = v168 + v165.ExtraOffset or UDim2.new(0.5, 0, 0.5, 0) + v165.ExtraOffset
                        v164.Size = v169 or UDim2.new(1, 0, 1, 0)
                    end
                else
                    table.remove(v157.Frames, v162)
                end
            end
        end
    end
end
function u1.ComputeStep(p170) --[[ Line: 705 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    local v171
    if p170.GuiFolder == nil then
        local v172 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ParallaxWindows_SurfaceGuis")
        if v172 == nil then
            v171 = true
        else
            p170.GuiFolder = v172
            v171 = nil
        end
    else
        v171 = nil
    end
    if v171 then
        return
    end
    local v173 = os.clock() - p170.LastStep
    p170.LastStep = os.clock()
    local v174 = game.Workspace.CurrentCamera
    local v175 = v174.CFrame.Position
    local v176 = p170.Default_GuiSettings
    local v177 = p170.Default_FrameSettings
    local v178 = {}
    for v179, _ in p170.FrameSettings do
        if not v179:IsDescendantOf(p170.GuiFolder) then
            p170.FrameSettings[v179] = nil
        end
    end
    local v180 = p170.MaxUpdates
    local v181 = {}
    local v182 = 0
    for v183, v184 in p170.TargetParts do
        if not v183:IsDescendantOf(game) then
            for _, v185 in v184 do
                p170.GuiSettings[v185.SurfaceGui] = nil
                v185.SurfaceGui:Destroy()
            end
            p170.TargetParts[v183] = nil
        end
        for _, v186 in v184 do
            local v187 = v186.SurfaceGui
            if v187 then
                local v188, v189 = u38(v186.SurfaceNormal, v183)
                local v190 = (v183.CFrame + v188) * v189
                local v191 = v186.SurfaceNormal
                local v192 = CanSee(v174, v183, v190, v191) or false
                v186.Visible = v192
                if v192 then
                    local v193 = {}
                    if p170.GuiSettings[v187] ~= nil then
                        for v194, v195 in v176 do
                            v193[v194] = p170.GuiSettings[v187][v194] or v195
                        end
                    end
                    local _ = next(v193) == nil
                    local v196 = (v190.Position - v175).Magnitude
                    if (v193.MinUpdateDistance >= v196 or v193.MinFramerate > 0) and v193.MaxDistance >= v196 then
                        local v197 = v193.MinFramerate
                        local v198 = v193.MaxFramerate - v193.MinFramerate
                        local v199 = 1 - (v196 - v193.MaxUpdateDistance) / v193.MinUpdateDistance
                        local v200 = v197 + v198 * math.clamp(v199, 0, 1)
                        if not v186.Visible then
                            v200 = v200 / v193.LazyCheckingModifier
                        end
                        local v201 = 1 / v200
                        local v202 = v193.MaxFramerate < 0 and -1 or v201
                        v186.LastUpdate = v186.LastUpdate + v173
                        table.insert(v181, {
                            v183,
                            v186,
                            v193,
                            {
                                v188,
                                v189,
                                v190,
                                v191,
                                v196
                            },
                            v202
                        })
                    end
                end
            end
        end
    end
    table.sort(v181, function(p203, p204) --[[ Line: 798 ]]
        return p203[2].LastUpdate / p203[5] > p204[2].LastUpdate / p204[5]
    end)
    for _, v205 in v181 do
        local _ = v205[1]
        local v206 = v205[2]
        local v207 = v205[3]
        if v180 <= v182 and v180 >= 0 then
            break
        end
        local v208 = v206.SurfaceGui
        local _ = v205[4][1]
        local _ = v205[4][2]
        local v209 = v205[4][3]
        local _ = v205[4][4]
        local v210 = v205[4][5]
        table.insert(v178, {
            ["istype"] = "surface",
            ["surfaceGui"] = v208,
            ["GuiSettings"] = v207
        })
        v206.LastUpdate = 0
        if (v207.MinUpdateDistance >= v210 or v207.MinFramerate > 0) and v207.MaxDistance >= v210 then
            v182 = v182 + 1
            for v211, v212 in v206.Frames do
                local v213 = v212.Frame
                if v213 and v213:IsDescendantOf(p170.GuiFolder) then
                    local v214 = {}
                    if p170.FrameSettings[v213] ~= nil then
                        for v215, v216 in v177 do
                            v214[v215] = p170.FrameSettings[v213][v215] or v216
                        end
                    end
                    local _ = next(v214) == nil
                    if v214.UpdateRange >= v210 then
                        local v217, v218 = getParallax(v206, v214, v175, v209, v214.PosOffset)
                        local v219 = {
                            ["istype"] = "frame",
                            ["frame"] = v213,
                            ["Position"] = v217 + v214.ExtraOffset or UDim2.new(0.5, 0, 0.5, 0) + v214.ExtraOffset,
                            ["Size"] = v218 or UDim2.new(1, 0, 1, 0),
                            ["frameSettings"] = v214
                        }
                        table.insert(v178, v219)
                    end
                else
                    table.remove(v206.Frames, v211)
                end
            end
        end
    end
    return v178
end
function u1.ApplyStep(p220, p221) --[[ Line: 868 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p221 ~= nil and #p221 > 0 then
        u7(p220)
        local _ = p220.Default_GuiSettings
        local _ = p220.Default_FrameSettings
        for _, v222 in p221 do
            if v222.istype == "frame" then
                local v223 = v222.frame
                if v223 and v223:IsDescendantOf(p220.GuiFolder) then
                    local v224 = v222.frameSettings
                    v223.ZIndex = v224.ZIndex
                    v223.Image = v224.Image
                    v223.Rotation = v224.Rotation
                    v223.ImageTransparency = v224.ImageTransparency
                    v223.BackgroundTransparency = v224.BackgroundTransparency
                    v223.ImageColor3 = v224.ImageColor3
                    v223.BackgroundColor3 = v224.BackgroundColor3
                    v223.ResampleMode = v224.ResampleMode
                    v223.ScaleType = v224.ScaleType
                    v223.TileSize = v224.TileSize
                    v223.Interactable = v224.Interactable
                    v223.Active = false
                    v223.Position = v222.Position
                    v223.Size = v222.Size
                end
            elseif v222.istype == "surface" then
                local v225 = v222.surfaceGui
                local v226 = v222.GuiSettings
                v225.ZOffset = v226.ZOffset
                v225.AlwaysOnTop = v226.AlwaysOnTop
                v225.Brightness = v226.Brightness
                v225.LightInfluence = v226.LightInfluence
                v225.MaxDistance = v226.MaxDistance
                v225.PixelsPerStud = v226.PixelsPerStud
                v225.SizingMode = v226.SizingMode
            end
        end
    end
end
return u1