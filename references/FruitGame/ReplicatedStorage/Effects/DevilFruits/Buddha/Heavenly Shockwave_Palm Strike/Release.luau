 

local u1 = require(script.InitiateVFX)
return function(_, ...) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = { ... }
    local v3 = v2[1]
    if v3.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(v3.PrimaryPart.Position) ~= false then
        local v4 = v3.Humanoid.RootPart
        local v5 = ("Form/Base"):split("/")
        local v6 = v3:GetAttribute("InForm")
        local v7 = v3:GetAttribute("BeastType") == "Full"
        local v8 = script
        local v9
        if v6 then
            v9 = v5[1]
        else
            v9 = v5[2]
        end
        local v10 = v8:FindFirstChild(v9)
        if v6 then
            v10 = v10:FindFirstChild(v3:GetAttribute("BeastType"))
        end
        warn("in form ", (tostring(v6)))
        local v11 = not v2[3] and 100 or v2[3]
        local v12 = not v2[4] and 0.2 or v2[4]
        local v13
        if v6 and v7 then
            v13 = CFrame.new(0, 0, -32)
        else
            v13 = CFrame.new(0, 0, -6)
        end
        local v14 = (v4.CFrame * v13).Position
        local v15 = CFrame.new(v14, v2[2])
        u1.CreateWind(v4.CFrame * v13 * CFrame.new(0, 0, 5), v10)
        u1.CreateBall(v15, v11, v12, v6, v7, v10)
    end
end