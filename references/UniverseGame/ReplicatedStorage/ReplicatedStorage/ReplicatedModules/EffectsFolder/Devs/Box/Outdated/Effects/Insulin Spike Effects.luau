  

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2) -- Line: 5
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy)
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart;
        p2:FindFirstChild("Humanoid");
    else
        v3 = nil;
    end;

    local v4 = u1["Candy Cutlass"]["Insulin Spike"].SnowExplosion:Clone();
    v4.CFrame = v3.CFrame;
    v4.Parent = workspace.Effects;
    Debris:AddItem(v4, 3.5);
    local v5 = u1["Candy Cutlass"]["Insulin Spike"].CandyCanes:Clone();
    local PrimaryPart = v5.PrimaryPart;
    PrimaryPart.CFrame = v3.CFrame * CFrame.new(0, -10, 0);
    v5.Parent = workspace.Effects;
    Debris:AddItem(v5, 5);
    TweenService:Create(PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
        CFrame = PrimaryPart.CFrame * CFrame.new(0, 7, 0)
    }):Play();
    task.wait(0.1);

    for _, descendant in pairs(v4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 31
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                task.wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;
end;