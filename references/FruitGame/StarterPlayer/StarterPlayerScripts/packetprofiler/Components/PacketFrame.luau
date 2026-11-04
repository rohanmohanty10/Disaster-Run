 

local v1 = script.Parent.Parent.Modules
local v2 = require(v1.Packages)
local u3 = require(v2.Directory.Roact)
local v4 = u3.Component:extend("PacketFrame")
function v4.render(u5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u6 = u5.props
    return u3.createElement("ImageLabel", {
        ["Size"] = u6.PacketsChanged:map(function(p7) --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u5
            --]]
            local v8 = p7[u6.Index]
            if not v8 then
                return u3.Constant.SkipBindingUpdate
            end
            local v9 = v8.TotalSize / u5.props.MaxFrameSize
            local v10 = math.min(v9, 1)
            local v11 = UDim2.fromScale(1 / u6.MaxFrames, v10)
            if v11 == u5.PreviousFrameSize then
                return u3.Constant.SkipBindingUpdate
            end
            u5.PreviousFrameSize = v11
            return v11
        end),
        ["Image"] = "rbxassetid://10370998310",
        ["AnchorPoint"] = Vector2.new(0, 1),
        ["Position"] = UDim2.fromScale(1 - u6.Index / u6.MaxFrames, 1),
        ["BorderSizePixel"] = 0,
        ["Visible"] = u6.PacketsChanged:map(function(p12) --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u5
                [3] = u3
            --]]
            local v13 = p12[u6.Index] ~= nil
            if v13 == u5.PreviousIsVisible then
                return u3.Constant.SkipBindingUpdate
            end
            u5.PreviousIsVisible = v13
            return v13
        end),
        ["BorderColor3"] = Color3.new(1, 1, 1)
    })
end
return v4