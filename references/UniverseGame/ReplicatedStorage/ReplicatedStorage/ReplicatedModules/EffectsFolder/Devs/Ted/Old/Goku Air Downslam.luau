  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy), TweenService (copy)
    local v5 = u1["Goku Rewrite"].Slam:Clone();
    v5:PivotTo(p2.HumanoidRootPart.CFrame);
    v5.Parent = workspace.Effects;

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local v6 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v7 = {
                Transparency = 1
            };
            local v8 = descendant.CFrame * CFrame.new(0, 4, 0);
            local Angles = CFrame.Angles;
            local v9 = math.random(-90, 90);
            v7.CFrame = v8 * Angles(0, math.rad(v9), 0);
            TweenService:Create(descendant, v6, v7):Play();
        elseif descendant:IsA("Decal") then
            TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        else
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    game.Debris:AddItem(v5, 1.5);
end;