  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();

return function(p3) -- Line: 12
    -- upvalues: u2 (copy), u1 (copy), TweenService (copy)
    local Colors = p3.Colors;
    local Amount = p3.Amount;
    local Radius = p3.Radius;
    local Origin = p3.Origin;
    local Time = p3.Time;
    local v4 = p3.SizeModifier or 1;

    for _ = 1, math.random(Amount.Min, Amount.Max) do
        local v5 = u2:NextNumber(0, Radius);
        local v6 = u2:NextNumber(0, 6.283185307179586);
        local v7 = CFrame.new(math.cos(v6) * v5, u2:NextNumber(34, 38), math.sin(v6) * v5);
        local v8 = u1.Gura.Line:Clone();
        v8.CFrame = Origin * v7;
        v8.Color = Colors[math.random(1, #Colors)];
        local v9 = v8.Size.X * u2:NextNumber(0.95, 1.3);
        local v10 = v8.Size.Y * u2:NextNumber(1, 1.4) * v4;
        local v11 = v8.Size.Z * u2:NextNumber(0.95, 1.3);
        v8.Size = Vector3.new(v9, v10, v11);
        v8.Parent = workspace.Effects;
        task.delay(Time, v8.Destroy, v8);
        TweenService:Create(v8, TweenInfo.new(Time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = Vector3.new(0, v8.Size.Y * 1.15, 0),
            CFrame = v8.CFrame * CFrame.new(0, -65, 0)
        }):Play();
    end;
end;