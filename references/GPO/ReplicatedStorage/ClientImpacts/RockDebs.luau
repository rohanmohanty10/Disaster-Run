 

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
        local v11, _, v12 = unpack(v7)
        for _ = 1, v3 do
            local u13 = script["Rock" .. math.random(1, 3)]:Clone()
            local v14 = math.random(v5 * 100, v4 * 100) / 100
            v6 = CFrame.new(v6.Position)
            local v15 = v6 * CFrame.new(0, v14 * 2, 0)
            local v16 = CFrame.Angles
            local v17 = math.random(-360, 360)
            local v18 = math.rad(v17)
            local v19 = math.random(-360, 360)
            local v20 = math.rad(v19)
            local v21 = math.random(-360, 360)
            u13.CFrame = v15 * v16(v18, v20, (math.rad(v21)))
            u13.Massless = true
            if v10 then
                u13.CFrame = CFrame.new(v6.p, v6.p + v10) * CFrame.new(0, v14 * 2, 0)
            end
            local v22 = u13.CFrame.lookVector * 100
            local v23 = math.random(-v11, v11)
            local v24 = math.random
            local v25 = -v12
            u13.Velocity = v22 + Vector3.new(v23, 0, v24(v25, v12))
            local v26 = math.random(-5, 5)
            local v27 = math.random(-5, 5)
            local v28 = math.random
            u13.RotVelocity = Vector3.new(v26, v27, v28(-5, 5))
            u13.Size = Vector3.new(v14, v14, v14)
            if v8 then
                u13.Color = v8
            end
            if v9 then
                u13.Material = v9
            end
            local u29 = script.treesmoke:Clone()
            u29.Parent = u13
            u29.Size = NumberSequence.new(u13.Size.Magnitude / 2)
            u29.Color = ColorSequence.new(u13.Color)
            u13.Parent = workspace.Effects
            _G.destroy(u13, 30)
            _G.setCollisionGroup(u13, "Ragdolls")
            task.spawn(function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u29
                --]]
                task.wait(0.1)
                local u30 = nil
                u30 = u13.Touched:Connect(function(p31) --[[ Line: 55 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u13
                        [3] = u30
                    --]]
                    if p31:IsDescendantOf(workspace.Effects) == false and (p31:IsDescendantOf(workspace.PlayerCharacters) == false and p31:IsDescendantOf(workspace.CurrentCamera) == false) then
                        u29:Emit(25)
                        u13.CastShadow = false
                        u13.Anchored = true
                        u30:disconnect()
                        u30 = nil
                        u13.Transparency = 1
                        _G.destroy(u13, 4)
                    end
                end)
            end)
        end
    end
end
return v1