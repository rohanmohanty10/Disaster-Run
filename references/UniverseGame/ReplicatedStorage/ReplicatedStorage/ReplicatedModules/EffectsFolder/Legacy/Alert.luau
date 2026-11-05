  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy), TweenService (copy)
    local v4 = u1.Universal.Alert:Clone();
    v4.Main.CFrame = p2.Head.CFrame + Vector3.new(0, 3, 0);
    v4.Parent = workspace.Effects;

    for _, child in pairs(v4:GetChildren()) do
        TweenService:Create(child, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, (1 / 0), true), {
            Color = Color3.fromRGB(255, 255, 255)
        }):Play();
    end;

    game.Debris:AddItem(v4, p3);
end;