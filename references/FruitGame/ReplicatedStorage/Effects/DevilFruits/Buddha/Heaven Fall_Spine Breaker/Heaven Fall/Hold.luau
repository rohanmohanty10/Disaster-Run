 

local _ = _G.Emit
local u1 = require(script.InitiateVFX)
local _ = _G.Ess.Tween
local _ = _G.Emit
local u9 = {
    ["InUse"] = {},
    ["Start"] = function(p2, p3, p4) --[[ Name: Start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u9
        --]]
        local v5 = u1.Light(p2:GetPivot(), p3, script.Form)
        u9.InUse[p4] = v5
    end,
    ["End"] = function(_, p6, p7) --[[ Name: End, Line 19 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u1
        --]]
        local v8 = u9.InUse[p7]
        u1.End(v8, p6)
        task.wait(p6)
        u9.InUse[p7]:Destroy()
        u9.InUse[p7] = nil
    end
}
return function(p10, ...) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    u9[p10](...)
end