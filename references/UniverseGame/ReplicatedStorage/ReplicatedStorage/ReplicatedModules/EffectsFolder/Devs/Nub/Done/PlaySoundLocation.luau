  

 

game:GetService("ContentProvider");

return function(p1, p2) -- Line: 3
    if not (p2 and p2.Parent) then
        return;
    end;

    local v3 = nil;

    if typeof(p1) == "CFrame" then
        p1 = p1.Position;
    elseif typeof(p1) == "Instance" and p1:IsA("BasePart") then
        p1 = p1.Position;
    elseif typeof(p1) ~= "Vector3" then
        p1 = v3;
    end;

    if not p1 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CanCollide = false;
    Part.Massless = true;
    Part.Parent = workspace.Effects;
    Part.CFrame = CFrame.new(p1);
    local v4 = p2:Clone();
    v4.Parent = Part;
    v4.Loaded:Wait();
    task.delay(v4.TimeLength + 0.5, Part.Destroy, Part);
    v4:Play();
end;