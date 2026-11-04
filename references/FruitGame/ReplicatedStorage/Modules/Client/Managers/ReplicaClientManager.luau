 

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules").Shared.Promises
local u2 = require(v1.Promise2)
local u3 = require(script.Parent.ReplicaClient)
local u4 = {}
local u5 = {}
local u9 = {
    ["GetReplica"] = function(_, u6) --[[ Name: GetReplica, Line 19 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u2
            [4] = u3
        --]]
        if u4[u6] ~= nil then
            return u4[u6]
        end
        if not u5[u6] then
            u5[u6] = u2.new(function(u7) --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                    [3] = u4
                --]]
                u3.OnNew(u6, function(p8) --[[ Line: 27 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u6
                        [3] = u7
                    --]]
                    u4[u6] = p8
                    u7(p8)
                end)
            end)
        end
        return u5[u6]:expect()
    end,
    ["GetPlayerDataReplica"] = function(_) --[[ Name: GetPlayerDataReplica, Line 37 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        return u9:GetReplica("PlayerData")
    end,
    ["Initialize"] = function() --[[ Name: Initialize, Line 41 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3.RequestData()
    end
}
return u9