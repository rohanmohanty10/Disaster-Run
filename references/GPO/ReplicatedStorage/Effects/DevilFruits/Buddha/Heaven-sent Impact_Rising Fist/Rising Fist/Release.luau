 

local u1 = require(script.InitiateVFX)
return function(p2, ...) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = { ... }
    local v4 = v3[1]
    if _G.checkRenderDistance(v4.PrimaryPart.Position) ~= false then
        local _ = v4.Humanoid.RootPart;
        ("Form/Base"):split("/")
        v4:GetAttribute("InForm")
        local _ = v4:GetAttribute("BeastType") == "Full"
        local v5 = script.Base
        table.insert(v3, v5)
        u1[p2](unpack(v3))
    end
end