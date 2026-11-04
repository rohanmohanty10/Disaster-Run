 

local _ = _G.Ess.Tween
local _ = _G.Emit
local u1 = {
    ["Start"] = function(_, _) --[[ Name: Start, Line 6 ]] end,
    ["End"] = function(_) --[[ Name: End, Line 10 ]] end
}
return function(p2, ...) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1[p2](...)
end