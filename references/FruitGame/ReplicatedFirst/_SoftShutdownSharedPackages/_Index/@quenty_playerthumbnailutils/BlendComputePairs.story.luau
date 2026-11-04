 

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
    local u6 = u2.State({ "a", "b", "c" })
    u5:GiveTask(u6)
    local v7 = u2.New("TextLabel")
    local v13 = {
        ["Parent"] = p4,
        [u2.Children] = { u2.New("TextButton")({
                ["Text"] = "Add",
                ["AutoButtonColor"] = true,
                ["Size"] = UDim2.new(0, 100, 0, 20),
                [u2.OnEvent("Activated")] = function() --[[ Line: 24 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    local v8 = {}
                    for _, v9 in pairs(u6.Value) do
                        table.insert(v8, v9)
                    end
                    local v10 = #v8 + 97
                    local v11 = string.char(v10)
                    table.insert(v8, v11)
                    u6.Value = v8
                end
            }), u2.ComputedPairs(u6, function(_, p12) --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                print("Compute", p12)
                return u2.New("TextLabel")({
                    ["Text"] = tostring(p12),
                    ["Size"] = UDim2.new(0, 20, 0, 20)
                })
            end), u2.New("UIListLayout")({
                ["Padding"] = UDim.new(0, 5)
            }) }
    }
    u5:GiveTask(v7(v13):Subscribe())
    return function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        u5:DoCleaning()
    end
end