 

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
local u2 = require(v1:WaitForChild("Trove"))
local function u8(p3, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = p4 or 0
    local u6 = u2.new()
    if typeof(p3) == "table" then
        for _, v7 in pairs(p3) do
            u6:Add(v7)
        end
    else
        u6:Add(p3)
    end
    task.delay(v5, function() --[[ Line: 18 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u6:Clean()
        u6 = nil
    end)
end
return {
    ["AddItem"] = function(_, p9, p10) --[[ Name: AddItem, Line 26 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        u8(p9, p10)
    end
}