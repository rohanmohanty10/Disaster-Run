 

local u45 = {
    ["QuickWeld"] = function(_, p1, p2, p3, p4) --[[ Name: QuickWeld, Line 4 ]]
        local v5 = Instance.new("Weld")
        v5.Part0 = p1
        v5.Part1 = p2
        if p3 ~= nil then
            v5.C0 = p3
        end
        if p4 ~= nil then
            v5.C1 = p4
        end
        v5.Parent = p1
        return v5
    end,
    ["QuickMotor6d"] = function(_, p6, p7, p8, p9) --[[ Name: QuickMotor6d, Line 21 ]]
        local v10 = Instance.new("Motor6D")
        v10.Part0 = p6
        v10.Part1 = p7
        if p8 ~= nil then
            v10.C0 = p8
        end
        if p9 ~= nil then
            v10.C1 = p9
        end
        v10.Parent = p6
        return v10
    end,
    ["AddItem"] = function(_, u11, p12) --[[ Name: AddItem, Line 37 ]]
        task.delay(p12, function() --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            if u11.Parent ~= nil then
                u11:Destroy()
            end
        end)
    end,
    ["ClearChildren"] = function(_, u13) --[[ Name: ClearChildren, Line 45 ]]
        task.spawn(function() --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            for _, v14 in ipairs(u13:GetChildren()) do
                v14:Destroy()
            end
        end)
    end,
    ["Emit"] = function(_, p15) --[[ Name: Emit, Line 55 ]]
        for _, v16 in ipairs(p15:GetDescendants()) do
            if v16:IsA("ParticleEmitter") then
                v16:Emit(v16:GetAttribute("EmitCount"))
            end
        end
    end,
    ["DelayEmit"] = function(_, u17, p18) --[[ Name: DelayEmit, Line 63 ]]
        --[[
        Upvalues:
            [1] = u45
        --]]
        task.delay(p18, function() --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u45
                [2] = u17
            --]]
            u45:Emit(u17)
        end)
    end,
    ["ToggleEnabled"] = function(_, p19, p20) --[[ Name: ToggleEnabled, Line 69 ]]
        for _, v21 in ipairs(p19:GetDescendants()) do
            if v21:IsA("ParticleEmitter") then
                v21.Enabled = p20
            end
        end
    end,
    ["GetBodyParts"] = function(_) --[[ Name: GetBodyParts, Line 77 ]]
        return {
            "RightUpperArm",
            "RightLowerArm",
            "RightHand",
            "LeftUpperArm",
            "LeftLowerArm",
            "LeftHand",
            "LeftUpperLeg",
            "LeftLowerLeg",
            "LeftFoot",
            "RightUpperLeg",
            "RightLowerLeg",
            "RightFoot",
            "Head",
            "UpperTorso",
            "LowerTorso"
        }
    end,
    ["GetQuadBezier"] = function(_, p22, p23, p24, p25) --[[ Name: GetQuadBezier, Line 101 ]]
        local v26 = p23 + (p24 - p23) * p22
        return v26 + (p24 + (p25 - p24) * p22 - v26) * p22
    end,
    ["GetCubicBezier"] = function(_, p27, p28, p29, p30, p31) --[[ Name: GetCubicBezier, Line 108 ]]
        return (1 - p27) ^ 3 * p28 + 3 * (1 - p27) ^ 2 * p27 * p29 + 3 * (1 - p27) * p27 ^ 2 * p30 + p27 ^ 3 * p31
    end,
    ["GetRadialPoints"] = function(_, p32, p33, p34) --[[ Name: GetRadialPoints, Line 112 ]]
        local v35 = {}
        for v36 = 1, p33 do
            local v37 = 6.283185307179586 / p33 * v36
            local v38 = math.sin(v37) * p34
            local v39 = math.cos(v37) * p34
            v35[v36] = p32 * CFrame.new(v39, 0, v38)
        end
        return v35
    end,
    ["VisualizeHitbox"] = function(_, p40, p41, p42, p43) --[[ Name: VisualizeHitbox, Line 125 ]]
        --[[
        Upvalues:
            [1] = u45
        --]]
        local v44 = Instance.new("Part")
        v44.CFrame = p41
        if typeof(p42) == "number" then
            v44.Size = Vector3.new(p42, p42, p42)
        else
            v44.Size = p42
        end
        v44.Shape = p40 or Enum.PartType.Block
        v44.Anchored = true
        v44.CanCollide = false
        v44.CanTouch = false
        v44.CanQuery = false
        v44.Color = Color3.new(0.9, 0, 0)
        v44.Transparency = 0.92
        v44.Material = Enum.Material.Neon
        v44.Parent = workspace.Effects
        u45:AddItem(v44, p43 or 1)
    end
}
return u45