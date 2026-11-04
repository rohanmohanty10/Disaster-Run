 

local u18 = {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        local v4 = nil
        local v5 = p1:FindFirstChild(p2)
        local v6 = script:FindFirstChild(p3):Clone()
        if p3 == "GumLeft" or p3 == "GumRight" then
            local v7 = p1.RightHand.Size.X
            local v8 = v6.Size.Y
            local v9 = p1.RightHand.Size.Z
            v6.Size = Vector3.new(v7, v8, v9)
        end
        v6:PivotTo(v5.CFrame)
        v6.Parent = workspace.Effects
        if v6:FindFirstChild("Skin") then
            v6.Skin.Color = p1.Head.Color
        elseif v6:IsA("Part") then
            v6.Color = p1.Head.Color
        end
        local v10
        if v6:IsA("Model") then
            v10 = v6.PrimaryPart
        else
            v10 = v6
            v6 = v4
        end
        local v11 = Instance.new("Motor6D")
        v11.Part0 = v5
        v11.Part1 = v10
        v11.C0 = v10:GetAttribute("C0")
        v11.C1 = v10:GetAttribute("C1")
        v11.Parent = v5
        return v6 or v10
    end,
    ["Rig"] = function(_, p12, p13, p14) --[[ Name: Rig, Line 39 ]]
        --[[
        Upvalues:
            [1] = u18
        --]]
        return u18:start(p12, p13, p14)
    end,
    ["Align"] = function(_, p15) --[[ Name: Align, Line 44 ]]
        local v16 = p15:FindFirstChild("AlignOrientation") or script.AlignOrientation:Clone()
        local v17 = p15:FindFirstChild("AlignPosition") or script.AlignPosition:Clone()
        v16.Attachment0 = p15.HumanoidRootPart.RootRigAttachment
        v17.Attachment0 = p15.HumanoidRootPart.RootRigAttachment
        v17.Parent = p15
        v16.Parent = p15
        return v17, v16
    end
}
_G.Apply = u18
return u18