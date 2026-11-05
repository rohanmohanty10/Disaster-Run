  

 

local RunService = game:GetService("RunService");

return function(p1, p2) -- Line: 8
    -- upvalues: RunService (copy)
    if p1 == nil then
        return;
    end;

    if p1:IsA("Model") then
        p1 = p1.PrimaryPart or (p1:FindFirstChild("HumanoidRootPart") or p1:FindFirstChildWhichIsA("BasePart"));
    end;

    if p1 == nil or p1:IsA("BasePart") ~= true then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = math.random();
    Part.Size = Vector3.new(0.001, 0.001, 0.001);
    Part.Massless = true;
    Part.Transparency = 1;
    local Weld = Instance.new("Weld");
    Weld.Part0 = p1;
    Weld.Part1 = Part;
    Weld.Parent = Part;
    Part.Parent = p1;
    local u3 = (p2 == nil or type(p2.Time) ~= "number") and 0.5 or p2.Time;
    local u4 = nil;
    u4 = RunService.PreSimulation:Connect(function(p5) -- Line: 35
        -- upvalues: Weld (copy), u3 (ref), Part (copy), u4 (ref)
        Weld.C0 = CFrame.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5);
        u3 = u3 - p5;

        if u3 <= 0 then
            Part:Destroy();
            u4:Disconnect();
            u4 = nil;
        end;
    end);
end;