  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function quadBezier(p1, p2, p3, p4) -- Line: 8
    return (1 - p1) ^ 2 * p2 + 2 * (1 - p1) * p1 * p3 + p1 ^ 2 * p4;
end;

Random.new();

return function(p5, p6, p7) -- Line: 14
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local v8 = AssetHandler.CloneAsset("Models/ObladiInsect", {
        AbilityName = "Wonder Of U"
    });
    v8.CFrame = p5;
    v8.Parent = workspace.Effects;
    local v9 = (p7 or 0.45) / 30;
    local v10 = p5 * CFrame.new(1, 0, -(p6.Position - p5.Position).Magnitude / 2);

    for i = 0, 30 do
        local v11 = i / 30;
        v8.CFrame = CFrame.new((1 - v11) ^ 2 * p5.Position + 2 * (1 - v11) * v11 * v10.Position + v11 ^ 2 * p6.Position, p6.Position);
        task.wait(v9);
    end;

    v8.CanCollide = true;
    v8.Anchored = false;
    task.wait(2);
    TweenService:Create(v8, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    }):Play();
    task.wait(0.25);
    v8:Destroy();
end;