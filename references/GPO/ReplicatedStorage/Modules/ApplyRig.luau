 

return {
    ["Rig"] = function(_, p1, p2, p3, p4) --[[ Name: Rig, Line 3 ]]
        local v5 = p1:FindFirstChild(p2)
        local v6 = script:FindFirstChild(p3):Clone()
        v6.Parent = p1
        local v7
        if v6:IsA("Model") then
            v7 = v6.PrimaryPart
        else
            v7 = v6
            v6 = nil
        end
        local v8 = Instance.new("Motor6D")
        v8.Part0 = v5
        v8.Part1 = v7
        v8.C0 = v7:GetAttribute("C0")
        v8.C1 = v7:GetAttribute("C1")
        v8.Name = p4 or "Motor6D"
        v8.Parent = v5
        return v6 or v7
    end,
    ["Align"] = function(_, p9, ...) --[[ Name: Align, Line 31 ]]
        local v10, v11 = ...
        local v12 = p9:FindFirstChildWhichIsA("AlignOrientation") or script.AlignOrientation:Clone()
        local v13 = p9:FindFirstChildWhichIsA("AlignPosition") or script.AlignPosition:Clone()
        local v14 = v11 or {}
        for v15, v16 in next, v10 or {} do
            v12[v15] = v16
        end
        for v17, v18 in next, v14 do
            v13[v17] = v18
        end
        v12.Attachment0 = p9.HumanoidRootPart.RootRigAttachment
        v13.Attachment0 = p9.HumanoidRootPart.RootRigAttachment
        v13.Parent = p9
        v12.Parent = p9
        return v13, v12
    end
}