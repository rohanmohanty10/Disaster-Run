 

local u1 = game:GetService("RunService")
local u2 = game:GetService("HttpService")
return function(p3, u4) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v5 = type(p3) == "number"
    assert(v5, "Bad priority")
    local v6 = type(u4) == "function"
    assert(v6, "Bad callback")
    local u7 = u2:GenerateGUID(false) .. "_onRenderStepFrame"
    local u8 = false
    u1:BindToRenderStep(u7, p3, function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u1
            [3] = u7
            [4] = u4
        --]]
        if not u8 then
            u1:UnbindFromRenderStep(u7)
            u4()
        end
    end)
    return function() --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u1
            [3] = u7
        --]]
        if not u8 then
            u1:UnbindFromRenderStep(u7)
            u8 = true
        end
    end
end