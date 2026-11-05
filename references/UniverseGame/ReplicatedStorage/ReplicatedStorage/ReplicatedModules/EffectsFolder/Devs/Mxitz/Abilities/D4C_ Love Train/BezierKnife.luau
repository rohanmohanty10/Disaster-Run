  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function quadBezier(p1, p2, p3, p4) -- Line: 8
    return (1 - p1) ^ 2 * p2 + 2 * (1 - p1) * p1 * p3 + p1 ^ 2 * p4;
end;

Random.new();

return function(p5) -- Line: 14
    local v6 = p5:FindFirstChild("Right Arm");
    local u7 = p5.Stand:FindFirstChild("Stand Right Arm");
    local u8 = v6.CFrame * CFrame.new(0, -1.1, 0);
    local v9 = p5:FindFirstChild("Knife"):Clone();
    v9:FindFirstChildOfClass("Motor6D"):Destroy();
    v9.Anchored = true;
    v9.CFrame = u8;
    v9.Parent = workspace.Effects;

    for _, descendant in v9:GetDescendants() do
        if table.find({ "Trail", "ParticleEmitter" }, descendant.ClassName) then
            descendant.Enabled = true;
        end;
    end;

    local function MidPoinnt() -- Line: 34
        -- upvalues: u8 (copy), u7 (copy)
        return u8 * CFrame.new(0, -1, -(u7.CFrame.Position - u8.Position).Magnitude / 2);
    end;

    for i = 0, 8 do
        local new = CFrame.new;
        local v10 = i / 8;
        local Position = u8.Position;
        local Position2 = (u8 * CFrame.new(0, -1, -(u7.CFrame.Position - u8.Position).Magnitude / 2)).Position;
        v9.CFrame = new((1 - v10) ^ 2 * Position + 2 * (1 - v10) * v10 * Position2 + v10 ^ 2 * u7.CFrame.Position, u7.CFrame.Position);
        task.wait(0.003333333333333333);
    end;

    for _, descendant in v9:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    for _, descendant in v9:GetDescendants() do
        if table.find({ "Trail", "ParticleEmitter" }, descendant.ClassName) then
            descendant.Enabled = false;
        end;
    end;

    task.wait(0.5);
    v9:Destroy();
end;