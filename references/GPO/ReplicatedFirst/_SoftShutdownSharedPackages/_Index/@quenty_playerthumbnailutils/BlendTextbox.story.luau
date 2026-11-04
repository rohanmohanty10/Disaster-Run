 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = v1("Blend")
local u3 = v1("Maid")
return function(p4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local u5 = u3.new()
    local v6 = u2.State("hi")
    local v7 = u2.New("Frame")
    local v10 = {
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["BackgroundTransparency"] = 1,
        ["Parent"] = p4,
        [u2.Children] = { u2.New("TextBox")({
                ["Size"] = UDim2.new(0, 200, 0, 50),
                ["Text"] = v6,
                [u2.OnChange("Text")] = v6,
                [u2.OnEvent("Focused")] = function() --[[ Line: 25 ]]
                    print("Focused")
                end,
                [function(p8) --[[ Line: 29 ]]
                    return p8.Focused
                end] = function() --[[ Line: 29 ]]
                    print("Focused (via func)")
                end,
                [function(p9) --[[ Line: 34 ]]
                    return p9:GetPropertyChangedSignal("Text")
                end] = function() --[[ Line: 34 ]]
                    print("Property changed from :GetPropertyChangedSignal()")
                end
            }), u2.New("TextBox")({
                ["Size"] = UDim2.new(0, 200, 0, 50),
                [u2.OnChange("Text")] = v6,
                ["Text"] = v6
            }), u2.New("UIListLayout")({
                ["Padding"] = UDim.new(0, 10)
            }) }
    }
    u5:GiveTask(v7(v10):Subscribe())
    return function() --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        u5:DoCleaning()
    end
end