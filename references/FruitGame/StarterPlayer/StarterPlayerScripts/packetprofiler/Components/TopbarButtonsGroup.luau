 

local u1 = game:GetService("TextService")
local v2 = game:GetService("RunService")
local v3 = script.Parent.Parent.Modules
local v4 = require(v3.Packages)
local u5 = require(v4.Directory.Roact)
local u6 = not v2:IsRunning()
local function u8(p7) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5.createElement("TextButton", {
        ["AutoLocalize"] = false,
        ["Text"] = p7.ButtonName,
        ["TextXAlignment"] = Enum.TextXAlignment.Right,
        ["TextYAlignment"] = Enum.TextYAlignment.Center,
        ["Font"] = Enum.Font.Code,
        ["TextColor3"] = p7.Theme.Name == "Light" and Color3.new(0, 0, 0) or Color3.new(1, 1, 1),
        ["TextSize"] = 12,
        ["BackgroundColor3"] = p7.Theme:GetColor("ScrollBarBackground"),
        ["Size"] = p7.Size,
        ["BorderSizePixel"] = 0,
        [u5.Event.Activated] = p7.OnClick
    })
end
local v9 = u5.Component:extend("TopbarButtonsGroup")
function v9.init(p10) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v11, v12 = u5.createBinding(0)
    p10.MouseHovering = v11
    p10.SetMouseHovering = v12
    p10.TopbarRef = u5.createRef()
end
function v9.render(u13) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u8
        [3] = u5
        [4] = u6
    --]]
    local u14 = u13.props
    local v15 = u1:GetTextSize(u14.Text, 12, Enum.Font.Code, Vector2.new(10000, 11))
    local v16 = v15.X
    local v17 = {}
    for _, v18 in u14.Options do
        local v19 = u1:GetTextSize(v18.Name, 11, Enum.Font.Code, Vector2.new(10000, 11)).X
        v16 = math.max(v16, v19)
    end
    for _, v20 in u14.Options do
        local v21 = u8
        local v22 = {
            ["ButtonName"] = v20.Name,
            ["OnClick"] = v20.Callback,
            ["Theme"] = u14.Theme,
            ["Size"] = UDim2.fromOffset(v16, 11)
        }
        table.insert(v17, v21(v22))
    end
    return u5.createElement("TextLabel", {
        ["AutoLocalize"] = false,
        ["Text"] = u14.Text,
        ["TextColor3"] = u14.Theme.Name == "Light" and Color3.new(0, 0, 0) or Color3.new(1, 1, 1),
        ["BackgroundColor3"] = u13.MouseHovering:map(function(p23) --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            return p23 > 0 and u14.Theme:GetColor("Light") or u14.Theme:GetColor("ScrollBarBackground")
        end),
        ["TextSize"] = 12,
        ["Font"] = Enum.Font.Code,
        ["BorderSizePixel"] = 0,
        ["Size"] = UDim2.fromOffset(v15.X, 10),
        ["TextXAlignment"] = Enum.TextXAlignment.Left,
        ["TextYAlignment"] = Enum.TextYAlignment.Center,
        ["LayoutOrder"] = u14.LayoutOrder,
        ["Visible"] = not u6,
        [u5.Event.MouseEnter] = function() --[[ Line: 71 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13.SetMouseHovering(1)
        end,
        [u5.Event.MouseLeave] = function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            task.defer(function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if u13.MouseHovering:getValue() == 1 then
                    u13.SetMouseHovering(0)
                end
            end)
        end,
        [u5.Ref] = u13.TopbarRef
    }, {
        ["OptionsHolder"] = u5.createElement("Frame", {
            ["AutomaticSize"] = Enum.AutomaticSize.Y,
            ["BackgroundTransparency"] = 1,
            ["Visible"] = u13.MouseHovering:map(function(p24) --[[ Line: 86 ]]
                return p24 > 0
            end),
            ["Position"] = UDim2.fromOffset(0, 10),
            [u5.Event.MouseEnter] = function() --[[ Line: 90 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.SetMouseHovering(2)
            end,
            [u5.Event.MouseLeave] = function() --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                task.defer(function() --[[ Line: 94 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    if u13.MouseHovering:getValue() == 2 then
                        u13.SetMouseHovering(0)
                    end
                end)
            end,
            ["Size"] = UDim2.fromOffset(v16, 0)
        }, {
            ["OptionsListLayout"] = u5.createElement("UIListLayout", {
                ["FillDirection"] = Enum.FillDirection.Vertical,
                ["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
                ["VerticalAlignment"] = Enum.VerticalAlignment.Top
            }),
            ["Buttons"] = u5.createFragment(v17)
        })
    })
end
return v9