  

 

return function(p1, p2) -- Line: 1
    for _, v in pairs(p2) do
        local Part = Instance.new("Part");
        Part.Color = Color3.fromRGB(0, 153, 255);
        Part.Size = Vector3.new(20, 20, 20);
        Part.Transparency = 1;
        Part.Material = Enum.Material.ForceField;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Shape = Enum.PartType.Ball;
        Part.Anchored = true;
        Part.CFrame = v.PrimaryPart.CFrame;
        Part.Parent = workspace.Effects;
        game:GetService("TweenService"):Create(Part, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Size = Vector3.new(0, 0, 0),
            Transparency = 0
        }):Play();
    end;
end;