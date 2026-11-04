 

game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local u1 = workspace.Effects
local function u12(p2, p3, p4) --[[ Line: 9 ]]
    local function v10(u5, p6, p7) --[[ Line: 10 ]]
        for _, v8 in ipairs(u5:GetDescendants()) do
            if v8:IsA("ParticleEmitter") or v8:IsA("Trail") then
                v8.Enabled = p6
            end
        end
        if p7 then
            task.delay(p7, function() --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                for _, v9 in ipairs(u5:GetDescendants()) do
                    if v9:IsA("ParticleEmitter") or v9:IsA("Trail") then
                        v9.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p2) == "table" then
        for _, v11 in p2 do
            v10(v11, p3, p4)
        end
    else
        v10(p2, p3, p4)
    end
end
return {
    ["start"] = function(_, p13, p14) --[[ Name: start, Line 47 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u12
        --]]
        local v15 = p13.HumanoidRootPart
        local _ = p13 == game.Players.LocalPlayer.Character
        local u16 = script.Transformation:Clone()
        u16:PivotTo(v15.CFrame * CFrame.new(0, -2.2, 0))
        local v17, v18, _ = _G.getRayFloor(v15.CFrame, 5)
        if v17 then
            u16:PivotTo(CFrame.new(v18 + Vector3.new(0, 0.1, 0)))
        end
        u16.Parent = u1
        _G.customEmit(u16.Transform1)
        _G.customEmit(u16.Transform2)
        _G.destroy(u16.Transform1, 2)
        _G.destroy(u16.Transform2, 2)
        u12(u16.Aura, true)
        u16.Aura.Anchored = false
        u16.Aura.CFrame = v15.CFrame * CFrame.new(0, -1, 0)
        local v19 = u16.Aura
        local v20 = Instance.new("WeldConstraint")
        v20.Part0 = v19
        v20.Part1 = v15
        v20.Parent = v19
        task.delay(p14, function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u16
            --]]
            u12(u16.Aura, false)
            _G.destroy(u16, 3)
        end)
    end
}