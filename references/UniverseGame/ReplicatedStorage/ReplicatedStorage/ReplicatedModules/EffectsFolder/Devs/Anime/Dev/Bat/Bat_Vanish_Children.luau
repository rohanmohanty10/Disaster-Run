  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 14
    local Duration = p1.Duration;
    local u3 = p1.Character.DescendantAdded:Connect(function(p2) -- Line: 18
        if p2:IsA("BasePart") or (p2:IsA("Decal") or p2:IsA("Texture")) then
            p2.Transparency = 1;

            return;
        end;

        if p2:IsA("ParticleEmitter") or (p2:IsA("Beam") or p2:IsA("Trail")) then
            p2.Enabled = false;

            if p2:IsA("ParticleEmitter") then
                p2:Clear();
            end;
        elseif p2:IsA("Sound") then
            p2.Volume = 0;
        end;
    end);
    task.delay(Duration, function() -- Line: 31
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
end;