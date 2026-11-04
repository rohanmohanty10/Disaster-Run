 

local u1 = game:GetService("TweenService")
local u2 = workspace.Effects
local u3 = Random.new()
local u59 = {
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
        local v8 = p4.Middle or (v7 - v6) * 0.5 + v6
        local v9 = p4.Amount
        local v10 = p4.OffsetRadius or 2.5
        table.insert(v5, v6)
        for v11 = 2, v9 - 1 do
            local v12 = v11 / v9
            local v13 = v6:Lerp(v8, v12):Lerp(v8:Lerp(v7, v12), v12) + u3:NextUnitVector() * v10
            table.insert(v5, v13)
        end
        table.insert(v5, v7)
        return v5
    end,
    ["_createBoltSegment"] = function(_, u14) --[[ Name: _createBoltSegment, Line 36 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v15 = u14.Duration
        local u16 = u14.Model
        local _ = u14.Width or 1
        local v17 = u14.OuterColor
        local v18 = u14.Size
        local v19 = u14.CFrame
        local u20 = script.boltPart:Clone()
        u20.Color = v17
        u20.CFrame = v19
        u20.Size = v18
        u20.Parent = u16
        local v21 = u1
        local v22 = TweenInfo.new(v15)
        local v23 = {}
        local v24 = v18.Z
        v23.Size = Vector3.new(0, 0, v24)
        v21:Create(u20, v22, v23):Play()
        task.delay(v15, function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u14
                [3] = u16
            --]]
            u20:Destroy()
            local v25 = u14
            v25.AmountOfParts = v25.AmountOfParts - 1
            if u14.AmountOfParts == 0 then
                u16:Destroy()
            end
        end)
        return u20
    end,
    ["_createBolt"] = function(_, p26, p27, p28) --[[ Name: _createBolt, Line 65 ]]
        --[[
        Upvalues:
            [1] = u59
            [2] = u3
        --]]
        local v29 = p28.Width or 1
        local v30 = p28.Resolution or 3
        local v31 = p28.Duration
        local v32 = p28.WaitDuration
        local v33 = p28.OffsetRadius
        local v34 = v29 / v31
        local v35 = p27 - p26
        local _ = v35.Unit
        local _ = v35.Magnitude
        local v36 = p28.Model
        local v37 = u59.Frequency
        local v38 = u59.Resolution
        local v39 = v29 * 2
        local v40 = v35 * 0.5 + p26 + u3:NextUnitVector() * v33
        local v41 = {}
        for v42 = 0, v30 do
            local v43 = v42 / v30
            v41[v42] = p26:Lerp(v40, v43):Lerp(v40:Lerp(p27, v43), v43) + u3:NextUnitVector() * ((v42 == 0 or v42 == v30) and 0 or (v33 * 0.15 or 0))
        end
        for v44 = 0, v30 - 1 do
            local v45 = math.noise(p28.AmountOfParts / v38 * v37 + p28.NoiseOffset, p28.Seed) * v39
            local v46 = -v29
            local v47 = math.clamp(v45, v46, v29) + v29 / 2
            if v47 >= v29 / 7.5 then
                local v48 = v41[v44 + 1] - v41[v44]
                local v49 = v48.Unit
                local v50 = v48.Magnitude
                local v51 = CFrame.new(Vector3.new(0, 0, 0), v49) + v41[v44] + v48 * 0.5
                p28.Size = Vector3.new(v47, v47, v50)
                p28.CFrame = v51
                p28.BoltDuration = v47 / v34
                p28.AmountOfParts = p28.AmountOfParts + 1
                u59:_createBoltSegment(p28)
                if v32 and (v32 > 0 and p28.AmountOfParts % p28.Skip == 0) then
                    task.wait(v32)
                end
            end
        end
        if p28.AmountOfParts == 0 and v36.Parent then
            v36:Destroy()
        end
    end,
    ["_render"] = function(_, p52) --[[ Name: _render, Line 122 ]]
        --[[
        Upvalues:
            [1] = u59
        --]]
        local v53 = p52.Points
        p52.testing = true
        for v54 = 1, #v53 - 1 do
            u59:_createBolt(v53[v54], v53[v54 + 1], p52)
        end
    end,
    ["_createModel"] = function(_, p55) --[[ Name: _createModel, Line 131 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v56 = Instance.new("Model")
        v56.Name = "Lightning"
        v56.Parent = u2
        local v57 = Instance.new("Highlight")
        v57.OutlineTransparency = p55.OuterTransparency or 0
        v57.FillTransparency = 0
        v57.OutlineColor = p55.OuterColor
        v57.FillColor = p55.InnerColor
        v57.DepthMode = Enum.HighlightDepthMode.Occluded
        v57.Parent = v56
        return v56
    end,
    ["CreateLightning"] = function(_, p58) --[[ Name: CreateLightning, Line 147 ]]
        --[[
        Upvalues:
            [1] = u59
            [2] = u3
        --]]
        p58.Amount = p58.Amount or 10
        p58.Points = u59:_createPoints(p58)
        p58.Seed = u3:NextNumber(0, 1)
        p58.AmountOfParts = 0
        p58.NoiseOffset = u3:NextInteger(1, 100)
        p58.Model = p58.Model or u59:_createModel(p58)
        task.spawn(u59._render, u59, p58)
    end
}
return u59