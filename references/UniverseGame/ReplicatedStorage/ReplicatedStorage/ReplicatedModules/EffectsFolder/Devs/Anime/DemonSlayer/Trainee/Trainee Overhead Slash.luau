  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: EffectsHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local u3 = v2.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Overhead/Slash",
        Origin = u3,
        Player = Player
    });
    task.spawn(function() -- Line: 33
        -- upvalues: u3 (copy), EffectsHandler (ref), TweenService (ref)
        local v4 = u3 * CFrame.Angles(0, 0, -2.9670597283903604);
        local v5 = EffectsHandler.CallEffect("MeshFlipbook", script.SlashMesh1, v4 * CFrame.Angles(0, 0.5235987755982988, 0), script.Slash2, 50, workspace.Effects, Color3.fromRGB(2555, 2555, 2555), 0.6);
        v5:FindFirstChild("Mesh").Scale = Vector3.new(14, 10, 14);
        TweenService:Create(v5:FindFirstChild("Mesh"), TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(19, 20, 19)
        }):Play();
        TweenService:Create(v5, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v5.CFrame * CFrame.Angles(0, 10, 0)
        }):Play();
    end);
end;