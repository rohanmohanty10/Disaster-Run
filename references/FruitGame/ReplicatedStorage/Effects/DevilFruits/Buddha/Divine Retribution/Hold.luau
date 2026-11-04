 

local _ = _G.Ess.Tween
local _ = _G.Emit
local _ = _G.ToggleInvis
local u14 = {
    ["InUse"] = {},
    ["Start"] = function(p1, p2) --[[ Name: Start, Line 13 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v3 = {}
        for v4, v5 in { "Right", "Left" } do
            local v6 = p1:FindFirstChild(v5 .. "Hand")
            local v7 = script.Ball2:Clone()
            v7.CFrame = v6.CFrame
            v7.RigidConstraint.Attachment1 = v6:FindFirstChild(v5 .. "WristRigAttachment")
            v7.Name = v5
            v7.Parent = workspace.Effects
            v3[v4] = v7
        end
        u14.InUse[p2] = v3
    end,
    ["Stage2"] = function(p8) --[[ Name: Stage2, Line 33 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v9 = u14.InUse[p8]
        if v9 then
            for _, v10 in v9 do
                local _ = v10.Name == "Right"
            end
        end
    end,
    ["End"] = function(p11) --[[ Name: End, Line 55 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v12 = u14.InUse[p11]
        if v12 then
            for _, v13 in v12 do
                v13:Destroy()
            end
            u14.InUse[p11] = nil
        end
    end
}
return function(p15, ...) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u14
    --]]
    u14[p15](...)
end