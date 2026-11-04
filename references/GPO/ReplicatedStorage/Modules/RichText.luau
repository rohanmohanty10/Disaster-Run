 

local u1 = {}
local u2 = {
    ["Color"] = "TextColor3",
    ["StrokeColor"] = "TextStrokeColor3",
    ["ImageColor"] = "ImageColor3"
}
u1.ColorShortcuts = {}
u1.ColorShortcuts.White = Color3.new(1, 1, 1)
u1.ColorShortcuts.Black = Color3.fromRGB(50, 50, 50)
u1.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4)
u1.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4)
u1.ColorShortcuts.Purple = Color3.new(1, 0, 1)
u1.ColorShortcuts.Blue = Color3.new(0.55, 0.6, 1)
u1.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1)
u1.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2)
u1.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2)
u1.ColorShortcuts.ZBlue = Color3.new(0.160784, 1, 0.933333)
u1.ColorShortcuts.Arise = Color3.new(0.333333, 0.333333, 1)
u1.ColorShortcuts.Pink = Color3.new(1, 0.607843, 0.760784)
u1.ImageShortcuts = {}
u1.ImageShortcuts.Eggplant = 639588687
u1.ImageShortcuts.Thinking = 955646496
u1.ImageShortcuts.Sad = 947900188
u1.ImageShortcuts.Happy = 414889555
u1.ImageShortcuts.Despicable = 711674643
local u3 = {
    ["ContainerHorizontalAlignment"] = "Left",
    ["ContainerVerticalAlignment"] = "Top",
    ["TextYAlignment"] = "Bottom",
    ["TextScaled"] = true,
    ["TextScaleRelativeTo"] = "Frame",
    ["TextScale"] = 0.25,
    ["TextSize"] = 20,
    ["Font"] = script.t.Font,
    ["FontFace"] = script.t.FontFace,
    ["TextColor3"] = "White",
    ["TextStrokeColor3"] = "Black",
    ["TextTransparency"] = 0,
    ["TextStrokeTransparency"] = 0,
    ["BackgroundTransparency"] = 1,
    ["TextWrapped"] = true,
    ["BorderSizePixel"] = 0,
    ["AutoLocalize"] = false,
    ["ImageColor3"] = "White",
    ["ImageTransparency"] = 0,
    ["ImageRectOffset"] = "0,0",
    ["ImageRectSize"] = "0,0",
    ["AnimateStepTime"] = 0,
    ["AnimateStepGrouping"] = "Letter",
    ["AnimateStepFrequency"] = 4,
    ["AnimateYield"] = 0,
    ["AnimateStyle"] = "SizeT",
    ["AnimateStyleTime"] = 0.3,
    ["AnimateStyleNumPeriods"] = 1,
    ["AnimateStyleAmplitude"] = 0.5
}
local u4 = {
    ["TextYAlignment"] = "TextLabel",
    ["TextScaled"] = "TextLabel",
    ["TextWrapped"] = "TextLabel",
    ["TextSize"] = "TextLabel",
    ["Font"] = "TextLabel",
    ["TextColor3"] = "TextLabel",
    ["TextStrokeColor3"] = "TextLabel",
    ["TextStrokeTransparency"] = "TextLabel",
    ["TextTransparency"] = "TextLabel",
    ["BackgroundTransparency"] = "GuiObject",
    ["BorderSizePixel"] = "GuiObject",
    ["ImageColor3"] = "ImageLabel",
    ["ImageTransparency"] = "ImageLabel",
    ["ImageRectOffset"] = "ImageLabel",
    ["ImageRectSize"] = "ImageLabel"
}
local u32 = {
    ["Appear"] = function(p5) --[[ Name: Appear, Line 252 ]]
        p5.Visible = true
    end,
    ["SizeT"] = function(p6, _, _) --[[ Name: SizeT, Line 256 ]]
        if p6.Name ~= "sized" and p6:IsA("TextLabel") then
            local v7 = p6.TextSize
            p6.Visible = true
            p6.Name = "sized"
            p6.TextSize = 0
            _G.tween(p6, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["TextSize"] = v7
            })
        end
    end,
    ["Fade"] = function(p8, p9, p10) --[[ Name: Fade, Line 267 ]]
        p8.Visible = true
        if p8:IsA("TextLabel") then
            p8.TextTransparency = 1 - p9 * (1 - p10.TextTransparency)
        elseif p8:IsA("ImageLabel") then
            p8.ImageTransparency = 1 - p9 * (1 - p10.ImageTransparency)
        end
    end,
    ["Wiggle"] = function(p11, p12, p13) --[[ Name: Wiggle, Line 276 ]]
        p11.Visible = true
        local v14 = p13.InitialSize.Y.Offset * (1 - p12) * p13.AnimateStyleAmplitude
        local v15 = p13.InitialPosition
        local v16 = UDim2.new
        local v17 = p12 * 3.141592653589793 * 2 * p13.AnimateStyleNumPeriods
        p11.Position = v15 + v16(0, 0, 0, math.sin(v17) * v14 / 2)
    end,
    ["Swing"] = function(p18, p19, p20) --[[ Name: Swing, Line 282 ]]
        p18.Visible = true
        local v21 = 90 * (1 - p19) * p20.AnimateStyleAmplitude
        local v22 = p19 * 3.141592653589793 * 2 * p20.AnimateStyleNumPeriods
        p18.Rotation = math.sin(v22) * v21
    end,
    ["Spin"] = function(p23, p24, p25) --[[ Name: Spin, Line 288 ]]
        p23.Visible = true
        p23.Position = p25.InitialPosition + UDim2.new(0, p25.InitialSize.X.Offset / 2, 0, p25.InitialSize.Y.Offset / 2)
        p23.AnchorPoint = Vector2.new(0.5, 0.5)
        p23.Rotation = p24 * p25.AnimateStyleNumPeriods * 360
    end,
    ["Rainbow"] = function(p26, p27, p28) --[[ Name: Rainbow, Line 295 ]]
        p26.Visible = true
        local v29 = Color3.fromHSV(p27 * p28.AnimateStyleNumPeriods % 1, 1, 1)
        if p26:IsA("TextLabel") then
            local v30 = getColorFromString(p28.TextColor3)
            p26.TextColor3 = Color3.new(v29.r + p27 * (v30.r - v29.r), v29.g + p27 * (v30.g - v29.g), v29.b + p27 * (v30.b - v29.b))
        else
            local v31 = getColorFromString(p28.ImageColor3)
            p26.ImageColor3 = Color3.new(v29.r + p27 * (v31.r - v29.r), v29.g + p27 * (v31.g - v29.g), v29.b + p27 * (v31.b - v29.b))
        end
    end
}
local u33 = game:GetService("TextService")
local u34 = game:GetService("RunService")
local u35 = 0
function getLayerCollector(p36)
    if p36 then
        if p36:IsA("LayerCollector") then
            return p36
        elseif p36 and p36.Parent then
            return getLayerCollector(p36.Parent)
        else
            return nil
        end
    else
        return nil
    end
end
function shallowCopy(p37)
    local v38 = {}
    for v39, v40 in pairs(p37) do
        v38[v39] = v40
    end
    return v38
end
function getColorFromString(p41)
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1.ColorShortcuts[p41] then
        return u1.ColorShortcuts[p41]
    end
    local v42, v43, v44 = p41:match("(%d+),(%d+),(%d+)")
    return Color3.new(v42 / 255, v43 / 255, v44 / 255)
end
function getVector2FromString(p45)
    local v46, v47 = p45:match("(%d+),(%d+)")
    return Vector2.new(v46, v47)
end
function setHorizontalAlignment(p48, p49)
    if p49 == "Left" then
        p48.AnchorPoint = Vector2.new(0, 0)
        p48.Position = UDim2.new(0, 0, 0, 0)
        return
    elseif p49 == "Center" then
        p48.AnchorPoint = Vector2.new(0.5, 0)
        p48.Position = UDim2.new(0.5, 0, 0, 0)
    elseif p49 == "Right" then
        p48.AnchorPoint = Vector2.new(1, 0)
        p48.Position = UDim2.new(1, 0, 0, 0)
    end
end
function u1.New(_, u50, p51, p52, p53, p54) --[[ Line: 361 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u33
        [4] = u1
        [5] = u35
        [6] = u34
        [7] = u32
        [8] = u4
    --]]
    for _, v55 in pairs(u50:GetChildren()) do
        v55:Destroy()
    end
    local u56 = p53 == nil and true or p53
    local u57 = {}
    local u58 = {}
    if p54 then
        p51 = p54.Text
        p52 = p54.StartingProperties
    end
    local u59 = {}
    local u60 = {}
    local u61 = {}
    local u62 = 0
    local u63 = false
    local u64 = Instance.new("TextLabel")
    local u65 = Instance.new("ImageLabel")
    local u66 = getLayerCollector(u50)
    local u67 = nil
    local u68 = nil
    local function u72(p69, p70) --[[ Line: 388 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u58
            [3] = u57
            [4] = u67
            [5] = u59
            [6] = u3
            [7] = u68
        --]]
        local v71 = u2[p69] or p69
        if p70 == "/" and u58[v71] then
            p70 = u58[v71]
        end
        if tonumber(p70) then
            p70 = tonumber(p70)
        elseif p70 == "false" or p70 == "true" then
            p70 = p70 == "true"
        end
        u57[v71] = p70
        if not u67(v71, p70) then
            if v71 == "ContainerHorizontalAlignment" and u59[#u59] then
                setHorizontalAlignment(u59[#u59].Container, p70)
            elseif not u3[v71] then
                if v71 ~= "Img" then
                    return false
                end
                u68(p70)
            end
        end
        return true
    end
    u67 = function(u73, p74, p75) --[[ Name: applyProperty, Line 419 ]]
        --[[
        Upvalues:
            [1] = u64
            [2] = u65
        --]]
        local u76 = nil
        local v77 = false
        for _, u78 in p75 and { p75 } or { u64, u65 } do
            if pcall(function() --[[ Line: 423 ]]
                --[[
                Upvalues:
                    [1] = u76
                    [2] = u78
                    [3] = u73
                --]]
                local v79 = u78[u73]
                u76 = typeof(v79)
            end) then
                if u76 == "Color3" then
                    u78[u73] = getColorFromString(p74)
                    v77 = true
                elseif u76 == "Vector2" then
                    u78[u73] = getVector2FromString(p74)
                    v77 = true
                else
                    u78[u73] = p74
                    v77 = true
                end
            end
            if u73 == "Rare" and script.Folder:FindFirstChild(p74) then
                local v80 = script.Folder:FindFirstChild(p74):Clone()
                v80.Parent = u78
                v80.Name = "UIG"
                v77 = true
            end
            if u73 == "Rare" and p74 == "/" then
                if u78:FindFirstChild("UIG") then
                    u78.UIG:Destroy()
                end
                v77 = true
            end
        end
        return v77
    end
    local u81 = u67
    for v82, v83 in pairs(u3) do
        u72(v82, v83)
        u58[u2[v82] or v82] = u57[u2[v82] or v82]
    end
    for v84, v85 in pairs(p52 or {}) do
        u72(v84, v85)
        u58[u2[v84] or v84] = u57[u2[v84] or v84]
    end
    if p54 then
        u57 = p54.OverflowPickupProperties
        for v86, v87 in pairs(u57) do
            u72(v86, v87)
        end
    end
    local u88 = 0
    local function u97() --[[ Line: 482 ]]
        --[[
        Upvalues:
            [1] = u59
            [2] = u88
            [3] = u56
            [4] = u57
            [5] = u66
            [6] = u50
            [7] = u63
            [8] = u60
            [9] = u62
        --]]
        local v89 = u59[#u59]
        if v89 then
            u88 = u88 + v89.Size.Y.Offset
            if not u56 then
                local v90 = u88
                local v91
                if u57.TextScaled == true then
                    local v92 = nil
                    if u57.TextScaleRelativeTo == "Screen" then
                        v92 = u66.AbsoluteSize.Y
                    elseif u57.TextScaleRelativeTo == "Frame" then
                        v92 = u50.AbsoluteSize.Y
                    end
                    local v93 = u57.TextScale * v92
                    v91 = math.min(v93, 100)
                else
                    v91 = u57.TextSize
                end
                if v90 + v91 > u50.AbsoluteSize.Y then
                    u63 = true
                    return
                end
            end
        end
        local v94 = Instance.new("Frame")
        v94.Name = string.format("Line%03d", #u59 + 1)
        v94.Size = UDim2.new(0, 0, 0, 0)
        v94.BackgroundTransparency = 1
        local v95 = Instance.new("Frame", v94)
        v95.Name = "Container"
        v95.Size = UDim2.new(0, 0, 0, 0)
        v95.BackgroundTransparency = 1
        setHorizontalAlignment(v95, u57.ContainerHorizontalAlignment)
        v94.Parent = u50
        local v96 = u59
        table.insert(v96, v94)
        u60[#u59] = {}
        u62 = 0
    end
    u97()
    local function u109(p98, p99, p100, p101) --[[ Line: 515 ]]
        --[[
        Upvalues:
            [1] = u59
            [2] = u57
            [3] = u62
            [4] = u50
            [5] = u60
            [6] = u97
            [7] = u61
        --]]
        local v102 = u59[#u59]
        local v103 = u57.TextYAlignment
        local v104 = tostring(v103)
        if v104 == "Top" then
            p98.Position = UDim2.new(0, u62, 0, 0)
            p98.AnchorPoint = Vector2.new(0, 0)
        elseif v104 == "Center" then
            p98.Position = UDim2.new(0, u62, 0.5, 0)
            p98.AnchorPoint = Vector2.new(0, 0.5)
        elseif v104 == "Bottom" then
            p98.Position = UDim2.new(0, u62, 1, 0)
            p98.AnchorPoint = Vector2.new(0, 1)
        end
        u62 = u62 + p100
        if u62 > u50.AbsoluteSize.X and u62 ~= p100 then
            p98:Destroy()
            local v105 = u60[#u59][#u60[#u59]]
            if v105:IsA("TextLabel") and v105.Text == " " then
                v102.Container.Size = UDim2.new(0, u62 - p100 - v105.Size.X.Offset, 1, 0)
                v105:Destroy()
                table.remove(u60[#u59])
            end
            u97()
            p101()
        else
            p98.Size = UDim2.new(0, p100, 0, p99)
            v102.Container.Size = UDim2.new(0, u62, 1, 0)
            local v106 = UDim2.new
            local v107 = v102.Size.Y.Offset
            v102.Size = v106(1, 0, 0, (math.max(v107, p99)))
            p98.Name = string.format("Group%03d", #u60[#u59] + 1)
            p98.Parent = v102.Container
            local v108 = u60[#u59]
            table.insert(v108, p98)
            u61[p98] = shallowCopy(u57)
            u61[p98].InitialSize = p98.Size
            u61[p98].InitialPosition = p98.Position
            u61[p98].InitialAnchorPoint = p98.AnchorPoint
            u57.AnimateYield = 0
        end
    end
    local function u128(u110) --[[ Line: 555 ]]
        --[[
        Upvalues:
            [1] = u97
            [2] = u62
            [3] = u57
            [4] = u66
            [5] = u50
            [6] = u64
            [7] = u33
            [8] = u61
            [9] = u109
            [10] = u63
            [11] = u128
        --]]
        if u110 == "\n" then
            u97()
            return
        elseif u110 ~= " " or u62 ~= 0 then
            local u111
            if u57.TextScaled == true then
                local v112 = nil
                if u57.TextScaleRelativeTo == "Screen" then
                    v112 = u66.AbsoluteSize.Y
                elseif u57.TextScaleRelativeTo == "Frame" then
                    v112 = u50.AbsoluteSize.Y
                end
                local v113 = u57.TextScale * v112
                u111 = math.min(v113, 100)
            else
                u111 = u57.TextSize
            end
            local function v118(u114) --[[ Line: 565 ]]
                --[[
                Upvalues:
                    [1] = u64
                    [2] = u111
                    [3] = u66
                    [4] = u33
                --]]
                local u115 = nil
                local _, _ = pcall(function() --[[ Line: 568 ]]
                    --[[
                    Upvalues:
                        [1] = u114
                        [2] = u64
                        [3] = u111
                        [4] = u66
                        [5] = u115
                        [6] = u33
                    --]]
                    local v116 = Instance.new("GetTextBoundsParams")
                    v116.Text = u114
                    if u64.Font == Enum.Font.Unknown then
                        v116.Font = Font.new(u64.FontFace.Family)
                    else
                        v116.Font = u64.Font
                    end
                    v116.Size = u111
                    v116.Width = Vector2.new(u66.AbsoluteSize.X, u111).X
                    u115 = u33:GetTextBoundsAsync(v116).X
                end)
                local v117
                if u115 == nil then
                    u115 = u33:GetTextSize(u114, u111, Enum.Font.SourceSans, Vector2.new(u66.AbsoluteSize.X, u111)).X
                    v117 = u115
                else
                    v117 = u115
                end
                return v117
            end
            local v119 = v118(u110)
            local v120 = u64:Clone()
            v120.TextScaled = false
            v120.TextSize = u111
            v120.Text = u110
            v120.TextTransparency = 1
            v120.TextStrokeTransparency = 1
            v120.TextWrapped = false
            local v121 = 0
            local v122 = 1
            for v123, v124 in utf8.graphemes(u110) do
                local v125 = string.sub(u110, v123, v124)
                local v126 = v118(v125)
                local v127 = u64:Clone()
                v127.Text = v125
                v127.TextScaled = false
                v127.TextWrapped = false
                v127.TextSize = u111
                v127.Position = UDim2.new(0, v121, 0, 0)
                v127.Size = UDim2.new(0, v126, 0, u111)
                v127.Name = string.format("Char%03d", v122)
                v127.Parent = v120
                v127.Visible = false
                u61[v127] = shallowCopy(u57)
                u61[v127].InitialSize = v127.Size
                u61[v127].InitialPosition = v127.Position
                u61[v127].InitialAnchorPoint = v127.AnchorPoint
                v121 = v121 + v126
                v122 = v122 + 1
            end
            u109(v120, u111, v119, function() --[[ Line: 622 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u128
                    [3] = u110
                --]]
                if not u63 then
                    u128(u110)
                end
            end)
        end
    end
    u68 = function(u129) --[[ Name: printImage, Line 625 ]]
        --[[
        Upvalues:
            [1] = u57
            [2] = u66
            [3] = u50
            [4] = u65
            [5] = u1
            [6] = u109
            [7] = u63
            [8] = u68
        --]]
        local v130
        if u57.TextScaled == true then
            local v131 = nil
            if u57.TextScaleRelativeTo == "Screen" then
                v131 = u66.AbsoluteSize.Y
            elseif u57.TextScaleRelativeTo == "Frame" then
                v131 = u50.AbsoluteSize.Y
            end
            local v132 = u57.TextScale * v131
            v130 = math.min(v132, 100)
        else
            v130 = u57.TextSize
        end
        local v133 = u65:Clone()
        if u1.ImageShortcuts[u129] then
            local v134 = u1.ImageShortcuts[u129]
            v133.Image = typeof(v134) == "number" and "rbxassetid://" .. u1.ImageShortcuts[u129] or u1.ImageShortcuts[u129]
        else
            v133.Image = "rbxassetid://" .. u129
        end
        v133.Size = UDim2.new(0, v130, 0, v130)
        v133.Visible = false
        u109(v133, v130, v130, function() --[[ Line: 639 ]]
            --[[
            Upvalues:
                [1] = u63
                [2] = u68
                [3] = u129
            --]]
            if not u63 then
                u68(u129)
            end
        end)
    end
    local function v139(p135) --[[ Line: 642 ]]
        --[[
        Upvalues:
            [1] = u72
            [2] = u128
        --]]
        for _, v136 in pairs(p135) do
            local v137, v138 = string.match(v136, "<(.+)=(.+)>")
            if v137 and v138 then
                if not u72(v137, v138) then
                    warn("Could not apply markup: ", v136)
                end
            else
                u128(v136)
            end
        end
    end
    local v140 = #p51
    local v141 = {}
    local v142
    if p54 then
        v142 = p54.OverflowPickupIndex
    else
        v142 = 1
    end
    while true do
        if not v142 or v142 > v140 then
            v143 = v142
            break
        end
        local v143, v144 = string.find(p51, "<.->", v142)
        local v145, v146 = string.find(p51, "[ \t\n]", v142)
        local v147
        if v143 and (v144 and (not v145 or v143 < v145)) then
            v147 = nil
        else
            v143 = v145 or v140 + 1
            v144 = v146 or v140 + 1
            v147 = true
        end
        local v148
        if v142 < v143 then
            local v149 = v143 - 1
            v148 = string.sub(p51, v142, v149) or nil
        else
            v148 = nil
        end
        local v150
        if v143 <= v140 then
            v150 = string.sub(p51, v143, v144) or nil
        else
            v150 = nil
        end
        table.insert(v141, v148)
        if v147 then
            v139(v141)
            if u63 then
                v143 = v142
                break
            end
            v139({ v150 })
            if u63 then
                break
            end
            v141 = {}
        else
            table.insert(v141, v150)
        end
        v142 = v144 + 1
    end
    if not u63 then
        v139(v141)
    end
    local v151 = Instance.new("UIListLayout")
    v151.HorizontalAlignment = u57.ContainerHorizontalAlignment
    v151.VerticalAlignment = u57.ContainerVerticalAlignment
    v151.Parent = u50
    local v152 = u50.AbsoluteSize.X
    local v153 = 0
    local v154 = 0
    for _, v155 in pairs(u59) do
        v153 = v153 + v155.Size.Y.Offset
        local v156 = v155.Container
        local v157 = nil
        local v158 = nil
        if v156.AnchorPoint.X == 0 then
            v157 = v156.Position.X.Offset
            v158 = v156.Size.X.Offset
        elseif v156.AnchorPoint.X == 0.5 then
            v157 = v155.AbsoluteSize.X / 2 - v156.Size.X.Offset / 2
            v158 = v155.AbsoluteSize.X / 2 + v156.Size.X.Offset / 2
        elseif v156.AnchorPoint.X == 1 then
            v157 = v155.AbsoluteSize.X - v156.Size.X.Offset
            v158 = v155.AbsoluteSize.X
        end
        v152 = math.min(v152, v157)
        v154 = math.max(v154, v158)
    end
    u35 = u35 + 1
    local u159 = false
    local u160 = false
    local u161 = false
    local u162 = "TextAnimation" .. u35
    local u163 = {}
    local function u171() --[[ Line: 741 ]]
        --[[
        Upvalues:
            [1] = u160
            [2] = u163
            [3] = u159
            [4] = u34
            [5] = u162
            [6] = u32
        --]]
        if u160 and #u163 == 0 or u159 then
            u159 = true
            u34:UnbindFromRenderStep(u162)
            u163 = {}
        else
            local v164 = tick()
            for v165 = #u163, 1, -1 do
                local v166 = u163[v165]
                local v167 = v166.Settings
                local v168 = u32[v167.AnimateStyle]
                if not v168 then
                    warn("No animation style found for: ", v167.AnimateStyle, ", defaulting to Appear")
                    v168 = u32.Appear
                end
                local v169 = (v164 - v166.Start) / v167.AnimateStyleTime
                local v170 = math.min(v169, 1)
                v168(v166.Char, v170, v167)
                if v170 >= 1 then
                    table.remove(u163, v165)
                end
            end
        end
    end
    local function u175(p172) --[[ Line: 766 ]]
        --[[
        Upvalues:
            [1] = u61
            [2] = u81
        --]]
        p172.Position = u61[p172].InitialPosition
        p172.Size = u61[p172].InitialSize
        p172.AnchorPoint = u61[p172].InitialAnchorPoint
        for v173, v174 in pairs(u61[p172]) do
            u81(v173, v174, p172)
        end
    end
    local function u179(p176, p177) --[[ Line: 775 ]]
        --[[
        Upvalues:
            [1] = u175
        --]]
        p176.Visible = p177
        for _, v178 in pairs(p176:GetChildren()) do
            if v178:IsA("TextLabel") ~= false then
                v178.Visible = p177
                if p177 then
                    u175(v178)
                end
            end
        end
        if p177 and p176:IsA("ImageLabel") then
            u175(p176)
        end
    end
    local function u213(p180) --[[ Line: 791 ]]
        --[[
        Upvalues:
            [1] = u159
            [2] = u34
            [3] = u162
            [4] = u171
            [5] = u60
            [6] = u163
            [7] = u161
            [8] = u61
            [9] = u160
            [10] = u57
        --]]
        u159 = false
        u34:BindToRenderStep(u162, Enum.RenderPriority.Last.Value, u171)
        local u181 = nil
        local u182 = nil
        local u183 = nil
        local v184 = nil
        for _, v185 in pairs(u60) do
            for _, v186 in pairs(v185) do
                v186.Visible = false
                for _, v187 in pairs(v186:GetChildren()) do
                    if v187:IsA("TextLabel") ~= false then
                        v187.Visible = false
                    end
                end
            end
        end
        local function v190() --[[ Line: 811 ]]
            --[[
            Upvalues:
                [1] = u161
                [2] = u181
                [3] = u182
                [4] = u183
            --]]
            if not u161 and (u181 % u182 == 0 and u183 >= 0) then
                local v188 = u183 > 0 and u183 or nil
                local v189 = script.Typing:Clone()
                v189.Parent = script.Parent
                v189.Name = "sfx"
                v189:Play()
                _G.destroy(v189, 0.2)
                task.wait(v188)
            end
        end
        for _, v191 in pairs(u60) do
            for _, v192 in pairs(v191) do
                local v193 = u61[v192]
                u181 = (v193.AnimateStepGrouping ~= v184 or v193.AnimateStepFrequency ~= u182) and 0 or u181
                v184 = v193.AnimateStepGrouping
                local _ = v193.AnimateStepTime
                local v194 = v193.AnimateStepFrequency
                if v193.AnimateYield > 0 then
                    wait(v193.AnimateYield)
                end
                local v195
                if v184 == "Word" or v184 == "All" then
                    if v192:IsA("TextLabel") then
                        v192.Visible = true
                        u182 = v194
                        for _, v196 in pairs(v192:GetChildren()) do
                            local v197 = u163
                            local v198 = {
                                ["Char"] = v196,
                                ["Settings"] = u61[v196],
                                ["Start"] = tick()
                            }
                            table.insert(v197, v198)
                        end
                    else
                        local v199 = u163
                        local v200 = {
                            ["Char"] = v192,
                            ["Settings"] = v193,
                            ["Start"] = tick()
                        }
                        table.insert(v199, v200)
                        u182 = v194
                    end
                    if v184 == "Word" then
                        v195 = u181 + 1
                        v190()
                        u181 = v195
                    end
                elseif v184 == "Letter" then
                    if v192:IsA("TextLabel") then
                        v192.Visible = true
                        local _ = v192.Text
                        u182 = v194
                        local v201 = 1
                        while true do
                            local v202 = v192:FindFirstChild(string.format("Char%03d", v201))
                            if not v202 then
                                break
                            end
                            local v203 = u163
                            local v204 = {
                                ["Char"] = v202,
                                ["Settings"] = u61[v202],
                                ["Start"] = tick()
                            }
                            table.insert(v203, v204)
                            v195 = u181 + 1
                            v190()
                            if u159 then
                                return
                            end
                            v201 = v201 + 1
                            u181 = v195
                        end
                    else
                        local v205 = u163
                        local v206 = {
                            ["Char"] = v192,
                            ["Settings"] = v193,
                            ["Start"] = tick()
                        }
                        table.insert(v205, v206)
                        v195 = u181 + 1
                        v190()
                        u181 = v195
                        u182 = v194
                    end
                else
                    warn("Invalid step grouping: ", v184)
                    u182 = v194
                end
                if u159 then
                    return
                end
            end
        end
        u160 = true
        for _, v207 in pairs(u60) do
            local v208 = nil
            for _, v209 in pairs(v207) do
                if v209:IsA("TextLabel") then
                    for _, v210 in v209:GetChildren() do
                        if not v210:IsA("UIGradient") then
                            v210:Destroy()
                        end
                    end
                    v209.TextTransparency = u57.TextTransparency or 0
                    v209.TextScaled = u57.TextScaled or false
                    v209.TextStrokeTransparency = u57.TextStrokeTransparency or 1
                    v209.TextWrapped = u57.TextWrapped or false
                    if v208 then
                        if v208.TextColor3 == v209.TextColor3 then
                            local v211 = v208:FindFirstChild("UIG")
                            local v212 = v209:FindFirstChild("UIG")
                            if (v211 or not v212) and (not v211 or v212) then
                                if v211 and (v212 and v211.Color ~= v212.Color) then
                                    v208 = v209
                                elseif v208.FontFace == v209.FontFace then
                                    v208.Size = v208.Size + UDim2.new(v209.Size.Width, 0)
                                    v208.Text = v208.Text .. v209.Text
                                    v209:Destroy()
                                else
                                    v208 = v209
                                end
                            else
                                v208 = v209
                            end
                        else
                            v208 = v209
                        end
                    else
                        v208 = v209
                    end
                end
            end
        end
        if p180 then
            while #u163 > 0 do
                print(#u163)
                u34.RenderStepped:Wait()
            end
        end
    end
    local v214 = {
        ["Overflown"] = u63,
        ["OverflowPickupIndex"] = v143,
        ["StartingProperties"] = p52,
        ["OverflowPickupProperties"] = u57,
        ["Text"] = p51,
        ["_textFrames"] = u60,
        ["_frameProperties"] = u61
    }
    if p54 then
        p54.NextTextObject = v214
    end
    v214.ContentSize = Vector2.new(v154 - v152, v153)
    function v214.Animate(p215, p216) --[[ Line: 971 ]]
        --[[
        Upvalues:
            [1] = u213
        --]]
        if p216 then
            u213()
        else
            coroutine.wrap(u213)()
        end
        if p215.NextTextObject then
            p215.NextTextObject:Animate(p216)
        end
    end
    function v214.Show(p217, p218) --[[ Line: 982 ]]
        --[[
        Upvalues:
            [1] = u161
            [2] = u159
            [3] = u60
            [4] = u179
        --]]
        if p218 then
            u161 = true
        else
            u159 = true
            for _, v219 in pairs(u60) do
                for _, v220 in pairs(v219) do
                    u179(v220, true)
                end
            end
        end
        if p217.NextTextObject then
            p217.NextTextObject:Show(p218)
        end
    end
    local function u228(u221, p222, u223) --[[ Line: 1043 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
        --]]
        if u4[u221] and u223:IsA(u4[u221]) then
            local v224 = string.gmatch(tostring(p222), "[^,]+")
            local u225 = v224()
            local v226 = v224()
            local v227 = v224()
            if v227 then
                u223[u221] = Color3.fromRGB(u225, v226, v227)
                return
            elseif u1.ColorShortcuts[u225] == nil then
                if v226 then
                    u223[u221] = Vector2.new(u225, v226)
                else
                    pcall(function() --[[ Line: 1057 ]]
                        --[[
                        Upvalues:
                            [1] = u223
                            [2] = u221
                            [3] = u225
                        --]]
                        u223[u221] = u225
                    end)
                end
            else
                u223[u221] = u1.ColorShortcuts[u225]
                return
            end
        else
            return
        end
    end
    local function u233(p229, p230) --[[ Line: 1063 ]]
        --[[
        Upvalues:
            [1] = u228
        --]]
        p229.Position = p230[p229].InitialPosition
        p229.Size = p230[p229].InitialSize
        p229.AnchorPoint = p230[p229].InitialAnchorPoint
        for v231, v232 in pairs(p230[p229]) do
            u228(v231, v232, p229)
        end
    end
    function v214.ShowFast(p234) --[[ Line: 1076 ]]
        --[[
        Upvalues:
            [1] = u233
            [2] = u60
        --]]
        local v235 = {}
        local v236 = 1
        local v237 = 1
        local v238 = {
            ["n"] = 0
        }
        while true do
            for v239, v240 in next, p234._frameProperties do
                v235[v239] = v240
            end
            while p234._textFrames[v236] do
                if p234._textFrames[v236][v237] then
                    v238.n = v238.n + 1
                    v238[v238.n] = p234._textFrames[v236][v237]
                    v237 = v237 + 1
                else
                    v236 = v236 + 1
                    v237 = 1
                end
            end
            p234 = p234.NextTextObject
            if p234 == nil then
                local v241 = 1
                while v241 <= v238.n do
                    if v238[v241] and game.IsA(v238[v241], "GuiObject") then
                        v238[v241].Visible = true
                        if v238[v241]:IsA("ImageLabel") then
                            u233(v238[v241], v235)
                        end
                        if u60[v241] then
                            local v242 = v238[v241]:GetChildren()
                            local v243 = #v242
                            for v244 = 1, v243 do
                                v238[v238.n + v244] = v242[v244]
                            end
                            v238.n = v238.n + v243
                        else
                            u233(v238[v241], v235)
                        end
                    end
                    v241 = v241 + 1
                end
                return
            end
        end
    end
    function v214.Hide(p245) --[[ Line: 1137 ]]
        --[[
        Upvalues:
            [1] = u159
            [2] = u60
        --]]
        u159 = true
        for _, v246 in pairs(u60) do
            for _, v247 in pairs(v246) do
                v247.Visible = false
                for _, v248 in pairs(v247:GetChildren()) do
                    if v248:IsA("TextLabel") ~= false then
                        v248.Visible = false
                    end
                end
            end
        end
        if p245.NextTextObject then
            p245.NextTextObject:Hide()
        end
    end
    return v214
end
function u1.ContinueOverflow(_, p249, p250) --[[ Line: 1152 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1:New(p249, nil, nil, false, p250)
end
return u1