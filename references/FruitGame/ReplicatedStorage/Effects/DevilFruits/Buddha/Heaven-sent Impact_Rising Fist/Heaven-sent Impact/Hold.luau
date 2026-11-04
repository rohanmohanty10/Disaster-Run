 

local _ = _G.Ess.Tween
local u1 = _G.Emit
local _ = _G.ToggleInvis
local u12 = {
    ["InUse"] = {},
    ["Start"] = function(p2, p3) --[[ Name: Start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u12
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            workspace:Raycast(p2:GetPivot().Position, Vector3.new(0, -3, 0), _G.RaycastParams)
            local v4 = {}
            for v5, v6 in { "Right" } do
                local v7 = script.Ball2:Clone()
                v7.RigidConstraint.Attachment1 = p2:FindFirstChild(v6 .. "Hand"):FindFirstChild(v6 .. "GripAttachment")
                v7.Parent = workspace.Effects
                u1(v7.Stage1, false)
                v4[v5] = v7
            end
            u12.InUse[p3] = v4
        end
    end,
    ["Stage2"] = function(p8) --[[ Name: Stage2, Line 32 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u1
        --]]
        for _, v9 in u12.InUse[p8] do
            u1(v9.Stage2, false)
            u1(v9.Emitters, true)
        end
    end,
    ["End"] = function(p10) --[[ Name: End, Line 43 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        for _, v11 in u12.InUse[p10] do
            v11:Destroy()
        end
        u12.InUse[p10] = nil
    end
}
return function(p13, ...) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12[p13](...)
end