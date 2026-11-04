 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("RunService")
local u3 = game:GetService("Workspace")
local u4 = v1("BasicPane")
local u5 = v1("Blend")
local u6 = v1("SpringObject")
local u7 = v1("Rx")
local u8 = v1("Math")
local u9 = setmetatable({}, u4)
u9.ClassName = "SoftShutdownUI"
u9.__index = u9
function u9.new() --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u9
        [3] = u6
        [4] = u3
    --]]
    local v10 = u4.new()
    local v11 = u9
    local u12 = setmetatable(v10, v11)
    u12._title = Instance.new("StringValue")
    u12._title.Value = ""
    u12._maid:GiveTask(u12._title)
    u12._subtitle = Instance.new("StringValue")
    u12._subtitle.Value = ""
    u12._maid:GiveTask(u12._subtitle)
    u12._percentVisible = u6.new(0, 40)
    u12._maid:GiveTask(u12._percentVisible)
    u12._maid:GiveTask(u12.VisibleChanged:Connect(function(p13, p14) --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        u12._percentVisible.t = p13 and 1 or 0
        if p14 then
            u12._percentVisible.p = u12._percentVisible.t
            u12._percentVisible.v = 0
        end
    end))
    u12._blur = Instance.new("BlurEffect")
    u12._blur.Name = "SoftShutdownBlur"
    u12._blur.Enabled = false
    u12._blur.Size = 0
    u12._blur.Parent = u3.CurrentCamera
    u12._maid:GiveTask(u12._blur)
    u12._maid:GiveTask(u12:_render():Subscribe(function(p15) --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        u12.Gui = p15
    end))
    return u12
end
function u9.SetTitle(p16, p17) --[[ Line: 56 ]]
    p16._title.Value = p17
end
function u9.SetSubtitle(p18, p19) --[[ Line: 60 ]]
    p18._subtitle.Value = p19
end
function u9._render(u20) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u8
        [3] = u7
        [4] = u2
    --]]
    local v21 = u20._percentVisible:ObserveRenderStepped()
    local v23 = u5.Computed(v21, function(p22) --[[ Line: 66 ]]
        return 1 - p22
    end)
    local v24 = Color3.new(0, 0, 0)
    local v25 = Color3.new(0.9, 0.9, 0.9)
    u20._maid:GiveTask(v21:Subscribe(function(p26) --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        u20._blur.Size = p26 * 30
        u20._blur.Enabled = p26 > 0
    end))
    local v27 = u5.New("Frame")
    local v31 = {
        ["Name"] = "SoftShutdownUI",
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["Active"] = u5.Computed(v21, function(p28) --[[ Line: 82 ]]
            return p28 > 0
        end),
        ["Visible"] = u5.Computed(v21, function(p29) --[[ Line: 85 ]]
            return p29 > 0
        end),
        ["BackgroundColor3"] = v24,
        ["BackgroundTransparency"] = u5.Computed(v21, function(p30) --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            return u8.map(p30, 0, 1, 1, 0.4)
        end)
    }
    local v32 = u5.Children
    local v33 = {}
    local v34 = u5.New("UIPadding")({
        ["PaddingLeft"] = UDim.new(0, 20),
        ["PaddingRight"] = UDim.new(0, 20),
        ["PaddingTop"] = UDim.new(0, 20),
        ["PaddingBottom"] = UDim.new(0, 20)
    })
    local v35 = u5.New("Frame")
    local v36 = {
        ["Name"] = "ContentContainer",
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["BackgroundTransparency"] = 1
    }
    local v37 = u5.Children
    local v38 = {}
    local v40 = u5.New("UIScale")({
        ["Scale"] = u5.Computed(v21, function(p39) --[[ Line: 110 ]]
            return 0.7 + 0.3 * p39
        end)
    })
    local v41 = u5.New("Frame")
    local v42 = {
        ["Name"] = "ImageLabelContainer",
        ["Size"] = UDim2.new(0, 80, 0, 80),
        ["BackgroundTransparency"] = 1,
        ["LayoutOrder"] = 1,
        [u5.Children] = { u5.New("ImageLabel")({
                ["Size"] = UDim2.new(1, 0, 1, 0),
                ["ImageTransparency"] = v23,
                ["BackgroundTransparency"] = 1,
                ["Image"] = "rbxassetid://6031302916"
            }) }
    }
    local v43 = v41(v42)
    local v44 = u5.New("Frame")
    local v45 = {
        ["Name"] = "LabelContainer",
        ["Size"] = UDim2.new(1, 0, 0, 80),
        ["Position"] = UDim2.new(0.5, 0, 0.5, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["BackgroundTransparency"] = 1,
        ["LayoutOrder"] = 2,
        [u5.Children] = { u5.New("TextLabel")({
                ["Name"] = "TitleLabel",
                ["BackgroundTransparency"] = 1,
                ["Position"] = UDim2.fromScale(0.5, 0),
                ["Size"] = UDim2.new(1, 0, 0.6, 0),
                ["AnchorPoint"] = Vector2.new(0.5, 0),
                ["Text"] = u20._title,
                ["Font"] = Enum.Font.SourceSansBold,
                ["TextTransparency"] = v23,
                ["TextColor3"] = v25,
                ["LayoutOrder"] = 1,
                ["TextScaled"] = true
            }), u5.New("TextLabel")({
                ["Name"] = "SubtitleLabel",
                ["BackgroundTransparency"] = 1,
                ["Position"] = UDim2.fromScale(0.5, 1),
                ["Size"] = UDim2.new(1, 0, 0.3, 0),
                ["AnchorPoint"] = Vector2.new(0.5, 1),
                ["Text"] = u20._subtitle,
                ["Font"] = Enum.Font.SourceSansLight,
                ["TextTransparency"] = v23,
                ["TextColor3"] = v25,
                ["LayoutOrder"] = 2,
                ["TextScaled"] = true
            }), u5.New("UIAspectRatioConstraint")({
                ["AspectRatio"] = 5
            }) }
    }
    local v46 = v44(v45)
    local v47 = u5.New("Frame")({
        ["Name"] = "Spacer",
        ["BackgroundTransparency"] = 1,
        ["Size"] = UDim2.new(0, 0, 0, 50),
        ["LayoutOrder"] = 3
    })
    local v48 = u5.New("Frame")
    local v49 = {
        ["Name"] = "LoadingLabel",
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["LayoutOrder"] = 4,
        ["Size"] = UDim2.fromScale(0.25, 0.25),
        ["BackgroundTransparency"] = 1
    }
    local v50 = u5.Children
    local v51 = {}
    local v52 = u5.New("Frame")
    local v57 = {
        ["Name"] = "RobloxLogo",
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["BackgroundColor3"] = v25,
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["BackgroundTransparency"] = v23,
        ["Rotation"] = u7.fromSignal(u2.RenderStepped):Pipe({ u7.map(function() --[[ Line: 199 ]]
                local v53 = tick() * 3.141592653589793 * 1.5
                local v54 = math.sin(v53)
                local v55 = v53 - 1.5707963267948966
                local v56 = (math.sin(v55) + 1) / 2
                return v54 <= 0 and 15 or v56 * 360 + 15
            end) }),
        [u5.Children] = { u5.New("Frame")({
                ["BackgroundColor3"] = v24,
                ["Size"] = UDim2.fromScale(0.2, 0.2),
                ["AnchorPoint"] = Vector2.new(0.5, 0.5),
                ["Position"] = UDim2.fromScale(0.5, 0.5),
                ["BackgroundTransparency"] = v23
            }) }
    }
    __set_list(v51, 1, {v52(v57), u5.New("UIAspectRatioConstraint")({
    ["AspectRatio"] = 1
}), u5.New("UISizeConstraint")({
    ["MaxSize"] = Vector2.new((1 / 0), 50)
})})
    v49[v50] = v51
    __set_list(v38, 1, {v40, v43, v46, v47, v48(v49), u5.New("UIListLayout")({
    ["FillDirection"] = Enum.FillDirection.Vertical,
    ["SortOrder"] = Enum.SortOrder.LayoutOrder,
    ["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
    ["VerticalAlignment"] = Enum.VerticalAlignment.Center,
    ["Padding"] = UDim.new(0, 10)
})})
    v36[v37] = v38
    __set_list(v33, 1, {v34, v35(v36)})
    v31[v32] = v33
    return v27(v31)
end
return u9