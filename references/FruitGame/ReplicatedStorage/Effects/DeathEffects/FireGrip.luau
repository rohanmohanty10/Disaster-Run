 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, _) --[[ Line: 5 ]]
    _G.PlaySound(p2.PrimaryPart, script.FlameGrip)
    local v3 = next
    local v4, v5 = p2:GetChildren()
    for _, v6 in v3, v4, v5 do
        if v6:IsA("BasePart") then
            local v7 = next
            local v8, v9 = script.Effects:GetDescendants()
            local u10 = {}
            for _, v11 in v7, v8, v9 do
                if v11:IsA("ParticleEmitter") then
                    local v12 = v11:Clone()
                    v12.Parent = v6
                    u10[#u10 + 1] = v12
                end
            end
            task.delay(1, function() --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                task.wait(1)
                for _, u13 in next, u10 do
                    u13.Enabled = false
                    task.delay(1, function() --[[ Line: 25 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                        --]]
                        u13:Destroy()
                    end)
                end
            end)
        end
    end
end
return v1