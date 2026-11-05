  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4, p5) -- Line: 2
    -- upvalues: TweenService (copy)
    local Model = Instance.new("Model", workspace.Effects);

    for _, child in pairs(p1.Character:GetChildren()) do
        if (child:IsA("Part") or child:IsA("MeshPart")) and child.Name ~= "HumanoidRootPart" then
            local v6 = child:Clone();
            v6.Parent = Model;
            v6.Transparency = p2;
            v6.Name = child.Name;
            v6.Anchored = true;

            if p4 then
                v6.Color = p4;
            else
                v6.Color = Color3.fromRGB(255, 255, 255);
            end;

            v6.Material = Enum.Material.Neon;
            v6.CanCollide = false;

            for _, child2 in pairs(v6:GetChildren()) do
                if (child2:IsA("Motor6D") or (child2:IsA("Motor") or child2:IsA("Weld"))) and child2.Name ~= "Head" then
                    child2:Destroy();
                end;
            end;
        end;
    end;

    if p5 and p5.Size then
        for _, child in pairs(Model:GetChildren()) do
            if (child:IsA("Part") or child:IsA("MeshPart")) and child.Name ~= "HumanoidRootPart" then
                TweenService:Create(child, TweenInfo.new(0.3), {
                    Size = child.Size * p5.Size,
                    Transparency = p5.Transparency
                }):Play();
            end;
        end;
    end;

    game.Debris:AddItem(Model, p3);
end;