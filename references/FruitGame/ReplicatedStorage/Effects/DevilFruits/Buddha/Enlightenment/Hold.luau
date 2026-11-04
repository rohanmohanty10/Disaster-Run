 

local _ = _G.Emit
local u1 = require(script.InitiateVFX)
local _ = _G.Ess.Tween
local _ = _G.Emit
local u10 = {
    ["InUse"] = {},
    ["Start"] = function(p2, p3, p4) --[[ Name: Start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        local v5 = u1.Light(p2:GetPivot(), p3, script.Form)
        u10.InUse[p4] = v5
    end,
    ["End"] = function(_, p6, p7, p8) --[[ Name: End, Line 19 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u1
        --]]
        local v9 = u10.InUse[p8]
        u1.End(v9, p7, p6)
        task.wait(p6)
        u10.InUse[p8]:Destroy()
        u10.InUse[p8] = nil
    end
}
return function(p11, ...) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10[p11](...)
end