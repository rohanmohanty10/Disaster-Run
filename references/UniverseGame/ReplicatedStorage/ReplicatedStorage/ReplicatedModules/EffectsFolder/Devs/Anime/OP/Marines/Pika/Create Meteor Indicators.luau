  

 

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage["Client Assets"];
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
Random.new();

return function(p2, p3) -- Line: 19
    -- upvalues: u1 (copy), TweenService (copy)
    local Size = p3.Hitbox.Size;
    local v4 = p3.ExplosionDelay / 60;

    for _, v in p2 do
        local v5 = u1.Pika.RayIndicator:Clone();
        v5.CFrame = v * CFrame.Angles(0, 1.5707963267948966, 0);
        v5.Size = Vector3.new(0.25, Size * 2, Size * 2);
        v5.Parent = workspace.Effects;
        task.delay(v4, v5.Destroy, v5);
        TweenService:Create(v5, TweenInfo.new(v4, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end;
end;