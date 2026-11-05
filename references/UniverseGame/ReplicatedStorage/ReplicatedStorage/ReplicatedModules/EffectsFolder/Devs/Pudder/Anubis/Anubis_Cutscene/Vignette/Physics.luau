  

 

local u1 = {
    joint = {}
};

function u1.joint.new(p2, p3, p4, p5) -- Line: 4
    local Weld = Instance.new("Weld");
    Weld.Part0 = p2;
    Weld.Part1 = p3;

    if p4 then
        Weld.C0 = p4;
        Weld.C1 = p5 or CFrame.new();
    else
        Weld.C0 = CFrame.new();
        Weld.C1 = p3.CFrame:toObjectSpace(p2.CFrame);
    end;

    Weld.Parent = p3;

    return Weld;
end;

function u1.joint.combine(p6, p7) -- Line: 22
    -- upvalues: u1 (copy)
    for _, child in ipairs(p6:GetChildren()) do
        if (child:IsA("BasePart") or child:IsA("UnionOperation")) and child ~= p7 then
            u1.joint.new(child, p7);
            child.Anchored = false;
        end;

        p7.Anchored = false;
    end;
end;

return u1;