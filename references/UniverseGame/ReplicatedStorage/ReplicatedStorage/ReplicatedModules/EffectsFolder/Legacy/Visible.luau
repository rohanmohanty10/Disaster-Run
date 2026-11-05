  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 2
    -- upvalues: TweenService (copy)
    local v3 = p2 or 0.5;

    for _, descendant in pairs(p1.Character:GetDescendants()) do
        if (descendant:IsA("Part") or descendant:IsA("MeshPart")) and (descendant.Name ~= "HumanoidRootPart" and not descendant:IsDescendantOf(p1.Character.Stand)) then
            TweenService:Create(descendant, TweenInfo.new(v3), {
                Transparency = 0
            }):Play();
        end;
    end;
end;