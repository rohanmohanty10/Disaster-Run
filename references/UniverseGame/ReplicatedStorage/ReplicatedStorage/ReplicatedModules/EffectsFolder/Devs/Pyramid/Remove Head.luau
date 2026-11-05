  

 

local u1 = {};

return function(p2, p3) -- Line: 2
    -- upvalues: u1 (copy)
    local v4 = p3.Head:Clone();
    v4.Parent = workspace.Effects;
    v4.Transparency = 0;
    v4.CanCollide = false;
    v4.Massless = true;
    local ManualWeld = Instance.new("ManualWeld", v4);
    ManualWeld.Part0 = p2["Right Arm"];
    ManualWeld.Part1 = v4;
    ManualWeld.C1 = CFrame.new(0, 0.5, 0.5);
    ManualWeld.C1 = ManualWeld.C1 * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);

    for _, descendant in pairs(p3:GetDescendants()) do
        if (descendant:IsA("Weld") or descendant:IsA("ManualWeld")) and descendant.Part0 == p3.Head then
            local Weld = Instance.new("Weld", v4);
            local v5 = descendant.Part1:Clone();
            v5.Parent = v4;
            Weld.Part0 = v4;
            Weld.Part1 = v5;
            Weld.C0 = descendant.C0;
            Weld.C1 = descendant.C1;
            v5.CanCollide = false;
            v5.Massless = true;
            v5.Transparency = 0;
        end;
    end;

    u1.FunnyHeadRip = {
        [v4] = "delete",
        [p3.Head] = {
            Transparency = p3.Head.Transparency
        }
    };
    p3.Head.Transparency = 1;

    for _, descendant in pairs(p3.Head:GetDescendants()) do
        pcall(function() -- Line: 35
            -- upvalues: u1 (ref), descendant (copy)
            u1.FunnyHeadRip[descendant] = {
                Transparency = descendant.Transparency
            };
            descendant.Transparency = 1;
        end);
    end;

    local v6 = {
        Enum.AccessoryType.Hat,
        Enum.AccessoryType.Face,
        Enum.AccessoryType.Hair,
        Enum.AccessoryType.Neck,
        Enum.AccessoryType.Unknown
    };

    for _, descendant in pairs(p3:GetDescendants()) do
        if descendant:IsA("Accessory") and table.find(v6, descendant.AccessoryType) then
            local Handle = descendant.Handle;
            local Weld = Instance.new("Weld", v4);
            local v7 = Handle:Clone();
            v7.Parent = v4;
            Weld.Part0 = v7;
            Weld.Part1 = v4;
            Weld.C0 = Handle.AccessoryWeld.C0;
            Weld.C1 = Handle.AccessoryWeld.C1;
            v7.CanCollide = false;
            v7.Massless = true;
            v7.Transparency = 0;
            Handle.Transparency = 1;
            u1.FunnyHeadRip[Handle] = {
                Transparency = Handle.Transparency
            };
        end;
    end;
end;