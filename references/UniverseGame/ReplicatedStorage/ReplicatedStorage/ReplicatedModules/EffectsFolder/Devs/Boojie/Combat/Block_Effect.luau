  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");

return function(p2, p3) -- Line: 8
    -- upvalues: u1 (copy), GenericModule (copy), TweenService (copy)
    local v4 = p2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
        return;
    end;

    local CFrame2 = HumanoidRootPart.CFrame;
    local v5 = u1.Combat.Block:Clone();
    v5.CFrame = CFrame2 * (p3 or CFrame.new(0, 1.25, -2.5)) * CFrame.Angles(0, 1.5707963267948966, 0);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v5;
    WeldConstraint.Parent = v5;
    v5.Parent = p2;

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    local v6 = TweenService:Create(v5, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Transparency = 1
    });
    v6:Play();
    v6.Completed:Wait();
    v5:Destroy();
end;