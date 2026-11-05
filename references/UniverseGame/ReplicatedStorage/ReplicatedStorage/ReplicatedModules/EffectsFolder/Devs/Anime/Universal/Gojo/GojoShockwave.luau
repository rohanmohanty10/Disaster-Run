  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 5
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local v2 = ReplicatedStorage["Client Assets"].Gojo.Shockwave:Clone();
    v2.Parent = game.Workspace.Effects;
    v2:SetPrimaryPartCFrame(p1.HumanoidRootPart.CFrame);

    for _, child in ipairs(v2:GetChildren()) do
        TweenService:Create(child, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = child.Size * 10,
            CFrame = child.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
        Debris:AddItem(child, 0.8);
    end;
end;