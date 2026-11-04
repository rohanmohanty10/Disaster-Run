 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = game:GetService("RunService")
local u3 = v1("Blend")
local u4 = v1("Maid")
local u5 = v1("ValueObject")
local u6 = v1("Rx")
return function(p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u5
        [4] = u6
        [5] = u2
    --]]
    local u8 = u4.new()
    local u9 = u3.State(0)
    local u10 = u3.State("a")
    u8:GiveTask(u10)
    local u11 = u5.new()
    u11.Value = u3.New("UICorner")({
        ["CornerRadius"] = UDim.new(0, 5)
    })
    u8:GiveTask(u11)
    task.delay(1, function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u3
        --]]
        if u11.Destroy then
            u11.Value = u3.New("UICorner")({
                ["CornerRadius"] = UDim.new(0, 25)
            })
        end
    end)
    u8:GiveTask(u3.New("TextLabel")({
        ["Parent"] = p7,
        ["Size"] = u3.Computed(u9, function(p12) --[[ Line: 38 ]]
            return UDim2.new(0, p12 * 100, 0, 50)
        end),
        ["BackgroundTransparency"] = u3.Computed(u9, function(p13) --[[ Line: 41 ]]
            return 1 - p13
        end),
        ["Position"] = UDim2.new(0.5, 0, 0.5, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5),
        ["Text"] = u10,
        ["TextScaled"] = true,
        [u3.Children] = {
            u11,
            u6.NEVER,
            u6.EMPTY,
            { u3.Single(u3.Computed(u9, function(p14) --[[ Line: 56 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    if p14 <= 0.5 then
                        return nil
                    else
                        return u3.New("Frame")({
                            ["Size"] = UDim2.new(0, 100, 0, 100),
                            ["BackgroundTransparency"] = 0.5
                        })
                    end
                end)) },
            { u3.Single(u3.Computed(u9, function(p15) --[[ Line: 70 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    local v16 = {}
                    for v17 = 0, p15 * 100, 10 do
                        local v18 = u3.New("Frame")
                        local v19 = {
                            ["Size"] = UDim2.new(0, 8, 0, 8),
                            ["Position"] = UDim2.new(0, v17, 0.9, 0),
                            ["AnchorPoint"] = Vector2.new(0.5, 0.5),
                            ["BorderSizePixel"] = 0,
                            ["BackgroundColor3"] = Color3.new(v17 / 100, 0.5, 0.5),
                            [u3.Children] = { u3.New("UICorner")({
                                    ["CornerRadius"] = UDim.new(0.5, 5)
                                }) }
                        }
                        table.insert(v16, v18(v19))
                    end
                    return v16
                end)) }
        }
    }):Subscribe())
    u8:GiveTask(u2.RenderStepped:Connect(function() --[[ Line: 97 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
        --]]
        local v20 = u10
        local v21 = tick
        v20.Value = tostring(v21())
        local v22 = u9
        local v23 = tick() * 3.141592653589793 * 2 / 5
        v22.Value = (math.sin(v23) + 1) / 2
    end))
    return function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        u8:DoCleaning()
    end
end