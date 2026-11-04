 

local u1 = game:GetService("RunService")
return {
    ["WaitForAttribute"] = function(_, p2, p3, p4) --[[ Name: WaitForAttribute, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v5 = tick()
        local v6 = p2:GetAttribute(p3)
        local v7 = p4 or 60
        while v7 > tick() - v5 do
            v6 = p2:GetAttribute(p3)
            u1.Heartbeat:Wait()
            if v6 ~= nil then
                return v6
            end
        end
        warn("Infinite yield waiting for \"" .. p3 .. " on " .. p2:GetFullName())
        return v6
    end
}