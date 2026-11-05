  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4) -- Line: 2
    -- upvalues: TweenService (copy)
    local v5 = game.ReplicatedStorage["Client Assets"].BakEffects.ShockwaveNEW:Clone();
    v5.Parent = game.Workspace.Effects;

    if p2 then
        for _, child in pairs(v5:GetChildren()) do
            child.Color = p2;
        end;
    end;

    v5:SetPrimaryPartCFrame(p1.HumanoidRootPart.CFrame * p3);

    for _, child in ipairs(v5:GetChildren()) do
        TweenService:Create(child, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = child.Size * p4,
            CFrame = child.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
    end;

    wait(1);
    v5:Destroy();
end;