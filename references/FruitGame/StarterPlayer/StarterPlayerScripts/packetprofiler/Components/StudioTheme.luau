 

local v1 = script.Parent.Parent
local v2 = v1.Components
local v3 = v1.Modules
local v4 = require(v3.Packages)
local u5 = require(v4.Directory.Roact)
local u6 = require(v2.StudioSettings)
local u7 = u5.Component:extend("StudioThemeProvider")
function u7.init(u8) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    u8:setState({
        ["CurrentTheme"] = u6.Theme
    })
    u8.StudioThemeChanged = u6.ThemeChanged:Connect(function() --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
        --]]
        u8:setState({
            ["CurrentTheme"] = u6.Theme
        })
    end)
end
function u7.render(p9) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5.oneChild(p9.props[u5.Children])(p9.state.CurrentTheme)
end
function u7.willUnmount(p10) --[[ Line: 27 ]]
    p10.StudioThemeChanged:Disconnect()
end
return function(p11) --[[ Name: StudioTheme, Line 31 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
    --]]
    return u5.createElement(u7, {}, {
        ["Component"] = p11
    })
end