 

local u1 = {
    ["joint"] = {}
}
function u1.joint.new(p2, p3, p4, p5) --[[ Line: 4 ]]
    local v6 = Instance.new("Weld")
    v6.Part0 = p2
    v6.Part1 = p3
    if p4 then
        v6.C0 = p4
        v6.C1 = p5 or CFrame.new()
    else
        v6.C0 = CFrame.new()
        v6.C1 = p3.CFrame:toObjectSpace(p2.CFrame)
    end
    v6.Parent = p3
    return v6
end
function u1.joint.combine(p7, p8) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _, v9 in p7:GetChildren() do
        if (v9:IsA("BasePart") or v9:IsA("UnionOperation")) and v9 ~= p8 then
            u1.joint.new(v9, p8)
            v9.Anchored = false
        end
        p8.Anchored = false
    end
end
return u1