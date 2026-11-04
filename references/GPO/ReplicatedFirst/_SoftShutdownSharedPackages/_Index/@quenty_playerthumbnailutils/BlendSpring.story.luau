 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = game:GetService("RunService")
local u3 = v1("Blend")
local u4 = v1("Maid")
return function(p5) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    local u6 = u4.new()
    local u7 = Instance.new("BoolValue")
    u7.Value = false
    local v9 = u3.Spring(u3.Computed(u7, function(p8) --[[ Line: 18 ]]
        return p8 and 1 or 0
    end), 35)
    local v11 = u3.Computed(v9, function(p10) --[[ Line: 22 ]]
        return 1 - p10
    end)
    local v12 = u3.New("Frame")
    local v14 = {
        ["Size"] = UDim2.new(0.5, 0, 0.5, 0),
        ["BackgroundColor3"] = Color3.new(0.9, 0.9, 0.9),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Position"] = UDim2.new(0.5, 0, 0.5, 0),
        ["BackgroundTransparency"] = v11,
        ["Parent"] = p5,
        [u3.Children] = { u3.New("UIScale")({
                ["Scale"] = u3.Computed(v9, function(p13) --[[ Line: 36 ]]
                    return 0.8 + 0.2 * p13
                end)
            }), u3.New("UICorner")({
                ["CornerRadius"] = UDim.new(0.05, 0)
            }) }
    }
    u6:GiveTask(v12(v14):Subscribe())
    u6:GiveTask(u2.RenderStepped:Connect(function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7.Value = tick() / 5 % 1 < 0.5
    end))
    return function() --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u6:DoCleaning()
    end
end