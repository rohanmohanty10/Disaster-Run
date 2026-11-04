 

local u1 = game:GetService("TweenService")
local u2 = workspace.Effects
local u3 = Random.new()
local u54 = {
    ["Frequency"] = 1,
    ["Resolution"] = 10,
    ["_createPoints"] = function(_, p4) --[[ Name: _createPoints, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v5 = {}
        local v6 = p4.Start
        local v7 = p4.End
        local v8 = p4.Amount
        local v9 = p4.OffsetRadius or 2.5
        table.insert(v5, v6)
        for v10 = 2, v8 - 1 do
            local v11 = v6:Lerp(v7, v10 / v8) + u3:NextUnitVector() * v9
            table.insert(v5, v11)
        end
        table.insert(v5, v7)
        return v5
    end,
    ["_createBoltSegment"] = function(_, u12) --[[ Name: _createBoltSegment, Line 30 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v13 = u12.Duration
        local u14 = u12.Model
        local _ = u12.Width or 1
        local v15 = u12.OuterColor
        local v16 = u12.Size
        local v17 = u12.CFrame
        local u18 = u12.Particle
        local u19
        if u18 then
            u19 = script.Bolt:Clone()
            u19.CanQuery = false
            u19.CastShadow = false
            u19.CanCollide = false
            u19.Anchored = true
            u19.Material = Enum.Material.Neon
            u19.Color = v15
            u19.CFrame = v17
            u19.Size = v16
            u19.Parent = u14
            for _, v20 in u19:GetDescendants() do
                if v20:IsA("ParticleEmitter") then
                    v20.Enabled = false
                    v20:Emit(v20:GetAttribute("EmitCount") or 2)
                end
            end
        else
            u19 = Instance.new("Part")
            u19.CanQuery = false
            u19.CastShadow = false
            u19.CanCollide = false
            u19.Anchored = true
            u19.Material = Enum.Material.Neon
            u19.Color = v15
            u19.CFrame = v17
            u19.Size = v16
            u19.Parent = u14
            local v21 = u1
            local v22 = TweenInfo.new(v13)
            local v23 = {}
            local v24 = v16.Z
            v23.Size = Vector3.new(0, 0, v24)
            v21:Create(u19, v22, v23):Play()
        end
        task.delay(v13, function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u19
                [3] = u14
                [4] = u12
            --]]
            if u18 then
                task.wait(0.5)
            end
            u19:Destroy()
            if #u14:GetChildren() == 1 and u12.AmountOfParts == (u12.Amount - 1) * u12.Resolution then
                u14:Destroy()
            end
        end)
        return u19
    end,
    ["_createBoltBezier"] = function(_, p25, p26, p27) --[[ Name: _createBoltBezier, Line 86 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u3
        --]]
        local v28 = p27.Width or 1
        local v29 = p27.Resolution or 3
        local v30 = p27.Duration
        local v31 = p27.WaitDuration
        local v32 = p27.OffsetRadius
        local v33 = v28 / v30
        local v34 = p26 - p25
        local _ = v34.Unit
        local _ = v34.Magnitude
        local _ = p27.Model
        local v35 = u54.Frequency
        local v36 = u54.Resolution
        local _ = v28 * 2
        local v37 = v34 * 0.5 + p25 + u3:NextUnitVector() * v32
        local v38 = {}
        for v39 = 0, v29 do
            local v40 = v39 / v29
            v38[v39] = p25:Lerp(v37, v40):Lerp(v37:Lerp(p26, v40), v40) + u3:NextUnitVector() * ((v39 == 0 or v39 == v29) and 0 or (v32 * 0.15 or 0))
        end
        for v41 = 0, v29 - 1 do
            p27.AmountOfParts = p27.AmountOfParts + 1
            local v42 = (math.noise(p27.AmountOfParts / v36 * v35 + p27.NoiseOffset, p27.Seed) + 0.5) * v28
            if v42 >= v28 / 5 then
                local v43 = v38[v41 + 1] - v38[v41]
                local v44 = v43.Unit
                local v45 = v43.Magnitude
                local v46 = CFrame.new(Vector3.new(0, 0, 0), v44) + v38[v41] + v43 * 0.5
                p27.Size = Vector3.new(v42, v42, v45)
                p27.CFrame = v46
                p27.BoltDuration = v42 / v33
                u54:_createBoltSegment(p27)
                if v31 and v31 > 0 then
                    task.wait(v31)
                end
            end
        end
    end,
    ["_render"] = function(_, p47) --[[ Name: _render, Line 139 ]]
        --[[
        Upvalues:
            [1] = u54
        --]]
        local v48 = p47.Points
        for v49 = 1, #v48 - 1 do
            u54:_createBoltBezier(v48[v49], v48[v49 + 1], p47)
        end
    end,
    ["_createModel"] = function(_, p50) --[[ Name: _createModel, Line 147 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v51 = Instance.new("Model")
        v51.Parent = u2
        if p50.Particle then
            return v51
        end
        local v52 = Instance.new("Highlight")
        v52.OutlineTransparency = 0
        v52.FillTransparency = 0
        v52.OutlineColor = p50.OuterColor
        v52.FillColor = p50.InnerColor
        v52.DepthMode = Enum.HighlightDepthMode.Occluded
        v52.Parent = v51
        return v51
    end,
    ["CreateLightning"] = function(_, p53) --[[ Name: CreateLightning, Line 166 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u3
        --]]
        p53.Amount = p53.Amount or 10
        p53.Points = u54:_createPoints(p53)
        p53.Seed = u3:NextNumber(0, 1)
        p53.AmountOfParts = 0
        p53.NoiseOffset = u3:NextInteger(1, 100)
        p53.Model = u54:_createModel(p53)
        task.spawn(u54._render, u54, p53)
    end
}
return u54