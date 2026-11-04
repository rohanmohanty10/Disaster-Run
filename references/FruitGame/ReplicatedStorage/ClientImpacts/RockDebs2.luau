 

local v1 = {}
game:GetService("PhysicsService")
function v1.start(_, p2) --[[ Line: 5 ]]
    local v3 = p2.rep
    local v4 = p2.max
    local v5 = p2.min
    local v6 = p2.cf
    local v7 = p2.vel
    local v8 = p2.color
    local v9 = p2.material
    local v10 = p2.normal
    if v10 == nil then
        v10 = v6
    end
    if not v6 or _G.checkRenderDistance(v6.p) ~= false then
        local v11, v12, v13 = unpack(v7)
        for _ = 1, v3 do
            local u14 = script["Rock" .. math.random(1, 3)]:Clone()
            local v15 = math.random(v5 * 100, v4 * 100) / 100
            v6 = CFrame.new(v6.Position)
            local v16 = v6 * CFrame.new(0, v15 * 2, 0)
            local v17 = CFrame.Angles
            local v18 = math.random(-360, 360)
            local v19 = math.rad(v18)
            local v20 = math.random(-360, 360)
            local v21 = math.rad(v20)
            local v22 = math.random(-360, 360)
            u14.CFrame = v16 * v17(v19, v21, (math.rad(v22)))
            u14.Massless = true
            if v10 then
                u14.CFrame = CFrame.new(v6.p, v6.p + v10) * CFrame.new(0, v15 * 2, 0)
            end
            local v23 = math.random(-v11, v11)
            local v24 = math.random(v12 / 2, v12)
            local v25 = math.random
            local v26 = -v13
            u14.Velocity = Vector3.new(v23, v24, v25(v26, v13))
            local v27 = math.random(-5, 5)
            local v28 = math.random(-5, 5)
            local v29 = math.random
            u14.RotVelocity = Vector3.new(v27, v28, v29(-5, 5))
            u14.Size = Vector3.new(v15, v15, v15)
            if v8 then
                u14.Color = v8
            end
            if v9 then
                u14.Material = v9
            end
            local u30 = script.treesmoke:Clone()
            u30.Size = NumberSequence.new(u14.Size.Magnitude / 2)
            u30.Color = ColorSequence.new(u14.Color)
            u30.Parent = u14
            u14.Parent = workspace.Effects
            _G.destroy(u14, 30)
            _G.setCollisionGroup(u14, "Ragdolls")
            task.spawn(function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u30
                --]]
                task.wait(0.1)
                local u31 = nil
                u31 = u14.Touched:Connect(function(p32) --[[ Line: 52 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u14
                        [3] = u31
                    --]]
                    if p32:IsDescendantOf(workspace.Islands) == true or (p32:IsDescendantOf(workspace.Env) == true or p32:IsDescendantOf(workspace.Ships) == true) then
                        u30:Emit(25)
                        u14.CastShadow = false
                        u14.Anchored = true
                        u31:disconnect()
                        u31 = nil
                        u14.Transparency = 1
                        _G.destroy(u14, 4)
                    end
                end)
            end)
        end
    end
end
return v1