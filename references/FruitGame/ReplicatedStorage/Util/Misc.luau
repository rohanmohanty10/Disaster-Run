 

local u1 = game:GetService("TweenService")
local u72 = {
    ["ScaleParticleSize"] = function(p2, p3) --[[ Name: ScaleParticleSize, Line 4 ]]
        local v4 = {}
        for _, v5 in next, p2 do
            local v6 = v5.Value * p3
            local v7 = math.max(0, v6)
            local v8 = NumberSequenceKeypoint.new
            local v9 = v5.Time
            local v10 = v7 < v5.Envelope and v7 and v7 or v5.Envelope
            table.insert(v4, v8(v9, v7, v10))
        end
        return NumberSequence.new(v4)
    end,
    ["AlignCFrame"] = function(p11, p12, p13) --[[ Name: AlignCFrame, Line 12 ]]
        local v14 = p11.p
        local v15 = p11.LookVector:Cross(p12).Unit
        local v16 = (v15.Magnitude > 0.001 and v15 and v15 or p11.RightVector).Unit
        local v17 = v16:Cross(p12).Unit.Unit
        if p13 then
            local v18 = Instance.new("Part")
            v18.TopSurface = 0
            v18.BottomSurface = 0
            v18.FrontSurface = 6
            v18.Anchored = true
            v18.CanCollide = false
            v18.Size = Vector3.new(1, 1, 1)
            v18.Color = Color3.new(0, 1, 0)
            local v19 = v18:Clone()
            v19.Color = Color3.new(1, 1, 0)
            local v20 = v18:Clone()
            v20.Color = Color3.new(1, 0, 0)
            v18.CFrame = CFrame.new(v14, v14 + v16)
            v19.CFrame = CFrame.new(v14, v14 + p12)
            v20.CFrame = CFrame.new(v14, v14 + v17)
            local v21 = workspace._WorldOrigin
            local v22 = workspace._WorldOrigin
            local v23 = workspace._WorldOrigin
            v18.Parent = v21
            v19.Parent = v22
            v20.Parent = v23
        end
        return CFrame.fromMatrix(v14, v16, p12, v17)
    end,
    ["DestroySound"] = function(u24, p25) --[[ Name: DestroySound, Line 44 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v26 = TweenInfo.new(p25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local v27
        if u24:IsA("Attachment") then
            v27 = u24:FindFirstChildOfClass("Sound")
        else
            v27 = u24
        end
        if v27 then
            local v28 = u1:Create(v27, v26, {
                ["Volume"] = 0
            })
            v28.Completed:Connect(function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24:Destroy()
            end)
            v28:Play()
        end
    end,
    ["PlaySound"] = function(p29, p30, p31, p32) --[[ Name: PlaySound, Line 63 ]]
        --[[
        Upvalues:
            [1] = u72
        --]]
        local v33, v34
        if typeof(p29) == "CFrame" or typeof(p29) == "Vector3" then
            local v35 = typeof(p29) == "CFrame" and p29 and p29 or CFrame.new(p29)
            p29 = Instance.new("Attachment")
            p29.CFrame = v35
            p29.Parent = workspace.Terrain
            v33 = p29
            v34 = v33
            local v36 = v33
            v33 = v34
            v36 = v34
        else
            v34 = p29
            v33 = nil
        end
        local v37 = p30:Clone()
        v37.Parent = p29
        if typeof(v34) == "userdata" and v34:IsA("Attachment") == false then
            local v38 = Instance.new("Attachment", workspace.Terrain)
            v38.WorldPosition = v34.Position
            v37.Parent = v38
            if v33 then
                v33:Destroy()
            end
            u72.DestroySound(v38, v37.TimeLength + 2)
        else
            u72.DestroySound(v37, v37.TimeLength + 2)
        end
        if p31 then
            for v39, v40 in p31 do
                if v37[v39] then
                    v37[v39] = v40
                end
            end
        end
        if p32 == nil then
            v37.PlayOnRemove = false
            v37:Play()
            return v37
        else
            v37.PlayOnRemove = true
            v37:Destroy()
            return nil
        end
    end,
    ["Ray"] = {
        ["Whitelist"] = function(p41, p42, p43) --[[ Name: Whitelist, Line 108 ]]
            local v44 = Ray.new(p41, p42)
            return _G.raycastWhitelist(v44, p43 or {})
        end
    },
    ["Shuffle"] = function(p45) --[[ Name: Shuffle, Line 114 ]]
        for v46 = #p45, 2, -1 do
            local v47 = math.random(v46)
            local v48 = p45[v47]
            local v49 = p45[v46]
            p45[v46] = v48
            p45[v47] = v49
        end
        return p45
    end,
    ["InCylinder"] = function(p50, p51, p52) --[[ Name: IsInRobloxCylinder, Line 124 ]]
        local v53 = p52 - p50.p
        local v54 = p50:vectorToWorldSpace(Vector3.new(1, 0, 0))
        local v55 = v54:Dot(v53)
        local v56
        if v55 < p51.x / 2 and -p51.x / 2 < v55 then
            local v57 = (v53 - v55 * v54).magnitude
            local v58 = p51.y
            local v59 = p51.z
            v56 = v57 < math.max(v58, v59) / 2
        else
            v56 = false
        end
        return v56
    end,
    ["TrailBeacons"] = function(p60, p61, p62) --[[ Name: TrailBeacons, Line 136 ]]
        local v63 = (p62 or 1) / 2
        local v64 = {}
        local v65 = (p61 - p60).Magnitude
        local v66
        if v65 <= v63 then
            v66 = 1
        else
            local v67 = v65 / v63
            v66 = math.floor(v67)
        end
        for v68 = 1, v66 do
            local v69 = CFrame.new(p60, p61)
            local v70 = -v63 * v68
            local v71 = v69 * Vector3.new(0, 0, v70)
            table.insert(v64, v71)
        end
        return v64
    end
}
return u72