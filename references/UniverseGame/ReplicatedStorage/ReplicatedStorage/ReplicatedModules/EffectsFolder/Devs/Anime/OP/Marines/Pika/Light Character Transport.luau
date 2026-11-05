  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2, p3) -- Line: 6
    -- upvalues: u1 (copy), TweenService (copy)
    local v4 = u1.Pika["Light Outline"]:Clone();

    for _, child in v4:GetChildren() do
        child.Size = child.Size * 1.05;
        child.CFrame = p2[child.Name].CFrame;
        local ManualWeld = Instance.new("ManualWeld");
        ManualWeld.Part0 = child;
        ManualWeld.Part1 = p2[child.Name];
        ManualWeld.C0 = child.CFrame:ToObjectSpace(ManualWeld.Part1.CFrame);
        ManualWeld.Parent = child;
    end;

    v4.Parent = p2;
    task.delay(p3 / 30, v4.Destroy, v4);

    for _, descendant in p2:GetDescendants() do
        if (descendant:IsA("Decal") or (descendant:IsA("BasePart") or descendant:IsA("Texture"))) and descendant.Transparency < 0.5 then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            task.delay(p3 / 30, function() -- Line: 27
                -- upvalues: descendant (copy), Transparency (copy)
                if descendant:IsDescendantOf(game) then
                    descendant.Transparency = Transparency;
                end;
            end);

            if v4:FindFirstChild(descendant.Name) then
                TweenService:Create(v4[descendant.Name], TweenInfo.new(p3 / 60, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true), {
                    Transparency = 0
                }):Play();
            end;
        end;
    end;
end;