  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local RunService = game:GetService("RunService");

local function GenerateTrail(p2, u3) -- Line: 4
    -- upvalues: u1 (copy), RunService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u4 = u1.Gameplay.LevelUpTrail:Clone();
    u4.Parent = workspace.Effects;
    local u5 = 0;
    local u6 = -1.5;
    local u8 = RunService.Heartbeat:Connect(function(p7) -- Line: 15
        -- upvalues: u5 (ref), u6 (ref), u4 (copy), HumanoidRootPart (copy), u3 (copy)
        u5 = u5 + p7 * 5;
        u6 = u6 + p7 * 2;
        u4.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, u5, 0) * CFrame.new(0, u6, 2 * u3);
    end);
    task.delay(1.5, function() -- Line: 24
        -- upvalues: u8 (ref), u4 (copy)
        u8:Disconnect();

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;

            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(3);
        u4:Destroy();
    end);
end;

return function(p9) -- Line: 41
    -- upvalues: GenerateTrail (copy)
    local Character = p9.Character;
    GenerateTrail(Character, -1);
    GenerateTrail(Character, 1);
end;