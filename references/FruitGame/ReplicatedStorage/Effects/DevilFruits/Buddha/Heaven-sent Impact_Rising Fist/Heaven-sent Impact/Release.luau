 

local u1 = require(script.InitiateVFX)
return function(p2, ...) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = { ... }
    local v4 = v3[1]
    if _G.checkRenderDistance(v4.PrimaryPart.Position) ~= false then
        local _ = v4.Humanoid.RootPart
        local v5 = ("Form/Base"):split("/")
        local v6 = v4:GetAttribute("InForm")
        local _ = v4:GetAttribute("BeastType") == "Full"
        local v7 = script
        local v8
        if v6 then
            v8 = v5[1]
        else
            v8 = v5[2]
        end
        local v9 = v7:FindFirstChild(v8)
        if v6 then
            v9 = v9:FindFirstChild(v4:GetAttribute("BeastType"))
        end
        table.insert(v3, v9)
        u1[p2](unpack(v3))
    end
end