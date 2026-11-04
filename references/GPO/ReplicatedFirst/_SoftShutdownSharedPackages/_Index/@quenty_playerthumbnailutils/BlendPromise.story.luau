 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = game:GetService("RunService")
local u3 = v1("Blend")
local u4 = v1("Maid")
local u5 = v1("PlayerThumbnailUtils")
return function(p6) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u5
        [4] = u2
    --]]
    local u7 = u4.new()
    local u8 = Instance.new("IntValue")
    u8.Value = 4397833
    u7:GiveTask(u8)
    local u9 = Instance.new("BoolValue")
    u9.Value = false
    u7:GiveTask(u9)
    local v11 = u3.Dynamic(u8, function(p10) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return u5.promiseUserThumbnail(p10)
    end)
    local v13 = u3.Dynamic(u8, function(p12) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return u5.promiseUserName(p12)
    end)
    local v15 = u3.Spring(u3.Computed(u9, function(p14) --[[ Line: 30 ]]
        return p14 and 1 or 0
    end), 35)
    local v17 = u3.Computed(v15, function(p16) --[[ Line: 33 ]]
        return 1 - p16
    end)
    local v18 = u3.New("Frame")
    local v19 = {
        ["Parent"] = p6,
        ["Name"] = "ProfileImage",
        ["LayoutOrder"] = 15,
        ["BackgroundTransparency"] = 1,
        ["Size"] = UDim2.new(0, 100, 0, 130),
        ["Position"] = UDim2.fromScale(0.5, 0.5),
        ["AnchorPoint"] = Vector2.new(0.5, 0.5)
    }
    local v20 = u3.Children
    local v21 = {}
    local v23 = u3.New("UIScale")({
        ["Scale"] = u3.Computed(v15, function(p22) --[[ Line: 47 ]]
            return 0.8 + 0.2 * p22
        end)
    })
    local v24 = u3.New("TextLabel")({
        ["Size"] = UDim2.new(1, 0, 0, 30),
        ["Position"] = UDim2.new(0.5, 0, 1, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 1),
        ["BackgroundTransparency"] = 1,
        ["TextTransparency"] = v17,
        ["TextColor3"] = Color3.new(1, 1, 1),
        ["TextSize"] = 20,
        ["Font"] = Enum.Font.Gotham,
        ["Text"] = v13
    })
    local v25 = u3.New("Frame")
    local v26 = {
        ["Position"] = UDim2.new(0.5, 0, 0, 0),
        ["AnchorPoint"] = Vector2.new(0.5, 0),
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["BackgroundColor3"] = Color3.new(0.2, 0.25, 0.2),
        ["BackgroundTransparency"] = v17
    }
    local v27 = u3.Children
    local v28 = {}
    local v29 = u3.New("UIAspectRatioConstraint")({
        ["AspectRatio"] = 1
    })
    local v30 = u3.New("UICorner")({
        ["CornerRadius"] = UDim.new(1, 0)
    })
    local v31 = u3.New("UIPadding")({
        ["PaddingLeft"] = UDim.new(0, 2),
        ["PaddingRight"] = UDim.new(0, 2),
        ["PaddingTop"] = UDim.new(0, 2),
        ["PaddingBottom"] = UDim.new(0, 2)
    })
    local v32 = u3.New("ImageLabel")
    local v33 = {
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["Image"] = v11,
        ["BackgroundTransparency"] = v17,
        ["ImageTransparency"] = v17,
        ["BackgroundColor3"] = Color3.new(0.1, 0.1, 0.1),
        [u3.Children] = { u3.New("UICorner")({
                ["CornerRadius"] = UDim.new(1, 0)
            }) }
    }
    __set_list(v28, 1, {v29, v30, v31, v32(v33)})
    v26[v27] = v28
    __set_list(v21, 1, {v23, v24, v25(v26)})
    v19[v20] = v21
    u7:GiveTask(v18(v19):Subscribe())
    u7:GiveTask(u2.RenderStepped:Connect(function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        u9.Value = tick() / 2 % 1 < 0.5
    end))
    local u34 = true
    u7:GiveTask(function() --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        u34 = false
    end)
    u7:GiveTask(u9.Changed:Connect(function() --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u34
            [3] = u8
        --]]
        if not u9.Value then
            task.delay(1, function() --[[ Line: 113 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u8
                --]]
                if u34 then
                    u8.Value = Random.new():NextInteger(1, 1000000000)
                end
            end)
        end
    end))
    return function() --[[ Line: 121 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:DoCleaning()
    end
end