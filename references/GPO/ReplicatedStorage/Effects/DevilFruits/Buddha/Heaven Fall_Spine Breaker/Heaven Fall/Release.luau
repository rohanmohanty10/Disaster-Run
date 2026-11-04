 

local u1 = require(script.InitiateVFX)
return function(p2, ...) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = { ... }
    local v4 = v3[1]
    local v5 = v4.RightHand
    local _ = v4.Humanoid.RootPart;
    ("Form/Base"):split("/")
    v4:GetAttribute("InForm")
    local _ = v4:GetAttribute("BeastType") == "Full"
    local v6 = script.Form:FindFirstChild(v4:GetAttribute("BeastType"))
    table.insert(v3, v5)
    table.insert(v3, v6)
    u1[p2](unpack(v3))
end