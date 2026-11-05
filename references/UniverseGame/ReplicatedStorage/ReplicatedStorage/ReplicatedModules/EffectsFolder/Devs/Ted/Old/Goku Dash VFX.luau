  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), TweenService (copy)
    local v3 = u1["Goku Rewrite"].Dash:Clone();
    v3:PivotTo(p2.HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    v3.Parent = workspace.Effects;
    local Weld = Instance.new("Weld");
    Weld.Part0 = p2.HumanoidRootPart;
    Weld.Part1 = v3.Main;
    Weld.Parent = v3.Main;
    Weld.C0 = CFrame.new() * CFrame.Angles(-1.5707963267948966, 0, 0);
    TweenService:Create(Weld, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        C0 = Weld.C0 * CFrame.Angles(0, 0, 6.265732014659643)
    }):Play();

    for _, descendant in pairs(v3:GetDescendants()) do
        if descendant:IsA("Decal") then
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                Transparency = 0
            }):Play();
        end;
    end;

    game.Debris:AddItem(v3, 1.5);
end;