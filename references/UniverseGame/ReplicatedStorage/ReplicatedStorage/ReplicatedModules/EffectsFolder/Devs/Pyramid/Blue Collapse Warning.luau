  

 

return function(p1, p2) -- Line: 1
    local Part = Instance.new("Part");
    Part.CFrame = p1[p2.RelativePart].CFrame * p2.Offset;
    Part.Size = p2.Size;
    Part.Color = Color3.new(1, 0, 0);
    Part.Material = Enum.Material.ForceField;
    Part.Anchored = true;
    Part.CastShadow = false;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Parent = workspace.Effects;

    for _ = 1, 3 do
        Part.Transparency = 0.5;
        wait(0.1);
        Part.Transparency = 1;
        wait(0.1);
    end;

    Part:Destroy();
end;