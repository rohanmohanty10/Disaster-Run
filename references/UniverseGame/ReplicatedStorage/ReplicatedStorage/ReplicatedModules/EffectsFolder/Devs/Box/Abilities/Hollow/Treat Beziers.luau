  

 

local TweenService = game:GetService("TweenService");
Random.new();
local Assets = game.ReplicatedStorage["Client Assets"].Assets;
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: Assets (copy), TweenService (copy)
    local Positions = p1.Positions;
    local Character = p1.Character;
    local Duration = p1.Duration;
    local v2 = Assets.Abilities.Hollow.Models.Candies:FindFirstChild("Candy" .. math.random(1, 3)):Clone();

    if not v2 then
        return;
    end;

    v2.CanCollide = true;
    v2.CanQuery = true;
    v2.CanTouch = true;
    v2.CollisionGroup = "FX";
    v2.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, -5);
    v2.Parent = workspace.Effects;
    local v3 = CFrame.new(Positions[1], Positions[2]);
    local v4 = (Positions[1] + Positions[2]) / 2 + Vector3.new(0, (Positions[1] - Positions[2]).Magnitude / 1.5, 0);

    for i = 1, 10 do
        local v5 = task.wait(Duration / 1 / 10);
        local v6 = i / 10;
        local v7 = (1 - v6) ^ 2 * Positions[1] + 2 * (1 - v6) * v6 * v4 + v6 ^ 2 * Positions[2];
        TweenService:Create(v2, TweenInfo.new(v5, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(v7, v7 + v3.LookVector)
        }):Play();
    end;

    v2.Anchored = true;
    v2.Transparency = 1;
    task.delay(1.5, v2.Destroy, v2);
end;