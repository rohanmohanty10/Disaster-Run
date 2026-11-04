 

local v1 = {}
local u2 = require(script.Parent.SukeTrans)
function v1.start(_, p3, p4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2:start(p3)
    repeat
        game["Run Service"].Heartbeat:Wait()
    until p4.Parent ~= p3 or p4.Parent == nil
    v5:Fire()
end
return v1