  

 

return function(p1, p2) -- Line: 1
    local v3 = p1:Clone();
    v3:TranslateBy(p2);

    for _, descendant in pairs(v3:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Accessory") then
            if descendant:IsA("BasePart") then
                descendant.Color = Color3.new(1, 1, 1);
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.Material = Enum.Material.ForceField;
                descendant:SetAttribute("Yeah", descendant.Transparency);
                descendant.Transparency = 1;
            end;
        else
            descendant:Destroy();
        end;
    end;

    for i = 1, 4 do
        local v4 = v3:Clone();
        v4:TranslateBy(v4.PrimaryPart.CFrame.LookVector * (p2.Magnitude / (5 - i)));

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = descendant:GetAttribute("Yeah");
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.15), {
                    Transparency = 1
                }):Play();
            end;
        end;

        v4.Parent = workspace.Effects;
        task.delay(0.2, v4.Destroy, v4);
        task.wait();
    end;

    v3:Destroy();
end;