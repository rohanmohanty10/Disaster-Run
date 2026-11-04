 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = v1("Maid")
local u3 = v1("Observable")
local u4 = v1("Blend")
return function(u5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    local u6 = u2.new()
    local v7 = u4.State("a")
    u6:GiveTask(u4.Single(u4.Dynamic(v7, function(u8) --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u3
            [4] = u2
        --]]
        return u4.New("TextLabel")({
            ["Parent"] = u5,
            ["Text"] = u8,
            ["Size"] = UDim2.new(1, 0, 1, 0),
            ["BackgroundTransparency"] = 0.5,
            [function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u2
                    [3] = u8
                --]]
                return u3.new(function() --[[ Line: 23 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u8
                    --]]
                    local v9 = u2.new()
                    print("Made for", u8)
                    v9:GiveTask(function() --[[ Line: 27 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                        --]]
                        print("Cleaning up", u8)
                    end)
                    return v9
                end)
            end] = true
        })
    end)):Subscribe())
    v7.Value = "b"
    return function() --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u6:DoCleaning()
    end
end