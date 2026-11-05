  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 2
    -- upvalues: TweenService (copy)
    for _, child in pairs(p1.Character:GetChildren()) do
        if (child:IsA("Part") or child:IsA("MeshPart")) and child.Name ~= "HumanoidRootPart" then
            TweenService:Create(child, TweenInfo.new(0.1), {
                Transparency = 1
            }):Play();
        end;
    end;

    wait(0.2);

    for _, child in pairs(p1.Character:GetChildren()) do
        if (child:IsA("Part") or child:IsA("MeshPart")) and child.Name ~= "HumanoidRootPart" then
            TweenService:Create(child, TweenInfo.new(0.1), {
                Transparency = 0
            }):Play();
        end;
    end;
end;