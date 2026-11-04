 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = 0
local u4 = require(script.Parent.Parent.Event).Reliable
local u5 = require(script.Parent.Assert)
function v1.increment(u6, p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u3
        [4] = u4
    --]]
    u5(typeof(u6) == "string", "Identifier must be a string type.")
    if u2:IsServer() then
        u5(u3 < 255, "reached max 255 identifiers.")
        if not u4:GetAttribute(u6) then
            u3 = u3 + 1
            u4:SetAttribute(("%*"):format(u3), u6)
            u4:SetAttribute(u6, u3)
        end
        return u4:GetAttribute(u6)
    end
    local u8 = coroutine.running()
    local u9 = task.delay(p7 or 10, function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
        --]]
        task.spawn(u8, nil)
        error(("Serdes: %* is taking too long to retrieve, seems like it\'s not replicated on server."):format(u6), 2)
    end)
    task.spawn(function() --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u4
            [3] = u6
            [4] = u8
        --]]
        while coroutine.status(u9) ~= "dead" and task.wait(0.04) do
            if u4:GetAttribute(u6) then
                task.cancel(u9)
                task.spawn(u8, u4:GetAttribute(u6))
                return
            end
        end
    end)
    return coroutine.yield()
end
function v1.decrement() --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if u2:IsServer() and u3 > 0 then
        local v10 = u4:GetAttribute((("%*"):format(u3)))
        if v10 then
            u4:SetAttribute(("%*"):format(v10), nil)
            u4:SetAttribute(("%*"):format(u3), nil)
            u3 = u3 - 1
        end
    else
        return
    end
end
return v1