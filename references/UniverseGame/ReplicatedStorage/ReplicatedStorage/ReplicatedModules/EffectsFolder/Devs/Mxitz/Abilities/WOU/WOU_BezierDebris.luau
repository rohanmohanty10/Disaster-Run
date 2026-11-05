  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function quadBezier(p1, p2, p3, p4) -- Line: 8
    return (1 - p1) ^ 2 * p2 + 2 * (1 - p1) * p1 * p3 + p1 ^ 2 * p4;
end;

local u5 = Random.new();

return function(p6, p7) -- Line: 14
    -- upvalues: AssetHandler (copy), u5 (copy), TweenService (copy)
    local v8 = AssetHandler.CloneAsset("Models/Plank", {
        AbilityName = "Wonder Of U"
    });
    v8.CFrame = p6;
    v8.Parent = workspace.Effects;
    local v9 = p6 * CFrame.new(u5:NextNumber(-10, 10), u5:NextNumber(15, 20), -(p7.Position - p6.Position).Magnitude / 2);

    for i = 0, 30 do
        local v10 = i / 30;
        v8.CFrame = CFrame.new((1 - v10) ^ 2 * p6.Position + 2 * (1 - v10) * v10 * v9.Position + v10 ^ 2 * p7.Position, p7.Position);
        task.wait(0.005);
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