 

game:GetService("RunService")
local u1 = {}
require(script:WaitForChild("Modes"))
local u2 = require(script:WaitForChild("Styles"));
(function(p3, p4) --[[ Line: 10 ]]
    for _, v5 in ipairs(p4) do
        if v5:IsA("ModuleScript") or v5 ~= "string" then
            p3[v5.Name] = require(v5)
        else
            p3[v5.Name] = v5
        end
    end
end)(u1, script:WaitForChild("Presets"):GetChildren())
return {
    ["new"] = function(u6, u7, u8) --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u8.PauseThread then
            if u8.PauseThread ~= false then
                local v9 = u2[u6]
                if v9 then
                    v9 = u2[u6](u7, u8 or {})
                end
                return v9
            end
            task.spawn(function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u6
                    [3] = u7
                    [4] = u8
                --]]
                local v10 = u2[u6]
                if v10 then
                    v10 = u2[u6](u7, u8 or {})
                end
                return v10
            end)
        else
            task.spawn(function() --[[ Line: 29 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u6
                    [3] = u7
                    [4] = u8
                --]]
                local v11 = u2[u6]
                if v11 then
                    v11 = u2[u6](u7, u8 or {})
                end
                return v11
            end)
        end
    end,
    ["preset"] = function(p12, p13, p14) --[[ Line: 46 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v15 = u1[p12]
        if v15 then
            v15 = u1[p12](p13, p14 or {})
        end
        return v15
    end
}