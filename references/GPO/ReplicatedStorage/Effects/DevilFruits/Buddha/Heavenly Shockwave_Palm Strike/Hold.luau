 

local _ = _G.Ess.Tween
local u1 = _G.Emit
local _ = _G.ToggleInvis
local u19 = {
    ["InUse"] = {},
    ["Start"] = function(p2, p3, p4) --[[ Name: Start, Line 13 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u19
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v5 = {}
            for v6, v7 in { "Right" } do
                local v8 = p2:FindFirstChild(v7 .. "Hand")
                local v9 = script.Hold:Clone()
                local v10 = v9.Ball2
                v9:ScaleTo(p3)
                v10.CFrame = v8.CFrame
                v10.Name = v7
                v10.Parent = workspace.Effects
                _G.customWeld(v10, v8, CFrame.new(), v10)
                if p3 > 1 then
                    local v11 = v10:GetDescendants()
                    for v12 = 1, #v11 do
                        if v11[v12]:IsA("ParticleEmitter") then
                            local v13 = v11[v12]
                            v13.ZOffset = v13.ZOffset * 5
                            warn(v11[v12].ZOffset)
                        end
                    end
                end
                u1(v10.Enable, false)
                v5[v6] = v10
            end
            u19.InUse[p4] = v5
        end
    end,
    ["Stage2"] = function(p14) --[[ Name: Stage2, Line 52 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u1
        --]]
        for _, v15 in u19.InUse[p14] do
            if v15.Name ~= "Right" then
                u1(v15.Enable, false)
            end
        end
    end,
    ["End"] = function(p16) --[[ Name: End, Line 72 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        local v17 = u19.InUse[p16]
        if v17 then
            for _, v18 in v17 do
                v18:Destroy()
            end
            u19.InUse[p16] = nil
        end
    end
}
return function(p20, ...) --[[ Line: 86 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    u19[p20](...)
end