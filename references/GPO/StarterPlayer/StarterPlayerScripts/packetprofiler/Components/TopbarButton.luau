 

local v1 = script.Parent.Parent.Modules
local v2 = require(v1.Packages)
local u3 = require(v2.Directory.Roact)
return function(p4) --[[ Name: TopbarButton, Line 9 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.createElement("TextButton", {
        ["AutoLocalize"] = false,
        ["TextColor3"] = p4.Theme.Name == "Light" and Color3.new(0, 0, 0) or Color3.new(1, 1, 1),
        ["Size"] = UDim2.fromOffset(0, 10),
        ["BackgroundColor3"] = p4.Theme:GetColor("Item"),
        ["TextSize"] = 11,
        ["BorderSizePixel"] = 0,
        ["Font"] = Enum.Font.Code,
        ["Text"] = p4.Text,
        ["AutomaticSize"] = Enum.AutomaticSize.X,
        ["TextXAlignment"] = Enum.TextXAlignment.Left,
        ["TextYAlignment"] = Enum.TextYAlignment.Center,
        ["LayoutOrder"] = p4.LayoutOrder,
        [u3.Event.Activated] = p4.OnClick
    })
end