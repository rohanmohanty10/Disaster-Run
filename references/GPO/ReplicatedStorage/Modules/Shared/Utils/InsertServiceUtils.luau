 

game:GetService("Workspace")
local u1 = game:GetService("InsertService")
local v2 = script.Parent.Parent.Promises
local u3 = require(v2.Promise)
local u19 = {
    ["PromiseAsset"] = function(u4) --[[ Name: PromiseAsset, Line 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v5 = type(u4) == "number"
        local v6 = "Must be a number! Received: " .. (u4 or "nil")
        assert(v5, v6)
        if u4 ~= 0 then
            return u3.spawn(function(p7, p8) --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u4
                --]]
                local u9 = nil
                local v12, v13 = pcall(function() --[[ Line: 22 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u1
                        [3] = u4
                    --]]
                    u9 = u1:LoadAsset(u4)
                    local v10 = u9
                    if typeof(v10) == "Instance" then
                        local v11 = u9
                        u9 = v11:GetChildren()[1]
                        u9.Parent = game.ServerStorage
                        v11:Destroy()
                    end
                end)
                if not v12 then
                    p8(v13)
                end
                local v14 = u9
                if typeof(v14) ~= "Instance" then
                    p8("Result was not an instance")
                end
                p7(u9)
            end)
        end
        u3.rejected("Invalid Accessory")
    end,
    ["LoadModel"] = function(_, p15) --[[ Name: LoadModel, Line 44 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        local v16 = u19.PromiseAsset(p15)
        v16:Yield()
        local v17, v18 = v16:GetResults()
        if v17 then
            return v18
        end
        task.wait(1)
        return u19:LoadModel(p15)
    end
}
return u19